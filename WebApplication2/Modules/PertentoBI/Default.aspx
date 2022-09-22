<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Root.master" CodeBehind="Default.aspx.cs" Inherits="PertentoBI.Default" Title="" %>

<asp:Content ID="Content" ContentPlaceHolderID="PageContent" runat="server">
    <style type="text/css">
        .dxbplc {
            vertical-align: top;
        }
        .itemphoto {
            display: block;
            margin: auto;
            max-width: 200px;
        }
        .contactname {
            display: block;
            width: 100%;
            margin: 6px 0;
        }
        .contactemail {
            display: block;
            text-overflow: ellipsis ;
            overflow: hidden;
        }
    </style>
</asp:Content>

<asp:Content ContentPlaceHolderID="LeftPanelContent" runat="server">
    <h3 class="section-caption contents-caption">Dashboards</h3>

    <dx:ASPxTreeView runat="server" ID="TableOfContentsTreeView" ClientInstanceName="tableOfContentsTreeView"
        EnableNodeTextWrapping="true" AllowSelectNode="true" Width="100%" SyncSelectionMode="None" DataSourceID="NodesDataSource">
        <Styles>
            <Elbow CssClass="tree-view-elbow" />
            <Node CssClass="tree-view-node" HoverStyle-CssClass="hovered" />
        </Styles>
        <ClientSideEvents NodeClick="function (s, e) { HideLeftPanelIfRequired(); }" />
    </dx:ASPxTreeView>

    <%--<asp:XmlDataSource ID="NodesDataSource" runat="server" DataFile="~/App_Data/OverviewContents.xml" XPath="//Nodes/*" />--%>
</asp:Content>
