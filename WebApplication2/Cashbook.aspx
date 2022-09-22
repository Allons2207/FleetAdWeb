<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="Cashbook.aspx.vb" Inherits="WebApplication2.Cashbook" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">


    <style type="text/css">
        .auto-style1 {
            height: 20px;
        }
        .auto-style3 {
            height: 20px;
            width: 746px;
        }
        .RadComboBox_Default{color:#333;font-size:12px;font-family:"Segoe UI",Arial,Helvetica,sans-serif}.RadComboBox{text-align:left;display:inline-block;vertical-align:middle;white-space:nowrap;*display:inline;*zoom:1}.RadComboBox_Default{color:#333;font-size:12px;font-family:"Segoe UI",Arial,Helvetica,sans-serif}.RadComboBox{text-align:left;display:inline-block;vertical-align:middle;white-space:nowrap;*display:inline;*zoom:1}.RadComboBox_Default{color:#333;font-size:12px;font-family:"Segoe UI",Arial,Helvetica,sans-serif}.RadComboBox{text-align:left;display:inline-block;vertical-align:middle;white-space:nowrap;*display:inline;*zoom:1}.RadComboBox .rcbReadOnly .rcbInputCellLeft{background-position:0 -88px}.RadComboBox .rcbReadOnly .rcbInputCellLeft{background-position:0 -88px}.RadComboBox .rcbReadOnly .rcbInputCellLeft{background-position:0 -88px}.RadComboBox_Default .rcbInputCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbInputCellLeft{background-position:0 0}.RadComboBox .rcbInputCell{padding-right:4px;padding-left:5px;width:100%;height:20px;line-height:20px;text-align:left;vertical-align:middle}.RadComboBox .rcbInputCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox_Default .rcbInputCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbInputCellLeft{background-position:0 0}.RadComboBox .rcbInputCell{padding-right:4px;padding-left:5px;width:100%;height:20px;line-height:20px;text-align:left;vertical-align:middle}.RadComboBox .rcbInputCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox_Default .rcbInputCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbInputCellLeft{background-position:0 0}.RadComboBox .rcbInputCell{padding-right:4px;padding-left:5px;width:100%;height:20px;line-height:20px;text-align:left;vertical-align:middle}.RadComboBox .rcbInputCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox .rcbReadOnly .rcbArrowCellRight{background-position:-162px -176px}.RadComboBox .rcbReadOnly .rcbArrowCellRight{background-position:-162px -176px}.RadComboBox .rcbReadOnly .rcbArrowCellRight{background-position:-162px -176px}.RadComboBox_Default .rcbArrowCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbArrowCellRight{background-position:-18px -176px}.RadComboBox .rcbArrowCell{width:18px}.RadComboBox .rcbArrowCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox_Default .rcbArrowCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbArrowCellRight{background-position:-18px -176px}.RadComboBox .rcbArrowCell{width:18px}.RadComboBox .rcbArrowCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox_Default .rcbArrowCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbArrowCellRight{background-position:-18px -176px}.RadComboBox .rcbArrowCell{width:18px}.RadComboBox .rcbArrowCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}
        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <table>
       <tr>
       <td style="font-size:medium; color:darkblue ">
           Cash Book Transactions
       </td>
       </tr>
       <tr>
         <td>
             <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small"></asp:Label>
         </td>
        </tr>
     </table>  


      <table>
        <tr>
            <td class="auto-style3">
                <asp:Panel ID="Panel2" runat="server" Width="568px">
                    <table>
                        <tr>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style1">
                                Date
                            </td>
                            <td>
                                
                                <telerik:RadDatePicker ID="rdDtDate" Runat="server"> </telerik:RadDatePicker>
                                
                             </td>
                        </tr>
                        <tr>
                            <td>
                                 &nbsp;

                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style1">
                                Action
                            </td>
                            <td>
                                <telerik:RadComboBox ID="cboAction" runat="server">
                                    <Items>
                                        <telerik:RadComboBoxItem runat="server" Text="Opening Balance" Value="Opening Balance" />
                                        <telerik:RadComboBoxItem runat="server" Text="In Coming" Value="In Coming" />
                                        <telerik:RadComboBoxItem runat="server" Text="Out Going" Value="Out Going" />
                                        <telerik:RadComboBoxItem runat="server" Text="Closing Balance" Value="Closing Balance" />
                                    </Items>
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                         <tr>
                            <td>
                                 &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style1">
                                 Amount </td>
                            <td>
                                <asp:TextBox ID="txtAmount" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                         <tr>
                            <td>
                                 &nbsp;

                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style1">Narration </td><td>
                            <asp:TextBox ID="txtNotes" runat="server" TextMode="MultiLine" Width="313px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Button ID="cmdAddNew" runat="server" Text="Save Cash Book Transaction" />
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
               </td>
            <td style="vertical-align:top">
                <asp:Panel ID="Panel1" runat="server" style="margin-left: 177px">
                    <table>
                        <tr>
                           <td class="auto-style1">
                                Opening Balance
                           </td>
                            <td>
                                <asp:TextBox ID="lblOpeningBal" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                         <tr>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr>
                           <td class="auto-style1">
                                Current Balance
                           </td>
                            <td>
                                <asp:TextBox ID="lblCurrentBalance" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                         <tr>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr>
                           <td class="auto-style1">
                                New Balance
                           </td>
                            <td>
                                <asp:TextBox ID="lblNewBalance" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                    </table>



                </asp:Panel>
            </td>
        </tr>
    </table>  

    <table width="100%" >
        <tr><td></td></tr>
        <tr><td colspan="6">
                    <telerik:RadGrid ID="gwBillPayments" runat="server"  BackColor="White"  AllowPaging="True"  DisplayMode="FirstLastPreviousNextNumeric, Text" PageSize="50"
         BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" AllowSorting="True" GroupPanelPosition="Top"  ForeColor="Black" Width="100%">
              
                        <ClientSettings>
                        <Scrolling AllowScroll="True"  />
                    </ClientSettings>
                   
                        <AlternatingItemStyle BackColor="#E9E9E9" />
                   
     </telerik:RadGrid> 
            </td></tr>
    </table>

</asp:Content>
