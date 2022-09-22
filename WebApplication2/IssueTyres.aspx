<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="IssueTyres.aspx.vb" Inherits="WebApplication2.IssueTyres" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3 style="font-size:medium; color:gray "> Issueing of Tyres</h3>
     <table width="80%"  style="margin-left:2%">
       <tr>
         <td colspan="4">
             <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small" Width="100%"></asp:Label>
         </td>
        </tr>
       <tr>
           <td colspan ="4"> Vehicle Details</td>
       </tr>
       <tr>
           <td><asp:Label ID="lblMsg0" runat="server" Text="Fleet ID"  Font-Italic="False" Font-Size="Small" Width="160px"></asp:Label>
           </td><td><asp:TextBox ID="txtFleetID" runat="server"></asp:TextBox>&nbsp;&nbsp;&nbsp;&nbsp; <asp:Button ID="btnSearchByFleetId" runat="server" Text="Search Vehicle" style="height: 26px" /></td>
           
           <td  rowspan="6">
                    <telerik:RadGrid ID="gwFittedTyres" runat="server" BackColor="#E2E2E2"  AllowPaging="True"  DisplayMode="FirstLastPreviousNextNumeric, Text" PageSize="100"
                                                        BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" AllowSorting="True" GroupPanelPosition="Top"  ForeColor="Black" AllowMultiRowSelection="True" ClientSettings-Selecting-AllowRowSelect="true" >
                        <ClientSettings>
                                       <Selecting AllowRowSelect="True"></Selecting>

                        <Scrolling AllowScroll="True"  />
                    </ClientSettings>
                   
                        <MasterTableView>
                            <Columns>
                                <telerik:GridClientSelectColumn FilterControlAltText="Filter column column" UniqueName="column">
                                </telerik:GridClientSelectColumn>
                            </Columns>
                        </MasterTableView>
                   
     </telerik:RadGrid> 
            </td>
       </tr>
       <tr>
           <td>Registration #</td><td><asp:TextBox ID="txtRegNumber" runat="server"></asp:TextBox>&nbsp;&nbsp;&nbsp;&nbsp; <asp:Button ID="cmdSearch" runat="server" Text="Search Vehicle" /></td>
       </tr>
       <tr>
           <td>Make</td><td><asp:TextBox ID="txtMake" runat="server" Width="300px" Enabled="False"></asp:TextBox></td>
       </tr>
       <tr>
           <td>Model</td><td><asp:TextBox ID="txtModel" runat="server" Width="295px" Enabled="False"></asp:TextBox></td>
       </tr>
       <tr><td>Current Vehicle Mileage</td><td><asp:TextBox ID="txtVehicleMileage" runat="server"></asp:TextBox></td>
       </tr>       
        <tr><td></td></tr>
         <tr><td></td></tr>
         <tr><td></td></tr>
         <tr><td colspan="3"><hr /></td></tr>
        <tr><td colspan="4"><b>Required/Replacement Tyre Details</b></td></tr>
        <tr><td>Reason for Replacing Tyre(s)</td><td>
                                <telerik:RadComboBox ID="cboReasonForReplacingTyres" runat="server">
                                </telerik:RadComboBox>                                
                                </td><td rowspan="6">
                    <telerik:RadGrid ID="gwAvailableTyres" runat="server"  BackColor="#EAEAEA"  AllowPaging="True"  DisplayMode="FirstLastPreviousNextNumeric, Text" PageSize="50"
         BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" AllowSorting="True" GroupPanelPosition="Top"  ForeColor="Black" Width="700px" >
              
                        <ClientSettings>
                        <Scrolling AllowScroll="True"  />
                    </ClientSettings>
                   
     </telerik:RadGrid> 
            </td></tr>
        <tr><td>Number of Tyres Required</td><td><asp:TextBox ID="txtNumberOfTyresReqd" runat="server"></asp:TextBox></td></tr>
        <tr><td>Tyre Size</td><td>
                                <telerik:RadComboBox ID="cboTyreSize" runat="server">
                                </telerik:RadComboBox>                                
            </td></tr>
        <tr><td>Mafacturer&nbsp;&nbsp;
            <asp:CheckBox ID="chkSpecifyManufacturer" runat="server" />
            </td><td>
                                <telerik:RadComboBox ID="cboManufacturer" runat="server">
                                </telerik:RadComboBox>                                
                                </td></tr>
        <tr><td>Fitting Date</td><td>                       
                                <telerik:RadDatePicker ID="rdDtDate" Runat="server">
                                </telerik:RadDatePicker>
                            </td></tr>
        <tr>
            <td></td>
            <td colspan="2">
                    &nbsp;</td></tr>
         <tr><td colspan="3"><hr /></td></tr>
          <tr><td>&nbsp</td><td>&nbsp</td><td>                                
                                <asp:Button ID="cmdShowReplacementTyres" runat="server" Text="Show the Replacement Tyres" />                    
                                <asp:Button ID="cmdFitTyres" runat="server" Text="Fit Selected Tyres onto Selected Vehicle" Width="261px" />                                
             </td></tr> 
         <tr><td colspan="3"><hr /></td></tr>
    </table>
</asp:Content>


