<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="IssuedTyreTotals.aspx.vb" Inherits="WebApplication2.IssuedTyreTotals" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
 </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table>
    <tr>
        <td class="PageTitle">
           Issued Tyre Totals
        </td>
    </tr>
         <tr>
             <td>
                 <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small"></asp:Label>
             </td>
         </tr>
    </table>
    <table>
        <tr>
             <td> From Date</td>
             <td>                                               
                   <telerik:RadDatePicker ID="rdFromDate" Runat="server">
                   </telerik:RadDatePicker>
             </td> 
             <td> To Date</td>
             <td> 
                   <telerik:RadDatePicker ID="rdToDate" Runat="server">
                   </telerik:RadDatePicker>
             </td> 
             <td> 
                   <asp:Button ID="btnSearchDates" runat="server" Text="Show the Issued Tyres" />
             </td> 
        </tr>
    </table>
    <table width="100%">
        <br />

        <tr>
            <td>
                <telerik:RadGrid ID="gwGrid" runat="server" AllowPaging="True" AllowSorting="True" BackColor="White" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" DisplayMode="FirstLastPreviousNextNumeric, Text" ForeColor="Black" GroupPanelPosition="Top" PageSize="50" AllowFilteringByColumn="True" ShowGroupPanel="True">
                    <ClientSettings AllowDragToGroup="True">
                        <Scrolling AllowScroll="True" />
                    </ClientSettings>
                    <AlternatingItemStyle BackColor="#EFEFEF" />
                </telerik:RadGrid>
            </td>
        </tr>
    </table>
</asp:Content>