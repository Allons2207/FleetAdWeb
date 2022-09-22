using System.Collections.Generic;
using System.Data;
using System;
using DevExpress.Utils;
using System.IO;
using System.Web.Hosting;
using System.Configuration;
using DevExpress.DashboardWeb;
using System.Collections;
using System.Data.SqlClient;
using System.Text;
using System.Xml.Linq;

using DevExpress.Xpo;
using DevExpress.Xpo.DB;
using DevExpress.DataAccess.Sql;

namespace PertentoBI.Web.DashboardCustomisation
{
    public static class DataLoader
    {
     
        private static Dictionary<string, string> dicSQLReplaceCrit { get; set; } = new Dictionary<string, string>();

        static long userid = 1;


        public static string groupName;
        static string GetRelativePath(string name)
        {
            return Path.Combine(HostingEnvironment.MapPath("~"), "App_Data", "Data", name);
        }
        static SelectedData LoadData(string DashboardId, Session session)
        {


            SelectedData ds = new SelectedData();

            string[] parameters = new string[] { "DashboardID", "UserID" };
            object[] parametersValues = new object[] { DashboardId, CookiesWrapper.UserID };

            StringBuilder strSQl = new StringBuilder();
            strSQl.AppendFormat("SELECT  DashboardID, DashboardName, GroupName, Datasource, DashboardDefinition, IsCustomDashboard, CreatedBy, CreatedDate, DefaultSource, ExtractSchedule, LastExtractDate, ExtractStatus FROM fnGetAllowedDashboards(@UserID) WHERE DashboardID = @DashboardID");

            SelectedData data = session.ExecuteQueryWithMetadata(strSQl.ToString(), parameters, parametersValues);

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

                    string viewtodisplay = $"{row.Values[columnNames["Datasource"]].ToString()}";
                    groupName = row.Values[columnNames["GroupName"]].ToString();

                    string reportsql = DataLoader.CleanupDataDefinition(viewtodisplay).ToString();
                    var i = reportsql.ToString().IndexOf(" order by ");
                    if (i > 0)
                    {
                        reportsql = reportsql.Substring(0, i - 1);
                    }

                    ds = session.ExecuteQueryWithMetadata(reportsql);
                }

            }

            return ds;
        }
        public static SelectedData LoadDataview(string DashboardId, Session session)
        {
            return LoadData(DashboardId, session);
        }
        public static void LoadData(DataLoadingWebEventArgs e, Session session)
        {
            // e.DataSourceComponentName

            e.Data = LoadDataview(e.DashboardId, session);
        }

        public static StringBuilder CleanupDataDefinition(string viewtodisplay)
        {
            try
            {
                StringBuilder sqlQuery = new StringBuilder();

                if (viewtodisplay.ToLower().Contains("(select") | viewtodisplay.ToLower().Contains("dbo."))
                {
                    sqlQuery.AppendFormat("SELECT * FROM {0}", viewtodisplay);
                }
                else
                {
                    sqlQuery.AppendFormat("SELECT * FROM [{0}] ", viewtodisplay.TrimStart('[').TrimEnd(']'));
                }

                ReplaceDWFilters(ref sqlQuery);

                if (dicSQLReplaceCrit.Count > 0)
                {

                    foreach (KeyValuePair<string, string> kpair in dicSQLReplaceCrit)
                    {
                        sqlQuery = sqlQuery.Replace(kpair.Key, kpair.Value);
                    }

                }

                return sqlQuery;

            }
            catch (Exception ex)
            {
          
                return new StringBuilder(string.Empty);
            }
        }

        public static void ReplaceDWFilters(ref StringBuilder sqlQuery)
        {
            try
            {
                if (dicSQLReplaceCrit.Count > 0)
                {

                    //INSTANT C# NOTE: Commented this declaration since looping variables in 'foreach' loops are declared in the 'foreach' header in C#:
                    //				KeyValuePair<string, string> kpair = new KeyValuePair<string, string>();
                    foreach (KeyValuePair<string, string> kpair in dicSQLReplaceCrit)
                    {
                        sqlQuery = new StringBuilder(sqlQuery.ToString().Replace(kpair.Key, kpair.Value));
                    }

                }

            }
            catch (Exception ex)
            {
           
            }
        }

        public static void LoadDatasources(ref CustomDataSourceStorage dataSourceStorage, Session session)
        {



            string[] parameters = new string[] { "UserID" };
            object[] parametersValues = new object[] { CookiesWrapper.UserID };

            StringBuilder strSQl = new StringBuilder();
            strSQl.AppendFormat("SELECT  DatasourceID, DatasourceName, DatasourceValue FROM fnGetAllowedDashboardDatasources(@UserID) ORDER BY DatasourceName");

            SelectedData data = session.ExecuteQueryWithMetadata(strSQl.ToString(), parameters, parametersValues);

            dataSourceStorage.RegisterDataSource("SQL Datasource", DataSourceGenerator.CreateDataviewDataSource().SaveToXml());

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

                    string DatasourceName = $"{row.Values[columnNames["DatasourceName"]].ToString()}";
                    string reportsql = DataLoader.CleanupDataDefinition(row.Values[columnNames["DatasourceValue"]].ToString()).ToString();
                    var i = reportsql.ToString().IndexOf(" order by ");
                    if (i > 0)
                    {
                        reportsql = reportsql.Substring(0, i - 1);
                    }

                    dataSourceStorage.RegisterDataSource(DatasourceName, DataSourceGenerator.CreateDataviewDataSource(DatasourceName, reportsql).SaveToXml());
                }


            }

        }


        public static void LoadDatasource(ref DataSourceInMemoryStorage dataSourceStorage, string DashboardID, Session session)
        {


            string[] parameters = new string[] { "DashboardID", "UserID" };
            object[] parametersValues = new object[] { DashboardID, CookiesWrapper.UserID };

            StringBuilder strSQl = new StringBuilder();
            strSQl.AppendFormat("SELECT DashboardID, DashboardName, GroupName, Datasource, DashboardDefinition, IsCustomDashboard, CreatedBy, CreatedDate FROM fnGetAllowedDashboards (@UserID) WHERE  DashboardID = @DashboardID ORDER BY GroupName, DashboardName");

            SelectedData data = session.ExecuteQueryWithMetadata(strSQl.ToString(), parameters, parametersValues);

            dataSourceStorage.RegisterDataSource("SQL Datasource", DataSourceGenerator.CreateDataviewDataSource().SaveToXml());

            Dictionary<string, int> columnNames = new Dictionary<string, int>();
            for (int columnIndex = 0; columnIndex < data.ResultSet[0].Rows.Length; columnIndex++)
            {
                string columnName = (string)data.ResultSet[0].Rows[columnIndex].Values[0];
                columnNames.Add(columnName, columnIndex);
            }
            if (data != null)
            {
                foreach (SelectStatementResultRow row in data.ResultSet[1].Rows)
                {

                    string DatasourceName = $"{row.Values[columnNames["GroupName"]].ToString()} -> {row.Values[columnNames["DashboardName"]].ToString()}";
                    string reportsql = DataLoader.CleanupDataDefinition(row.Values[columnNames["Datasource"]].ToString()).ToString();
                    var i = reportsql.ToString().IndexOf(" order by ");
                    if (i > 0)
                    {
                        reportsql = reportsql.Substring(0, i - 1);
                    }

                    dataSourceStorage.RegisterDataSource(DatasourceName, DataSourceGenerator.CreateDataviewDataSource(DatasourceName, reportsql).SaveToXml());
                }

            }

        }

        public static IEnumerable<string> GetDatasourcesNames(Session session)
        {


            string[] parameters = new string[] { "UserID" };
            object[] parametersValues = new object[] { CookiesWrapper.thisUserID };

            StringBuilder strSQl = new StringBuilder();
            strSQl.AppendFormat("SELECT  DatasourceID, DatasourceName, DatasourceValue,ConnectionString FROM fnGetAllowedDashboardDatasources(@UserID) ORDER BY DatasourceName");

            SelectedData data = session.ExecuteQueryWithMetadata(strSQl.ToString(), parameters, parametersValues);

            Dictionary<string, int> columnNames = new Dictionary<string, int>();
            for (int columnIndex = 0; columnIndex < data.ResultSet[0].Rows.Length; columnIndex++)
            {
                string columnName = (string)data.ResultSet[0].Rows[columnIndex].Values[0];
                columnNames.Add(columnName, columnIndex);
            }

            foreach (SelectStatementResultRow row in data.ResultSet[1].Rows)
            {
                string DatasourceName = $"{row.Values[columnNames["DatasourceName"]].ToString()}";

                //string reportsql = DataLoader.CleanupDataDefinition(dr["DatasourceValue"].ToString()).ToString();
                yield return DatasourceName;
            }

        }

        public static XDocument GetDatasource(String DatasourceName, Session session)
        {

            try
            {


                //ArrayList parameters = new ArrayList();
                //parameters.Add(new SqlParameter("@UserID", userid));
                //parameters.Add(new SqlParameter("@DatasourceName", DatasourceName));

                string[] parameters = new string[] { "DatasourceName", "UserID" };
                object[] parametersValues = new object[] { DatasourceName, CookiesWrapper.UserID };

                StringBuilder strSQl = new StringBuilder();
                strSQl.AppendFormat("SELECT DatasourceValue FROM fnGetAllowedDashboardDatasources(@UserID) WHERE DatasourceName = @DatasourceName");

                String DatasourceValue = session.ExecuteScalar(strSQl.ToString(), parameters, parametersValues).ToString();

                string reportsql = DatasourceValue.ToString();
                XDocument xDocument = new XDocument(new object[1] { DataSourceGenerator.CreateDataviewDataSource(DatasourceName, reportsql).SaveToXml() });
                return xDocument;

            }
            catch (Exception ex)
            {
              
                return null;
            }

        }


        public static SelectedData GetDashboardGroup(string dashboardid, Session session)
        {

            try
            {


                string[] parameters = new string[] { "DashboardID", "UserID" };
                object[] parametersValues = new object[] { Convert.ToInt32(dashboardid), CookiesWrapper.UserID };

                StringBuilder strSQl = new StringBuilder();

                strSQl.AppendLine(";WITH GROUPS AS");
                strSQl.AppendLine("(");
                strSQl.AppendLine("SELECT Distinct Dash.GroupName, NULL as DashboardID   FROM fnGetAllowedDashboards(@UserID) Dash");
                strSQl.AppendLine(" UNION ");
                strSQl.AppendLine("SELECT 'Dashboard', NULL");
                strSQl.AppendLine(") , Dashgrp as");
                strSQl.AppendLine("(");
                strSQl.AppendLine("    select Distinct Dash.GroupName, DashboardID   FROM fnGetAllowedDashboards(@UserID) Dash  WHERE  DashboardID  = @DashboardID ");
                strSQl.AppendLine(")");
                strSQl.AppendLine("SELECT Distinct groups.GroupName, Case when isnull(Dashgrp.DashboardID,0) = 0 then 0 else 1 end AS Selected   from groups ");
                strSQl.AppendLine("LEFT JOIN Dashgrp on groups.GroupName  = 	Dashgrp.GroupName");
                strSQl.AppendLine("");

                SelectedData dsReports = session.ExecuteQueryWithMetadata(strSQl.ToString(), parameters, parametersValues);


                return dsReports;

            }
            catch (Exception ex)
            {
          
                return null;
            }
        }

        public static DefaultDashboardSource GetDefaultSourceType(string dashboardID, Session session)
        {
            string sourceType = "";
            string lastExtractDate = "";
            string extractStatus = "";
            bool HasExtract = false;


            DefaultDashboardSource defaultDashboardSource = new DefaultDashboardSource("", "", "", false);
            try
            {


                if (!string.IsNullOrEmpty(dashboardID) && (dashboardID != "0"))
                {
                    StringBuilder strSQl = new StringBuilder("SELECT ISNULL(DefaultSource,'L') DefaultSource, ISNULL(LastExtractDate,'') LastExtractDate, ISNULL(ExtractStatus,'') ExtractStatus,dbo.fn_Dashboards_HasExtract(Datasource) HasExtract FROM fnGetAllowedDashboards(@UserID)  WHERE DashboardID=@DashboardID");
                    string[] parameters = new string[] { "DashboardID", "UserID" };
                    object[] parametersValues = new object[] { Convert.ToInt32(dashboardID), Convert.ToInt32(userid) };

                    SelectedData dsReports = session.ExecuteQuery(strSQl.ToString(), parameters, parametersValues);

                    if (dsReports != null)
                    {

                        SelectStatementResultRow reader = dsReports.ResultSet[0].Rows[0];

                        sourceType = reader.Values[0] as string;
                        lastExtractDate = reader.Values[1].ToString();
                        extractStatus = reader.Values[2].ToString();
                        HasExtract = Convert.ToBoolean(reader.Values[3]);
                        defaultDashboardSource = new DefaultDashboardSource(sourceType, lastExtractDate, extractStatus, HasExtract);
                    }
                }

                return defaultDashboardSource;
            }
            catch (Exception ex)
            {
              
                return defaultDashboardSource;
            }

        }
    }


    public struct DefaultDashboardSource
    {
        public string SourceType, LastExtractDate, ExtractStatus;
        public Boolean HasExtract;

        public DefaultDashboardSource(string sourceType, string lastExtractDate, string extractStatus, bool hasExtract)
        {
            SourceType = sourceType;
            LastExtractDate = lastExtractDate;
            ExtractStatus = extractStatus;
            HasExtract = hasExtract;
        }
    }
}





