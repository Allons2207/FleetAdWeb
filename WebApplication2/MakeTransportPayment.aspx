<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="MakeTransportPayment.aspx.vb" Inherits="WebApplication2.MakeTransportPayment" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style1 {
            width: 80px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <table>
    <tr>
        <td style="font-size:medium; color:darkblue ">
            Transport Payment
        </td>
    </tr>
             <tr>
             <td>
                 <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small"></asp:Label>
             </td>
         </tr>
</table>
    <asp:Panel ID="Panel1" runat="server" GroupingText="Student Details">
    <table width ="100%">
        <tr>
            <td>
                StudentID
            </td>
            <td>
                <asp:TextBox ID="txtStudentID" runat="server"></asp:TextBox>
            </td>
            <td>
                First Name
            </td>
            <td>
                <asp:TextBox ID="txtStudentFName" runat="server"></asp:TextBox>
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
                Stream
            </td>
            <td>
                <asp:TextBox ID="txtStream" runat="server"></asp:TextBox>
            </td>
            <td>
              Class
            </td>
            <td>
                <asp:TextBox ID="txtClass" runat="server"></asp:TextBox>

            </td>
            <td>
             
            </td>
            <td>
                
            </td>

        </tr>
   
    </table>
        </asp:Panel>
    <table>
        <tr>
            <td class="auto-style1">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            </td>
            <td>
                Amount Due
            </td>
            <td>
                Amount Paid
            </td>
            <td>
                Balance
            </td>
            <td>
                Receipt number
            </td>
        </tr>
        <tr>
            <td class="auto-style1">
                 &nbsp;</td>
            <td>
                <asp:TextBox ID="txtAmountDue" runat="server"></asp:TextBox>
            </td>
            <td>
                <asp:TextBox ID="txtAmountPaid" runat="server" AutoPostBack="True"></asp:TextBox>
            </td>
            <td>
                <asp:TextBox ID="txtBalance" runat="server"></asp:TextBox>
            </td>
            <td>
                <asp:TextBox ID="txtReceiptNo" runat="server" Enabled="False"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="auto-style1"></td>
        </tr>
    </table>
    <asp:Button ID="cmdSave" runat="server" Text="Save"  Width="150px" BackColor="Orange" />
</asp:Content>
