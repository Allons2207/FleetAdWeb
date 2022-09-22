<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="AllocateVehicle.aspx.vb" Inherits="WebApplication2.AllocateVehicle" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3 style="font-size:medium; color:gray "> Vehicle Allocation</h3>
    <table style="margin-left:2%" >
         <tr>
         <td colspan="4">
             <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small" Width ="100%"></asp:Label>
         </td>
        </tr>
        <tr><td><b>VEHICLE DETAILS:</b></td></tr>
        <tr><td>Search by Fleet ID.</td><td><asp:TextBox ID="txtFleetIDSearch" runat="server" Width="211px"></asp:TextBox></td><td><asp:Button ID="btnSearchByFleetID" runat="server" Text="Find" Width="150px" /></td></tr>
        <tr><td>Search by Reg No.</td><td><asp:TextBox ID="txtRegNo" runat="server" Width="211px"></asp:TextBox></td><td><asp:Button ID="cmdClear0" runat="server" Text="Find" Width="150px" /></td></tr>
<tr>
    <td colspan="5"><hr /></td>
</tr>
         <tr>
             <td>Fleet ID </td><td>
                                         <asp:TextBox ID="txtFleetID" runat="server" Width="210px" Enabled="False"></asp:TextBox>
             </td>
        </tr>
        <tr><td>Make</td><td> <asp:TextBox ID="txtMake" runat="server" Width="212px" Enabled="False"></asp:TextBox></td><td>Model</td><td> <asp:TextBox ID="txtModel" runat="server" Width="212px" Enabled="False"></asp:TextBox></td></tr>
<tr><td></td></tr>
<tr><td><b>ALLOCATE TO</b></td></tr>
        
        <tr>
             <td>Firstname</td><td> <asp:TextBox ID="txtSearhFirstName" runat="server" Width="212px"></asp:TextBox></td><td>Surname</td><td> <asp:TextBox ID="txtSearchSurname" runat="server" Width="212px"></asp:TextBox></td>
             <td>
                 <asp:Button ID="cmdFind" runat="server" Text="Find" Width="105px" />
             </td>
         </tr>


               <tr><td>Search by License No.</td><td><asp:TextBox ID="txtLicenceNo" runat="server" Width="211px"></asp:TextBox></td><td><asp:Button ID="btnFindDriver" runat="server" Text="Find" Width="150px" /></td></tr>

        <tr><td>First Name</td><td> <asp:TextBox ID="txtFirstName" runat="server" Width="211px" Enabled="False"></asp:TextBox></td>
            <td>Surname</td><td> <asp:TextBox ID="txtSurname" runat="server" Width="212px" Enabled="False"></asp:TextBox></td>
        </tr>
        <tr><td>Department</td><td> <asp:TextBox ID="txtDept" runat="server" Width="213px" Enabled="False"></asp:TextBox></td>
            <td>Designation</td><td> <asp:TextBox ID="txtDesignation" runat="server" Width="212px" Enabled="False"></asp:TextBox></td></tr>
        <tr><td colspan="5"><hr /></td></tr>
        <tr><td></td><td>
                 <asp:Button ID="cmdSave" runat="server" Text="Allocate" Width="217px" />
             </td></tr>
        <tr>
            <td></td><td> 
                                         <telerik:RadComboBox ID="cboRegistrationNumber" runat="server" Width="215px" AutoPostBack="True" Visible="False"></telerik:RadComboBox>
             </td>
        </tr>

            <tr><td>&nbsp;</td><td> 
                                         <telerik:RadComboBox ID="cboNationalIDNos" runat="server" Width="222px" AutoPostBack="True" Visible="False"></telerik:RadComboBox>
                                         </td> 
            <td>&nbsp;</td><td>
                                         <telerik:RadComboBox ID="cboLicense" runat="server" Width="222px" AutoPostBack="True" Visible="False"></telerik:RadComboBox>
                                         </td>

        </tr>
        </tr>


    </table>
</asp:Content>
