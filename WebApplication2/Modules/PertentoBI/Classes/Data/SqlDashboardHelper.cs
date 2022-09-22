using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using DevExpress.DataAccess.ConnectionParameters;
using DevExpress.Xpo;
using System.Data;

    public static class SqlDashboardHelper
    {
        public static void SetupSqlParameters(MsSqlConnectionParameters connectionParameters)
        {
            connectionParameters.ServerName = "server";
            connectionParameters.DatabaseName = "database";
            connectionParameters.AuthorizationType = MsSqlAuthorizationType.SqlServer;
            connectionParameters.UserName = "user";
            connectionParameters.Password = "password";
        }

        public static void SetupSqlParameters()
        {
            MsSqlConnectionParameters connectionParameters = new MsSqlConnectionParameters();

            var connectionString = ConnectionHelper.ConnectionString;
            SqlConnectionStringBuilder builder = new SqlConnectionStringBuilder(connectionString);
            connectionParameters.ServerName = builder.DataSource;
            connectionParameters.DatabaseName = builder.InitialCatalog;
            connectionParameters.AuthorizationType = MsSqlAuthorizationType.Windows;
            if (builder.IntegratedSecurity == false)
            {
                connectionParameters.AuthorizationType = MsSqlAuthorizationType.SqlServer;
                connectionParameters.UserName = builder.UserID;
                connectionParameters.Password = builder.Password;
            }
        }
    }
