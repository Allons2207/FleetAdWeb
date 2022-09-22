<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="ProfStudentsPersonalDetails.aspx.vb" Inherits="WebApplication2.ProfStudentsPersonalDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <table>
        <tr>
            <td>&nbsp</td>
        </tr>
    <tr>
        <td style="font-size:medium; color:darkblue ">
            Capturing Professional Student Personal Details
        </td>
    </tr>
            <tr>
             <td>
                 <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small"></asp:Label>
             </td>
         </tr>
</table>
    <table width="80%">
        <tr>
            <td >
                Student No
            </td>
            <td >
                
                <asp:TextBox ID="txtStudentNumber" runat="server"></asp:TextBox>
                
            </td>
           </tr> 
        <tr>
            <td>Reg Date</td>
            <td>
                <telerik:RadDatePicker ID="RadDatePicker" runat="server"></telerik:RadDatePicker>
                <asp:RequiredFieldValidator ID="rqvalRadDatePicker" runat="server" ControlToValidate="RadDatePicker"
                                ErrorMessage="Please supply registration Date">*</asp:RequiredFieldValidator>
            </td>
            </tr>
        <tr>
            <td>
                First Name
            </td>
            <td>
                <asp:TextBox ID="txtFirstName" runat="server"></asp:TextBox>
                 <asp:RequiredFieldValidator ID="rqvalFirstName" runat="server" ControlToValidate="txtFirstName"
                                ErrorMessage="Please supply student's first name">*</asp:RequiredFieldValidator>
            </td>
            <td>
                Second Name
            </td>
            <td >
                <asp:TextBox ID="txtSecondName" runat="server"></asp:TextBox>
            </td>
            
            <td>
                Surname
            </td>
            <td>
                <asp:TextBox ID="txtSurname" runat="server"></asp:TextBox></td>
           </tr>


        <tr>
            <td class="auto-style6">
                National ID Number
            </td>
            <td>
                 <asp:TextBox ID="txtNationalIDNumber" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rqvalNationalIDNum" runat="server" ControlToValidate="txtNationalIDNumber"
                                ErrorMessage="Please supply National ID Number">*</asp:RequiredFieldValidator>
            </td>
           
            
                <td>
                    Sex</td>
            <td>
                <telerik:RadComboBox ID="cbSex" runat="server">
                    <Items>
                        <telerik:RadComboBoxItem runat="server" Text="Male" Value="Male" />
                        <telerik:RadComboBoxItem runat="server" Text="Female" Value="Female" />
                    </Items>
                </telerik:RadComboBox>
                 </td>
          
        
            <td>Contact Number</td> <td><asp:TextBox ID="txtContactNum" runat="server"></asp:TextBox></td>
        </tr>



        <tr>
            <td>Course</td>
            <td class="auto-style1">
                <telerik:RadComboBox ID="cbCourse" runat="server" Width="301px"></telerik:RadComboBox>
                 <asp:RequiredFieldValidator ID="rqvalCourse" runat="server" ControlToValidate="cbCourse"
                                ErrorMessage="Please specify the course">*</asp:RequiredFieldValidator>
            </td>
            <td> Level </td>
            <td >
                 <telerik:RadComboBox ID="cbLevel" runat="server"></telerik:RadComboBox>
                 <asp:RequiredFieldValidator ID="rqvalLevel" runat="server" ControlToValidate="cbLevel"
                                ErrorMessage="Please specify the course level">*</asp:RequiredFieldValidator>
                 </td>
            <td class="auto-style3">
                &nbsp;Status
            </td><td class="auto-style2">
                 <telerik:RadComboBox ID="cbStatus" runat="server"></telerik:RadComboBox>
                 <asp:RequiredFieldValidator ID="rqStatus" runat="server" ControlToValidate="cbStatus"
                                ErrorMessage="Please specify the student status">*</asp:RequiredFieldValidator>
                 </td>
            </tr>
        
        <tr>
            <td >Physical Address</td> <td ><asp:TextBox ID="txtAddress" runat="server" Height="65px" TextMode="MultiLine" Width="303px"></asp:TextBox></td>
            <td>E-mail Address</td><td colspan="3"><asp:TextBox ID="txtEmailAddress" runat="server" Width="417px"></asp:TextBox>  </td>
        </tr>
        <tr>
            <td >&nbsp;</td>
        </tr>
        <tr>
            <td style="font-size:small; color:darkblue" class="auto-style6"> Details of Next of Kin</td>
        </tr>
        <tr><td >&nbsp;</td></tr>
        <tr>
            <td >Full Name</td><td class="auto-style1"><asp:TextBox ID="txtNextOfKin" runat="server"></asp:TextBox></td>
        </tr>
        <tr>
            <td >ContactNumber</td><td class="auto-style1"><asp:TextBox ID="txtNextOfKinContactNum" runat="server"></asp:TextBox></td>
        </tr>
           <tr>
            <td >Address</td><td class="auto-style1"><asp:TextBox ID="txtNextOfKinAddress" runat="server" TextMode="MultiLine" Width="303px" Height="58px"></asp:TextBox></td>
        </tr>

        <tr>
            <td>&nbsp</td>
        </tr>
        <tr>
            <td>&nbsp</td><td> <asp:Button ID="cmdSave" runat="server" Text="Save" BackColor="#FF9900" /></td>
        </tr>
    </table>
    



</asp:Content>
