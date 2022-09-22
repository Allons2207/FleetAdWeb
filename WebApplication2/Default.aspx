<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="SchoolAppMaster.Master" CodeBehind="Default.aspx.vb" Inherits="WebApplication2.Home" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <telerik:RadStyleSheetManager ID="RadStyleSheetManager1" runat="server">
     </telerik:RadStyleSheetManager>
     <telerik:radwindowmanager ID="RadWindowManager1" runat="server" EnableShadow="True">
    </telerik:radwindowmanager>
    <telerik:radajaxmanager runat="server" ID="RadAjaxManager1">
    </telerik:radajaxmanager>
    <center>
    <table>
         <tr>
            <td colspan="2" class="PageTitle" style="text-align:center"><br /> Welcome</td>
        </tr>
        <tr>
            <td>&nbsp</td>
        </tr>
        <tr >
            <td colspan="2" style="text-align:center">FLEET MANAGEMENT SYSTEM </td>
        </tr>
        <tr>
            <td>&nbsp</td>
        </tr>
        <tr >
            <td colspan="2" style="text-align:center"> Licensed To </td>
        </tr>
        <tr>
            <td>&nbsp</td>
        </tr>
         <tr>
            <td colspan="2" style="text-align:center">
              <asp:Panel ID="pnlMessages" runat="server" Width="95%">
                <asp:Label ID="lblMessages" runat="server"></asp:Label>
              </asp:Panel> 
            </td>
        </tr>
         <tr>
                        <td colspan="3">
                           
                        </td>
                    </tr>
        <tr>
            <td colspan="2" style="width: 60%" valign="top">
                <table style="width: 100%">
    <tr>
        <td >
        </td>
    </tr>
                    <tr>
                        <td style="text-align:center">
                            <img alt="Fleet Mgt Sys" class="auto-style1" src="images/Fleet-management-system.jpg" /></td>
                    </tr>
    <tr>
        <td style="width: 100%; ">
            &nbsp;</td>
    </tr>
                    <tr><td style="text-align:center"><asp:Label ID="lblCentre" runat="server" Font-Size="XX-Large" ForeColor="#3399FF"></asp:Label></td></tr>
</table>
            </td>
        </tr>
    </table>
    </center>
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="head">
    <style type="text/css">
        .auto-style1 {
            width: 1032px;
            height: 220px;
        }
    </style>
</asp:Content>

