using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
namespace PertentoBI.Classes.Mapping.Attributes
{

    [AttributeUsage(AttributeTargets.Property)]
    public class DataNamesAttribute : Attribute
    {
        protected List<string> fvalueNames { get; set; }

        public List<string> ValueNames
        {
            get
            {
                return fvalueNames;
            }
            set
            {
                fvalueNames = value;
            }
        }

        public DataNamesAttribute()
        {
            ValueNames = new List<string>();
        }

        public DataNamesAttribute(params string[] valueNames)
        {
            fvalueNames = valueNames.ToList();
        }
    }
}
