<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="VehicleFuelingDetails.aspx.vb" Inherits="WebApplication2.VehicleFuelingDetails" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <h3 style="font-size:medium; color:gray "> Vehicle Fueling Details</h3>
    <table width="60%" style="margin-left:2%" >


          <tr>
         <td colspan="4">
             <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small" Width="100%"></asp:Label>
         </td>
</tr>
                <tr><td>Search by Fleet ID.</td><td><asp:TextBox ID="txtFleetIDSearch" runat="server" Width="211px"></asp:TextBox></td><td><asp:Button ID="btnSearchByFleetID" runat="server" Text="Find" Width="150px" /></td></tr>

        <tr><td>Search by Reg No.</td><td><asp:TextBox ID="txtRegNo" runat="server" Width="211px"></asp:TextBox></td><td><asp:Button ID="cmdClear0" runat="server" Text="Find" Width="150px" /></td></tr>
<tr>
    <td colspan="4"><hr /></td>
</tr>
<tr>
   
             
             <td>Fleet ID</td> <td> <asp:TextBox ID="txtFleetID" runat="server" Width="211px" Enabled="False"></asp:TextBox></td>
        </tr>
        <tr>
            <td>Make</td> <td> <asp:TextBox ID="txtMake" runat="server" Width="211px" Enabled="False"></asp:TextBox></td> <td>Model</td> <td> <asp:TextBox ID="txtModel" runat="server" Width="211px" Enabled="False"></asp:TextBox></td>
        </tr>
        <tr>
          <td>Fuel Type</td> <td>
                                         <telerik:RadComboBox ID="cboFuelType" runat="server"></telerik:RadComboBox>
                                         </td> 

        </tr>

       <tr>
    <td colspan="4"><hr/></td>
</tr>
        <tr><td></td></tr>

        <tr>
          
           <td>Year</td> <td> <telerik:RadComboBox ID="radYear" runat="server">
            <Items>
                <telerik:RadComboBoxItem runat="server" Text="2018" Value="2018" />
                <telerik:RadComboBoxItem runat="server" Text="2019" Value="2019" />
                <telerik:RadComboBoxItem runat="server" Text="2020" Value="2020" />
                <telerik:RadComboBoxItem runat="server" Text="2021" Value="2021" />
                <telerik:RadComboBoxItem runat="server" Text="2022" Value="2022" />
                <telerik:RadComboBoxItem runat="server" Text="2023" Value="2023" />
                <telerik:RadComboBoxItem runat="server" Text="2024" Value="2024" />
                <telerik:RadComboBoxItem runat="server" Text="2025" Value="2025" />
            </Items>
            </telerik:RadComboBox></td>
             <td>Month</td> <td> <telerik:RadComboBox ID="radMonth" runat="server" AutoPostBack="True"></telerik:RadComboBox></td>
            
        </tr>
        <tr>
            <td>Opening Odometer Reading</td><td> <asp:TextBox ID="txtOpeningOdometerReadn" runat="server" Width="211px" Enabled="False"></asp:TextBox></td>
            <td>Closing Odometer Reading</td><td> <asp:TextBox ID="txtClosingOdometerReadn" runat="server" Width="211px" Enabled="False"></asp:TextBox></td>
        </tr>
        <tr>
            <td>&nbsp;</td> <td> &nbsp;</td> <td>&nbsp;</td> <td> &nbsp;</td>
        </tr>
        <tr>
            <td>&nbsp;</td> <td> <asp:Button ID="cmdSave0" runat="server" Text="Save Odometer Reading(s)" Width="214px" Visible="False" /></td> <td>&nbsp;</td> <td> &nbsp;</td>
        </tr>
         <tr>
            <td>&nbsp;</td> <td> &nbsp;</td> <td>&nbsp;</td> <td> &nbsp;</td>
        </tr>
        <tr>
            <td colspan="3"><b>Fueling Supplied</b></td> 
        </tr>
        <tr><td>Entry Number</td><td><asp:TextBox ID="txtEntryNum" runat="server" Width="211px" Enabled="False"></asp:TextBox></td>
            <td>Requisition Number</td><td><asp:TextBox ID="txtRequisitionNo" runat="server" Width="211px"></asp:TextBox></td>
       </tr>
        <tr><td>Date</td><td> <telerik:RadDatePicker ID="rdFuelingDate" runat="server" Culture="en-US" MinDate="1900-01-01"></telerik:RadDatePicker></td>
     
      <td>Quantity Supplied (litres)</td><td> <asp:TextBox ID="txtQtySupplied" runat="server" Width="211px"></asp:TextBox></td></tr>
     <tr><td>Mileage at Fueling</td><td><asp:TextBox ID="txtMileageAtFueling" runat="server" Width="211px"></asp:TextBox></td></tr>
        <tr><td colspan="4"><hr /></td></tr>
        <tr><td>&nbsp</td><td><asp:Button ID="cmdSave" runat="server" Text="Save Fueling Details" Width="214px" /></td>
            <td><asp:Button ID="cmdClear" runat="server" Text="Clear" Width="150px" /></td>
            <td><asp:Button ID="cmdDelete" runat="server" Text="Delete" Width="150px" /></td>
        </tr>
         <tr><td colspan="4"><hr /></td></tr>
    </table>
    <table width="60%" style="margin-left:2%">
        <tr><td colspan="4"><h4> Vehicle Fueling History</h4></td></tr>
        <tr><td style="vertical-align:top">&nbsp</td><td colspan ="3">
                <telerik:RadGrid ID="gwGrid" runat="server" AllowPaging="True" AllowSorting="True" BackColor="White" BorderColor="#003366" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" DisplayMode="FirstLastPreviousNextNumeric, Text" ForeColor="Black" GroupPanelPosition="Top" PageSize="100" AllowFilteringByColumn="True" ShowGroupPanel="True" AutoGenerateColumns="False">
                    <clientsettings AllowDragToGroup="True">
                        <Scrolling AllowScroll="True" UseStaticHeaders="True"  />
                    </clientsettings>
                    <MasterTableView>
                        <Columns>
                            <telerik:GridButtonColumn FilterControlAltText="Filter column column" UniqueName="column" CommandName="Edita" HeaderText="Edit" Text="Edit">
                            </telerik:GridButtonColumn>
                            <telerik:GridBoundColumn DataField="EntryNo" FilterControlAltText="Filter EntryNo column" HeaderText="EntryNo" UniqueName="EntryNo">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="requisitionNo" FilterControlAltText="Filter requisitionNo column" HeaderText="RequisitionNo" UniqueName="requisitionNo">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Date" FilterControlAltText="Filter Date column" HeaderText="Date" UniqueName="Date">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="FleetId" FilterControlAltText="Filter FleetId column" HeaderText="FleetId" UniqueName="FleetId" Display="False">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="QtySupplied" FilterControlAltText="Filter QtySupplied column" HeaderText="QtySupplied" UniqueName="QtySupplied">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="QtyUsed" FilterControlAltText="Filter QtyUsed column" HeaderText="QtyUsed" UniqueName="QtyUsed" Display="False">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="OdometerReading" FilterControlAltText="Filter OdometerReading column" HeaderText="OdometerReading" UniqueName="OdometerReading">
                            </telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </td></tr>
        <tr>
            <td>&nbsp;</td> <td>
                                         <telerik:RadComboBox ID="cboRegNumber" runat="server" Width="219px" AutoPostBack="True" Enabled="False" Visible="False"></telerik:RadComboBox>
                                         </td>
        </tr>
        </table>
</asp:Content>
