<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="TyrePrices.aspx.vb" Inherits="WebApplication2.tyrePrices" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table width="90%">
           <tr>
        <td class="PageTitle">
           Tyre Prices
        </td>
    </tr>
         <tr>
             <td>
                 <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small" Width="100%"></asp:Label>
             </td>
         </tr>
    <tr><td ><asp:Button ID="cmdExportToExcel" runat="server" Text="Export to MS Excel" Width="150px"/>
                            </td></tr>
        <tr>
            <td>
                <telerik:RadGrid ID="gwGrid" runat="server" AllowPaging="True" AllowSorting="True" BackColor="White" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" DisplayMode="FirstLastPreviousNextNumeric, Text" ForeColor="Black" GroupPanelPosition="Top" PageSize="50" AllowFilteringByColumn="True" ShowGroupPanel="True">
                    <ClientSettings AllowDragToGroup="True">
                        <Scrolling AllowScroll="True" />
                    </ClientSettings>
                    <AlternatingItemStyle BackColor="#CCCCFF" />
                </telerik:RadGrid>
            </td>
        </tr>
    </table>
</asp:Content>
