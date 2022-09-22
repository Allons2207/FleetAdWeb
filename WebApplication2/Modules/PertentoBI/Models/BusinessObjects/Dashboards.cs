using System;
using DevExpress.Xpo;
using DevExpress.Xpo.Metadata;
using DevExpress.Data.Filtering;
using System.Collections.Generic;
using System.ComponentModel;
using System.Reflection;
using DevExpress.Persistent.Base;
using System.Xml.Linq;
using System.IO;

namespace PertentoBI.BusinessObjects.Database
{

    public partial class Dashboards 
    {
        public Dashboards(Session session)
        {
           // base. = session;
        }

        //public string Title { get { throw new NotImplementedException(); } set => throw new NotImplementedException(); }
        public string Content
        {
            get
            {
                MemoryStream stream = new MemoryStream(fDashboardDefinition);
                XDocument xdoc = XDocument.Load(stream);
                return xdoc.ToString();
            }
            set
            {
                XDocument xdoc = XDocument.Load(value);
                MemoryStream stream = new MemoryStream();
                xdoc.Save(stream);
                SetPropertyValue<byte[]>(nameof(DashboardDefinition), ref fDashboardDefinition, stream.ToArray());
            }
        }
        //public bool SynchronizeTitle { get  {  throw new NotImplementedException(); set => throw new NotImplementedException(); }

        public override void AfterConstruction() { base.AfterConstruction(); }
    }

}
