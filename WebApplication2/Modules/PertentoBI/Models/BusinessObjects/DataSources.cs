using System;
using DevExpress.Xpo;
using DevExpress.Xpo.Metadata;
using DevExpress.Data.Filtering;
using System.Collections.Generic;
using System.ComponentModel;
using System.Reflection;
namespace PertentoBI.BusinessObjects.Database
{

    public partial class DataSources
    {
        public DataSources(Session session) : base(session) { }
        public override void AfterConstruction() { base.AfterConstruction(); }
    }

}
