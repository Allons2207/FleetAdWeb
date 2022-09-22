<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="DefensiveDriversCertificateDetails.aspx.vb" Inherits="WebApplication2.DefensiveDriversCertificateDetails" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <h3 style="font-size:medium; color:gray "> Defensive Drivers&#39; Certificate Details</h3>
     <table style="margin-left:2%" >
         <tr>
             <td>Firstname</td><td> <asp:TextBox ID="txtFirstNameSearch" runat="server" Width="212px"></asp:TextBox></td><td>Surname</td><td> <asp:TextBox ID="txtSurnameSearch" runat="server" Width="212px"></asp:TextBox></td>
             <td>
                 <asp:Button ID="cmdFind" runat="server" Text="Find" Width="105px" />
             </td>
         </tr>
          <tr>
         <td colspan="5" class="auto-style1">
             <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small" Width ="100%"></asp:Label>             
         </td>
        </tr>
         <tr>
             <td colspan="5"><hr /></td>
         </tr>
        <tr><td>Select by Nat. ID No</td><td> 
                                         <telerik:RadComboBox ID="cboNationalIDNos" runat="server" Width="222px" AutoPostBack="True"></telerik:RadComboBox>
                                         </td> 
            <td>&nbsp;Select by License #</td><td>
                                         <telerik:RadComboBox ID="cboLicense" runat="server" Width="222px" AutoPostBack="True"></telerik:RadComboBox>
                                         </td>
        </tr>
        <tr><td>First Name</td><td> <asp:TextBox ID="txtFirstName" runat="server" Width="213px" Enabled="False"></asp:TextBox></td>
            <td>Surname</td><td> <asp:TextBox ID="txtSurname" runat="server" Width="212px" Enabled="False"></asp:TextBox></td>
        </tr>
        <tr><td>Department</td><td> <asp:TextBox ID="txtDept" runat="server" Width="213px" Enabled="False"></asp:TextBox></td>
            <td>Designation</td><td> <asp:TextBox ID="txtDesignation" runat="server" Width="212px" Enabled="False"></asp:TextBox></td></tr>
         <tr><td></td></tr>
         <tr><td colspan="5"><hr /></td></tr>
         <tr><td>Examination Date</td><td>
                                         <telerik:RadDatePicker ID="rdDateIssued" runat="server" Culture="en-US" MinDate="1900-01-01"></telerik:RadDatePicker>
                                     </td><td>Expiry Date</td><td>
                                         <telerik:RadDatePicker ID="rdExpiryDate" runat="server" Culture="en-US" MinDate="1900-01-01"></telerik:RadDatePicker>
                                     </td></tr>
        <tr><td colspan="5"><hr /></td></tr>
        <tr><td colspan="4" style="text-align:center">
                 <asp:Button ID="cmdSave" runat="server" Text="Save" Width="217px" />&nbsp;&nbsp
                 <asp:Button ID="cmdDelete" runat="server" Text="Delete" Width="214px" />
             </td></tr>

    </table>

</asp:Content>
