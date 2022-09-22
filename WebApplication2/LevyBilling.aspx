<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="LevyBilling.aspx.vb" Inherits="WebApplication2.LevyBilling" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style1 {
            height: 24px;
        }
        .auto-style2 {
            height: 26px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <table>
        <tr>
            <td>
                <b>Levy Billing</b>
            </td>
        </tr>
         <tr>
             <td>
                 <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small"></asp:Label>
             </td>
         </tr>
    </table>
    
     <asp:Panel ID="Panel2" runat="server">
    <table width ="70%">
        <tr>
            <td>
                Select billing date
            </td>
            <td>
                <telerik:RadDatePicker ID="RadDatePickerBillingDate" runat="server"></telerik:RadDatePicker>
            </td>
            </tr>
        <tr>
            <td>

            </td>
        </tr>
        <tr>
            <td>
                select billing term
            </td>
            <td>
                <telerik:RadComboBox ID="RadComboBoxBillingTerm" runat="server">
                    <Items>
                        <telerik:RadComboBoxItem runat="server" Text="" Value="0" />
                        <telerik:RadComboBoxItem runat="server" Text="First Term" Value="1" />
                        <telerik:RadComboBoxItem runat="server" Text="Second Term" Value="2" />
                        <telerik:RadComboBoxItem runat="server" Text="Third Term" Value="3" />
                    </Items>
                </telerik:RadComboBox>
            </td>
        </tr>
        <tr>
            <td>

            </td>
        </tr>
        <tr>
            
            <td class="auto-style1">
                select Billing Year
            </td>
            <td class="auto-style1">
                
                <asp:TextBox ID="txtYear" runat="server" Width="155px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>

            </td>
        </tr>
        <tr>
            <td class="auto-style2">
                Select Stream
            </td>
            <td class="auto-style2">
                <telerik:RadComboBox ID="RadComboBoxStream" runat="server"></telerik:RadComboBox>
            </td>
        </tr>
        <tr>
            <td>

            </td>
        </tr>
         <tr>
            <td></td>
        </tr>
         <tr>
            <td>
                <asp:Button ID="cmdBill" runat="server" Text="Start Billing" BackColor="Orange" />
            </td>
        </tr>
    </table>
                  
          <table width="100%">
             <tr>
                 <td>
<hr />
                </td>
             </tr>
             <tr>
                <td>
                    <table>
                        <tr>
                            <td>View Billing for: Stream</td><td>
                                <telerik:RadComboBox ID="radCboStream" runat="server">
                                        <Items>
                                                <telerik:RadComboBoxItem runat="server" Text="Tuition" Value="Tuition" />
                                                        <telerik:RadComboBoxItem runat="server" Text="Levy" Value="Levy" />
                                                    <telerik:RadComboBoxItem runat="server" Text="All Payments" Value="All Payments" />
                                        </Items>
                                </telerik:RadComboBox>
                            </td>
                            <td>Term </td><td>
                                <telerik:RadComboBox ID="radCboTerm" runat="server">
                                </telerik:RadComboBox>
                            </td>
                            <td> &nbsp;&nbsp<asp:Button ID="btnShowBillingGrid" runat="server" Text="Show Billing" /></td>
                        </tr>
                        <tr>
            <td>
                &nbsp;&nbsp
            </td>
        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <telerik:RadGrid ID="gwBilling" runat="server" AllowPaging="True" AllowSorting="True" BackColor="#DEBA84" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" DisplayMode="FirstLastPreviousNextNumeric, Text" ForeColor="Black" GroupPanelPosition="Top" PageSize="50">
                        <ClientSettings>
                            <Scrolling AllowScroll="True" />
                        </ClientSettings>
                    </telerik:RadGrid>
                </td>
            </tr>
         </table>





        </asp:Panel>
</asp:Content>
