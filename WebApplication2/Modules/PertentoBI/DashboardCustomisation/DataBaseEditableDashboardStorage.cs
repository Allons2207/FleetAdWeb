using DevExpress.DashboardCommon;
using DevExpress.DashboardWeb;
using DevExpress.DataAccess.ConnectionParameters;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Xml.Linq;
using System.Xml.XPath;
using DevExpress.Xpo;
using DevExpress.Xpo.DB;
using PertentoBI.Classes;
using PertentoBI.BusinessObjects.Database;
using PertentoBI.Classes.Mapping;

namespace PertentoBI.Web.DashboardCustomisation
{
    public class DataBaseEditableDashboardStorage : IEditableDashboardStorage

    {

        public string sourceType = "";
        private Session mSession;

        private string ConnectionString;
        public DataBaseEditableDashboardStorage(string ConnectionString, Session session)
     : base()
        {
            this.mSession = session;
            this.ConnectionString = ConnectionString;
        }

        public DataBaseEditableDashboardStorage(Session session)
   : base()
        {
            this.mSession = session;
            this.ConnectionString = ConnectionHelper.ConnectionString;
        }

        string IEditableDashboardStorage.AddDashboard(XDocument document, string dashboardName)
        {
            try
            {
                //this.mobjBus = new Docwize.cDWMain.cDWBusTier(cCookies.CompanyLogin, General.getServerName(), cCookies.AuditUser);
                string datasource = string.Empty;
                string groupName = string.Empty;
                string queryType = string.Empty;
                try
                {
                    queryType = document.XPathSelectElement("/Dashboard/DataSources/SqlDataSource/Query").Attribute("Type").Value;
                    IEnumerable<XElement> xlEl = document.XPathSelectElements("/Dashboard/DataSources/SqlDataSource/Query");
                    switch (queryType)
                    {
                        case "SelectQuery":

                            foreach (XElement xmlElement in xlEl)
                            {
                                var xmlE = (IEnumerable)xmlElement.XPathEvaluate("Tables/Table");
                                foreach (var element in xmlE)
                                {
                                    var qry = ((XElement)element).Attribute("Name").Value.Replace("Extract_", "");
                                    datasource += (string.IsNullOrEmpty(datasource)) ? qry : "|" + qry;
                                }

                            }

                            break;
                        case "CustomSqlQuery":

                            var datasourceEls = document.XPathSelectElements("/Dashboard/DataSources/SqlDataSource/Query/Sql");

                            foreach (XElement datasourceEl in datasourceEls)
                            {
                                var qry = HelperFunctions.Catchnull(datasourceEl.Value, "").ToString().Replace("Extract_", "");
                                var i = qry.Replace("Extract_", "").IndexOf(" order by ");
                                if (i > 0)
                                {
                                    qry = qry.Substring(0, i);
                                }
                                datasource += (string.IsNullOrEmpty(datasource)) ? qry : "|" + qry;
                            }
                            break;

                        case "StoredProcQuery":

                            foreach (XElement xmlElement in xlEl)
                            {
                                var xmlE = (IEnumerable)xmlElement.XPathEvaluate("ProcName");
                                foreach (var element in xmlE)
                                {
                                    var qry = ((XElement)element).Value;

                                    datasource += (string.IsNullOrEmpty(datasource)) ? $"exec {((XElement)element).Value}" : "| exec " + ((XElement)element).Value;
                                }

                            }

                            break;
                        default:
                            break;
                    }
                }
                catch (Exception)
                {
                    datasource = string.Empty;
                }

                MemoryStream stream = new MemoryStream();
                document.Save(stream);
                stream.Position = 0;
                Boolean IsCustomDashboard = true;

                //Dashboards dashboards = new Dashboards(mSession) {
                //    DashboardName = dashboardName,
                //    GroupName = groupName,
                //    Datasource = datasource.Replace("Extract_", ""),
                //    DashboardDefinition = stream.ToArray(),
                //    IsCustomDashboard = IsCustomDashboard,
                //    DefaultSource = "L"
                //};

                //dashboards.Save();

                string defaultSource = "L";

                string[] parameters = new string[] { "DashboardName", "GroupName", "Datasource", "DashboardDefinition", "IsCustomDashboard", "DefaultSource", "CreatedBy" };
                object[] parametersValues = new object[] { dashboardName, groupName, datasource.Replace("Extract_", ""), stream.ToArray(), IsCustomDashboard, defaultSource, CookiesWrapper.thisUserID };

                StringBuilder strInsert = new StringBuilder();
                strInsert.AppendLine("DECLARE @DashboardID bigint = null");
                strInsert.AppendLine("INSERT INTO [PBI_Dashboards] ([DashboardName],[GroupName],[Datasource],[DashboardDefinition],[IsCustomDashboard],[DefaultSource],[CreatedBy],[CreatedDate])");
                strInsert.AppendLine("VALUES (@DashboardName, @GroupName, @Datasource, @DashboardDefinition,@IsCustomDashboard,@DefaultSource,@CreatedBy,GetDate())");
                strInsert.AppendLine("SELECT @DashboardID = ISNULL(NullIF(@DashboardID, 0), SCOPE_IDENTITY()) ");
                strInsert.AppendLine("select @DashboardID");

                string ID = this.mSession.ExecuteScalar(strInsert.ToString(), parameters, parametersValues).ToString();
                //string ID = dashboards.DashboardID.ToString();
                if (ID != "") AddDashboardSecurity(ID, "", true);

             
                return ID;
            }
            catch (Exception ex)
            {
              
                return String.Empty;
            }


        }

        XDocument IDashboardStorage.LoadDashboard(string dashboardID)
        {

            try
            {
                // XPObjectSpace xpObjectSpace = objectSpace as XPObjectSpace;
                using (SqlConnection connection = new SqlConnection(this.ConnectionString))
                {
                    if (!string.IsNullOrEmpty(dashboardID) && (dashboardID != "0"))
                    {
                        connection.Open();

                        SqlCommand GetCommand = new SqlCommand("SELECT DashboardDefinition, ISNULL(DefaultSource,'L') DefaultSource FROM fnGetAllowedDashboards(@UserID)  WHERE DashboardID=@DashboardID");
                        GetCommand.Parameters.Add("@DashboardID", SqlDbType.VarChar).Value = dashboardID;
                        GetCommand.Parameters.Add("@UserID", SqlDbType.Int).Value = CookiesWrapper.thisUserID;


                        //SqlCommand GetCommand = new SqlCommand("SELECT DashboardDefinition, ISNULL(DefaultSource,'L') DefaultSource FROM fnGetAllowedDashboards(@UserID)  WHERE DashboardID=@DashboardID");
                        //GetCommand.Parameters.Add("@DashboardID", SqlDbType.Int).Value = Convert.ToInt32(dashboardID);
                        //GetCommand.Parameters.Add("@UserID", SqlDbType.UniqueIdentifier).Value = CookiesWrapper.UserID);
                        GetCommand.Connection = connection;

                        SqlDataReader reader = GetCommand.ExecuteReader();
                        reader.Read();
                        byte[] data = reader.GetValue(0) as byte[];
                        string DefaultSource = reader["DefaultSource"] as string;
                        //if (cCookies.SourceType != "")
                        //{
                        //    DefaultSource = cCookies.SourceType;
                        //    cCookies.SourceType = "";
                        //}

                        MemoryStream stream = new MemoryStream(data);
                        connection.Close();

                        XDocument xdoc = ApplyConnectionParameters(XDocument.Load(stream));
                        var queryEls = xdoc.XPathSelectElements("/Dashboard/DataSources/SqlDataSource/Query");
                        string queryType = xdoc.XPathSelectElement("/Dashboard/DataSources/SqlDataSource/Query").Attribute("Type").Value;

                        switch (queryType)
                        {
                            case "SelectQuery":

                                foreach (XElement xmlElement in queryEls)
                                {
                                    var xmlE = (IEnumerable)xmlElement.XPathEvaluate("Tables/Table");
                                    foreach (var element in xmlE)
                                    {
                                        if (DefaultSource.ToUpper() == "E")
                                        {
                                            var tbl = ((XElement)element).Attribute("Name").Value;
                                            ((XElement)element).Attribute("Name").Value = $"Extract_{tbl}";
                                        }
                                    }

                                }

                                break;
                            case "CustomSqlQuery":

                                var datasourceEls = xdoc.XPathSelectElements("/Dashboard/DataSources/SqlDataSource/Query/Sql");

                                foreach (XElement xEl in datasourceEls)
                                {
                                    var orderIndex = xEl.Value.ToUpper().IndexOf(" ORDER BY ");
                                    var whereIndex = xEl.Value.ToUpper().IndexOf(" WHERE ");
                                    var paranthesisIndexStart = xEl.Value.IndexOf("(");
                                    var paranthesisIndexEnd = xEl.Value.IndexOf(")");
                                    var FromIndexEnd = xEl.Value.ToUpper().IndexOf(" FROM ");

                                    if (orderIndex > 0)
                                    {
                                        xEl.Value = (xEl.Value.Substring(0, orderIndex)).Trim();
                                    }

                                    if (DefaultSource.ToUpper() == "E")
                                    {

                                        var qry = xEl.Value;

                                        if (paranthesisIndexStart > 0)
                                        {
                                            paranthesisIndexEnd = qry.IndexOf(")");
                                            qry = (qry.Substring(paranthesisIndexStart + 1, (paranthesisIndexEnd - paranthesisIndexStart) - 1)).Trim();

                                        }
                                        if (whereIndex > 0)
                                        {
                                            whereIndex = qry.ToUpper().IndexOf(" WHERE ");
                                            qry = (qry.Substring(0, whereIndex)).Trim();
                                        }

                                        if (FromIndexEnd > 0)
                                        {
                                            FromIndexEnd = qry.ToUpper().IndexOf(" FROM ");
                                            qry = (qry.Substring(FromIndexEnd + 6)).Trim().Trim(')');
                                        }

                                        var qrytbl = qry.Trim('[', ']');

                                        //check existence of extract before changing 
                                        var verifyTable = $@"IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Extract_{qrytbl}')  SELECT 1 ELSE SELECT 0";

                                        var result = this.mSession.ExecuteScalar(verifyTable).ToString();
                                        if (result == "1")
                                        {
                                            xEl.Value = xEl.Value.Replace(qry, $"[Extract_{qrytbl}]");

                                        }

                                    }
                                    else if (DefaultSource.ToUpper() == "L")
                                    {
                                        var qry = xEl.Value;

                                        if (paranthesisIndexStart > 0)
                                        {
                                            paranthesisIndexEnd = qry.IndexOf(")");
                                            qry = (qry.Substring(paranthesisIndexStart + 1, (paranthesisIndexEnd - paranthesisIndexStart) - 1)).Trim();

                                        }
                                        if (whereIndex > 0)
                                        {
                                            whereIndex = qry.ToUpper().IndexOf(" WHERE ");
                                            qry = (qry.Substring(0, whereIndex)).Trim();
                                        }

                                        if (FromIndexEnd > 0)
                                        {
                                            FromIndexEnd = qry.ToUpper().IndexOf(" FROM ");
                                            qry = (qry.Substring(FromIndexEnd + 6)).Trim().Trim(')');
                                        }

                                        var qrytbl = qry.Trim('[', ']');
                                        qrytbl = qrytbl.Replace("Extract_", "");
                                        //check existence of extract before changing 
                                        var verifyTable = $@"IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = '{qrytbl}')  SELECT 1 ELSE SELECT 0";

                                        var result = this.mSession.ExecuteScalar(verifyTable).ToString();
                                        if (result == "1")
                                        {
                                            xEl.Value = xEl.Value.Replace(qry, $"[{qrytbl}]");

                                        }
                                    }

                                }
                                break;
                        }


                        DevExpress.DashboardCommon.Dashboard d = new DevExpress.DashboardCommon.Dashboard();


                        d.LoadFromXDocument(xdoc);
                        d.DataSources.OfType<DashboardSqlDataSource>().ToList().ForEach(ds =>
                        {
                            ds.ConnectionParameters = null;
                            ds.ConnectionOptions.DbCommandTimeout = 300;
                        });
                        d.DataConnections.Clear();
                        // cCookies.SourceType = "";

                        return d.SaveToXDocument();

                    }
                    else
                    {
                        return null;
                    }

                }
            }
            catch (Exception ex)
            {
      
                return null;
            }


        }

        IEnumerable<DashboardInfo> IDashboardStorage.GetAvailableDashboardsInfo()
        {
            List<DashboardInfo> list = new List<DashboardInfo>();

            try
            {
                StringBuilder str = new StringBuilder();
                str.AppendFormat("SELECT DashboardID, DashboardName, GroupName, Datasource, DashboardDefinition, IsCustomDashboard, ISNULL(DefaultSource,'L') DefaultSource, ExtractSchedule, LastExtractDate, ExtractStatus FROM fnGetAllowedDashboards(@UserID) ORDER BY GroupName, DashboardName");

                string[] parameters = new string[] { "UserID" };
                object[] parametersValues = new object[] { CookiesWrapper.thisUserID };

                SelectedData data = this.mSession.ExecuteQueryWithMetadata(str.ToString(), parameters, parametersValues);

                List<DashboardDto> dashBoard = new List<DashboardDto>();
                DataNamesMapper<DashboardDto> mapper = new DataNamesMapper<DashboardDto>();

                if (data != null)
                {

                    Dictionary<string, int> columnNames = new Dictionary<string, int>();
                    for (int columnIndex = 0; columnIndex < data.ResultSet[0].Rows.Length; columnIndex++)
                    {
                        string columnName = (string)data.ResultSet[0].Rows[columnIndex].Values[0];
                        columnNames.Add(columnName, columnIndex);
                    }

                    foreach (SelectStatementResultRow row in data.ResultSet[1].Rows)
                    {
                        string DashboardName = row.Values[columnNames["DashboardName"]].ToString();
                        string DashboardID = row.Values[columnNames["DashboardID"]].ToString();
                        list.Add(new DashboardInfo() { ID = DashboardID, Name = DashboardName });

                    }

                }

            }
            catch (Exception ex)
            {

            
            }

            return list;
        }

        void IDashboardStorage.SaveDashboard(string dashboardID, XDocument document)
        {
            try
            {
                string datasource = "";
                try
                {
                    string queryType = document.XPathSelectElement("/Dashboard/DataSources/SqlDataSource/Query").Attribute("Type").Value;
                    IEnumerable<XElement> xlEl = document.XPathSelectElements("/Dashboard/DataSources/SqlDataSource/Query");
                    switch (queryType)
                    {
                        case "SelectQuery":

                            foreach (XElement xmlElement in xlEl)
                            {
                                var xmlE = (IEnumerable)xmlElement.XPathEvaluate("Tables/Table");
                                foreach (var element in xmlE)
                                {
                                    var qry = ((XElement)element).Attribute("Name").Value.Replace("Extract_", "");
                                    datasource += (string.IsNullOrEmpty(datasource)) ? qry : "|" + qry;
                                }

                            }

                            break;
                        case "CustomSqlQuery":

                            var datasourceEls = document.XPathSelectElements("/Dashboard/DataSources/SqlDataSource/Query/Sql");

                            foreach (XElement datasourceEl in datasourceEls)
                            {
                                var qry = HelperFunctions.Catchnull(datasourceEl.Value, "").ToString().Replace("Extract_", "");
                                var i = qry.IndexOf(" order by ");
                                if (i > 0)
                                {
                                    qry = qry.Substring(0, i);
                                }
                                datasource += (string.IsNullOrEmpty(datasource)) ? qry : "|" + qry;
                            }
                            break;


                        case "StoredProcQuery":

                            foreach (XElement xmlElement in xlEl)
                            {
                                var xmlE = (IEnumerable)xmlElement.XPathEvaluate("ProcName");
                                foreach (var element in xmlE)
                                {
                                    var qry = ((XElement)element).Value;

                                    datasource += (string.IsNullOrEmpty(datasource)) ? $"exec {((XElement)element).Value}" : "| exec " + ((XElement)element).Value;
                                }

                            }

                            break;
                        default:
                            break;
                    }
                }
                catch (Exception)
                {
                    datasource = string.Empty;
                }

                MemoryStream stream = new MemoryStream();
                document.Save(stream);
                stream.Position = 0;

                //StringBuilder strUpdate = new StringBuilder();
                //strUpdate.AppendFormat("UPDATE [PBI_Dashboards] Set Datasource = @Datasource, DashboardDefinition = @DashboardDefinition WHERE DashboardID = @DashboardID");

                //string[] parameters = new string[] { "DashboardID", "DashboardDefinition", "Datasource" };
                //object[] parametersValues = new object[] { dashboardID, stream.ToArray() , datasource.Replace("Extract_", "") };

                //this.mSession.ExecuteNonQuery(strUpdate.ToString(), parameters, parametersValues);

                Dashboards dashboards = new Dashboards(mSession)
                {
                    DashboardID = Convert.ToInt16(dashboardID),
                    Datasource = datasource.Replace("Extract_", ""),
                    DashboardDefinition = stream.ToArray(),
                    DefaultSource = "L"
                };

                dashboards.Save();

            }
            catch (Exception ex)
            {

            }



        }

        public static List<DashboardInfo> GetDashboardsList(List<DashboardDto> dashboardList)
        {

            List<DashboardInfo> dashboardInfos = new List<DashboardInfo>();
            try
            {

                foreach (var item in dashboardList)
                {
                    dashboardInfos.Add(new DashboardInfo() { ID = item.DashboardID.ToString(), Name = item.DashboardName });

                }

                return dashboardInfos;
            }
            catch (Exception ex)
            {
             
                return dashboardInfos;
            }

        }


        public List<DashboardInfo> GetAvailableDashboards()
        {
            List<DashboardInfo> list = new List<DashboardInfo>();
            try
            {
                StringBuilder str = new StringBuilder();
                str.AppendFormat("SELECT DashboardID, DashboardName, GroupName, Datasource, DashboardDefinition, IsCustomDashboard, CreatedBy, CreatedDate, ISNULL(DefaultSource,'L') DefaultSource, ExtractSchedule, LastExtractDate, ExtractStatus FROM fnGetAllowedDashboards(@UserID) ORDER BY GroupName, DashboardName");

                string[] parameters = new string[] { "UserID" };
                object[] parametersValues = new object[] {  CookiesWrapper.thisUserID };

                SelectedData data = this.mSession.ExecuteQueryWithMetadata(str.ToString(), parameters, parametersValues);

                List<DashboardDto> dashBoard = new List<DashboardDto>();
                DataNamesMapper<DashboardDto> mapper = new DataNamesMapper<DashboardDto>();

                if (data != null)
                {
                    Dictionary<string, int> columnNames = new Dictionary<string, int>();
                    for (int columnIndex = 0; columnIndex < data.ResultSet[0].Rows.Length; columnIndex++)
                    {
                        string columnName = (string)data.ResultSet[0].Rows[columnIndex].Values[0];
                        columnNames.Add(columnName, columnIndex);
                    }

                    foreach (SelectStatementResultRow row in data.ResultSet[1].Rows)
                    {
                        string DashboardName = row.Values[columnNames["DashboardName"]].ToString();
                        string DashboardID = row.Values[columnNames["DashboardID"]].ToString();
                        list.Add(new DashboardInfo() { ID = DashboardID, Name = DashboardName });

                    }
                }

                return list;

            }
            catch (Exception ex)
            {
                
            }

            return list;
        }

        public List<DashboardDto> GetAvailableDashboardList()
        {
            List<DashboardDto> dashboard = new List<DashboardDto>();
            try
            {
                using (SqlConnection connection = new SqlConnection(this.ConnectionString))
                {
                    connection.Open();
                    StringBuilder str = new StringBuilder();
                    str.AppendFormat("SELECT DashboardID, DashboardName, GroupName, Datasource, DashboardDefinition, IsCustomDashboard, CreatedBy, CreatedDate,ISNULL(DefaultSource,'L') DefaultSource, ExtractSchedule, LastExtractDate, ExtractStatus FROM fnGetAllowedDashboards(@UserID) ORDER BY GroupName, DashboardName");
                    SqlCommand GetCommand = new SqlCommand(str.ToString());
                    GetCommand.Parameters.Add("@UserID", SqlDbType.Int).Value = Convert.ToInt32( CookiesWrapper.thisUserID);

                    GetCommand.Connection = connection;
                    SqlDataReader reader = GetCommand.ExecuteReader();
                    while (reader.Read())
                    {

                        long dashboardID = long.Parse(reader.GetValue(0).ToString());
                        string dashboardName = reader["DashboardName"] as string;
                        string groupName = reader["GroupName"] as string;
                        string datasource = reader["Datasource"] as string;
                        bool isCustomDashboard = bool.Parse(reader["IsCustomDashboard"] as string);
                        byte[] dashboardDefinition = reader["DashboardDefinition"] as byte[];

                        dashboard.Add(new DashboardDto()
                        {
                            DashboardID = dashboardID,
                            DashboardName = dashboardName,
                            GroupName = groupName,
                            Datasource = datasource.Replace("Extract_", ""),
                            IsCustomDashboard = isCustomDashboard,
                            DashboardDefinition = dashboardDefinition,
                        });


                    }
                    connection.Close();
                }

            }
            catch (Exception ex)
            {

              
            }


            return dashboard;
        }

        public bool DeleteDashboard(string dashboardID)
        {
            try
            {
                StringBuilder strUpdate = new StringBuilder();
                strUpdate.AppendFormat("DELETE FROM  [PBI_Dashboards]  WHERE DashboardID = @DashboardID");

                string[] parameters = new string[] { "DashboardID" };
                object[] parametersValues = new object[] { dashboardID };

                if (this.mSession.ExecuteNonQuery(strUpdate.ToString(), parameters, parametersValues) >= 0) { return true; } else { return false; }

            }
            catch (Exception ex)
            {
        
                return false;
            }

        }

        public bool AddToDashboardGroup(string dashboardID, string groupName)
        {
            try
            {
                StringBuilder strUpdate = new StringBuilder();
                strUpdate.AppendFormat("UPDATE [PBI_Dashboards] Set GroupName = @GroupName WHERE DashboardID = @DashboardID");

                string[] parameters = new string[] { "DashboardID", "GroupName" };
                object[] parametersValues = new object[] { dashboardID, groupName };

                if (this.mSession.ExecuteNonQuery(strUpdate.ToString(), parameters, parametersValues) > 0)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            catch (Exception ex)
            {
              
                return false;
            }

        }
        //select * from Groups where Group_Name = 'Administrator'
        public bool AddDashboardSecurity(string dashboardID, string groups, bool isNewDashboard)
        {
            try
            {
                var groupIDs = groups.Split(',');
                StringBuilder errors;
                if (groupIDs != null)
                {
                    foreach (string groupID in groupIDs)
                    {
                        try
                        {
                            StringBuilder strUpdate = new StringBuilder();
                            ArrayList parameters = new ArrayList();

                            if (!isNewDashboard)
                            {

                                string[] param = new string[] { "DashboardID", "Group_ID" };
                                object[] paramValues = new object[] { dashboardID, groupID };

                                strUpdate.AppendLine("INSERT INTO [Dashboard_Groups]([Dashboard_ID],[Group_ID])");
                                strUpdate.AppendLine("SELECT @DashboardID, @GroupID");
                                strUpdate.AppendLine("EXCEPT");
                                strUpdate.AppendLine("SELECT  [Dashboard_ID],[Group_ID] FROM  [Dashboard_Groups]");

                                this.mSession.ExecuteNonQuery(strUpdate.ToString(), param, paramValues);

                                //REMOVE ALL GROUPS THAT ARE NOT IN THE GROUP IDS LIST
                                try
                                {

                                    string[] paramD = new string[] { "DashboardID", "Group_ID" };
                                    object[] paramValuesD = new object[] { dashboardID, groupID };
                                    StringBuilder strDelete = new StringBuilder();
                                    strDelete.AppendLine($"DELETE  FROM  [Dashboard_Groups] WHERE [Dashboard_ID] = @DashboardID  AND [Group_ID] NOT IN ({groups})  ");

                                    this.mSession.ExecuteNonQuery(strDelete.ToString(), paramD, paramValuesD);
                                }
                                catch (Exception ex)
                                {
                                 
                                }
                            }
                            else if (isNewDashboard)
                            {

                                string[] param = new string[] { "DashboardID", "User_ID" };
                                object[] paramValues = new object[] { dashboardID, CookiesWrapper.thisUserID };

                                strUpdate.AppendLine("INSERT INTO [Dashboard_Users]([Dashboard_ID],[User_ID] )");
                                strUpdate.AppendLine("SELECT @DashboardID, @User_ID");
                                strUpdate.AppendLine("EXCEPT");
                                strUpdate.AppendLine("SELECT  [Dashboard_ID],[User_ID]  FROM  [Dashboard_Users]");

                                this.mSession.ExecuteNonQuery(strUpdate.ToString(), param, paramValues);
                            }


                        }
                        catch (Exception ex)
                        {
                           
                        }

                    }

                    return true;
                }
                else
                {
                    return false;
                }


            }
            catch (Exception ex)
            {
          
                return false;
            }

        }


        public bool SetDashboardDefaultSource(string dashboardID, string defaultSource)
        {
            try
            {

                StringBuilder strUpdate = new StringBuilder();
                strUpdate.AppendFormat("UPDATE [PBI_Dashboards] Set  DefaultSource = @DefaultSource WHERE DashboardID = @DashboardID");

                string[] param = new string[] { "DashboardID", "DefaultSource" };
                object[] paramValues = new object[] { dashboardID, defaultSource };

                this.mSession.ExecuteNonQuery(strUpdate.ToString(), param, paramValues).ToString();

                return true;

            }
            catch (Exception ex)
            {

                return false;
            }
        }
        private XDocument ApplyConnectionParameters(XDocument document)
        {
            try
            {
                SqlConnectionStringBuilder decoder = new SqlConnectionStringBuilder(this.ConnectionString);

                MsSqlConnectionParameters connectionParameters = new MsSqlConnectionParameters()
                {
                    ServerName = decoder.DataSource,
                    DatabaseName = decoder.InitialCatalog,
                    UserName = decoder.UserID,
                    Password = decoder.Password,
                    AuthorizationType = MsSqlAuthorizationType.SqlServer
                };
                try
                {
                    document.XPathSelectElement("//Dashboard/DataSources/SqlDataSource/Connection/Parameters/Parameter[@Name='server']").Attribute("Value").Value = connectionParameters.ServerName;
                    document.XPathSelectElement("//Dashboard/DataSources/SqlDataSource/Connection/Parameters/Parameter[@Name='database']").Attribute("Value").Value = connectionParameters.DatabaseName;
                    document.XPathSelectElement("//Dashboard/DataSources/SqlDataSource/Connection/Parameters/Parameter[@Name='userid']").Attribute("Value").Value = connectionParameters.UserName;
                    document.XPathSelectElement("//Dashboard/DataSources/SqlDataSource/Connection/Parameters/Parameter[@Name='password']").Attribute("Value").Value = connectionParameters.Password;

                }
                catch (Exception) { }
            }
            catch (Exception ex)
            {
         
            }
            return document;
        }

    }

}

