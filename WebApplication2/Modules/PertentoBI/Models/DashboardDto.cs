using PertentoBI.Classes.Mapping.Attributes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

public class DashboardDto
{
    [DataNames("DashboardID")] public long DashboardID { get; set; }
    [DataNames("DashboardName")] public string DashboardName { get; set; }
    [DataNames("GroupName")] public string GroupName { get; set; }
    [DataNames("Datasource")] public string Datasource { get; set; }
    [DataNames("IsCustomDashboard")] public bool IsCustomDashboard { get; set; }
    [DataNames("CreatedBy")] public long CreatedBy { get; set; }
    [DataNames("CreatedDate")] public string CreatedDate { get; set; }
    [DataNames("DefaultSource")] public string DefaultSource { get; set; }
    [DataNames("ExtractSchedule")] public string ExtractSchedule { get; set; }
    [DataNames("LastExtractDate")] public string LastExtractDate { get; set; }
    [DataNames("ExtractStatus")] public string ExtractStatus { get; set; }
    public byte[] DashboardDefinition { get; set; }

}
