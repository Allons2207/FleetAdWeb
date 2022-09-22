<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="ExpectedAmountCorrection.aspx.vb" Inherits="WebApplication2.ExpectedAmountCorrection" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
    
    <style type="text/css">
.RadComboBox{text-align:left;display:inline-block;vertical-align:middle;white-space:nowrap;*display:inline;*zoom:1}.RadComboBox_Default{color:#333;font-size:12px;font-family:"Segoe UI",Arial,Helvetica,sans-serif}.RadComboBox{text-align:left;display:inline-block;vertical-align:middle;white-space:nowrap;*display:inline;*zoom:1}.RadComboBox_Default{color:#333;font-size:12px;font-family:"Segoe UI",Arial,Helvetica,sans-serif}.RadComboBox{text-align:left;display:inline-block;vertical-align:middle;white-space:nowrap;*display:inline;*zoom:1}
        .RadComboBox_Default{color:#333;font-size:12px;font-family:"Segoe UI",Arial,Helvetica,sans-serif}.RadComboBox .rcbReadOnly .rcbInputCellLeft{background-position:0 -88px}.RadComboBox .rcbReadOnly .rcbInputCellLeft{background-position:0 -88px}.RadComboBox .rcbReadOnly .rcbInputCellLeft{background-position:0 -88px}.RadComboBox .rcbInputCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox .rcbInputCell{padding-right:4px;padding-left:5px;width:100%;height:20px;line-height:20px;text-align:left;vertical-align:middle}.RadComboBox .rcbInputCellLeft{background-position:0 0}.RadComboBox_Default .rcbInputCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbInputCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox .rcbInputCell{padding-right:4px;padding-left:5px;width:100%;height:20px;line-height:20px;text-align:left;vertical-align:middle}.RadComboBox .rcbInputCellLeft{background-position:0 0}.RadComboBox_Default .rcbInputCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbInputCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox .rcbInputCell{padding-right:4px;padding-left:5px;width:100%;height:20px;line-height:20px;text-align:left;vertical-align:middle}.RadComboBox .rcbInputCellLeft{background-position:0 0}.RadComboBox_Default .rcbInputCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbReadOnly .rcbArrowCellRight{background-position:-162px -176px}.RadComboBox .rcbReadOnly .rcbArrowCellRight{background-position:-162px -176px}.RadComboBox .rcbReadOnly .rcbArrowCellRight{background-position:-162px -176px}.RadComboBox .rcbArrowCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}
        .RadComboBox .rcbArrowCell{width:18px}.RadComboBox .rcbArrowCellRight{background-position:-18px -176px}.RadComboBox_Default .rcbArrowCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbArrowCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox .rcbArrowCell{width:18px}.RadComboBox .rcbArrowCellRight{background-position:-18px -176px}.RadComboBox_Default .rcbArrowCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbArrowCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox .rcbArrowCell{width:18px}.RadComboBox .rcbArrowCellRight{background-position:-18px -176px}.RadComboBox_Default .rcbArrowCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}
        .auto-style1 {
            height: 23px;
        }
    </style>
    
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table>
        <tr><td><h4>Corrections to Expected Payment Amounts</h4></td></tr>
        <tr><td>&nbsp</td></tr>

        <tr>
             <td colspan ="3">
                 <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small"></asp:Label>
             </td>
         </tr>
        
        <tr><td >Payment Type</td><td>
                                <telerik:RadComboBox ID="cboPaymentType" runat="server">
                                    <Items>
                                        <telerik:RadComboBoxItem runat="server" Text="Tuition" Value="Tuition" />
                                        <telerik:RadComboBoxItem runat="server" Text="Levy" Value="Levy" />
                                    </Items>
                                </telerik:RadComboBox>
                            </td></tr>
        <tr><td>Year</td><td><asp:TextBox ID="txtYear" runat="server"></asp:TextBox></td></tr>
        <tr><td>Month</td><td>
                                <telerik:RadComboBox ID="cboMonth" runat="server">
                                    <Items>
                                        <telerik:RadComboBoxItem runat="server" Text="January" Value="Jan" />
                                        <telerik:RadComboBoxItem runat="server" Text="February" Value="Feb" />
                                        <telerik:RadComboBoxItem runat="server" Text="March" Value="Mar" />
                                        <telerik:RadComboBoxItem runat="server" Text="April" Value="Apr" />
                                        <telerik:RadComboBoxItem runat="server" Text="May" Value="May" />
                                        <telerik:RadComboBoxItem runat="server" Text="June" Value="Jun" />
                                        <telerik:RadComboBoxItem runat="server" Text="July" Value="Jul" />
                                        <telerik:RadComboBoxItem runat="server" Text="August" Value="Aug" />
                                        <telerik:RadComboBoxItem runat="server" Text="September" Value="Sept" />
                                        <telerik:RadComboBoxItem runat="server" Text="October" Value="Oct" />
                                        <telerik:RadComboBoxItem runat="server" Text="November" Value="Nov" />
                                        <telerik:RadComboBoxItem runat="server" Text="December" Value="Dec" />
                                    </Items>
                                </telerik:RadComboBox>
                            </td></tr>
        <tr><td>Term</td><td>
                                <telerik:RadComboBox ID="cboTerm" runat="server">
                                    <Items>
                                        <telerik:RadComboBoxItem runat="server" Text="Term 1" Value="1" />
                                        <telerik:RadComboBoxItem runat="server" Text="Term 2" Value="2" />
                                        <telerik:RadComboBoxItem runat="server" Text="Term 3" Value="3" />
                                    </Items>
                                </telerik:RadComboBox>
                            </td></tr>
        <tr><td>&nbsp</td></tr>
        <tr><td colspan="2"><h4>Student Details</h4></td></tr>
        <tr><td>&nbsp</td></tr>
        <tr><td>Student ID</td><td><asp:TextBox ID="txtStudentID" runat="server"></asp:TextBox></td><td>
                <asp:Button ID="cmdShowStudentDets" runat="server" Text="Search" Width="77px" />
            </td></tr>
        <tr><td>Student Name</td><td><asp:TextBox ID="txtStudentName" runat="server" Enabled="False" Width="318px"></asp:TextBox></td></tr>
        <tr><td>Class</td><td>
                                <asp:TextBox ID="txtClass" runat="server" Enabled="False"></asp:TextBox>
                            </td></tr>
        <tr><td class="auto-style1">Current Expected Amount</td><td class="auto-style1"><asp:TextBox ID="txtCurrentExpectedAmount" runat="server" Enabled="False"></asp:TextBox></td></tr>
        <tr><td>New Expected Amount</td><td><asp:TextBox ID="txtNewExpectedAmount" runat="server"></asp:TextBox></td></tr>
        <tr><td>&nbsp</td></tr>
        <tr><td></td><td>
                <asp:Button ID="cmdSave" runat="server" Text="Update" Width="77px" />
            </td></tr>
    </table>

</asp:Content>
