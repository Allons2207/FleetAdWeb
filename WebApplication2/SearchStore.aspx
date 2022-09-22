<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="SearchStore.aspx.vb" Inherits="WebApplication2.SearchStore" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
 <h3 style="font-size:medium; color:gray "> Search Tyres Store</h3>

    <table width="90%">
        <tr><td><hr /></td></tr>
           <tr>
             <td>
                 <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small" Width="100%"></asp:Label>
             </td>
         </tr>
        <tr><td>
            <table width="80%" style="margin-left:2%" >
        
              <tr>
            <td>Purchase Order #</td> <td>
                <asp:TextBox ID="txtPurchaseOrderNumber" runat="server"></asp:TextBox> </td>
            <td> Serial Number</td> <td>
                <asp:TextBox ID="txtSerialNumber" runat="server"></asp:TextBox>
            </td>
            <td>&nbsp;</td> <td> 
                &nbsp;</td>
            </tr>
        <tr>
            <td>Manufacturer</td><td>
                <telerik:RadComboBox ID="cboManufacturer" runat="server" Width="208px">
                </telerik:RadComboBox>
            </td>
            <td>Supplier</td><td> 
                <telerik:RadComboBox ID="cboSupplier" runat="server">
                </telerik:RadComboBox>
            </td>
            <td>Tyre Size</td><td> 
                <telerik:RadComboBox ID="cboTyreSize" runat="server"></telerik:RadComboBox>
               </td>
             <td>
                 <asp:Button ID="btnSearch" runat="server" Text="Search" Width="207px" />
            </td>
            </tr>
                
        <tr>
            <td>
                 
            </td>
        </tr>

    </table>
            </td></tr>
        <tr><td><hr /></td></tr>
        <tr><td>
             
                
                        <telerik:RadGrid ID="gwStores" runat="server"  BackColor="White"  AllowPaging="True"  DisplayMode="FirstLastPreviousNextNumeric, Text" PageSize="50"
         BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" AllowSorting="True" GroupPanelPosition="Top"  ForeColor="Black" >
              
                        <ClientSettings>
                        <Scrolling AllowScroll="True"  />
                    </ClientSettings>
                   
     </telerik:RadGrid> 
             </td></tr>
    </table>

    
    
   
</asp:Content>
