<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="VehicleInspectionsList.aspx.vb" Inherits="WebApplication2.VehicleInspectionsList" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3 style="font-size:medium; color:gray "> Vehicle Inspections List</h3>
    <table width="90%" style="margin-left:2%" >
      
        <tr><td>
              <asp:Button ID="cmdAddNew" runat="server" Text="Add New" Width="107px" />&nbsp;&nbsp
                            <asp:Button ID="cmdExport" runat="server" Text="Export List to MS Excel" Width="150px" />
            
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
                            <telerik:GridButtonColumn CommandName="View" FilterControlAltText="Filter View column" HeaderText="View" Text="View" UniqueName="View">
                            </telerik:GridButtonColumn>
                            <telerik:GridBoundColumn DataField="EntryNo" Display="False" FilterControlAltText="Filter EntryNo column" HeaderText="EntryNo" UniqueName="EntryNo">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Date" DataType="System.DateTime" FilterControlAltText="Filter Date column" HeaderText="Date" UniqueName="Date">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="RegNumber" FilterControlAltText="Filter RegNumber column" HeaderText="RegNumber" UniqueName="RegNumber">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="FleetID" FilterControlAltText="Filter FleetID column" HeaderText="FleetID" UniqueName="FleetID">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Make" FilterControlAltText="Filter Make column" HeaderText="Make" UniqueName="Make">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Model" FilterControlAltText="Filter Model column" HeaderText="Model" UniqueName="Model">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="KeyFinding" FilterControlAltText="Filter KeyFinding column" HeaderText="KeyFinding" UniqueName="KeyFinding">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Details" FilterControlAltText="Filter Details column" HeaderText="Details" UniqueName="Details">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="VehicleUser" FilterControlAltText="Filter VehicleUser column" HeaderText="VehicleUser" UniqueName="VehicleUser">
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
