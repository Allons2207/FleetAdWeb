<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="testQuestions.aspx.vb" Inherits="WebApplication2.testQuestions" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style1 {
            height: 24px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <table>
       <tr>
       <td style="font-size:medium; color:darkblue " colspan="3">Tests and Assignments Questions</td>
       </tr>
       <tr>
         <td>
             <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small"></asp:Label>
         </td>
        </tr>

        <tr><td>Subject</td><td><asp:TextBox ID="txtSubject" runat="server" ></asp:TextBox></td></tr>
        
        <tr><td>Test Code</td><td><asp:TextBox ID="txtTestCode" runat="server" ></asp:TextBox></td></tr>
        <tr>
            <td>Sorting Order Number</td><td><asp:TextBox ID="txtOrderNumber" runat="server" ></asp:TextBox></td></tr>
        <tr>
            <td>Question Number</td><td><asp:TextBox ID="txtQuestionNum" runat="server" ></asp:TextBox></td></tr>
         <tr>   <td>Question </td><td><asp:TextBox ID="txtQuestion" runat="server" Height="93px" TextMode="MultiLine" Width="900px" ></asp:TextBox></td></tr>
        <tr>    <td class="auto-style1">Covered Topics</td><td class="auto-style1"><asp:TextBox ID="txtCoveredTopics" runat="server" ></asp:TextBox></td></tr>
           <tr><td></td></tr>
        <tr>    <td>Possible Answers</td><td></td></tr>
        <tr>    <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;A</td><td><asp:TextBox ID="txtA" runat="server" Width="900px" ></asp:TextBox></td></tr>
        <tr>   <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;B</td><td><asp:TextBox ID="txtB" runat="server" Width="900px" ></asp:TextBox></td></tr>
        <tr>    <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;C</td><td><asp:TextBox ID="txtC" runat="server" Width="900px" ></asp:TextBox></td></tr>
        <tr>    <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;D</td><td><asp:TextBox ID="txtD" runat="server" Width="900px" ></asp:TextBox></td></tr>
        <tr>    <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;E</td><td><asp:TextBox ID="txtE" runat="server" Width="900px" ></asp:TextBox></td>
            
        </tr>
        <tr><td></td></tr>
        <tr><td>Correct Answer</td><td>
            <telerik:RadComboBox ID="cboAnswer" runat="server" Height="16px" Width="137px">
                <Items>
                    <telerik:RadComboBoxItem runat="server" Text="A" Value="A" />
                    <telerik:RadComboBoxItem runat="server" Text="B" Value="B" />
                    <telerik:RadComboBoxItem runat="server" Text="C" Value="C" />
                    <telerik:RadComboBoxItem runat="server" Text="D" Value="D" />
                    <telerik:RadComboBoxItem runat="server" Text="E" Value="E" />
                </Items>
            </telerik:RadComboBox></td></tr>
        <tr><td>Question Marks = </td><td><asp:TextBox ID="txtQuestionMarks" runat="server" ></asp:TextBox></td></tr>
        <tr><td>  </td><td><asp:Button ID="cmdSave" runat="server" Text="Save" Width="136px" /></td></tr>
    </table>

    </asp:Content>
