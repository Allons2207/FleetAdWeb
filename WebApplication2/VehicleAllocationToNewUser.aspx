<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="VehicleAllocationToNewUser.aspx.vb" Inherits="WebApplication2.VehicleAllocationToNewUser" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
      <h3 style="font-size:medium; color:gray "> Vehicle Allocation to New User</h3>
    <table style="margin-left:2%" >
        <tr><td colspan="4"><hr /></td></tr>
         <tr>
         <td colspan="4">
             <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small" Width="100%"></asp:Label>
         </td>
        </tr>
        <tr><td>First Name</td><td> <asp:TextBox ID="txtFirstName" runat="server" Width="216px"></asp:TextBox></td> <td>Surname</td><td> <asp:TextBox ID="txtSurname" runat="server" Width="216px"></asp:TextBox></td>  </tr>
        <tr><td>Department</td><td> <asp:TextBox ID="txtDepartment" runat="server" Width="216px"></asp:TextBox></td><td>Designation</td><td> <asp:TextBox ID="txtDesignation" runat="server" Width="216px"></asp:TextBox></td></tr>
        <tr><td>National ID #</td><td> <asp:TextBox ID="txtNationalIDNumber" runat="server" Width="216px"></asp:TextBox></td><td>License Number</td><td> <asp:TextBox ID="txtLicenseNumba" runat="server" Width="216px"></asp:TextBox></td></tr>
        <tr><td>Defensive License Expiry Date</td><td>
                                         <telerik:RadDatePicker ID="rdExpiryDate" runat="server" Culture="en-US" MinDate="1900-01-01"></telerik:RadDatePicker>
                                     </td><td></td><td></td></tr>
        <tr><td></td><td></td><td></td><td></td></tr>
        <tr><td>Application Date</td><td>
                                         <telerik:RadDatePicker ID="rdApplicationDate" runat="server" Culture="en-US" MinDate="1900-01-01"></telerik:RadDatePicker>
                                     </td><td>Application Form #</td><td> <asp:TextBox ID="txtApplicationFormNumber" runat="server" Width="216px"></asp:TextBox></td></tr>
        <tr><td></td><td></td><td></td><td></td></tr>
      
        <tr><td colspan="4"><hr /></td></tr>
        <tr><td>Fleet ID</td><td><asp:Label ID="lblFleetId" runat="server" Text=""  Font-Bold="True" Font-Size="Small"></asp:Label></td>
            <td>Registration Number</td><td><asp:Label ID="lblRegNo" runat="server" Text=""  Font-Bold="True" Font-Size="Small"></asp:Label></td>
        </tr>
        <tr><td>Make</td><td><asp:Label ID="lblMake" runat="server" Text=""  Font-Bold="True" Font-Size="Small"></asp:Label></td>
            <td>Model</td><td><asp:Label ID="lblModel" runat="server" Text=""  Font-Bold="True" Font-Size="Small"></asp:Label></td>
        </tr>
        <tr><td>User Category</td><td><asp:Label ID="lblUserCategory" runat="server" Text=""  Font-Bold="True" Font-Size="Small"></asp:Label></td>
            <td>Vehicle Type</td><td><asp:Label ID="lblVehicleType" runat="server" Text=""  Font-Bold="True" Font-Size="Small"></asp:Label></td>
        </tr>
        <tr><td colspan="4"><hr /></td></tr>
        <tr><td></td><td colspan="3">
              <asp:Button ID="cmdAllocate" runat="server" Text="Allocate" Width="168px" />&nbsp
                            <asp:Button ID="cmdClear" runat="server" Text="Clear" Width="168px" />
            &nbsp;&nbsp
                            </td></tr>
    </table>

</asp:Content>
