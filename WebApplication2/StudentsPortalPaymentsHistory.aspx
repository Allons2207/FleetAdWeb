<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/StudentsPortalMaster.Master" CodeBehind="StudentsPortalPaymentsHistory.aspx.vb" Inherits="WebApplication2.StudentsPortalPaymentsHistory" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   
                        <table>
                              <tr>
       <td style="font-size:medium; color:darkblue " colspan="6">
         Your Payments Details
       </td>
       </tr>
       <tr>
         <td>
             <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small"></asp:Label>
         </td>
        </tr>
                            <tr>
                                <td>
                                    Select Payment History To View
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="radComboPaymentsHistory" runat="server" AutoPostBack="True" >
                                        <Items>
                                            <telerik:RadComboBoxItem runat="server" Text="--Select--" Value="--Select--" />
                                            <telerik:RadComboBoxItem runat="server" Text="Tuition" Value="1" />
                                            <telerik:RadComboBoxItem runat="server" Text="Levy" Value="2" />
                                            <telerik:RadComboBoxItem runat="server" Text="Transport" Value="3" />
                                            <telerik:RadComboBoxItem runat="server" Text="Registration" Value="4" />
                                            <telerik:RadComboBoxItem runat="server" Text="Uniforms" Value="5" />
                                        </Items>
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                      </table>
    <table width="50%">
                            <tr>
                                <td colspan="3">
                                     <telerik:RadGrid ID="gwStudentPaymentHistory" runat="server" Width ="100%"  BackColor="White"  AllowPaging="True"  DisplayMode="FirstLastPreviousNextNumeric, Text" PageSize="50"
         BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" AllowSorting="True" GroupPanelPosition="Top"  ForeColor="Black">
   
                    <ClientSettings>
                        <Scrolling AllowScroll="True"  />
                    </ClientSettings>
                   
                                         <AlternatingItemStyle BackColor="#E9E9E9" />
                   
     </telerik:RadGrid>   
                                </td>
                            </tr>
                        </table>
 
</asp:Content>
