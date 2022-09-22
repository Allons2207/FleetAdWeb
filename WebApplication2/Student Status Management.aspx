<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="Student Status Management.aspx.vb" Inherits="WebApplication2.Student_Status_Management" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table width ="100%">
        <tr>
            <td>
                Student No
            </td>
            <td>
                <asp:TextBox ID="txtStudentNo" runat="server"></asp:TextBox>
            </td>
            <td>
                FirstName
            </td>
            <td>
                <asp:TextBox ID="txtFirstName" runat="server"></asp:TextBox>
            </td>
            <td>
                Surname
            </td>
            <td>
                <asp:TextBox ID="txtSurname" runat="server"></asp:TextBox>
            </td>
        </tr>
       <tr>
           <td>
           Status</td>
           <td>
               <telerik:RadComboBox ID="cbStatus" runat="server"></telerik:RadComboBox>
           </td>
           <td>
               Change Reason
           </td>
           <td>
               <asp:TextBox ID="txtChangeReason" runat="server" TextMode="MultiLine" ></asp:TextBox>
           </td>
         </tr>
        <tr>
            <td>
                <asp:Button ID="cmdSave" runat="server" Text="Save Change" />
            </td>
        </tr>
    </table>
</asp:Content>
