<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="SearchAssets.aspx.vb" Inherits="WebApplication2.SearchAssets" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
      <table>
        <tr>
            
<td style="font-size:medium; color:darkblue ">
         Search Assets
      
            </td>
        </tr>
         <tr>
             <td>
                 <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small"></asp:Label>
             </td>
         </tr>
       
    </table>
    <table width="100%">
        <tr>
            <td>
                Asset Name 
            </td>
            <td>
                <telerik:RadComboBox ID="cbAssetName" runat="server"></telerik:RadComboBox>
            </td>
            <td>
                Asset Number
            </td>
            <td>
                <asp:TextBox ID="txtAssetNumber" runat="server"></asp:TextBox>
            </td>
            <td>
                Serial Number
            </td>
            <td>
                <asp:TextBox ID="txtSerialNumber" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                Supplier
            </td>
            <td>
                <telerik:RadComboBox ID="cbSupplier" runat="server"></telerik:RadComboBox>
            </td>
            <td>
                Date Bought
            </td>
            <td>
                <telerik:RadDatePicker ID="radDateBought" runat="server"></telerik:RadDatePicker>
            </td>
            <td>
                Asset User
            </td>
            <td>
                <asp:TextBox ID="txtAssetUser" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Button ID="cmdSearch" runat="server" Text="Search" BackColor="#FF9900" Width="72px" />
            </td>
        </tr>
    </table>
    <table width ="100%">
        <tr>
            <td>
                  <telerik:RadGrid ID="gwAssetsSearch" runat="server"  BackColor="White"  AllowPaging="True"  DisplayMode="FirstLastPreviousNextNumeric, Text" PageSize="50"
         BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" AllowSorting="True" GroupPanelPosition="Top"  ForeColor="Black">
                      <AlternatingItemStyle BackColor="#E9E9E9" />
              
                             
     </telerik:RadGrid>
            </td>
        </tr>
    </table>
</asp:Content>
