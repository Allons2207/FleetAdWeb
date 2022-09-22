<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="MakeUniformItemPayment.aspx.vb" Inherits="WebApplication2.MakeUniformItemPayment" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style1 {
            height: 33px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <table>
    <tr>
        <td style="font-size:medium; color:darkblue ">
            Uniform Items Payment
        </td>
    </tr>
            <tr>
             <td>
                 <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small"></asp:Label>
             </td>
         </tr>
</table>
    <asp:Panel ID="Panel1" runat="server" GroupingText ="Student Details">
    <table width ="80%">
        <tr>
        <td class="auto-style1">
                  Student Number
            </td>
        <td class="auto-style1">
                <asp:TextBox ID="txtStudentNo" runat="server"></asp:TextBox> &nbsp; &nbsp; &nbsp
                <asp:Button ID="cmdFind" runat="server" BackColor="Orange" Text="Find" Width="64px" />
            </td>
        <td class="auto-style1">
            First Name
        </td>
            <td class="auto-style1">
                <asp:TextBox ID="txtFirstName" runat="server" Enabled="False"></asp:TextBox>
            </td>
            <td class="auto-style1">
                Surname
            </td>
            <td class="auto-style1">
                <asp:TextBox ID="txtSurname" runat="server" Enabled="False"></asp:TextBox>
            </td>
            </tr>
          <tr>
         <td>
            Stream
        </td>
            <td>
                <asp:TextBox ID="txtStream" runat="server" Enabled="False"></asp:TextBox>
            </td>
            <td>
                Class
            </td>
            <td>
                <asp:TextBox ID="txtClass" runat="server" Enabled="False"></asp:TextBox>
            </td>
            </tr>
        </table>
    </asp:Panel>
    <table>
        <tr>
            <td>
             Item
            </td>
            <td>
                Item Price
            </td>
            <td>
                Quantity
            </td>
            <td>
                Total Price
            </td>
        </tr>
        <tr>
                     
            <td>
                <telerik:RadComboBox ID="RadComboBoxUniformItems" Runat="server" AutoPostBack="True">
                </telerik:RadComboBox>
            </td>
            <td>
                <asp:TextBox ID="txtItemPrice" runat="server" BackColor="#99FFCC" Enabled="False"></asp:TextBox>
            </td>
            <td>
                <asp:TextBox ID="txtQuantity" runat="server" AutoPostBack="True"></asp:TextBox>
            </td>
            <td>
                <asp:TextBox ID="txtTotalPrice" runat="server" BackColor="#99FFCC" Enabled="False"></asp:TextBox>
            </td>
                        <td>
                            <asp:Button ID="cmdAdd" runat="server" Text="Add" Width="150px"  BackColor="Orange" /></td>
        </tr>
        <tr>
            <td></td>
        </tr>
        <tr>
            <td colspan="4">

                    <telerik:RadGrid ID="gwUniformPayments" runat="server"  BackColor="#DEBA84"  AllowPaging="True"  DisplayMode="FirstLastPreviousNextNumeric, Text" PageSize="50"
         BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" AllowSorting="True" GroupPanelPosition="Top"  ForeColor="Black" >
              
                        <ClientSettings>
                        <Scrolling AllowScroll="True"  />
                    </ClientSettings>
                   
     </telerik:RadGrid> 

            </td>
            <td>

            </td>
        </tr>
        
        <tr><td>Total Amount</td><td><asp:TextBox ID="txtTotal" runat="server" BackColor="#99FFCC" Enabled="False"></asp:TextBox></td></tr>
         
          <tr>
            <td>
                Receipt Number
            </td>
            <td>
                <asp:TextBox ID="txtReceiptNo" runat="server" Enabled="False"></asp:TextBox>
            </td>
              <td>&nbsp</td>
              <td>&nbsp</td>
            <td> <asp:Button ID="cmdSave" runat="server" Text="Save" Width="150px"  BackColor="Orange" /></td>
        </tr>
        </table>
    <table>
        
<tr>
    <td>
          <%--<CR:CrystalReportViewer ID="crvReports1" runat="server" AutoDataBind="true" DisplayToolbar="true"
                                HasCrystalLogo="False"/>--%>
    </td>
</tr>
    </table>
   
</asp:Content>
