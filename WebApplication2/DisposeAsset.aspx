<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="DisposeAsset.aspx.vb" Inherits="WebApplication2.DisposeAsset" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style1 {
            height: 20px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table>
        <tr>
            
<td style="font-size:medium; color:darkblue ">
         Dispose Asset
      
            </td>
        </tr>
         <tr>
             <td>
                 <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small"></asp:Label>
             </td>
         </tr>
       
    </table>
    <asp:Panel ID="Panel3" runat="server">
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
      </asp:Panel>
    <table width ="100%">
        <tr>
            <td>
                  <telerik:RadGrid ID="gwAssetsSearch" runat="server"  BackColor="#DEBA84"  AllowPaging="True"  DisplayMode="FirstLastPreviousNextNumeric, Text" PageSize="50"
         BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" AllowSorting="True" GroupPanelPosition="Top"  ForeColor="Black">
                 <MasterTableView DataKeyNames="assetNumber">
             <Columns>
                 <telerik:GridButtonColumn ButtonType="LinkButton" Text="Dispose Asset" CommandName="dispose"></telerik:GridButtonColumn>
             </Columns>

         </MasterTableView>
                          
     </telerik:RadGrid>
            </td>
        </tr>
    </table>
    <asp:Panel ID="Panel1" runat="server" GroupingText ="Asset Details" Visible ="false">
    <table width="100%">
        <tr>
            <%--<td class="auto-style1">
                Asset Type
            </td>
            <td class="auto-style1">
                <asp:Label ID="lblAssetType" runat="server" Text="" style="font-weight: 700"></asp:Label>
            </td>--%>
            <td class="auto-style1">
                Asset Name
            </td>
            <td class="auto-style1">
                <asp:Label ID="lblAssetName" runat="server" Text="" style="font-weight: 700"></asp:Label>
            </td>
            <td class="auto-style1">
                Serial Number
            </td>
            <td class="auto-style1">
                <asp:Label ID="lblSerialNumber" runat="server" Text="" style="font-weight: 700"></asp:Label>
            </td>
            
            <td>
                Asset Number
            </td>
            <td>
                <asp:Label ID="lblAssetNumber" runat="server" Text="" style="font-weight: 700"></asp:Label>
            </td>
            
        </tr>
        <tr>
            <td>
                Functional State
            </td>
            <td>
                <asp:Label ID="lblFunctionalState" runat="server" Text="" style="font-weight: 700"></asp:Label>
            </td>
            <td>
                Description
            </td>
            <td>
                <asp:Label ID="lblDescription" runat="server" Text="" style="font-weight: 700"></asp:Label>
            </td>
            <td>
                Date Bought
            </td>
            <td>
                <asp:Label ID="lblDateBought" runat="server" Text="" style="font-weight: 700"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                Supplier
            </td>
            <td>
                <asp:Label ID="lblSupplier" runat="server" Text="" style="font-weight: 700"></asp:Label>
            </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:Panel ID="Panel2" runat="server" Visible="false">
    <table>
        <tr>
            <td>
                Quantities Disposed
            </td>
            <td>
                <asp:TextBox ID="txtQuantitesDisposed" runat="server"></asp:TextBox>
            </td>
            <td>
                Value Of Disposed Assets
            </td>
            <td>
                <asp:TextBox ID="txtValueDisposed" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                Reason For Disposal
            </td>
            <td>
                <asp:TextBox ID="txtReasonForDisposal" runat="server" TextMode="MultiLine"></asp:TextBox>
            </td>
            <td>
                Date Disposed
            </td>
            <td>
                <telerik:RadDatePicker ID="rdDateDisposed" runat="server"></telerik:RadDatePicker>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Button ID="cmdSave" runat="server" Text="Save" BackColor="#FF9900" Width="91px" />
            </td>
        </tr>
    </table>
            </asp:Panel>
</asp:Content>
