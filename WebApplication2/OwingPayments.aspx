<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="OwingPayments.aspx.vb" Inherits="WebApplication2.OwingPayments" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <table>
    <tr>
        <td style="font-size:medium; color:darkblue ">
           Students Owing Payments
        </td>
    </tr>
        
</table>
    <table width="100%">
         <tr>
             <td><hr/></td>
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
                Payment Type &nbsp;&nbsp;&nbsp
                <telerik:RadComboBox ID="cbPaymentType" runat="server">
                    <Items>
                        <telerik:RadComboBoxItem runat="server" Text="Tuition" Value="Tuition" />
                        <telerik:RadComboBoxItem runat="server" Text="Levy" Value="Levy" />
                    </Items>
                </telerik:RadComboBox>
            </td>
            <td>
                Stream  &nbsp;&nbsp;&nbsp <telerik:RadComboBox ID="cbStream" runat="server"></telerik:RadComboBox>
            </td>
            <td>
                Class  &nbsp;&nbsp;&nbsp <telerik:RadComboBox ID="cbClass" runat="server"></telerik:RadComboBox>
            </td>
            <td>
                <asp:Button ID="cmdSearch" runat="server" Text="Show" BackColor="#FF9933" />
            </td>
        </tr>
    </table>
    <table width ="100%">
        <tr>
            <td>
                <telerik:RadGrid ID="gwArrears" runat="server" Width ="100%"  BackColor="White"  AllowPaging="True"  DisplayMode="FirstLastPreviousNextNumeric, Text" PageSize="50"
           BorderColor="#666666" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" AllowSorting="True" GroupPanelPosition="Top"  ForeColor="Black" AllowFilteringByColumn="True">
                    <ClientSettings>
                        <Scrolling AllowScroll="True"  />
                    </ClientSettings>
                   
                    <AlternatingItemStyle BackColor="#E0E0E0" />
                   
     </telerik:RadGrid>   
            </td>
        </tr>
    </table>
</asp:Content>
