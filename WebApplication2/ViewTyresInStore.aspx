<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="ViewTyresInStore.aspx.vb" Inherits="WebApplication2.ViewTyresInStore" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <table width="90%"  style="margin-left:2%">
       <tr>
       <td style="font-size:medium; color:darkblue ">
           <br />
           Tyres into Store
       </td>
       </tr>
       <tr>
         <td >
             <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small" Width="100%"></asp:Label>
         </td>
        </tr>
        <tr><td><asp:Button ID="cmdExportToExcel" runat="server" Text="Export to MS Excel" Width="150px"/>
                            </td></tr>
        <tr><td>
                    
                    <telerik:RadGrid ID="gwBillPayments" runat="server"  BackColor="White"  AllowPaging="True"  DisplayMode="FirstLastPreviousNextNumeric, Text" PageSize="50"
         BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" AllowSorting="True" GroupPanelPosition="Top"  ForeColor="Black" AllowFilteringByColumn="True" ShowGroupPanel="True" AutoGenerateColumns="False" >
              
                        <ClientSettings allowdragtogroup="True">
                            <scrolling allowscroll="True" usestaticheaders="True" />
                    </ClientSettings>
                   
                        <AlternatingItemStyle BackColor="#CCCCFF" />
                   
                        <MasterTableView>
                            <Columns>
                                <telerik:GridButtonColumn CommandName="Dispose" FilterControlAltText="Filter Dispose column" HeaderText="Dispose" Text="Dispose" UniqueName="Dispose">
                                </telerik:GridButtonColumn>
                                <telerik:GridBoundColumn DataField="batchNumber" FilterControlAltText="Filter batchNumber column" HeaderText="Purchase Order #" UniqueName="batchNumber">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="serialNumber" FilterControlAltText="Filter serialNumber column" HeaderText="Serial #" UniqueName="serialNumber">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="detReceived" FilterControlAltText="Filter detReceived column" HeaderText="Date Received" UniqueName="detReceived">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="detManufactured" FilterControlAltText="Filter detManufactured column" HeaderText="Date Manufactured" UniqueName="detManufactured">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="manufacturer" FilterControlAltText="Filter manufacturer column" HeaderText="Manufacturer" UniqueName="manufacturer">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="supplierName" FilterControlAltText="Filter supplierName column" HeaderText="Supplier" UniqueName="supplierName">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="unitCost" FilterControlAltText="Filter unitCost column" HeaderText="Unit Cost" UniqueName="unitCost">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="tyreSize" FilterControlAltText="Filter tyreSize column" HeaderText="Tyre Size" UniqueName="tyreSize">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="fittingStatus" FilterControlAltText="Filter fittingStatus column" HeaderText="Fitting Status" UniqueName="fittingStatus">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="expectedTyreMileage" FilterControlAltText="Filter expectedTyreMileage column" HeaderText="Expected Mileage" UniqueName="expectedTyreMileage">
                                </telerik:GridBoundColumn>
                            </Columns>
                        </MasterTableView>
                   
     </telerik:RadGrid> 
                    
            </td></tr>
    </table>




</asp:Content>
