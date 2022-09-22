<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="DefensiveDriversCertificatesListing.aspx.vb" Inherits="WebApplication2.DefensiveDriversCertificatesListing" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
    .auto-style3 {
        height: 30px;
    }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">   
    <h3 style="font-size:medium; color:gray "> Defensive Drivers&#39; Certificates Listing</h3>
    <table width="90%" style="margin-left:2%" >
        <tr>
            <td class="auto-style3">
              <asp:Button ID="cmdAddNew" runat="server" Text="Add New" Width="107px" />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:Button ID="cmdExportToExcel" runat="server" Text="Export to MS Excel" Width="150px"/>
            </td>
        </tr>
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
                            <telerik:GridBoundColumn DataField="MonthsToExpiryDate" FilterControlAltText="Filter MonthsToExpiryDate column" HeaderText="MonthsToExpiryDate" UniqueName="MonthsToExpiryDate">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="ExamDate" FilterControlAltText="Filter ExamDate column" HeaderText="ExamDate" UniqueName="ExamDate">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="ExpiryDate" FilterControlAltText="Filter ExpiryDate column" HeaderText="ExpiryDate" UniqueName="ExpiryDate">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="LicenseNumber" FilterControlAltText="Filter LicenseNumber column" HeaderText="LicenseNumber" UniqueName="LicenseNumber">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="NationalIDNo" FilterControlAltText="Filter NationalIDNo column" HeaderText="NationalIDNo" UniqueName="NationalIDNo">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="FirstName" FilterControlAltText="Filter FirstName column" HeaderText="FirstName" UniqueName="FirstName">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Surname" FilterControlAltText="Filter Surname column" HeaderText="Surname" UniqueName="Surname">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Department" FilterControlAltText="Filter Department column" HeaderText="Department" UniqueName="Department">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Position" FilterControlAltText="Filter Position column" HeaderText="Position" UniqueName="Position">
                            </telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </td>
        </tr>
    </table>
   
</asp:Content>
