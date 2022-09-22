<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="SchoolCoreDetails.aspx.vb" Inherits="WebApplication2.SchoolCoreDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style1 {
            width: 174px;
        }
    .auto-style2 {
        width: 174px;
        height: 24px;
    }
    .auto-style3 {
        height: 24px;
    }
        .auto-style4 {
            width: 174px;
            height: 62px;
        }
        .auto-style5 {
            height: 62px;
        }
    .RadComboBox{text-align:left;display:inline-block;vertical-align:middle;white-space:nowrap;*display:inline;*zoom:1}.RadComboBox_Default{color:#333;font-size:12px;font-family:"Segoe UI",Arial,Helvetica,sans-serif}.RadComboBox{text-align:left;display:inline-block;vertical-align:middle;white-space:nowrap;*display:inline;*zoom:1}.RadComboBox_Default{color:#333;font-size:12px;font-family:"Segoe UI",Arial,Helvetica,sans-serif}.RadComboBox{text-align:left;display:inline-block;vertical-align:middle;white-space:nowrap;*display:inline;*zoom:1}
        .RadComboBox_Default{color:#333;font-size:12px;font-family:"Segoe UI",Arial,Helvetica,sans-serif}.RadComboBox .rcbReadOnly .rcbInputCellLeft{background-position:0 -88px}.RadComboBox .rcbReadOnly .rcbInputCellLeft{background-position:0 -88px}.RadComboBox .rcbReadOnly .rcbInputCellLeft{background-position:0 -88px}.RadComboBox .rcbInputCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox .rcbInputCell{padding-right:4px;padding-left:5px;width:100%;height:20px;line-height:20px;text-align:left;vertical-align:middle}.RadComboBox .rcbInputCellLeft{background-position:0 0}.RadComboBox_Default .rcbInputCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbInputCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox .rcbInputCell{padding-right:4px;padding-left:5px;width:100%;height:20px;line-height:20px;text-align:left;vertical-align:middle}.RadComboBox .rcbInputCellLeft{background-position:0 0}.RadComboBox_Default .rcbInputCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbInputCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox .rcbInputCell{padding-right:4px;padding-left:5px;width:100%;height:20px;line-height:20px;text-align:left;vertical-align:middle}.RadComboBox .rcbInputCellLeft{background-position:0 0}.RadComboBox_Default .rcbInputCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbReadOnly .rcbArrowCellRight{background-position:-162px -176px}.RadComboBox .rcbReadOnly .rcbArrowCellRight{background-position:-162px -176px}.RadComboBox .rcbReadOnly .rcbArrowCellRight{background-position:-162px -176px}.RadComboBox .rcbArrowCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}
        .RadComboBox .rcbArrowCell{width:18px}.RadComboBox .rcbArrowCellRight{background-position:-18px -176px}.RadComboBox_Default .rcbArrowCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbArrowCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox .rcbArrowCell{width:18px}.RadComboBox .rcbArrowCellRight{background-position:-18px -176px}.RadComboBox_Default .rcbArrowCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbArrowCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox .rcbArrowCell{width:18px}.RadComboBox .rcbArrowCellRight{background-position:-18px -176px}.RadComboBox_Default .rcbArrowCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table width="100%">
        <tr><td>&nbsp</td></tr>
        <tr>
            
          <td style="font-size:medium; color:darkblue ">
           School Core Details      
            </td>
        </tr>
        <tr><td><hr /></td></tr>
         <tr>
             <td>
                 <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small"></asp:Label>
             </td>
         </tr>
       </table>
    <table width="100%">
        <tr><td class="auto-style1"></td><td></td></tr>
        <tr><td class="auto-style1">School Code</td><td><asp:TextBox ID="txtCode" runat="server"></asp:TextBox></td></tr>
        <tr><td class="auto-style1">School Name</td><td><asp:TextBox ID="txtName" runat="server" Width="610px"></asp:TextBox></td></tr>
        <tr><td class="auto-style1">Type of School</td><td>
                                
                                <telerik:RadComboBox ID="cboSchoolType" runat="server">
                                    <Items>
                                        <telerik:RadComboBoxItem runat="server" Text="Opening Balance" Value="Opening Balance" />
                                        <telerik:RadComboBoxItem runat="server" Text="In Coming" Value="In Coming" />
                                        <telerik:RadComboBoxItem runat="server" Text="Out Going" Value="Out Going" />
                                        <telerik:RadComboBoxItem runat="server" Text="Closing Balance" Value="Closing Balance" />
                                    </Items>
                                </telerik:RadComboBox>
                                
                </td></tr>
        <tr><td class="auto-style1">Physical Address</td><td><asp:TextBox ID="txtPhysicalAddress" runat="server" Height="52px" TextMode="MultiLine" Width="294px"></asp:TextBox></td></tr>
        <tr><td class="auto-style4">Postal Address</td><td class="auto-style5"><asp:TextBox ID="txtPostalAddress" runat="server" Height="54px" TextMode="MultiLine" Width="290px"></asp:TextBox></td></tr>
        <tr><td class="auto-style1">Telephone Number(s)</td><td><asp:TextBox ID="txtTelNumbers" runat="server" Width="289px"></asp:TextBox></td></tr>
        <tr><td class="auto-style2">email-Address</td><td class="auto-style3"><asp:TextBox ID="txtEmailAddress" runat="server" Width="618px"></asp:TextBox></td></tr>
        <tr><td class="auto-style1">Date Stated</td><td>                   
                             <telerik:RadDatePicker ID="rdDtDate" Runat="server">
                                </telerik:RadDatePicker>
                            </td></tr>
        <tr><td class="auto-style2">Headmaster/mistress</td><td class="auto-style3"><asp:TextBox ID="txtHead" runat="server" Width="290px"></asp:TextBox></td></tr>
        <tr><td class="auto-style2">Head's Contact Number</td><td class="auto-style3"><asp:TextBox ID="txtHeadContactNum" runat="server" Width="288px"></asp:TextBox></td></tr>

        <tr><td class="auto-style2">Contact Person</td><td class="auto-style3"><asp:TextBox ID="txtContactPerson" runat="server" Width="290px"></asp:TextBox></td></tr>
        <tr><td class="auto-style2">Contact Person's Position</td><td class="auto-style3"><asp:TextBox ID="txtContactPersonPosition" runat="server" Width="288px"></asp:TextBox></td></tr>
        <tr><td class="auto-style1">Contact Person's Number</td><td><asp:TextBox ID="txtContactPersonNumber" runat="server" Width="288px"></asp:TextBox></td></tr>
        <tr><td></td></tr>
        <tr><td class="auto-style1">&nbsp;</td><td><asp:Button ID="cmdSave" runat="server" Text="Save School Details" Width="125px" /></td></tr>
        <tr><td></td></tr>
    </table>
   
</asp:Content>
