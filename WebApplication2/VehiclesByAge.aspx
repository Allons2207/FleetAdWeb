<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="VehiclesByAge.aspx.vb" Inherits="WebApplication2.VehiclesByAge" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
      <h3 style="font-size:medium; color:gray "> Vehicles by Age</h3>
    <table width="90%" style="margin-left:2%" >
      
        <tr><td>
              <asp:Button ID="cmdAddNew" runat="server" Text="Add New" Width="107px" />
                            </td></tr>
       <tr>
         <td>
             <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small"></asp:Label>
         </td>
        </tr>
        <tr>
            <td>
                <telerik:RadGrid ID="gwGrid" runat="server" AllowPaging="True" AllowSorting="True" BackColor="White" BorderColor="#003366" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" DisplayMode="FirstLastPreviousNextNumeric, Text" ForeColor="Black" GroupPanelPosition="Top" PageSize="100" AllowFilteringByColumn="True" ShowGroupPanel="True" AutoGenerateColumns="False">
                    <GroupingSettings CaseSensitive="False" />
                    <clientsettings AllowDragToGroup="True">
                        <Scrolling AllowScroll="True" UseStaticHeaders="True"  />
                    </clientsettings>
                    <MasterTableView>
                        <Columns>
                            <telerik:GridButtonColumn CommandName="View" FilterControlAltText="Filter View column" HeaderText="View" Text="View" UniqueName="View">
                            </telerik:GridButtonColumn>
                            <telerik:GridBoundColumn DataField="VehicleCategory" FilterControlAltText="Filter VehicleCategory column" HeaderText="VehicleCategory" UniqueName="VehicleCategory">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="RegNo" FilterControlAltText="Filter RegNo column" HeaderText="RegNo" UniqueName="RegNo">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="FleetId" FilterControlAltText="Filter FleetId column" HeaderText="FleetId" UniqueName="FleetId">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Make" FilterControlAltText="Filter Make column" HeaderText="Make" UniqueName="Make">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Model" FilterControlAltText="Filter Model column" HeaderText="Model" UniqueName="Model">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="EngineNo" FilterControlAltText="Filter EngineNo column" HeaderText="EngineNo" UniqueName="EngineNo">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="ChassisNo" FilterControlAltText="Filter ChassisNo column" HeaderText="ChassisNo" UniqueName="ChassisNo">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Mileage" FilterControlAltText="Filter Mileage column" HeaderText="Mileage" UniqueName="Mileage">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="MileageDate" FilterControlAltText="Filter MileageDate column" HeaderText="MileageDate" UniqueName="MileageDate">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="VehicleUser" FilterControlAltText="Filter VehicleUser column" HeaderText="VehicleUser" UniqueName="VehicleUser">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="UserCategory" FilterControlAltText="Filter UserCategory column" HeaderText="UserCategory" UniqueName="UserCategory">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Position" FilterControlAltText="Filter Position column" HeaderText="Position" UniqueName="Position">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Department" FilterControlAltText="Filter Department column" HeaderText="Department" UniqueName="Department">
                            </telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </td>
        </tr>
    </table>
</asp:Content>
