<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="BulkLicensingList.aspx.vb" Inherits="WebApplication2.BulkLicensingList" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <h3 style="font-size:medium; color:gray "> Bulk Licenses</h3>
    <table width="90%" style="margin-left:2%" >
      
        <tr><td>
              <asp:Button ID="cmdAddNew" runat="server" Text="Add New" Width="107px" />
                            &nbsp;&nbsp;&nbsp;&nbsp; <asp:Button ID="cmdExportToExcel" runat="server" Text="Export to MS Excel" Width="150px"/>
                            </td></tr>
       <tr>
         <td>
             <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small"></asp:Label>
         </td>
        </tr>
        <tr>
            <td>
                <telerik:RadGrid ID="gwGrid" runat="server" AllowPaging="True" AllowSorting="True" BackColor="White" BorderColor="#003366" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" DisplayMode="FirstLastPreviousNextNumeric, Text" ForeColor="Black" GroupPanelPosition="Top" PageSize="100" AllowFilteringByColumn="True" ShowGroupPanel="True" AutoGenerateColumns="False">
                    <clientsettings AllowDragToGroup="True">
                        <Scrolling AllowScroll="True" UseStaticHeaders="True"  />
                    </clientsettings>
                    <MasterTableView>
                        <Columns>
                            <telerik:GridButtonColumn CommandName="View" FilterControlAltText="Filter column column" HeaderText="View" Text="View" UniqueName="column">
                            </telerik:GridButtonColumn>
                            <telerik:GridBoundColumn DataField="LicenseType" FilterControlAltText="Filter LicenseType column" HeaderText="LicenseType" UniqueName="LicenseType">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="MonthsToExpiryDate" FilterControlAltText="Filter MonthsToExpiryDate column" HeaderText="MonthsToExpiryDate" UniqueName="MonthsToExpiryDate">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="DateIssued" FilterControlAltText="Filter DateIssued column" HeaderText="DateIssued" UniqueName="DateIssued">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="ExpiryDate" FilterControlAltText="Filter ExpiryDate column" HeaderText="ExpiryDate" UniqueName="ExpiryDate">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="LicenseNo" FilterControlAltText="Filter LicenseNo column" HeaderText="LicenseNumber" UniqueName="LicenseNo">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Details" FilterControlAltText="Filter Details column" HeaderText="Details" UniqueName="Details">
                            </telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </td>
        </tr>
    </table>
</asp:Content>
