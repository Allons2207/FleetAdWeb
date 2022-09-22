<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="SetTransportFees.aspx.vb" Inherits="WebApplication2.SetTransportFees" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
    
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <table>
        <tr>
            <td>
                <b>Set Transport Fees</b>
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
                   Month
                </td>
                <td>
                    Year 
                </td>
                <td>
                  Amount    
                </td>
                
            </tr>
            <tr>
               <td>
                   <asp:TextBox ID="txtMonth" runat="server" Visible="false"></asp:TextBox>
                  
                <telerik:RadComboBox ID="RadComboBoxMonth" runat="server" >
                    <Items>
                        <telerik:RadComboBoxItem runat="server" Text="" Value="0" />
                        <telerik:RadComboBoxItem runat="server" Text="January" Value="January" />
                        <telerik:RadComboBoxItem runat="server" Text="February" Value="February" />
                        <telerik:RadComboBoxItem runat="server" Text="March" Value="March" />
                        <telerik:RadComboBoxItem runat="server" Text="April" Value="April" />
                        <telerik:RadComboBoxItem runat="server" Text="May" Value="May" />
                        <telerik:RadComboBoxItem runat="server" Text="June" Value="June" />
                        <telerik:RadComboBoxItem runat="server" Text="July" Value="July" />
                        <telerik:RadComboBoxItem runat="server" Text="August" Value="August" />
                        <telerik:RadComboBoxItem runat="server" Text="September" Value="September" />
                        <telerik:RadComboBoxItem runat="server" Text="October" Value="October" />
                        <telerik:RadComboBoxItem runat="server" Text="November" Value="November" />
                        <telerik:RadComboBoxItem runat="server" Text="December" Value="December" />
                    </Items>
                </telerik:RadComboBox>
            </td>
                <td>
                    <asp:TextBox ID="txtYear" runat="server"></asp:TextBox>
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
                      <telerik:RadGrid ID="gwTransportPaymentsSchedule" runat="server" Width ="100%"  BackColor="#DEBA84"  AllowPaging="True"  DisplayMode="FirstLastPreviousNextNumeric, Text" PageSize="50"
         BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" AllowSorting="True" GroupPanelPosition="Top"  ForeColor="Black">
         <MasterTableView DataKeyNames="ctr">
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
