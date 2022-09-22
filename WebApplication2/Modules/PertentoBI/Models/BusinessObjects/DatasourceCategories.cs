using System;
using DevExpress.Xpo;
using DevExpress.Xpo.Metadata;
using DevExpress.Data.Filtering;
using System.Collections.Generic;
using System.ComponentModel;
using System.Reflection;
namespace PertentoBI.BusinessObjects.Database
{

    public partial class DatasourceCategories
    {
        public DatasourceCategories(Session session) : base(session) { }
        public override void AfterConstruction() { base.AfterConstruction(); }
    }

}
