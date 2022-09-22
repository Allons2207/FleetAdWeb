using DevExpress.Xpo.DB;
using DevExpress.DataAccess.ConnectionParameters;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DevExpress.DataAccess.Sql;

namespace PertentoBI.Web.DashboardCustomisation
{
    public class CustomDBSchemaProvider : DBSchemaProviderEx
    {

        public override DBStoredProcedure[] GetProcedures(SqlDataConnection connection, params string[] procedureList)
        {
            var procedures = base.GetProcedures(connection, procedureList);
            if (procedureList.Length == 0)
            {
                //procedureList is empty if schema is loaded by the query builder
                return procedures.Where((d) => d.Name.StartsWith("PBI_")).ToArray();
            }
            else
            {
                //before data loading dashboard requests schema only for the used procedures
                return procedures;
            }
        }

        public override DBTable[] GetTables(SqlDataConnection connection, params string[] tableList)
        {
            return base.GetTables(connection, tableList);
        }

        public override DBTable[] GetViews(SqlDataConnection connection, params string[] viewList)
        {
            return base.GetViews(connection, viewList);
        }

        public override void LoadColumns(SqlDataConnection connection, params DBTable[] tables)
        {
            base.LoadColumns(connection, tables);
        }
    }
}