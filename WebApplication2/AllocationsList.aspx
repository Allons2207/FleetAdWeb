<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="AllocationsList.aspx.vb" Inherits="WebApplication2.AllocationsList" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
      <h3 style="font-size:medium; color:gray "> Vehicle Allocations List</h3>
    <table width="80%" style="margin-left:2%" >
      
        <tr><td>
              <asp:Button ID="cmdAddNew" runat="server" Text="Add New" Width="107px" />&nbsp;&nbsp              
              <asp:Button ID="cmdExport" runat="server" Text="Export List to MS Excel" Width="150px" />
            
                            </td>         </tr>
       <tr>
         <td>
             <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small"></asp:Label>
         </td>
        </tr>
        <tr>
            <td>
                <telerik:RadGrid ID="gwGrid" runat="server" AllowPaging="True" AllowSorting="True" BackColor="White" BorderColor="#003366" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" DisplayMode="FirstLastPreviousNextNumeric, Text" ForeColor="Black" GroupPanelPosition="Top" PageSize="100" AllowFilteringByColumn="True" ShowGroupPanel="True">
                    <clientsettings AllowDragToGroup="True">
                        <Scrolling AllowScroll="True" UseStaticHeaders="True"  />
                    </clientsettings>
                </telerik:RadGrid>
            </td>
        </tr>
    </table>
</asp:Content>
