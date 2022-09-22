<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="VehicleInspectionDetails.aspx.vb" Inherits="WebApplication2.VehicleInspectionDetails" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
  
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3 style="font-size:medium; color:gray "> Vehicle Inspection Details</h3>
    <table style="margin-left:2%" >
         <tr>
         <td colspan="4" class="auto-style1">
             <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small" Width="100%"></asp:Label>
         </td>
        </tr>
        <tr><td><b>VEHICLE DETAILS:</b></td></tr>
         <tr><td>Search by Fleet ID.</td><td><asp:TextBox ID="txtFleetIDSearch" runat="server" Width="211px"></asp:TextBox></td><td><asp:Button ID="btnSearchByFleetID" runat="server" Text="Find" Width="150px" /></td></tr>
          <tr><td>Search by Reg No.</td><td><asp:TextBox ID="txtRegNo" runat="server" Width="211px"></asp:TextBox></td><td><asp:Button ID="cmdClear0" runat="server" Text="Find" Width="150px" /></td></tr>
<tr>
    <td colspan="4"><hr /></td>
</tr>

        <tr>
            <td>Fleet ID</td><td> <asp:TextBox ID="txtFleetID" runat="server" Width="209px" Enabled="False"></asp:TextBox></td>
            
        </tr>
        <tr><td>Make</td><td> <asp:TextBox ID="txtMake" runat="server" Width="212px" Enabled="False"></asp:TextBox></td><td>Model</td><td> <asp:TextBox ID="txtModel" runat="server" Width="212px" Enabled="False"></asp:TextBox></td></tr>
<tr><td></td></tr>
<tr><td><b>Inspection Details</b></td></tr>
        <tr><td>Inspection Date</td><td>
                                         <telerik:RadDatePicker ID="rdInspectionDate" runat="server" Culture="en-US" MinDate="1900-01-01"></telerik:RadDatePicker>
                                     </td></tr>
        <tr><td>Inspected Items</td><td colspan="3"> 
          <telerik:RadGrid ID="gwList" runat="server"  BackColor="White"  AllowPaging="True"  DisplayMode="FirstLastPreviousNextNumeric, Text" PageSize="100"
         BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" AllowSorting="True" GroupPanelPosition="Top"  ForeColor="Black" AutoGenerateColumns="False" AllowMultiRowSelection="True" ClientSettings-Selecting-AllowRowSelect="true" Width="250px" >
                      
                  <ClientSettings>
                        <Selecting AllowRowSelect="True"></Selecting>
                          </ClientSettings>

              <AlternatingItemStyle BackColor="#E9E9E9" />

           <MasterTableView>
             <Columns>
                 
                 <telerik:GridClientSelectColumn DataType="System.Boolean" FilterControlAltText="Filter attendance column"
                            UniqueName="attendance" HeaderText="attendance" FooterText="attendance">
                        </telerik:GridClientSelectColumn>
                 
                 <telerik:GridBoundColumn DataField="Inspected" FooterText="Inspected" HeaderText="Inspected"
                            UniqueName="Inspected" FilterControlAltText="Filter Accessory column">  </telerik:GridBoundColumn>
             </Columns>
              
         </MasterTableView>
                                 
     </telerik:RadGrid> 
            </td></tr>
        <tr><td>Overall Finding</td><td> 
                                         <telerik:RadComboBox ID="cboOverallFinding" runat="server" Width="222px">
                                             <Items>
                                                 <telerik:RadComboBoxItem runat="server" Text="Dents" Value="Dents" />
                                                 <telerik:RadComboBoxItem runat="server" Text="Suspension" Value="Suspension" />
                                                 <telerik:RadComboBoxItem runat="server" Text="Tyres" Value="Tyres" />
                                                 <telerik:RadComboBoxItem runat="server" Text="Electrical" Value="Electrical" />
                                                 <telerik:RadComboBoxItem runat="server" Text="Non-Service Compiance" Value="Non-Service Compiance" />
                                                 <telerik:RadComboBoxItem runat="server" Text="N/A" Value="N/A" />
                                             </Items>
                                         </telerik:RadComboBox>
                                         </td> 
            <td>&nbsp;</td><td>
                                         &nbsp;</td>

        </tr>
        <tr><td>Details</td><td colspan="3"> <asp:TextBox ID="txtInspectionDetails" runat="server" Width="555px" Height="58px" TextMode="MultiLine"></asp:TextBox></td>
            
        </tr>
        
        <tr><td colspan="4"><hr /></td></tr>
        <tr><td></td><td colspan="3">
                 <asp:Button ID="cmdSave" runat="server" Text="Save Inspection Details" Width="214px" />&nbsp
                 <asp:Button ID="cmdDelete" runat="server" Text="Delete" Width="214px" />
             </td></tr>
        <tr>
            <td>&nbsp;</td><td>
                                         <telerik:RadComboBox ID="cboRegistrationNumber" runat="server" Width="219px" AutoPostBack="True" Visible="False"></telerik:RadComboBox>
                                         </td> 
        </tr>
    </table>



</asp:Content>
