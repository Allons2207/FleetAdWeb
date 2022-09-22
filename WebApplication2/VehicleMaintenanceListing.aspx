<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="VehicleMaintenanceListing.aspx.vb" Inherits="WebApplication2.VehicleMaintenanceListing" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <h3 style="font-size:medium; color:gray "> Vehicle Servicing List</h3>
    <table width="90%" style="margin-left:2%" >
      
        <tr><td>

     Load Maintenance Data From Date: <telerik:RadDatePicker ID="rdFromDate" runat="server" Culture="en-US" MinDate="1900-01-01"></telerik:RadDatePicker>
            To Date <telerik:RadDatePicker ID="rdToDate" runat="server" Culture="en-US" MinDate="1900-01-01"></telerik:RadDatePicker>
            <asp:Button ID="cmdShow" runat="server" Text="Show" Width="105px" /> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              <asp:Button ID="cmdAddNew" runat="server" Text="Add New" Width="107px" />
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:Button ID="cmdExportToExcel" runat="server" Text="Export to MS Excel" Width="150px"/>
                            </td></tr>
       <tr>
         <td>
             <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small" Width="100%"></asp:Label>
         </td>
        </tr>
        <tr>
            <td>
     <telerik:RadGrid ID="radMaintenance" runat="server" Height="80%" 
                    CellPadding="0" Width="90%" AutoGenerateColumns="False" GroupPanelPosition="Top" >
                    <MasterTableView  AllowFilteringByColumn="True" AllowPaging="True" 
                       AllowMultiColumnSorting="true" AllowSorting="true" PagerStyle-Mode="NextPrevNumericAndAdvanced" DataKeyNames="JobCardNo"
                        HierarchyLoadMode="Client" >
                          <Columns>
                            <telerik:GridButtonColumn FilterControlAltText="Filter View column" HeaderText="View" Text="View" UniqueName="View" CommandName="View">
                            </telerik:GridButtonColumn>
                            <telerik:GridButtonColumn FilterControlAltText="Filter Delete column" HeaderText="Delete" Text="Delete" UniqueName="Delete" CommandName="Delete">
                            </telerik:GridButtonColumn>
                            <telerik:GridBoundColumn DataField="JobCardNo" FilterControlAltText="Filter JobCardNo column" HeaderText="JobCardNo" UniqueName="JobCardNo">
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
                        <DetailTables>                           
                            <telerik:GridTableView Name="dsDetails">                                
                                <Columns>
                                        <telerik:GridBoundColumn DataField="JobCardNo" UniqueName="JobCardNo" HeaderText="JobCardNo" Display="false">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Workdone" UniqueName="Workdone" HeaderText="Workdone">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="MaterialsUsed" UniqueName="MaterialsUsed" HeaderText="MaterialsUsed">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="QuantityUsed" UniqueName="QuantityUsed" HeaderText="QuantityUsed">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="UnitPrice" UniqueName="UnitPrice" HeaderText="UnitPrice">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Total" UniqueName="Total" HeaderText="Total">
                                        </telerik:GridBoundColumn>
                                </Columns>
                            </telerik:GridTableView>
                        </DetailTables>
                        <RowIndicatorColumn>
                            <HeaderStyle Width="20px"></HeaderStyle>
                        </RowIndicatorColumn>
                        <ExpandCollapseColumn>
                            <HeaderStyle Width="20px"></HeaderStyle>
                        </ExpandCollapseColumn>
                        <EditFormSettings>
                            <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                            </EditColumn>
                        </EditFormSettings>
                        <PagerStyle Position="Top" AlwaysVisible="true"/>
                    </MasterTableView>
                    <ClientSettings EnablePostBackOnRowClick="true">
                    </ClientSettings>
                    <FilterMenu EnableImageSprites="False">
                    </FilterMenu>
                </telerik:RadGrid>
                      </td>
        </tr>
    </table>
</asp:Content>
