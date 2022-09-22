<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="ManageUsers.aspx.vb" Inherits="WebApplication2.ManageUsers" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
       <table>
        <tr>
           <td style="font-size:medium; color:darkblue "> User Management </td>
        </tr>
           <tr><td>&nbsp</td></tr>
         <tr><td>
                                <asp:Button ID="cmdAddNew" runat="server" Text="Add New" Width="150px" />
                            </td></tr>
           <tr>
               <td colspan="2">
                <telerik:RadGrid ID="gwGrid" runat="server" AllowPaging="True" AllowSorting="True" BackColor="White" BorderColor="#003366" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" DisplayMode="FirstLastPreviousNextNumeric, Text" ForeColor="Black" GroupPanelPosition="Top" PageSize="20" AllowFilteringByColumn="True" ShowGroupPanel="True" AutoGenerateColumns="False" Width="40%">
                    <clientsettings AllowDragToGroup="True">
                        <Scrolling AllowScroll="True" UseStaticHeaders="True"  />
                    </clientsettings>
                    <MasterTableView>
                        <Columns>
                            <telerik:GridButtonColumn CommandName="Edita" FilterControlAltText="Filter Edita column" HeaderText="Edit" Text="Edit" UniqueName="Edita">
                            </telerik:GridButtonColumn>
                            <telerik:GridBoundColumn DataField="UserId" FilterControlAltText="Filter UserId column" HeaderText="UserId" UniqueName="UserId">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="UserName" FilterControlAltText="Filter UserName column" HeaderText="UserName" UniqueName="UserName">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="UserGroup" FilterControlAltText="Filter UserGroup column" HeaderText="UserGroup" UniqueName="UserGroup">
                            </telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
               </td>
           </tr>
       </table>    
  
</asp:Content>
