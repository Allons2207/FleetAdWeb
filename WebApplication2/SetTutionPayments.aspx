<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="SetTutionPayments.aspx.vb" Inherits="WebApplication2.SetTutionPayments" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table>
        <tr>
            <td>
                <b>Set Tuition Fee</b>
            </td>
        </tr>
         <tr>
             <td>
                 <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small"></asp:Label>
             </td>
         </tr>
    </table>
    <asp:Panel ID="Panel1" runat="server">
        <table width="100%">
            <tr>
                <td>
                   Stream
                </td>
                <td>
                    Tution 
                </td>
                <td>
                  Amount per extra subject   
                </td>
                <td>
                     Computer Fees
                </td>
            </tr>
            <tr>
                <td>
                    <telerik:RadComboBox ID="RadComboBoxStream" runat="server"></telerik:RadComboBox>
                </td>
                <td>
                    <asp:TextBox ID="txtAmountPM" runat="server"></asp:TextBox>
                </td>
                <td>
                      <asp:TextBox ID="txtAmountPerXSub" runat="server"></asp:TextBox>
                </td>
                <td>
                      <asp:TextBox ID="txtComputerFee" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td></td>
            </tr>
        </table>
        <table width ="100%">
            <tr>
                <td>
                      <telerik:RadGrid ID="gwTuitionPaymentsSchedule" runat="server" Width ="100%"  BackColor="#DEBA84"  AllowPaging="True"  DisplayMode="FirstLastPreviousNextNumeric, Text" PageSize="50"
         BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" AllowSorting="True" GroupPanelPosition="Top"  ForeColor="Black">
         <MasterTableView DataKeyNames="tuitionPaymentId">
             <Columns>
                 <telerik:GridButtonColumn ButtonType="LinkButton" Text="Edit" CommandName="View"></telerik:GridButtonColumn>
             </Columns>
         </MasterTableView>
                    <ClientSettings>
                        <Scrolling AllowScroll="True"  />
                    </ClientSettings>
                   
     </telerik:RadGrid>   
                </td>
            </tr>
        </table>
        <asp:Button ID="cmdSave" runat="server" Text="SAVE" Width="121px" BackColor="#FF9900" ForeColor="White" />
    </asp:Panel>

</asp:Content>
