<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="InternalStudentFeesPayment.aspx.vb" Inherits="WebApplication2.InternalStudentFeesPayment" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
.RadComboBox_Default{color:#333;font-size:12px;font-family:"Segoe UI",Arial,Helvetica,sans-serif}.RadComboBox{text-align:left;display:inline-block;vertical-align:middle;white-space:nowrap;*display:inline;*zoom:1}.RadComboBox_Default{color:#333;font-size:12px;font-family:"Segoe UI",Arial,Helvetica,sans-serif}.RadComboBox{text-align:left;display:inline-block;vertical-align:middle;white-space:nowrap;*display:inline;*zoom:1}.RadComboBox_Default{color:#333;font-size:12px;font-family:"Segoe UI",Arial,Helvetica,sans-serif}.RadComboBox{text-align:left;display:inline-block;vertical-align:middle;white-space:nowrap;*display:inline;*zoom:1}.RadComboBox .rcbReadOnly .rcbInputCellLeft{background-position:0 -88px}.RadComboBox .rcbReadOnly .rcbInputCellLeft{background-position:0 -88px}.RadComboBox .rcbReadOnly .rcbInputCellLeft{background-position:0 -88px}.RadComboBox_Default .rcbInputCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbInputCellLeft{background-position:0 0}.RadComboBox .rcbInputCell{padding-right:4px;padding-left:5px;width:100%;height:20px;line-height:20px;text-align:left;vertical-align:middle}.RadComboBox .rcbInputCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox_Default .rcbInputCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbInputCellLeft{background-position:0 0}.RadComboBox .rcbInputCell{padding-right:4px;padding-left:5px;width:100%;height:20px;line-height:20px;text-align:left;vertical-align:middle}.RadComboBox .rcbInputCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox_Default .rcbInputCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbInputCellLeft{background-position:0 0}.RadComboBox .rcbInputCell{padding-right:4px;padding-left:5px;width:100%;height:20px;line-height:20px;text-align:left;vertical-align:middle}.RadComboBox .rcbInputCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox .rcbReadOnly .rcbArrowCellRight{background-position:-162px -176px}.RadComboBox .rcbReadOnly .rcbArrowCellRight{background-position:-162px -176px}.RadComboBox .rcbReadOnly .rcbArrowCellRight{background-position:-162px -176px}.RadComboBox_Default .rcbArrowCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbArrowCellRight{background-position:-18px -176px}.RadComboBox .rcbArrowCell{width:18px}.RadComboBox .rcbArrowCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox_Default .rcbArrowCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbArrowCellRight{background-position:-18px -176px}.RadComboBox .rcbArrowCell{width:18px}.RadComboBox .rcbArrowCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox_Default .rcbArrowCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbArrowCellRight{background-position:-18px -176px}.RadComboBox .rcbArrowCell{width:18px}.RadComboBox .rcbArrowCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}
        .auto-style1 {
            border-width: 0;
            padding-left: 5px;
            padding-right: 4px;
            padding-top: 0;
            padding-bottom: 0;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table>
    <tr>
        <td style="font-size:medium; color:darkblue ">
            Internal Student Examination Payment
        </td>
    </tr>
            <tr>
             <td>
                 <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small"></asp:Label>
             </td>
         </tr>
        <tr><td>&nbsp</td></tr>
</table>
    <asp:Panel ID="Panel1" runat="server" GroupingText ="Student Details">
    <table width ="80%">
        <tr>
        <td >
                  Student Number
            </td>
        <td >
                <asp:TextBox ID="txtStudentNo" runat="server"></asp:TextBox> &nbsp; &nbsp; &nbsp
                <asp:Button ID="cmdFind" runat="server" BackColor="Orange" Text="Find" Width="64px" />
            </td>
        <td >
            First Name
        </td>
            <td >
                <asp:TextBox ID="txtFirstName" runat="server" Enabled="False"></asp:TextBox>
            </td>
            <td >
                Surname
            </td>
            <td >
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

    <br />
    <asp:Panel ID="Panel2" runat="server" GroupingText ="Registration and Payment Details">
    <table width ="60%">
        <tr>
             <td>
                 Year
            </td>
            <td><asp:TextBox ID="txtYear" runat="server"></asp:TextBox></td>
            <td>Registered Subjects;</td>
        </tr>
        <tr>
            <td>Level</td><td >
                <telerik:RadComboBox ID="cboLevel" runat="server" AutoPostBack="True">
                </telerik:RadComboBox>
             </td>
            <td rowspan="8">
                <telerik:RadGrid ID="gwBillPayments" runat="server" AllowPaging="True" AllowSorting="True" BackColor="#DEBA84" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" DisplayMode="FirstLastPreviousNextNumeric, Text" ForeColor="Black" GroupPanelPosition="Top" PageSize="50">
                    <clientsettings>
                        <Scrolling AllowScroll="True"  />
                    </clientsettings>
                </telerik:RadGrid>
            </td>
            </tr>
         <tr>
             <td> Examination Board </td>
             <td>
                <telerik:RadComboBox ID="cboExamBoard" runat="server" AutoPostBack="True">
                </telerik:RadComboBox>
            </td>
         </tr>
        <tr>
             <td> Session </td>
           
            <td>
                <telerik:RadComboBox ID="cboSession" runat="server">
                </telerik:RadComboBox>
            </td>
         </tr>
        <tr>
             <td> Centre Fee </td>
            <td>
                <asp:TextBox ID="txtCentreFee" runat="server"></asp:TextBox>
            </td>
       </tr>
          <tr>
         <td>
            Number of Subjects Registered
           </td>
            <td>
                <asp:TextBox ID="txtNumberOfSubjectsRegistered" runat="server"></asp:TextBox>
            </td>
              </tr>
        <tr>
            <td>
                Stationery Fee
            </td>
            <td>
                <asp:TextBox ID="txtStationeryFee" runat="server"></asp:TextBox>
            </td>
            </tr>
        <tr>
            <td>
                Describe other applicable fees
            </td>
            <td>
                <asp:TextBox ID="txtOtherFeesDesc" runat="server" Height="46px" TextMode="MultiLine" Width="266px"></asp:TextBox>
            </td>
            </tr>
        <tr>
            <td>
               Total of the Other Fees
            </td>
            <td>
                <asp:TextBox ID="txtOtherFeesAmt" runat="server"></asp:TextBox>
            </td>
            </tr>
        <tr>
            <td>Total Amount Due</td>
             <td>
                <asp:TextBox ID="txtAmountDue" runat="server"></asp:TextBox>
            </td>
        </tr>
         <tr>
            <td>Amount Paid</td>
             <td>
                <asp:TextBox ID="txtAmountPaid" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>&nbsp</td>
        </tr>
        <tr>
            <td>&nbsp</td>
            <td><asp:Button ID="btnSave" runat="server" Text="Capture Payment" /></td>
            <td>
                <asp:Button ID="btnClear" runat="server" Text="Clear" Width="191px" />
            </td>
        </tr>
        </table>
    </asp:Panel>
</asp:Content>
