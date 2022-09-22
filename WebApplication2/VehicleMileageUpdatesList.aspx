<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="VehicleMileageUpdatesList.aspx.vb" Inherits="WebApplication2.VehicleMileageUpdatesList" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3 style="font-size:medium; color:gray "> Vehicle Mileage Updates</h3>
    <table width="60%" style="margin-left:2%" >
      
        <tr><td>
              <asp:Button ID="cmdAddNew" runat="server" Text="Add New" Width="107px" />
                            </td></tr>
       <tr>
         <td colspan="100%">
             <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small" Width="100%"></asp:Label>
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
                            <telerik:GridButtonColumn FilterControlAltText="Filter Delete column" HeaderText="Delete" Text="Delete" UniqueName="Delete" CommandName="Delete">
                            </telerik:GridButtonColumn>
                            <telerik:GridBoundColumn DataField="ID" FilterControlAltText="Filter ID column" HeaderText="ID" UniqueName="ID" Display="False">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="DateUpdated" FilterControlAltText="Filter DateUpdated column" HeaderText="DateUpdated" UniqueName="DateUpdated">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="RegNumber" FilterControlAltText="Filter RegNumber column" HeaderText="RegNumber" UniqueName="RegNumber">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="FleetID" FilterControlAltText="Filter FleetID column" HeaderText="FleetID" UniqueName="FleetID">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn FilterControlAltText="Filter Make column" UniqueName="Make" DataField="Make" HeaderText="Make">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn FilterControlAltText="Filter Model column" UniqueName="Model" DataField="Model" HeaderText="Model">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn FilterControlAltText="Filter NewMileage column" UniqueName="NewMileage" DataField="NewMileage" HeaderText="NewMileage">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn FilterControlAltText="Filter OldMileage column" UniqueName="OldMileage" DataField="OldMileage" HeaderText="OldMileage">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn FilterControlAltText="Filter Notes column" UniqueName="Notes" DataField="Notes" HeaderText="Notes">
                            </telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </td>
        </tr>
    </table>
</asp:Content>
