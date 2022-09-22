using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.DashboardCommon;
using DevExpress.DashboardWeb;
using System.IO;
using System.Xml.Linq;
using System.Web.Script.Serialization;
using DevExpress.DataAccess.ConnectionParameters;
using DevExpress.Web;
using System.Web.Services;
using Newtonsoft;
using PertentoBI.Web.DashboardCustomisation;
using DevExpress.Xpo;
using DevExpress.Xpo.DB;

public partial class DashboardViewer : System.Web.UI.Page
{

    public Dictionary<string, string> dicSQLReplaceCrit { get; set; } = new Dictionary<string, string>();

    protected static string dashboardID;
    public static string defaultSourceType;
    private static Session xSession;

    string groupName;

    WorkingMode WorkingMode
    {
        get
        {
            string workingModeString = this.Request.QueryString["mode"];
            if (!string.IsNullOrEmpty(workingModeString) && workingModeString == "designer")
                return WorkingMode.Designer;
            return WorkingMode.Viewer;


        }
    }

    protected void Page_Init(object sender, EventArgs e)
    {
        Session session = XpoHelper.GetNewSession();
        xSession = session;
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsCallback && !IsPostBack)
        {
            ASPxDashboard1.WorkingMode = WorkingMode;

            CookiesWrapper.SourceType = "";
            //         ASPxDashboard1.ColorScheme = Request.QueryString["colorSchema"] ?? ASPxDashboard.ColorSchemeLight;
        }

        dashboardID = Request.QueryString["dashboardId"];
        defaultSourceType = Request.QueryString["dst"];

        if (defaultSourceType != null && !(string.IsNullOrEmpty(defaultSourceType))) CookiesWrapper.SourceType = defaultSourceType;

        DataBaseEditableDashboardStorage dataBaseDashboardStorage = new DataBaseEditableDashboardStorage(xSession);
        CustomDataSourceStorage dataSourceStorage = new CustomDataSourceStorage(xSession);
        //  DataLoader.LoadDatasources(ref dataSourceStorage, objBus);

        //  DefaultReportDesignerContainer.RegisterDataSourceWizardDBSchemaProviderExFactory<CustomDataSourceWizardDBSchemaProviderFactory>();

        DashboardConfigurator.Default.SetDashboardStorage(dataBaseDashboardStorage);
        DashboardConfigurator.Default.AllowExecutingCustomSql = true;
        DashboardConfigurator.Default.SetDataSourceStorage(dataSourceStorage);
        DashboardConfigurator.Default.ConfigureDataConnection += DataApi_ConfigureDataConnection;
        DashboardConfigurator.Default.SetConnectionStringsProvider(new ConnectionStringsProvider(xSession));

    }
    void DataApi_ConfigureDataConnection(object sender, ConfigureDataConnectionWebEventArgs e)
    {
        SqlConnectionStringBuilder decoder = new SqlConnectionStringBuilder(ConnectionHelper.ConnectionString);

        MsSqlConnectionParameters connectionParameters = new MsSqlConnectionParameters()
        {
            ServerName = decoder.DataSource,
            DatabaseName = decoder.InitialCatalog,
            UserName = decoder.UserID,
            Password = decoder.Password,
            AuthorizationType = MsSqlAuthorizationType.SqlServer
        };
        e.ConnectionParameters = connectionParameters;

    }
    protected void OnDataLoading(object sender, DevExpress.DashboardWeb.DataLoadingWebEventArgs e)
    {
        DataLoader.LoadData(e,xSession);
        groupName = DataLoader.groupName;

    }

    protected void ASPxDashboard1_CustomJSProperties(object sender, CustomJSPropertiesEventArgs e)
    {
        e.Properties.Add("cpGroupName", groupName);

        DefaultDashboardSource defaultDashboardSource = DataLoader.GetDefaultSourceType(dashboardID,xSession);
        e.Properties.Add("cpSourceType", defaultDashboardSource.SourceType);
        e.Properties.Add("cpExtractionDate", defaultDashboardSource.LastExtractDate);
        e.Properties.Add("cpExtractStatus", defaultDashboardSource.ExtractStatus);
        e.Properties.Add("cpHasExtract", defaultDashboardSource.HasExtract);

    }


    protected void ASPxDashboard1_CustomDataCallback(object sender, DevExpress.Web.CustomDataCallbackEventArgs e)
    {
        try
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            dynamic json = serializer.Deserialize<dynamic>(e.Parameter);

            Dictionary<string, string> parameters = serializer.Deserialize<Dictionary<string, string>>(e.Parameter);

            if (!parameters.ContainsKey("ExtensionName"))
                return;

            DataBaseEditableDashboardStorage dataBaseDashboardStorage = new DataBaseEditableDashboardStorage(xSession);

            //Saving group against dashboard
            if (parameters["ExtensionName"] == "dxdde-delete-dashboard" && parameters.ContainsKey("DashboardID"))
                dataBaseDashboardStorage.DeleteDashboard(parameters["DashboardID"]);
            //Saving group against dashboard
            if (parameters["ExtensionName"] == "dxdadd-dashboard-to-Group" && parameters.ContainsKey("DashboardID") && parameters.ContainsKey("GroupName"))
                dataBaseDashboardStorage.AddToDashboardGroup(parameters["DashboardID"], parameters["GroupName"]);
            if (parameters["ExtensionName"] == "dxdadd-dashboard-security" && parameters.ContainsKey("DashboardID") && parameters.ContainsKey("GroupIDs"))
              //  dataBaseDashboardStorage.AddDashboardSecurity(parameters["DashboardID"], parameters["GroupIDs"], false);
            if (parameters["ExtensionName"] == "dxdset-defaultsource" && parameters.ContainsKey("DashboardID") && parameters.ContainsKey("DefaultSource"))
                dataBaseDashboardStorage.SetDashboardDefaultSource(parameters["DashboardID"], parameters["DefaultSource"]);

        }
        catch (Exception ex)
        {

     
        }

    }

    public static object GetDashboardGroups(string dashboardid)
    {

        SelectedData ds = DataLoader.GetDashboardGroup(dashboardid, xSession);
        return Newtonsoft.Json.JsonConvert.SerializeObject(ds.ResultSet);
    }

    [WebMethod]
    public static object GetPBIGroups()
    {
        SelectedData ds = DataLookup.get_Lookup(session: xSession, tableName: "Groups", valueColumn: "Group_ID", descriptionColumn: "Group_Name", orderColumn: "Group_Name", DISTINCT: true);
        return Newtonsoft.Json.JsonConvert.SerializeObject(ds.ResultSet);
    }

    [WebMethod]
    public static object GetDashboardAppliedSecurity(string dashboardid)
    {

        SelectedData ds = DataLookup.get_Lookup(session: xSession, tableName: "Dashboard_Groups", valueColumn: "Group_ID", descriptionColumn: "Group_ID", orderColumn: "Group_ID", filterRows: $"Dashboard_ID = {dashboardid}", DISTINCT: true);
        return Newtonsoft.Json.JsonConvert.SerializeObject(ds.ResultSet);
    }

    [WebMethod]
    public static object GetDefaultDatasource(string dashboardid)
    {

        DefaultDashboardSource defaultDashboardSource = DataLoader.GetDefaultSourceType(dashboardid, xSession);
        return Newtonsoft.Json.JsonConvert.SerializeObject(defaultDashboardSource);
    }

}
