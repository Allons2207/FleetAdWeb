
//using System;
//using System.Collections.Generic;
//using System.IO;
//using PertentoBI.Classes;
//using DevExpress.Web;
//using System.Web.UI;
//using System.Text;

//public class MenuBuilderHelper
//{
//    private static List<MenuItem> menu;
//         private static log4net.ILog log = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);
//    public static ASPxTreeView BuildDxTreeMenu(ASPxTreeView dxTvMenu)
//    {
//        try
//        {
//            Dictionary<string, DevExpress.Web.TreeViewNode> menuItems = new Dictionary<string, DevExpress.Web.TreeViewNode>();
//            menu = MenuData.GetMenu();
//            for (int i = 0; i < menu.Count; i++)
//            {
//                MenuItem mnuItem = menu[i];
//                DevExpress.Web.TreeViewNode item = CreateTreeViewMenuNode(mnuItem);
//                string itemID = mnuItem.MenuName;
//                string parentID = mnuItem.ParentMenu;

//                if (menuItems.ContainsKey(HelperFunctions.Catchnull(parentID, "0", true).ToString()))
//                    menuItems[parentID].Nodes.Add(item);
//                else
//                {
//                    if (HelperFunctions.Catchnull(parentID, "0", true).ToString() == "0") // It's Root Item
//                        dxTvMenu.Nodes.Add(item);
//                }
//                menuItems.Add(itemID, item);
//            }
//        }
//        catch (Exception ex)
//        {
//           log.Error(ex);
//        }

//        return dxTvMenu;
//    }
//    public static ASPxMenu BuildMenu(ASPxMenu dxMenu)
//    {
//        try
//        {
//            Dictionary<string, DevExpress.Web.MenuItem> menuItems = new Dictionary<string, DevExpress.Web.MenuItem>();
//            menu = MenuData.GetMenu();

//            for (int i = 0; i < menu.Count; i++)
//            {
//                MenuItem mnuItem = menu[i];
//                DevExpress.Web.MenuItem item = CreateMenuItem(mnuItem);
//                string itemID = mnuItem.MenuName;
//                string parentID = mnuItem.ParentMenu;

//                if (menuItems.ContainsKey(HelperFunctions.Catchnull(parentID, "0", true).ToString()))
//                    menuItems[parentID].Items.Add(item);
//                else
//                {
//                    if (HelperFunctions.Catchnull(parentID, "0", true).ToString() == "0") // It's Root Item
//                        dxMenu.Items.Add(item);
//                }
//                menuItems.Add(itemID, item);
//            }
//        }
//        catch (Exception ex)
//        {
//           log.Error(ex);
//        }
//        return dxMenu;
//    }
//    public static ASPxNavBar BuildDxNavBarMenu(ASPxNavBar dxNavBar, string GroupName = "")
//    {
//        try
//        {

//            Dictionary<string, DevExpress.Web.NavBarItem> menuItems = new Dictionary<string, DevExpress.Web.NavBarItem>();
//            if (string.IsNullOrEmpty(GroupName)) { menu = MenuData.GetGroupMenu(); }
//            else
//            {
//                menu = MenuData.GetGroupNameMenu(GroupName);
//            }

//            for (int i = 0; i < menu.Count; i++)
//            {
//                MenuItem mnuItem = menu[i];
//                DevExpress.Web.NavBarItem item = new NavBarItem(mnuItem.MenuName, mnuItem.ParentMenu);

//                string itemID = mnuItem.MenuName;
//                string parentID = mnuItem.ParentMenu;

//                if (menuItems.ContainsKey(HelperFunctions.Catchnull(parentID, "0", true).ToString()))
//                {
//                    //dxNavBar.Groups.Items[.Add(item);
//                }
//                else
//                {
//                    if (HelperFunctions.Catchnull(parentID, "0", true).ToString() == "0") // It's Root Item
//                    {
//                        DevExpress.Web.NavBarGroup gitem = CreateNavBarGroupMenuItem(mnuItem);
//                        gitem.Expanded = false;
//                        dxNavBar.Groups.Add(gitem);
//                    }
//                }
//                menuItems.Add(itemID, item);

//            }
//        }
//        catch (Exception ex)
//        {
//           log.Error(ex);
//        }
//        return dxNavBar;
//    }
//    private static DevExpress.Web.MenuItem CreateMenuItem(MenuItem menuItem)
//    {
//        DevExpress.Web.MenuItem ret = new DevExpress.Web.MenuItem();
//        try
//        {
//            ret.Text = menuItem.Text.ToString();
//            ret.NavigateUrl = $"{General.dataviewPage()}?src={menuItem.ReportName}";
//            if (menuItem.Items.Count > 0)
//            {
//                for (int i = 0; i < menuItem.Items.Count; i++)
//                {
//                    ret.Items.Add(CreateMenuItem(menuItem.Items[i]));
//                }
//            }
//        }
//        catch (Exception ex)
//        {
//           log.Error(ex);
//        }
//        return ret;

//    }
//    private static DevExpress.Web.TreeViewNode CreateTreeViewMenuNode(MenuItem menuItem)
//    {
//        DevExpress.Web.TreeViewNode ret = new DevExpress.Web.TreeViewNode();
//        try
//        {
//            ret.Text = menuItem.Text.ToString();
//            ret.NavigateUrl = $"{General.dataviewPage()}?src={menuItem.ReportName}";

//            if (menuItem.Items.Count > 0)
//            {
//                for (int i = 0; i < menuItem.Items.Count; i++)
//                {
//                    ret.Nodes.Add(CreateTreeViewMenuNode(menuItem.Items[i]));
//                }
//            }
//        }
//        catch (Exception ex)
//        {
//           log.Error(ex);
//        }
//        return ret;

//    }
//    private static DevExpress.Web.NavBarItem CreateNavBarMenuItem(MenuItem menuItem)
//    {
//        DevExpress.Web.NavBarItem ret = new DevExpress.Web.NavBarItem();
//        try
//        {

//            System.Web.UI.WebControls.Image img = new System.Web.UI.WebControls.Image();
//            StringBuilder imgUrl = new StringBuilder();
//            if (img != null)
//            {
//                img.ImageUrl = ($"data:image/{HelperFunctions.Catchnull(menuItem.ImageType, "png", true)};base64,{menuItem.ImageURL}").ToString();
//            }


//            ret.Text = menuItem.Text.ToString();
//            ret.NavigateUrl = menuItem.NavigationURL;
//            ret.Image.Url = ($"data:image/{HelperFunctions.Catchnull(menuItem.ImageType, "png", true)};base64,{menuItem.ImageURL}").ToString();
//            ret.Name = menuItem.MenuID;
//            ret.Image.Url = img.ImageUrl;
//            ret.Image.Width = 30;
//            ret.Image.Height = 30;
//        }
//        catch (Exception ex)
//        {
//           log.Error(ex);
//        }
//        return ret;

//    }
//    private static DevExpress.Web.NavBarGroup CreateNavBarGroupMenuItem(MenuItem menuItem)
//    {
//        DevExpress.Web.NavBarGroup ret = new DevExpress.Web.NavBarGroup();
//        try
//        {
//            System.Web.UI.WebControls.Image img = new System.Web.UI.WebControls.Image();
//            StringBuilder imgUrl = new StringBuilder();
//            if (img != null)
//            {
//                img.ImageUrl = ($"data:image/{HelperFunctions.Catchnull(menuItem.ImageType, "png", true)};base64,{menuItem.ImageURL}").ToString();
//            }

//            ret.Text = menuItem.Text.ToString();
//            ret.NavigateUrl = "#";
//            ret.HeaderImage.Url = ($"data:image/{HelperFunctions.Catchnull(menuItem.ImageType, "png", true)};base64,{menuItem.ImageURL}").ToString();
//            ret.Name = menuItem.MenuID;
//            ret.HeaderImage.Url = img.ImageUrl;
//            ret.HeaderImage.Width = 30;
//            ret.HeaderImage.Height = 30;

//            if (menuItem.Items.Count > 0)
//            {
//                for (int i = 0; i < menuItem.Items.Count; i++)
//                {
//                    ret.Items.Add(CreateNavBarMenuItem(menuItem.Items[i]));
//                }
//            }
//        }
//        catch (Exception ex)
//        {
//           log.Error(ex);
//        }
//        return ret;

//    }
///*
//    protected static void CreateTextTile(TileGroup group)
//    {
//        //Initialize a new TextTile
//        RadTextTile textTile = new RadTextTile();

//        //Add TextTile-specific properties
//        textTile.Text = "Sample Text";

//        //Add Common Properties
//        //   LoadSharedProperties(textTile);

//        //Add tile to the group
//        group.Tiles.Add(textTile);
//    }

//    protected static void CreateIconTile(TileGroup group, MenuItem menuItem)
//    {
//        //Initialize a new IconTile
//        RadIconTile iconTile = new RadIconTile();

//        //Add IconTile-specific properties
//        iconTile.ImageUrl = "SampleImage.jpg";
//        iconTile.Name = menuItem.MenuName;

//        //Add Common Properties
//        // LoadSharedProperties(iconTile);

//        //Add tile to the group
//        group.Tiles.Add(iconTile);
//    }

//    protected static void CreateImageTile(TileGroup group)
//    {
//        //Initialize a new ImageTile
//        RadImageTile imageTile = new RadImageTile();

//        //Add ImageTile-specific properties
//        imageTile.ImageUrl = "SampleImage.jpg";

//        //Add Common Properties
//        //  LoadSharedProperties(imageTile);

//        //Add tile to the group
//        group.Tiles.Add(imageTile);
//    }

//    public static RadTileList CreateTiles(RadTileList tileList)
//    {
//        tileList.SelectionMode = TileListSelectionMode.Single;
//        menu = MenuData.GetGroupMenu();
//        //Create 4 tile groups
//        for (int i = 0; i < menu.Count; i++)
//        {
//            TileGroup tileGroup = new TileGroup();
//            tileList.Groups.Add(tileGroup);
//            CreateIconTile(tileGroup, menu[i]);
//            //Create different tiles for each group
//            //TextTile, IconTile, ImageTile
//            //for (int j = 0; j < 5; j++)
//            //{
//            //    if (i == 0) CreateTextTile(tileGroup, j);
//            //    else if (i == 1) CreateIconTile(tileGroup, j);
//            //    else if (i == 2) CreateImageTile(tileGroup, j);
//            //}
//        }

//        return tileList;

//    }
//    */

//    //protected static LoadSharedProperties(RadBaseTile tile)
//    //{
//    //    //Name
//    //    tile.Name = "Tile" + (index + 1);

//    //    //Title
//    //    //tile.Title.ImageUrl = "SampleImage.jpg";
//    //    tile.Title.Text = "Tile Number " + (index + 1);

//    //    //NavigateUrl
//    //    tile.NavigateUrl = urls[index];

//    //    //Badge
//    //    //tile.Badge.Value = index;
//    //    //tile.Badge.ImageUrl = "~/SampleImage.jpg";
//    //    tile.Badge.PredefinedType = badges[index];

//    //    //Target
//    //    tile.Target = targets[index];

//    //    //BackColor
//    //    tile.BackColor = Color.FromName(colors[index]);

//    //    //Selected
//    //    tile.Selected = (index % 2 != 0);

//    //    //Shape
//    //    if (index == 0) tile.Shape = TileShape.Wide;

//    //    //PeekTemplate and PeekTemplate Settings
//    //    LiteralControl div = new LiteralControl("<div class=\"peekTemplate\">Peek Template" + index + "</div>");
//    //    tile.PeekContentContainer.Controls.Add(div); //Add the literal control to the Peek Template Container
//    //    tile.PeekTemplateSettings.Animation = animations[index];
//    //    tile.PeekTemplateSettings.ShowPeekTemplateOnMouseOver = true;
//    //    tile.PeekTemplateSettings.HidePeekTemplateOnMouseOut = true;
//    //    tile.PeekTemplateSettings.ShowInterval = 1000; //in ms
//    //    tile.PeekTemplateSettings.CloseDelay = 5000; //in ms
//    //}
//}