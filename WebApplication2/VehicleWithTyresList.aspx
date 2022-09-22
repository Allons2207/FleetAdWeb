<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="VehicleWithTyresList.aspx.vb" Inherits="WebApplication2.VehicleWithTyresList" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <table>
       <tr>
       <td style="font-size:medium; color:darkblue ">
           <br />
           List of Vehicles and their Fitted Tyres
       </td>
       </tr>
       <tr>
         <td>
             <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small"></asp:Label>
         </td>
        </tr>
     </table>  
    <table width="100%">
        <tr>
            <td>
                <radgrid id="gwAvailableTyres" runat="server" allowpaging="True" allowsorting="True" backcolor="#DEBA84" bordercolor="#DEBA84" borderstyle="None" borderwidth="1px" cellpadding="3" cellspacing="2" displaymode="FirstLastPreviousNextNumeric, Text" forecolor="Black" grouppanelposition="Top" pagesize="50">
              
                        <clientsettings>
                        <scrolling allowscroll="True" />
                <telerik:RadGrid ID="gwGrid" runat="server" AllowPaging="True" AllowSorting="True" BackColor="White" BorderColor="#003366" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" DisplayMode="FirstLastPreviousNextNumeric, Text" ForeColor="Black" GroupPanelPosition="Top" PageSize="100" AllowFilteringByColumn="True" ShowGroupPanel="True">
                    <GroupingSettings CaseSensitive="False" />
                    <clientsettings AllowDragToGroup="True">
                        <Scrolling AllowScroll="True" UseStaticHeaders="True"  />
                    </clientsettings>
                </telerik:RadGrid>
                    </clientsettings>
                   
     </radgrid>
            </td>
        </tr>
    </table>
</asp:Content>
