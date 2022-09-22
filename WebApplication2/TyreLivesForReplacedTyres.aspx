<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="TyreLivesForReplacedTyres.aspx.vb" Inherits="WebApplication2.TyreLivesForReplacedTyres" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
  <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table>
    <tr>
        <td class="PageTitle">
           Tyre Lives for Replaced Tyres
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
             <td class="auto-style7"> From Removal Date</td>
             <td class="auto-style8">                                               
                   <telerik:RadDatePicker ID="rdFromDate" Runat="server">
                   </telerik:RadDatePicker>
             </td> 
             <td class="auto-style6"> To Removal Date</td>
             <td class="auto-style1"> 
                   <telerik:RadDatePicker ID="rdToDate" Runat="server">
                   </telerik:RadDatePicker>
             </td> 
             <td class="auto-style1"> 
                   <asp:Button ID="btnSearchDates" runat="server" Text="Show Tyre Lives for Replaced Tyres" />
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
                    <AlternatingItemStyle BackColor="#E6E6E6" />
                </telerik:RadGrid>
            </td>
        </tr>
    </table>
</asp:Content>
