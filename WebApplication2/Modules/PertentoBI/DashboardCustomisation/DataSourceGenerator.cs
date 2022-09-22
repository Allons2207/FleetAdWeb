using DevExpress.DashboardCommon;
using DevExpress.DataAccess.ConnectionParameters;
using DevExpress.DataAccess.Sql;
using PertentoBI.Classes;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace PertentoBI.Web.DashboardCustomisation
{
    public static class DataSourceGenerator
    {
        public static DashboardSqlDataSource CreateDataviewDataSource(string DatasourceName, string reportsql)
        {

            string dashboardname = DatasourceName;
            HelperFunctions.CleanupFilename(ref DatasourceName);

            DashboardSqlDataSource dashboardSqlDataSource1 = new DashboardSqlDataSource(DatasourceName);
            CustomSqlQuery query = new CustomSqlQuery(DatasourceName, reportsql);
            dashboardSqlDataSource1.Queries.Add(query);

            return dashboardSqlDataSource1;
        }
        public static DashboardSqlDataSource CreateDataviewDataSource()
        {

            DashboardSqlDataSource dashboardSqlDataSource1 = new DashboardSqlDataSource("SQL Datasource");

            return dashboardSqlDataSource1;
        }

    }
}
