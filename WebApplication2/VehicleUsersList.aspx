<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="VehicleUsersList.aspx.vb" Inherits="WebApplication2.VehicleUsersList" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3 style="font-size:medium; color:gray "> List of All Vehicle Users</h3>
    <table width="90%" style="margin-left:2%" >
      
        <tr><td>
              <asp:Button ID="cmdAddNew" runat="server" Text="Add New" Width="107px" />&nbsp;&nbsp<asp:Button ID="cmdExportToExcel" runat="server" Text="Export to MS Excel" Width="150px"/>
                            </td></tr>
       <tr>
         <td colspan="2">
             <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small"></asp:Label>
         </td>
        </tr>
        <tr>
            <td colspan="2">
                <telerik:RadGrid ID="gwGrid" runat="server" AllowPaging="True" AllowSorting="True" BackColor="White" BorderColor="#003366" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" DisplayMode="FirstLastPreviousNextNumeric, Text" ForeColor="Black" GroupPanelPosition="Top" PageSize="100" AllowFilteringByColumn="True" ShowGroupPanel="True" AutoGenerateColumns="False">
                    <GroupingSettings CaseSensitive="False" />
                    <clientsettings AllowDragToGroup="True">
                        <Scrolling AllowScroll="True" UseStaticHeaders="True"  />
                    </clientsettings>
                    <MasterTableView>
                        <Columns>
                            <telerik:GridButtonColumn FilterControlAltText="Filter View column" HeaderText="View" Text="View" UniqueName="View" CommandName="View">
                            </telerik:GridButtonColumn>
                            <telerik:GridBoundColumn DataField="Surname" FilterControlAltText="Filter Surname column" HeaderText="Surname" UniqueName="Surname">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="FirstName" FilterControlAltText="Filter FirstName column" HeaderText="FirstName" UniqueName="FirstName">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Department" FilterControlAltText="Filter Department column" HeaderText="Department" UniqueName="Department">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Position" FilterControlAltText="Filter Position column" HeaderText="Position" UniqueName="Position">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="NationalIDNo" FilterControlAltText="Filter NationalIDNo column" HeaderText="NationalIDNo" UniqueName="NationalIDNo">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="LicenseNo" FilterControlAltText="Filter LicenseNo column" HeaderText="LicenseNo" UniqueName="LicenseNo">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="DefensiveExpDate" FilterControlAltText="Filter DefensiveExpDate column" HeaderText="DefensiveExpDate" UniqueName="DefensiveExpDate">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="AllocationStatus" FilterControlAltText="Filter AllocationStatus column" HeaderText="AllocationStatus" UniqueName="AllocationStatus">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Make" FilterControlAltText="Filter Make column" HeaderText="Make" UniqueName="Make">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Model" FilterControlAltText="Filter Model column" HeaderText="Model" UniqueName="Model">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="RegNumber" FilterControlAltText="Filter RegNumber column" HeaderText="RegNumber" UniqueName="RegNumber">
                            </telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </td>
        </tr>
    </table>
</asp:Content>
