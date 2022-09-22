using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using PertentoBI.Classes.Mapping.Attributes;
using System.ComponentModel.DataAnnotations;

public class MenuItem
{
    [DataNames("ReportName")] public string MenuName { get; set; }
    [DataNames("ReportName")] public string ReportName { get; set; }
    [DataNames("Notes", "ParentGroup")] public string ParentMenu { get; set; }
    [DataNames("OwnID")] public string MenuID { get; set; }
    [DataNames("NavigationURL")] public string NavigationURL { get; set; }
    [DataNames("ImageURL")] public string ImageURL { get; set; }
    [DataNames("ImageType")] public string ImageType { get; set; }
    [DataNames("FColor")] public string FColor { get; set; }
    [DataNames("Color2")] public string Color2 { get; set; }
    [DataNames("Color1")] public string Color1 { get; set; }
    public string Text { get; set; }
    public List<MenuItem> Items { get; set; }
    public bool HasDashboard { get; set; }
}


