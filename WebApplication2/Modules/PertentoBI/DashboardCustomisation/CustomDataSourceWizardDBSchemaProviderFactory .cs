using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DevExpress.DataAccess.Sql;
using DevExpress.DataAccess.Web;

namespace PertentoBI.Web.DashboardCustomisation
{
    public class CustomDataSourceWizardDBSchemaProviderFactory : IDataSourceWizardDBSchemaProviderExFactory
    {
        public IDBSchemaProviderEx Create()
        {
            return new CustomDBSchemaProvider();
        }

    }
}