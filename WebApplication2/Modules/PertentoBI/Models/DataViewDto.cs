using PertentoBI.Classes.Mapping.Attributes;
using System.ComponentModel.DataAnnotations;
using System.Xml;

namespace PertentoBI.Models
{
    public class DataViewDto
    {
        [DataNames("OwnID")] public long OwnID { get; set; }
        [DataNames("ReportName")] public string ReportName { get; set; }
        [DataNames("ReportFileName")] public string ReportFileName { get; set; }
        [DataNames("ReportGroup")] public string ReportGroup { get; set; }
        [DataNames("ReportData")] public string ReportData { get; set; }
        [DataNames("Notes")] public string Notes { get; set; }
        public byte[] Dashboard { get; set; }
   
    }

}