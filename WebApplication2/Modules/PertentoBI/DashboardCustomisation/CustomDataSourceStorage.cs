using DevExpress.DashboardCommon;
using DevExpress.DashboardWeb;
using DevExpress.Xpo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Linq;

namespace PertentoBI.Web.DashboardCustomisation
{
    public class CustomDataSourceStorage : IDataSourceStorage
    {
        Dictionary<string, XDocument> documents = new Dictionary<string, XDocument>();
        private Dictionary<string, XDocument> dataSources = new Dictionary<string, XDocument>();

        private Session mSession;
        public CustomDataSourceStorage(Session session)
        {
            this.mSession = session;
        }

        public void RegisterDataSource(XElement rootElement)
        {
            this.RegisterDataSource(Guid.NewGuid().ToString(), rootElement);
        }

        public void RegisterDataSource(XDocument document)
        {
            this.RegisterDataSource(Guid.NewGuid().ToString(), document);
        }

        public void RegisterDataSource(string dataSourceId, XElement rootElement)
        {
            this.RegisterDataSource(dataSourceId, new XDocument(new object[1]
            {
        (object) rootElement
            }));
        }

        public void RegisterDataSource(string dataSourceId, XDocument document)
        {
            this.dataSources[dataSourceId] = document;
        }

        IEnumerable<string> IDataSourceStorage.GetDataSourcesID()
        {

            return (IEnumerable<string>)DataLoader.GetDatasourcesNames(this.mSession);
        }

        XDocument IDataSourceStorage.GetDataSource(string dataSourceID)
        {
            return DataLoader.GetDatasource(dataSourceID, this.mSession);
        }
    }
}