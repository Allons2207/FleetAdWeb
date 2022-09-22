<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="TuitionBilling.aspx.vb" Inherits="WebApplication2.TutionBilling" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style1 {
            height: 24px;
        }
        .auto-style2 {
            height: 42px;
        }
        .auto-style3 {
            height: 20px;
        }
        .auto-style4 {
            height: 26px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table width="90%">
        <tr>
            <td>
                <b>Tuition Billing</b>
            </td>
        </tr>
         <tr>
             <td width="100%">
                 <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small"></asp:Label>
             </td>
         </tr>
    </table>
   
     <asp:Panel ID="Panel2" runat="server">
          <table width="80%">
              <tr>
                  <td width="50%">
                         <table>                    
         <tr>
            <td >Select billing date</td>
            <td ><telerik:RadDatePicker ID="RadDatePickerBillingDate" runat="server"></telerik:RadDatePicker></td>
        </tr>
        <tr>
            <td></td>
        </tr>
        <tr>
              <td>select billing month</td>
            <td>
                <telerik:RadComboBox ID="RadComboBoxBillingMonth" runat="server">
                    <Items>
                        <telerik:RadComboBoxItem runat="server" Text="" Value="0" />
                        <telerik:RadComboBoxItem runat="server" Text="Jan" Value="1" />
                        <telerik:RadComboBoxItem runat="server" Text="Feb" Value="2" />
                        <telerik:RadComboBoxItem runat="server" Text="Mar" Value="3" />
                        <telerik:RadComboBoxItem runat="server" Text="Apr" Value="4" />
                        <telerik:RadComboBoxItem runat="server" Text="May" Value="5" />
                        <telerik:RadComboBoxItem runat="server" Text="Jun" Value="6" />
                        <telerik:RadComboBoxItem runat="server" Text="Jul" Value="7" />
                        <telerik:RadComboBoxItem runat="server" Text="Aug" Value="8" />
                        <telerik:RadComboBoxItem runat="server" Text="Sep" Value="9" />
                        <telerik:RadComboBoxItem runat="server" Text="Oct" Value="10" />
                        <telerik:RadComboBoxItem runat="server" Text="Nov" Value="11" />
                        <telerik:RadComboBoxItem runat="server" Text="Dec" Value="12" />
                    </Items>
                </telerik:RadComboBox>
            </td>
        </tr>
        <tr>
            <td></td>
        </tr>
        <tr>
           <td>select Billing Year</td>
            <td><asp:TextBox ID="txtYear" runat="server" Width="155px"></asp:TextBox></td>
        </tr>
        <tr>
            <td></td>
        </tr>
        <tr>
            <td>Select Stream</td>
            <td ><telerik:RadComboBox ID="RadComboBoxStream" runat="server"></telerik:RadComboBox></td>
        </tr>
        <tr>
            <td> </td>
        </tr>
        <tr>
             <td>
                 &nbsp;<asp:CheckBox ID="chkClassSpecificBilling" runat="server" AutoPostBack="True" BorderStyle="None" Text="Apply Class Specific Billing" />
                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (Specify Class)</td>
            <td>
                <telerik:RadComboBox ID="RadComboClass" runat="server"></telerik:RadComboBox>
            </td>
        </tr>
         <tr>
            <td></td>
        </tr>
         <tr>
             <td>&nbsp</td>
            <td>
                <asp:Button ID="cmdBill" runat="server" Text="Start Billing" BackColor="Orange" />
            </td>
        </tr>
         
                    </table>
                  </td>
            </tr> 
            <tr>
                <td width="100%"><hr></td>
            </tr>   
            <tr><td width="100%">
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
                            <td>Month</td><td>
                                <telerik:RadComboBox ID="cboMonths" runat="server">
                                    <Items>
                                        <telerik:RadComboBoxItem runat="server" Value="0" />
                                        <telerik:RadComboBoxItem runat="server" Text="Jan" Value="1" />
                                        <telerik:RadComboBoxItem runat="server" Text="Feb" Value="2" />
                                        <telerik:RadComboBoxItem runat="server" Text="Mar" Value="3" />
                                        <telerik:RadComboBoxItem runat="server" Text="Apr" Value="4" />
                                        <telerik:RadComboBoxItem runat="server" Text="May" Value="5" />
                                        <telerik:RadComboBoxItem runat="server" Text="Jun" Value="6" />
                                        <telerik:RadComboBoxItem runat="server" Text="Jul" Value="7" />
                                        <telerik:RadComboBoxItem runat="server" Text="Aug" Value="8" />
                                        <telerik:RadComboBoxItem runat="server" Text="Sep" Value="9" />
                                        <telerik:RadComboBoxItem runat="server" Text="Oct" Value="10" />
                                        <telerik:RadComboBoxItem runat="server" Text="Nov" Value="11" />
                                        <telerik:RadComboBoxItem runat="server" Text="Dec" Value="12" />
                                    </Items>
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
                </td></tr>            
            <tr>

                <td width="100%">
                    <telerik:RadGrid ID="gwBilling" runat="server" AllowPaging="True" AllowSorting="True" BackColor="White" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" DisplayMode="FirstLastPreviousNextNumeric, Text" ForeColor="Black" GroupPanelPosition="Top" PageSize="50">
                        <ClientSettings>
                            <Scrolling AllowScroll="True" />
                        </ClientSettings>
                        <AlternatingItemStyle BackColor="#E9E9E9" />
                    </telerik:RadGrid>
                </td>
            </tr>
         </table>             
      </asp:Panel>
</asp:Content>

