<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="TyreLivesForFittedTyres.aspx.vb" Inherits="WebApplication2.TyreLivesForFittedTyres" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
  
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
   
    <style type="text/css">
.RadComboBox_Default{color:#333;font-size:12px;font-family:"Segoe UI",Arial,Helvetica,sans-serif}.RadComboBox{text-align:left;display:inline-block;vertical-align:middle;white-space:nowrap;*display:inline;*zoom:1}.RadComboBox .rcbReadOnly .rcbInputCellLeft{background-position:0 -88px}.RadComboBox_Default .rcbInputCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbInputCellLeft{background-position:0 0}.RadComboBox .rcbInputCell{padding-right:4px;padding-left:5px;width:100%;height:20px;line-height:20px;text-align:left;vertical-align:middle}.RadComboBox .rcbInputCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox .rcbReadOnly .rcbArrowCellRight{background-position:-162px -176px}.RadComboBox_Default .rcbArrowCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbArrowCellRight{background-position:-18px -176px}.RadComboBox .rcbArrowCell{width:18px}.RadComboBox .rcbArrowCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}</style>
   
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table style="margin-left:2%" width="50%">
    <tr>
        <td class="PageTitle">
           Tyre Lives for currently Fitted Tyres
        </td>
    </tr>
        <tr>
            <td><b>&nbsp;&nbsp;&nbsp;Select Tyres Whose Tyre Life is Now ;</b> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<telerik:RadComboBox ID="cboTyreLife" runat="server" Width="122px" AutoPostBack="True">
            <Items>
                <telerik:RadComboBoxItem runat="server" Text="&lt;= 6 months" Value="&lt;= 6 months" />
                <telerik:RadComboBoxItem runat="server" Text="&lt;= 12 Months" Value="&lt;= 12 Months" />
                <telerik:RadComboBoxItem runat="server" Text="&lt;= 18 Months" Value="&lt;= 18 Months" />
                <telerik:RadComboBoxItem runat="server" Text="&lt;= 24 Months" Value="&lt;= 24 Months" />
            </Items>
            </telerik:RadComboBox></td>
        </tr>
         <tr>
             <td colspan="2">
                 <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small"></asp:Label>
             </td>
         </tr>
   
         <tr>
            <td colspan="2">
                <telerik:RadGrid ID="gwGrid" runat="server" AllowPaging="True" AllowSorting="True" BackColor="White" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" DisplayMode="FirstLastPreviousNextNumeric, Text" ForeColor="Black" GroupPanelPosition="Top" PageSize="50" AllowFilteringByColumn="True" ShowGroupPanel="True">
                    <ClientSettings AllowDragToGroup="True">
                        <Scrolling AllowScroll="True" />
                    </ClientSettings>
                    <AlternatingItemStyle BackColor="#CCCCFF" />
                </telerik:RadGrid>
            </td>
        </tr>
    </table>


</asp:Content>