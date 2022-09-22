<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="BulkLicenseDetails.aspx.vb" Inherits="WebApplication2.BulkLicenseDetails" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <h3 style="font-size:medium; color:gray "> License Details</h3>
     <table style="margin-left:2%" >
          <tr>
         <td colspan="5" class="auto-style1">
             <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small" Width ="100%"></asp:Label>             
         </td>
        </tr>
         <tr>
             <td>Type</td><td>  
                                         <telerik:RadComboBox ID="cboLicenseType" runat="server" Width="222px" AutoPostBack="True"></telerik:RadComboBox>
                                         </td><td>&nbsp;</td><td> &nbsp;</td>
        </tr>
         <tr>
             <td>License No.</td><td> <asp:TextBox ID="txtLicenseNo" runat="server" Width="212px"></asp:TextBox></td><td>&nbsp;</td><td> &nbsp;</td>
        </tr>
        <tr><td>Details</td><td colspan="3"> <asp:TextBox ID="txtDetails" runat="server" Width="500px" Height="85px" TextMode="MultiLine"></asp:TextBox></td>
        </tr>
        <tr><td></td></tr>
        <tr><td>Date Issued</td><td>
                                         <telerik:RadDatePicker ID="rdDateIssued" runat="server" Culture="en-US" MinDate="1900-01-01"></telerik:RadDatePicker>
                                     </td><td>Expiry Date</td><td>
                                         <telerik:RadDatePicker ID="rdExpiryDate" runat="server" Culture="en-US" MinDate="1900-01-01"></telerik:RadDatePicker>
                                     </td></tr>
        <tr><td colspan="5"><hr /></td></tr>
         <tr>
             <td style="vertical-align:top">Vehicles</td>
             <td colspan ="4">
                  <telerik:RadGrid ID="gwList" runat="server"  BackColor="White"  AllowPaging="True"  DisplayMode="FirstLastPreviousNextNumeric, Text" PageSize="25"
         BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" AllowSorting="True" GroupPanelPosition="Top"  ForeColor="Black" AutoGenerateColumns="False" AllowMultiRowSelection="True" ClientSettings-Selecting-AllowRowSelect="true" Width="500px" AllowFilteringByColumn="True" >
                      
                      <GroupingSettings CaseSensitive="False" />
                      
                  <ClientSettings>
                        <Selecting AllowRowSelect="True"></Selecting>
                          </ClientSettings>

              <AlternatingItemStyle BackColor="#E9E9E9" />

           <MasterTableView>
             <Columns>
                 
                 <telerik:GridClientSelectColumn DataType="System.Boolean" FilterControlAltText="Filter attendance column"
                            UniqueName="attendance" HeaderText="attendance" FooterText="attendance">
                        </telerik:GridClientSelectColumn>
                 
                 <telerik:GridBoundColumn DataField="FleetId" FooterText="FleetId" HeaderText="FleetId"
                            UniqueName="FleetId" FilterControlAltText="Filter FleetId column">  </telerik:GridBoundColumn>
                 <telerik:GridBoundColumn DataField="RegNumber" FilterControlAltText="Filter RegNumber column" HeaderText="RegNumber" UniqueName="RegNumber">
                 </telerik:GridBoundColumn>
                 <telerik:GridBoundColumn DataField="VehicleCategory" FilterControlAltText="Filter VehicleCategory column" HeaderText="VehicleCategory" UniqueName="VehicleCategory">
                 </telerik:GridBoundColumn>
                 <telerik:GridBoundColumn DataField="Make" FilterControlAltText="Filter Make column" HeaderText="Make" UniqueName="Make">
                 </telerik:GridBoundColumn>
                 <telerik:GridBoundColumn DataField="Model" FilterControlAltText="Filter Model column" HeaderText="Model" UniqueName="Model">
                 </telerik:GridBoundColumn>
             </Columns>
              
         </MasterTableView>
                                 
     </telerik:RadGrid> 
             </td>
         </tr>
        <tr><td colspan="5" style="text-align:center">
                 <asp:Button ID="cmdSave" runat="server" Text="Save" Width="170px" />&nbsp;&nbsp
                 <asp:Button ID="cmdDelete" runat="server" Text="Delete" Width="170px" />
             </td></tr>
    </table>
</asp:Content>
