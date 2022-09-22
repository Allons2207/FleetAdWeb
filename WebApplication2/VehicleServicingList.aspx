<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="VehicleServicingList.aspx.vb" Inherits="WebApplication2.VehicleServicingList" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3 style="font-size:medium; color:gray "> Vehicle Servicing List</h3>
    <table width="90%" style="margin-left:2%" >
      
        <tr><td class="auto-style1">
              <asp:Button ID="cmdAddNew" runat="server" Text="Add New" Width="107px" />
                            </td></tr>
       <tr>
         <td>
             <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small" Width="100%"></asp:Label>
         </td>
        </tr>
        <tr>
            <td>
                <telerik:radgrid ID="gwGrid" runat="server" AllowPaging="True" AllowSorting="True" BackColor="White" BorderColor="#003366" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" DisplayMode="FirstLastPreviousNextNumeric, Text" ForeColor="Black" GroupPanelPosition="Top" PageSize="100" AllowFilteringByColumn="True" ShowGroupPanel="True" AutoGenerateColumns="False">
                    <clientsettings AllowDragToGroup="True">
                        <Scrolling AllowScroll="True" UseStaticHeaders="True"  />
                    </clientsettings>
                    <MasterTableView>
                        <Columns>
                            <telerik:GridButtonColumn FilterControlAltText="Filter View column" HeaderText="View" Text="View" UniqueName="View" CommandName="View">
                            </telerik:GridButtonColumn>
                            <telerik:GridButtonColumn FilterControlAltText="Filter Delete column" HeaderText="Delete" Text="Delete" UniqueName="Delete" CommandName="Delete">
                            </telerik:GridButtonColumn>
                            <telerik:GridBoundColumn DataField="JobCard_#" FilterControlAltText="Filter JobCard_# column" HeaderText="JobCard_#" UniqueName="JobCard_#">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="FleetID" FilterControlAltText="Filter FleetID column" HeaderText="FleetID" UniqueName="FleetID">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="RegNo" FilterControlAltText="Filter RegNo column" HeaderText="RegNo" UniqueName="RegNo">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Date" FilterControlAltText="Filter Date column" HeaderText="Date" UniqueName="Date">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="TypeOfService" FilterControlAltText="Filter TypeOfService column" HeaderText="TypeOfService" UniqueName="TypeOfService">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="serviceCategory" FilterControlAltText="Filter serviceCategory column" HeaderText="ServiceCategory" UniqueName="serviceCategory">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Mileage" FilterControlAltText="Filter Mileage column" HeaderText="Mileage" UniqueName="Mileage">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="DateOut" FilterControlAltText="Filter DateOut column" HeaderText="DateOut" UniqueName="DateOut">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="ServiceFreq" FilterControlAltText="Filter ServiceFreq column" HeaderText="ServiceFreq" UniqueName="ServiceFreq">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Mechanic" FilterControlAltText="Filter Mechanic column" HeaderText="Mechanic" UniqueName="Mechanic">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="TotalTimeTaken" FilterControlAltText="Filter TotalTimeTaken column" HeaderText="TotalTimeTaken" UniqueName="TotalTimeTaken">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Costs" FilterControlAltText="Filter Costs column" HeaderText="Costs" UniqueName="Costs">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Value" FilterControlAltText="Filter Value column" HeaderText="Value" UniqueName="Value">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Sundries" FilterControlAltText="Filter Sundries column" HeaderText="Sundries" UniqueName="Sundries">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="SundriesCost" FilterControlAltText="Filter SundriesCost column" HeaderText="SundriesCost" UniqueName="SundriesCost">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="TotalCost" FilterControlAltText="Filter TotalCost column" HeaderText="TotalCost" UniqueName="TotalCost">
                            </telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:radgrid>
            </td>
        </tr>
    </table>


</asp:Content>
