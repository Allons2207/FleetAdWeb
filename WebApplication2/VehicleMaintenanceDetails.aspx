<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="VehicleMaintenanceDetails.aspx.vb" Inherits="WebApplication2.VehicleMaintenanceDetails" MaintainScrollPositionOnPostback ="true" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
                 
                    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3 style="font-size:medium; color:gray "> Vehicle Maintenance Records List</h3>
    <table width="60%" style="margin-left:2%" >
       <tr>
         <td colspan="4">
             <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small" Width="100%"></asp:Label>
         </td>
      </tr>
      <tr>
         <td colspan="6">
               <table>
             <tr><td>Search by Fleet ID.</td><td><asp:TextBox ID="txtFleetIDSearch" runat="server" Width="211px"></asp:TextBox></td><td><asp:Button ID="btnSearchByFleetID" runat="server" Text="Find" Width="150px" /></td></tr>
             <tr><td>Search by Reg No.</td><td><asp:TextBox ID="txtRegNo" runat="server" Width="211px"></asp:TextBox></td><td><asp:Button ID="cmdClear0" runat="server" Text="Find" Width="150px" /></td></tr>
              <tr>
             <td>Fleet ID</td> <td> <asp:TextBox ID="txtFleetID" runat="server" Width="211px" Enabled="False"></asp:TextBox></td>
        </tr>
        <tr>
            <td>Make</td> <td> <asp:TextBox ID="txtMake" runat="server" Width="211px" Enabled="False"></asp:TextBox></td> <td>Model</td> <td> <asp:TextBox ID="txtModel" runat="server" Width="211px" Enabled="False"></asp:TextBox></td>
        </tr>
        <tr>
            <td>&nbsp;</td> <td> &nbsp;</td> <td>&nbsp;</td> <td> &nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style2">Last Recorded Mileage</td> <td class="auto-style2"> <asp:TextBox ID="txtLastRecordedMileage" runat="server" Width="211px" Enabled="False"></asp:TextBox></td> <td class="auto-style2">Mileage Date</td> <td class="auto-style2">
                                         <telerik:RadDatePicker ID="rdMileageDate" runat="server" Culture="en-US" MinDate="1900-01-01" Enabled="False"></telerik:RadDatePicker>
                                     </td>
        </tr>
        <tr><td colspan="4" ></td></tr>
        <tr><td colspan ="2"><b>Servicing Details</b></td></tr>
         <tr><td colspan="4"><hr /></td></tr>
        <tr>
            <td>Job Card #</td> <td> <asp:TextBox ID="txtJobCardNumber" runat="server" Width="211px"></asp:TextBox></td> <td>&nbsp;</td>
        </tr>
        <tr><td>Type of Service</td> <td>
                                         <telerik:RadComboBox ID="cboTypeOfService" runat="server" Width="222px">
                                             <Items>
                                                 <telerik:RadComboBoxItem runat="server" Text="Scheduled Service" Value="Scheduled Service" />
                                                 <telerik:RadComboBoxItem runat="server" Text="UnScheduled Service" Value="UnScheduled Service" />
                                                 <telerik:RadComboBoxItem runat="server" Text="Schedule A" Value="Schedule A" />
                                                 <telerik:RadComboBoxItem runat="server" Text="Schedule B" Value="Schedule B" />
                                             </Items>
                                         </telerik:RadComboBox>
                                         </td>
            <td>Service Category</td><td> <telerik:RadComboBox ID="cboServiceCategory" runat="server" Width="222px">   </telerik:RadComboBox>                                                                           </telerik:RadComboBox></td>
            
        </tr>
        <tr><td>Service Frequency</td>
            <td> <telerik:RadComboBox ID="cboServiceFrequency" runat="server" Width="222px">
                                             
                                         </telerik:RadComboBox></td></tr>
        <tr>
            <td class="auto-style2">Date in for Service</td> <td class="auto-style2">
                                         <telerik:RadDatePicker ID="rdServiceDate" runat="server" Culture="en-US" MinDate="1900-01-01"></telerik:RadDatePicker>
                                     </td> <td class="auto-style2">At Mileage</td> <td class="auto-style2">
                                         <asp:TextBox ID="txtCurrentMileage" runat="server" Width="211px"></asp:TextBox>
                                         </td>
        </tr>
        <tr>
            <td class="auto-style2">Mechanic</td> <td class="auto-style2"> <asp:TextBox ID="txtMechanic" runat="server" Width="211px"></asp:TextBox></td> <td>&nbsp;</td> <td> &nbsp;</td>
        </tr>
        <tr><td>Date out of Service</td><td>
                                         <telerik:RadDatePicker ID="rdDateOutOfService" runat="server" Culture="en-US" MinDate="1900-01-01"></telerik:RadDatePicker>
                                     </td><td>Total Time Taken</td><td><asp:TextBox ID="txtTotalTimeTaken" runat="server" Width="211px"></asp:TextBox></td></tr>
        



        </table>
         </td>
      </tr>
      <tr><td colspan="6"><hr /></td></tr>
      <tr>
            <td class="auto-style4">&nbsp;</td><td colspan="5">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp
                 <asp:Button ID="cmdSaveHeader" runat="server" Text="Save Header Details" Width="197px" />&nbsp
                 </td></tr>
      <tr>
          <td colspan="6"><hr /></td>
      </tr>
      <tr>
          <td class="auto-style4">&nbsp;</td><td colspan="5">
                  <table>
            <tr>
                <td class="auto-style1">Work Done</td><td >Materials Used</td><td >Quantity</td><td class="auto-style1">Unit Price</td><td class="auto-style1">Total Price</td><td class="auto-style1"></td></tr>
                <tr><td>
                                         <telerik:RadComboBox ID="cboWorkDone" runat="server" Width="211px" ></telerik:RadComboBox>
                                         </td><td>
                                         <telerik:RadComboBox ID="cboMaterialsUsed" runat="server" Width="211px" AutoPostBack="True" ></telerik:RadComboBox>
                                         </td><td> <asp:TextBox ID="txtQty" runat="server" Width="48px" AutoPostBack="True"></asp:TextBox></td><td class="auto-style1"> <asp:TextBox ID="txtUnitPrice" runat="server" Width="48px" AutoPostBack="True"></asp:TextBox></td><td> <asp:TextBox ID="txtTotalPrice" runat="server" Width="48px"></asp:TextBox></td><td>
                 <asp:Button ID="cmdSave" runat="server" Text="+" Width="27px" Enabled="False" />
                    </td>
                    <td>&nbsp;&nbsp;&nbsp;&nbsp<asp:Button ID="btnClear" runat="server" Text="Clear" Width="76px" /></td>
                    <td><asp:TextBox ID="txtEntryId" runat="server" Width="48px" AutoPostBack="True" Visible="False"></asp:TextBox></td>
            </tr>
            <tr><td><asp:TextBox ID="txtWorkDone" runat="server" Width="211px"></asp:TextBox></td><td><asp:TextBox ID="txtMaterialsUsed" runat="server" Width="211px"></asp:TextBox></td><td></td><td></td><td></td></tr>
            <tr>
                <td colspan="8"> <asp:Label ID="lblMsg2" runat="server" Text=""  Font-Italic="True" Font-Size="Small" Width="100%"></asp:Label></td>
            </tr>
        </table>
         </td>
      </tr>
          <tr><td>&nbsp</td>
            <td><b>Grand Total</b></td><td colspan="4"  style="text-align:right"> <asp:Label ID="lblMsg3" runat="server"  Font-Italic="True" Font-Size="Small" Width="100px" BackColor="#CCCCCC" ></asp:Label></td>
        </tr>
      <tr>
          <td class="auto-style4">&nbsp;</td>
          <td colspan="5">
                <telerik:radgrid ID="gwGrid" runat="server" AllowPaging="True" AllowSorting="True" BackColor="White" BorderColor="#003366" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" ForeColor="Black" GroupPanelPosition="Top" PageSize="100" AllowFilteringByColumn="True" ShowGroupPanel="True" AutoGenerateColumns="False">
                    <clientsettings AllowDragToGroup="True">
                        <Scrolling AllowScroll="True" UseStaticHeaders="True"  />
                    </clientsettings>
                    <MasterTableView>
                        <Columns>
                            <telerik:GridButtonColumn CommandName="Editta" FilterControlAltText="Filter Editta column" HeaderText="Edit" Text="Editta" UniqueName="Editta">
                            </telerik:GridButtonColumn>
                            <telerik:GridButtonColumn CommandName="Delete" FilterControlAltText="Filter Delete column" HeaderText="Delete" Text="Delete" UniqueName="Delete">
                            </telerik:GridButtonColumn>
                            <telerik:GridBoundColumn DataField="EntryID" FilterControlAltText="Filter EntryID column" HeaderText="EntryID" UniqueName="EntryID">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="WorkDone" FilterControlAltText="Filter WorkDone column" HeaderText="WorkDone" UniqueName="WorkDone">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Desc" FilterControlAltText="Filter Desc column" HeaderText="Desc" UniqueName="Desc">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="QtyUsed" FilterControlAltText="Filter QtyUsed column" HeaderText="QtyUsed" UniqueName="QtyUsed">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="UnitPrice" FilterControlAltText="Filter UnitPrice column" HeaderText="UnitPrice" UniqueName="UnitPrice">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="TotalPrice" FilterControlAltText="Filter TotalPrice column" HeaderText="TotalPrice" UniqueName="TotalPrice">
                            </telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:radgrid>
          </td>

      </tr>
       
      <tr>
          <td class="auto-style4"></td>
          <td>
                 <telerik:RadGrid ID="gwGrid0" runat="server"  BackColor="White"  AllowPaging="True" PageSize="100"
         BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" AllowSorting="True" GroupPanelPosition="Top"  ForeColor="Black" AutoGenerateColumns="False" AllowMultiRowSelection="True" ClientSettings-Selecting-AllowRowSelect="true" Visible="False" >
                      
<ClientSettings>
<Selecting AllowRowSelect="True"></Selecting>
</ClientSettings>

              <AlternatingItemStyle BackColor="#E9E9E9" />

           <MasterTableView>
             <Columns>
                 
                 <telerik:GridClientSelectColumn DataType="System.Boolean" FilterControlAltText="Filter attendance column"
                            UniqueName="attendance" HeaderText="attendance" FooterText="attendance">
                        </telerik:GridClientSelectColumn>
                 
                 <telerik:GridBoundColumn DataField="Type" FooterText="Type" HeaderText="Type"
                            UniqueName="Type" FilterControlAltText="Filter Type column">  </telerik:GridBoundColumn>
                 <telerik:GridBoundColumn DataField="Failure" FooterText="Failure" HeaderText="Failure"
                            UniqueName="Failure" FilterControlAltText="Filter Failure column">  </telerik:GridBoundColumn>
                
             </Columns>
                
         </MasterTableView>
                                      
     </telerik:RadGrid> 
          </td>
      </tr>
       
      <tr>
          <td class="auto-style4"></td> 
          <td>
              <telerik:RadComboBox ID="cboRegNumber" runat="server" Width="219px" AutoPostBack="True" Visible="False"></telerik:RadComboBox>
             
          </td>
        </tr>
</table>
</asp:Content>
