<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="VehicleAvailability.aspx.vb" Inherits="WebApplication2.VehicleAvailability" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style3 {
            width: 105px;
        }
.RadComboBox_Default{color:#333;font-size:12px;font-family:"Segoe UI",Arial,Helvetica,sans-serif}.RadComboBox{text-align:left;display:inline-block;vertical-align:middle;white-space:nowrap;*display:inline;*zoom:1}.RadComboBox .rcbReadOnly .rcbInputCellLeft{background-position:0 -88px}.RadComboBox_Default .rcbInputCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbInputCellLeft{background-position:0 0}.RadComboBox .rcbInputCell{padding-right:4px;padding-left:5px;width:100%;height:20px;line-height:20px;text-align:left;vertical-align:middle}.RadComboBox .rcbInputCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox .rcbReadOnly .rcbArrowCellRight{background-position:-162px -176px}.RadComboBox_Default .rcbArrowCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbArrowCellRight{background-position:-18px -176px}.RadComboBox .rcbArrowCell{width:18px}.RadComboBox .rcbArrowCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}
        .auto-style4 {
            border-width: 0;
            padding-left: 5px;
            padding-right: 4px;
            padding-top: 0;
            padding-bottom: 0;
        }
        .auto-style5 {
            border-width: 0;
            padding: 0;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

     <h3 style="font-size:medium; color:gray "> Pool Vehicles List</h3>
    <table width="90%" style="margin-left:2%" >
       <tr><td class="auto-style3">
              Select
       </td><td> 
                                         <telerik:RadComboBox ID="cboSelect" runat="server" Width="222px" AutoPostBack="True">
                                             <Items>
                                                 <telerik:RadComboBoxItem runat="server" Text="--Select--" Value="--Select--" />
                                                 <telerik:RadComboBoxItem runat="server" Text="Available Vehicle" Value="Available Vehicle" />
                                                 <telerik:RadComboBoxItem runat="server" Text="UnAvailable Vehicles" Value="UnAvailable Vehicles" />
                                             </Items>
               </telerik:RadComboBox>
                                         </td></tr>
       <tr>
         <td colspan="2">
             <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small" Width="100%"></asp:Label>
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
                            <telerik:GridBoundColumn DataField="Mileage" FilterControlAltText="Filter Mileage column" HeaderText="Mileage" UniqueName="Mileage">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="MileageDate" FilterControlAltText="Filter MileageDate column" HeaderText="MileageDate" UniqueName="MileageDate">
                            </telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </td>
        </tr>
    </table>
</asp:Content>
