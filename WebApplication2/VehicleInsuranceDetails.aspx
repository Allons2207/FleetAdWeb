<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="VehicleInsuranceDetails.aspx.vb" Inherits="WebApplication2.VehicleInsuranceDetails" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <h3 style="font-size:medium; color:gray "> Vehicle Insurance Details</h3>
    <table style="margin-left:2%" >
         <tr>
         <td colspan="4" class="auto-style1">
             <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small" Width="100%"></asp:Label>
         </td>
        </tr>
        <tr><td><b>VEHICLE DETAILS:</b></td></tr>
         <tr><td>Search by Fleet ID.</td><td><asp:TextBox ID="txtFleetIDSearch" runat="server" Width="211px"></asp:TextBox></td><td><asp:Button ID="btnSearchByFleetID" runat="server" Text="Find" Width="150px" /></td></tr>
          <tr><td>Search by Reg No.</td><td><asp:TextBox ID="txtRegNo" runat="server" Width="211px"></asp:TextBox></td><td><asp:Button ID="cmdFindVehicleByRegNo" runat="server" Text="Find" Width="150px" /></td></tr>
<tr>
    <td colspan="4"><hr /></td>
</tr>

        <tr>
            <td>Fleet ID</td><td> <asp:TextBox ID="txtFleetID" runat="server" Width="209px" Enabled="False"></asp:TextBox></td>
            
        </tr>
        <tr><td>Make</td><td> <asp:TextBox ID="txtMake" runat="server" Width="212px" Enabled="False"></asp:TextBox></td><td>Model</td><td> <asp:TextBox ID="txtModel" runat="server" Width="212px" Enabled="False"></asp:TextBox></td></tr>
<tr><td></td></tr>
<tr><td><b>Insurance Details</b></td></tr>
        <tr><td>Date Issued</td><td>
                                         <telerik:RadDatePicker ID="rdIssuedDate" runat="server" Culture="en-US" MinDate="1900-01-01"></telerik:RadDatePicker>
                                     </td>
            <td>Expiry Date</td><td>
                                         <telerik:RadDatePicker ID="rdExpiryDate" runat="server" Culture="en-US" MinDate="1900-01-01"></telerik:RadDatePicker>
                                     </td>
        </tr>
        <tr><td>Details</td><td colspan="3"> <asp:TextBox ID="txtDetails" runat="server" Width="555px" Height="58px" TextMode="MultiLine"></asp:TextBox></td>
            
        </tr>
        
        <tr><td colspan="4"><hr /></td></tr>
        <tr><td></td><td colspan="3">
                 <asp:Button ID="cmdSave" runat="server" Text="Save Insurance Details" Width="214px" />&nbsp
                 <asp:Button ID="cmdDelete" runat="server" Text="Delete" Width="214px" />
             </td></tr>
        <tr>
            <td>&nbsp;</td><td>
                                         <telerik:RadComboBox ID="cboRegistrationNumber" runat="server" Width="219px" AutoPostBack="True" Visible="False"></telerik:RadComboBox>
                                         </td> 
        </tr>
    </table>
</asp:Content>
