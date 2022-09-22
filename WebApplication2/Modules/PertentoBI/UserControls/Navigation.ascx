<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Navigation.ascx.cs" Inherits="PertentoBI.Navigation" %>

<a href="https://www.devexpress.com/products/try/" target="_blank" class="demo-try-now-link bg-primary text-white">Try it now</a>
<dx:BootstrapTreeView runat="server">
    <CssClasses
        IconExpandNode="demo-icon demo-icon-col m-0"
        IconCollapseNode="demo-icon demo-icon-ex m-0"
        NodeList="demo-treeview-nodes m-0" Node="demo-treeview-node" Control="demo-treeview" />
    <Nodes>
        <dx:BootstrapTreeViewNode Text="Overview" NavigateUrl="~/Default.aspx"></dx:BootstrapTreeViewNode>
        <dx:BootstrapTreeViewNode Text="Scenarios" Expanded="true">
            <Nodes>
                <dx:BootstrapTreeViewNode Text="Tasks data table" NavigateUrl="~/TasksDataTable.aspx"></dx:BootstrapTreeViewNode>
                <dx:BootstrapTreeViewNode Text="Event scheduling" NavigateUrl="~/EventScheduling.aspx"></dx:BootstrapTreeViewNode>
            </Nodes>
        </dx:BootstrapTreeViewNode>
        <dx:BootstrapTreeViewNode Text="Documentation" NavigateUrl="https://docs.devexpress.com/AspNetBootstrap/118796/getting-started" Target="_blank"></dx:BootstrapTreeViewNode>
    </Nodes>
</dx:BootstrapTreeView>