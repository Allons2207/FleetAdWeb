using PertentoBI.Classes.Mapping.Attributes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

public class ReportGroupDto
{
    [DataNames("ReportID")] public long ReportID { get; set; }
    [DataNames("ReportName")] public string ReportName { get; set; }
    [DataNames("ParentGroup")] public string ParentGroup { get; set; }
    [DataNames("Group_Name")] public string Group_Name { get; set; }
    [DataNames("Type")] public string ReportData { get; set; }
    [DataNames("Depth")] public long Depth { get; set; }
    [DataNames("Notes")] public string Notes { get; set; }
    [DataNames("NavigationURL")] public string NavigationURL { get; set; }
    [DataNames("ImageURL")] public string ImageURL { get; set; }
    [DataNames("Color1")] public string Color1 { get; set; }
    [DataNames("Color2")] public string Color2 { get; set; }
    [DataNames("FColor")] public string FColor { get; set; }
    [DataNames("ImageType")] public string ImageType { get; set; }

}
