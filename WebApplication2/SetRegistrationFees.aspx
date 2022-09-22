<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="SetRegistrationFees.aspx.vb" Inherits="WebApplication2.SetRegistrationFees" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <table>
        <tr>
            <td>
                <b>Set Registration Fees</b>
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
                    Registration Fee</td>
                
            </tr>
            <tr>
                <td>
                    <telerik:RadComboBox ID="RadComboBoxStream" runat="server"></telerik:RadComboBox>
                </td>
                <td>
                    <asp:TextBox ID="txtAmount" runat="server"></asp:TextBox>
                </td>
               
            </tr>
            <tr>
                <td></td>
            </tr>
        </table>
        <table width ="100%">
            <tr>
                <td>
                      <telerik:RadGrid ID="gwRegistrationPaymentsSchedule" runat="server" Width ="100%"  BackColor="#DEBA84"  AllowPaging="True"  DisplayMode="FirstLastPreviousNextNumeric, Text" PageSize="50"
         BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" AllowSorting="True" GroupPanelPosition="Top"  ForeColor="Black">
         <MasterTableView DataKeyNames="PaymentId">
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
