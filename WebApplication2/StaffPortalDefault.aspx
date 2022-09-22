<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/StaffPortalMaster.Master" CodeBehind="StaffPortalDefault.aspx.vb" Inherits="WebApplication2.StaffPortalDefault" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
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
            <td colspan="2" style="text-align:center">School Administration System: </td>
        </tr>
        <tr>
            <td>&nbsp</td>
        </tr>
        <tr >
            <td colspan="2" style="text-align:center"> Staff Portal </td>
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
                        <td style="text-align:center"><img src="images/herentals logo.JPG"/></td>
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
