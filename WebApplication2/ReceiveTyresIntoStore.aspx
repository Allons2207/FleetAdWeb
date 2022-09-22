<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="ReceiveTyresIntoStore.aspx.vb" Inherits="WebApplication2.ReceiveTyresIntoStore" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

       <table style="margin-left:2%" width="60%">
       <tr>
       <td style="font-size:medium; color:darkblue " colspan="3">
          
           Receive Tyres into Store
       </td>
       </tr>
            <tr><td colspan="4"><hr /></td></tr>
       <tr>
         <td>
             <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small"></asp:Label>
         </td>
        </tr>
        <tr>
            <td>Purchase Order #</td><td>
                                <asp:TextBox ID="txtPONumber" runat="server"></asp:TextBox>
                            </td>
            <td>Date Received</td><td>                       
                                <telerik:RadDatePicker ID="rdDtDate" Runat="server">
                                </telerik:RadDatePicker>
                            </td>
        </tr>
           <tr>
            <td>Supplier</td><td>
                                <telerik:RadComboBox ID="cboSupplier" runat="server" Width="321px">
                                </telerik:RadComboBox>                                
                                </td>
                <td>Manufacturer</td><td>
                                <telerik:RadComboBox ID="cboManufacturer" runat="server" Width="320px">
                                </telerik:RadComboBox>                                
                                </td>
               </tr>
          <tr>         
              
            <td>Tyre Size</td><td>
                                <telerik:RadComboBox ID="cboTyreSize" runat="server">
                                </telerik:RadComboBox>                                
                                </td>
               <td>Unit Cost</td><td>
                                <asp:TextBox ID="txtUnitCost" runat="server"></asp:TextBox>
                            </td>
               </tr>
            <tr>
            <td>Date Manufactured</td><td>                       
                                <telerik:RadDatePicker ID="rdDtDateManufactured" Runat="server">
                                </telerik:RadDatePicker>
                            </td>
               </tr>
          <tr>
            <td>Standard Mileage</td><td>
                                <asp:TextBox ID="txtStandardMileage" runat="server"></asp:TextBox>
                            </td>
               <td>&nbsp;</td><td>
                                <asp:TextBox ID="txtCurrentMileage" runat="server" Visible="False">0</asp:TextBox>
                            </td>
               </tr>
           <tr>
                <td>Number of such Tyres in P.O</td><td>
                                <asp:TextBox ID="txtNumberOfTyresInBatch" runat="server"></asp:TextBox>
                            </td>
            <td>Description</td><td>
                            <asp:TextBox ID="txtNotes" runat="server" TextMode="MultiLine" Width="313px"></asp:TextBox>
                            </td>
               </tr>
          <tr><td colspan="4"><hr /></td></tr>
           <tr><td></td><td colspan="3">
                                <asp:Button ID="cmdAddNew" runat="server" Text="Save Purchase Order Record" /> &nbsp;&nbsp;&nbsp
               
                                <asp:Button ID="cmdClear" runat="server" Text="Clear Controls" />
                            </td></tr>
          <tr><td colspan="2">&nbsp</td></tr>
          
          
     </table>
        
     <table style="margin-left:2%" width="90%">
        
        <tr>
            <td><b>Details of Tyres on this Purchase Order</b></td>
        </tr>
        <tr><td>&nbsp</td></tr>
        <tr><td>
                    <telerik:RadGrid ID="gwBillPayments" runat="server"  BackColor="White"  AllowPaging="True"  DisplayMode="FirstLastPreviousNextNumeric, Text" PageSize="50"
         BorderColor="Silver" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" AllowSorting="True" GroupPanelPosition="Top"  ForeColor="Black" >
              
                        <ClientSettings>
                        <Scrolling AllowScroll="True"  />
                    </ClientSettings>
                   
                        <AlternatingItemStyle BackColor="#E6E6E6" />
                   
     </telerik:RadGrid> 
            </td></tr>
    </table>


</asp:Content>
