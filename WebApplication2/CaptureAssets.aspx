<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="CaptureAssets.aspx.vb" Inherits="WebApplication2.CaptureAssets" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style1 {
            height: 23px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table>
        <tr>
            
<td style="font-size:medium; color:darkblue ">
           Capture Assets
      
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
                Functional State
            </td>
            <td>
                <telerik:RadComboBox ID="rbFunctionalState" runat="server"></telerik:RadComboBox>
            </td>
            <td>
                Description
            </td>
            <td>
                <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" ></asp:TextBox>
            </td>
            <td>
                Date Bought
            </td>
            <td>
                <telerik:RadDatePicker ID="rdDateBought" runat="server"></telerik:RadDatePicker>
            </td>
        </tr>
        <tr>
            <td>
                Supplier
            </td>
            <td>
                <telerik:RadComboBox ID="rbSupplier" runat="server"></telerik:RadComboBox>
            </td>
            <td>
                Quantity
            </td>
            <td>
                <asp:TextBox ID="txtQuantity" runat="server"></asp:TextBox>
            </td>
            <td>
                Total Value
            </td>
            <td>
                <asp:TextBox ID="txtTotalValue" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                Asset Location
            </td>
            <td>
                <telerik:RadComboBox ID="cbAssetLocation" runat="server"></telerik:RadComboBox>
            </td>
            <td>
                Asset User
            </td>
            <td>
                <asp:TextBox ID="txtAssetUser" runat="server"></asp:TextBox>
            </td>
                   
            <td class="auto-style1">
                Disposal Date
            </td>
            <td class="auto-style1">
                <telerik:RadDatePicker ID="rdDisposalDate" runat="server"></telerik:RadDatePicker>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Button ID="cmdSave" runat="server" Text="Save" BackColor="#FF9900" Width="75px" />
            </td>
        </tr>
    </table>
</asp:Content>
