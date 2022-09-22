<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/StudentsPortalMaster.Master" CodeBehind="StudentsPortalExamTimeTable.aspx.vb" Inherits="WebApplication2.StudentsPortalExamTimeTable" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table width = "40%">
         <tr>
       <td style="font-size:medium; color:darkblue " colspan="6">
           Student Exam Time Table(s)</td>
       </tr>
       <tr>
         <td>
             <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small"></asp:Label>
         </td>
        </tr>
    </table>
</asp:Content>
