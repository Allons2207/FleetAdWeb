<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="ExamFeesSetUp.aspx.vb" Inherits="WebApplication2.ExamFeesSetUp" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style8 {
            height: 30px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:Panel ID="Panel1" groupingtext="Setting Exam Fees" runat="server" Width="100%">
        <table width="100%">
             <tr>
                <td>
                    Level
                </td>
                <td>
                    Exam Board
                </td>
                <td>
                    Center Fee
                </td>
                <td>
                    Stationary Fee
                </td>
                   <td >
                     Subject
                </td>
                <td >
                   Exam Fee
                </td>
            
            </tr>
            <tr>
                <td>
                    <telerik:RadComboBox ID="RadComboBoxStream" Runat="server">
                    </telerik:RadComboBox></td>
                <td>
                  <telerik:RadComboBox ID="RadComboBoxExamBoard" Runat="server">
                    </telerik:RadComboBox>
                </td>
                <td>
                    <asp:TextBox ID="txtCenterFee" runat="server"></asp:TextBox>
                </td>
                <td>
                    <asp:TextBox ID="txtStationaryFee" runat="server"></asp:TextBox>
                </td>
                 <td class="auto-style8" >
                    <telerik:RadComboBox ID="RadComboBoxSubjects" runat="server"></telerik:RadComboBox>
                </td>
               
                <td class="auto-style8">
                    <asp:TextBox ID="txtFees" runat="server"></asp:TextBox>
                </td>
               
            </tr>
       </table>

        <table width="100%">
            <tr>
                
                <td ></td>
                <td></td>
            </tr>
            <tr>
               
                <td class="auto-style8">
                    <asp:Button ID="cmdSave" runat="server" Text="Save" BackColor="#FF9900" Width="98px" ForeColor="White" />

                </td>
                <td >
                  <asp:TextBox ID="TextBox1" runat="server" Visible="False"></asp:TextBox>
                </td>
            </tr>
           
            </table>
         
        <table>
             <tr>
                <td>
                    <asp:ListView ID="ListView1" runat="server"></asp:ListView>
                </td>
            </tr>
           
        </table>
 </asp:Panel>


</asp:Content>
