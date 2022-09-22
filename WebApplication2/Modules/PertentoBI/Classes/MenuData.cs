//using PertentoBI.Classes;
//using Newtonsoft.Json;
//using System;
//using System.Collections;
//using System.Collections.Generic;
//using System.Data;
//using System.Data.SqlClient;
//using System.Linq;
//using System.Text;
//using System.Threading.Tasks;
//using PertentoBI.Classes.Mapping;
//using PertentoBI.Models;
//using DevExpress.Xpo.DB;
//using DevExpress.Xpo;

//static class MenuData
//{
//     private static log4net.ILog log = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);
//    //public static List<MenuItem> Reports = GetMenu();
//    private static Session mSession = XpoHelper.GetNewSession();

//    public static List<MenuItem> GetMenu()
//    {

//        //ArrayList parameters = new ArrayList();
//        //parameters.Add(new SqlParameter("@UserID",  CookiesWrapper.thisUserID));
//        string[] parameters = new string[] { "UserID" };
//        object[] parametersValues = new object[] {  CookiesWrapper.thisUserID };

//        StringBuilder strSQl = new StringBuilder();
//        strSQl.AppendFormat("SELECT ownID,ReportName, ReportFileName, ReportGroup,ReportData,Notes FROM fnGetAllowedReports(@UserID) WHERE ReportGroup = 'DataView' ORDER BY notes, reportname");

//        //DataSet dsReports = objBus.mDB.GetDataSet(strSQl, parameters);
//        SelectedData data = mSession.ExecuteQueryWithMetadata(strSQl.ToString(), parameters, parametersValues);

//        List<DashboardDto> dashBoard = new List<DashboardDto>();
//        DataNamesMapper<DashboardDto> mapper = new DataNamesMapper<DashboardDto>();

//        if (data != null)
//        {

//            Dictionary<string, int> columnNames = new Dictionary<string, int>();
//            for (int columnIndex = 0; columnIndex < data.ResultSet[0].Rows.Length; columnIndex++)
//            {
//                string columnName = (string)data.ResultSet[0].Rows[columnIndex].Values[0];
//                columnNames.Add(columnName, columnIndex);
//            }

//            foreach (SelectStatementResultRow row in data.ResultSet[1].Rows)
//            {
//                string DashboardName = row.Values[columnNames["DashboardName"]].ToString();
//                string DashboardID = row.Values[columnNames["DashboardID"]].ToString();
//                list.Add(new DashboardInfo() { ID = DashboardID, Name = DashboardName });

//            }

//        }

//        List<DataViewDto> dataView = new List<DataViewDto>();
//        DataNamesMapper<DataViewDto> mapper = new DataNamesMapper<DataViewDto>();

//        if (dsReports != null)
//        {
//            foreach (DataRow dr in dsReports.Tables[0].Rows)
//            {

//                var dt = mapper.Map(dr);

//                dataView.Add(dt);
//            }


//        }

//        return BuildMenu(dataView);
//    }


//    public static List<MenuItem> GetGroupMenu()
//    {

//        ArrayList parameters = new ArrayList();
//        parameters.Add(new SqlParameter("@UserID",  CookiesWrapper.thisUserID));

//        StringBuilder strSQl = new StringBuilder();
//        strSQl.AppendFormat("SELECT Group_Name, ParentGroup, Depth,  ReportID, Type, ReportName  FROM  dbo.fnGetAllowedReportingGroups(@UserID) WHERE [Type] = 'Group' ORDER BY Group_Name");

//        DataSet dsReports = objBus.mDB.GetDataSet(strSQl, parameters);

//        List<ReportGroupDto> reportGroups = new List<ReportGroupDto>();
//        DataNamesMapper<ReportGroupDto> mapper = new DataNamesMapper<ReportGroupDto>();

//        if (dsReports != null)
//        {
//            foreach (DataRow dr in dsReports.Tables[0].Rows)
//            {

//                var dt = mapper.Map(dr);

//                reportGroups.Add(dt);
//            }


//        }

//        return BuildMenu(reportGroups);
//    }

//    public static List<MenuItem> GetGroupNameMenu(string GroupName)
//    {

//        ArrayList parameters = new ArrayList();
//        parameters.Add(new SqlParameter("@UserID",  CookiesWrapper.thisUserID));
//        parameters.Add(new SqlParameter("@GroupName", GroupName));

//        StringBuilder strSQl = new StringBuilder();
//        strSQl.AppendFormat("SELECT * FROM  dbo.fnGetAllowedReportingGroupsByGroupName(@UserID, @GroupName) ORDER BY Group_Name");

//        DataSet dsReports = objBus.mDB.GetDataSet(strSQl, parameters);

//        List<ReportGroupDto> reportGroups = new List<ReportGroupDto>();
//        DataNamesMapper<ReportGroupDto> mapper = new DataNamesMapper<ReportGroupDto>();

//        if (dsReports != null)
//        {
//            foreach (DataRow dr in dsReports.Tables[0].Rows)
//            {

//                var dt = mapper.Map(dr);

//                reportGroups.Add(dt);
//            }


//        }

//        return BuildMenu(reportGroups);
//    }


//    public static System.Data.DataSet GetGroupMenuDataset(long Level, string groupName)
//    {
//        try
//        {

//            ArrayList parameters = new ArrayList();
//            parameters.Add(new SqlParameter("@UserID",  CookiesWrapper.thisUserID));
//            parameters.Add(new SqlParameter("@Depth", Level));
//            parameters.Add(new SqlParameter("@GroupName", groupName));

//            StringBuilder strSQl = new StringBuilder();

//            DataSet dsReports = objBus.mDB.GetDataSet_SP("sp_GetTileList", parameters);


//            return dsReports;
//        }
//        catch (Exception ex)
//        {
//           log.Error(ex);
//            return null;
//        }
//    }

//    public static System.Data.DataSet GetGroupMenuDataset_dx(long Level, string groupName)
//    {
//        try
//        {

//            ArrayList parameters = new ArrayList();
//            parameters.Add(new SqlParameter("@UserID",  CookiesWrapper.thisUserID));
//            parameters.Add(new SqlParameter("@Depth", Level));
//            parameters.Add(new SqlParameter("@GroupName", groupName));

//            StringBuilder strSQl = new StringBuilder();

//            DataSet dsReports = objBus.mDB.GetDataSet_SP("sp_GetTileList_dx", parameters);


//            return dsReports;
//        }
//        catch (Exception ex)
//        {
//           log.Error(ex);
//            return null;
//        }
//    }

//    private static List<MenuItem> BuildMenu(List<DataViewDto> dataViewList)
//    {
//        List<MenuItem> mnu = new List<MenuItem>();
//        try
//        {

//            var distinctList = dataViewList.GroupBy(elem => elem.Notes).Select(group => group.First()).ToList();
//            distinctList.ForEach((item) =>

//           mnu.Add(new MenuItem
//           {
//               MenuID = item.OwnID.ToString(),
//               Text = item.Notes,
//               ReportName = "",
//               MenuName = item.Notes,
//               Items = new List<MenuItem>()
//           }));

//            foreach (MenuItem item in mnu)
//            {
//                IEnumerable<DataViewDto> itemlist = from mnuitem in dataViewList
//                                                    where mnuitem.Notes == item.MenuName

//                                                    select mnuitem;

//                foreach (var mni in itemlist)
//                {
//                    MenuItem mnuitm = new MenuItem
//                    {
//                        MenuID = mni.OwnID.ToString(),
//                        Text = mni.ReportName,
//                        ReportName = mni.ReportName,
//                        MenuName = mni.ReportName,
//                        ParentMenu = mni.Notes,
//                        Items = new List<MenuItem>()
//                    };
//                    item.Items.Add(mnuitm);
//                }

//            }

//            return mnu;
//        }
//        catch (Exception ex)
//        {
//           log.Error(ex);
//            return mnu;
//        }

//    }


//    private static List<MenuItem> BuildMenu(List<ReportGroupDto> dataViewList)
//    {
//        List<MenuItem> mnu = new List<MenuItem>();
//        try
//        {

//            var distinctList = dataViewList.GroupBy(elem => elem.Group_Name).Select(group => group.First()).ToList();
//            distinctList.ForEach((item) =>

//       mnu.Add(new MenuItem
//       {
//           MenuID = item.Group_Name,
//           Text = item.Group_Name,
//           ReportName = "",
//           MenuName = item.Group_Name,
//           Items = new List<MenuItem>(),
//           NavigationURL = item.NavigationURL,
//           ImageURL = item.ImageURL,
//           ImageType = item.ImageType,
//           Color1 = item.Color1,
//           Color2 = item.Color2,
//           FColor = item.FColor
//       }));

//            foreach (MenuItem item in mnu)
//            {
//                IEnumerable<ReportGroupDto> itemlist = from mnuitem in dataViewList
//                                                       where (mnuitem.ReportData != "Group")

//                                                       select mnuitem;

//                foreach (var mni in itemlist)
//                {
//                    MenuItem mnuitm = new MenuItem
//                    {
//                        MenuID = mni.ReportName,
//                        Text = mni.ReportName,
//                        ReportName = mni.ReportName,
//                        MenuName = mni.ReportName,
//                        ParentMenu = mni.ParentGroup,
//                        Items = new List<MenuItem>(),
//                        NavigationURL = mni.NavigationURL,
//                        ImageURL = mni.ImageURL,
//                        ImageType = mni.ImageType,
//                        Color1 = mni.Color1,
//                        Color2 = mni.Color2,
//                        FColor = mni.FColor
//                    };
//                    item.Items.Add(mnuitm);
//                }

//            }

//            return mnu;
//        }
//        catch (Exception ex)
//        {
//           log.Error(ex);
//            return mnu;
//        }

//    }

//}
