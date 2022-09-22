using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DevExpress.DataAccess.ConnectionParameters;
using DevExpress.DataAccess.Web;
using System.Configuration;
using System.Data.SqlClient;
using DevExpress.DashboardWeb;
using System.Data;
using System.Text;
using DevExpress.Xpo.DB;
using DevExpress.Xpo;

namespace PertentoBI.Web.DashboardCustomisation
{
    public class ConnectionStringsProvider : IDataSourceWizardConnectionStringsProvider
    {
        Dictionary<string, DataConnectionParametersBase> connections = new Dictionary<string, DataConnectionParametersBase>();
       
        private Session mSession;

        public ConnectionStringsProvider( MsSqlConnectionParameters connectionParameters, Session session)
        {

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
            // }

            this.mSession = session;

               connections.Add("MSSqlServer", new CustomStringConnectionParameters(connectionString));
                GetConnectionsFromDatasources(connections);

            //var connectionString = DevExpress.Internal.DbEngineDetector.PatchConnectionString(objBus.Connection_String_DOTNET) + ";XpoProvider=MSSqlServer";

        }

        public ConnectionStringsProvider(Session session)
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
            // }

            this.mSession = session;

            connections.Add("MSSqlServer", new CustomStringConnectionParameters(connectionString));
            GetConnectionsFromDatasources(connections);

            //var connectionString = DevExpress.Internal.DbEngineDetector.PatchConnectionString(objBus.Connection_String_DOTNET) + ";XpoProvider=MSSqlServer";

        }

        Dictionary<string, string> IDataSourceWizardConnectionStringsProvider.GetConnectionDescriptions()
        {
            try
            {
                return connections.Keys.ToDictionary(key => key, value => value);
            }
            catch (Exception ex)
            {
          
                return connections.Keys.ToDictionary(key => key, value => value);
            }

        }

        DataConnectionParametersBase IDataSourceWizardConnectionStringsProvider.GetDataConnectionParameters(string name)
        {
            return connections[name];
        }
        public Dictionary<string, string> GetConnectionDescriptions()
        {
            Dictionary<string, string> connections = new Dictionary<string, string>();

            // Customize the loaded connections list.  
            // connections.Add("msAccessConnection", "MS Access Connection");
            connections.Add("msSqlConnection", "MS SQL Connection");
            return connections;
        }

        public DataConnectionParametersBase GetDataConnectionParameters(string name)
        {
            // Return custom connection parameters for the custom connection.
            if (name == "msAccessConnection")
            {
                return new Access97ConnectionParameters("|DataDirectory|nwind.mdb", "", "");
            }
            else if (name == "msSqlConnection")
            {

                SqlConnectionStringBuilder decoder = new SqlConnectionStringBuilder(ConnectionHelper.ConnectionString);

                return new MsSqlConnectionParameters(decoder.DataSource, decoder.InitialCatalog, decoder.UserID, decoder.Password, MsSqlAuthorizationType.SqlServer);
            }
            else
            {

                SqlConnectionStringBuilder decoder = new SqlConnectionStringBuilder(ConnectionHelper.ConnectionString);

                return new MsSqlConnectionParameters(decoder.DataSource, decoder.InitialCatalog, decoder.UserID, decoder.Password, MsSqlAuthorizationType.SqlServer);
            }
            throw new System.Exception("The connection string is undefined.");
        }

        public void GetConnectionsFromDatasources(Dictionary<string, DataConnectionParametersBase> connections)
        {
            try
            {

                string[] parameters = new string[] { "UserID" };
                object[] parametersValues = new object[] { CookiesWrapper.UserID };

                StringBuilder strSQl = new StringBuilder();
                strSQl.AppendFormat("SELECT  DatasourceID, DatasourceName, DatasourceValue,ConnectionString FROM fnGetAllowedDashboardDatasources(@UserID) ORDER BY DatasourceName");

                SelectedData data = this.mSession.ExecuteQueryWithMetadata(strSQl.ToString(), parameters, parametersValues);

                Dictionary<string, int> columnNames = new Dictionary<string, int>();
                for (int columnIndex = 0; columnIndex < data.ResultSet[0].Rows.Length; columnIndex++)
                {
                    string columnName = (string)data.ResultSet[0].Rows[columnIndex].Values[0];
                    columnNames.Add(columnName, columnIndex);
                }

                foreach (SelectStatementResultRow row in data.ResultSet[1].Rows)
                {
                    string DatasourceName = row.Values[columnNames["DatasourceName"]].ToString();

                    string conn = row.Values[columnNames["ConnectionString"]].ToString();
                    connections.Add(DatasourceName, new CustomStringConnectionParameters(conn));
                }
            }
            catch (Exception ex)
            {

        
            }

        }

    }

}

