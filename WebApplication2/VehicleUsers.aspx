<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="VehicleUsers.aspx.vb" Inherits="WebApplication2.VehicleUsers" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style3 {
            width: 184px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <h3 style="font-size:medium; color:gray "> Vehicle Users</h3>
    <table style="margin-left:2%" >
         <tr>
         <td colspan="4">
             <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small" Width="100%"></asp:Label>
         </td>
        </tr>
        <tr><td>First Name</td><td> <asp:TextBox ID="txtFirstName" runat="server" Width="216px"></asp:TextBox></td> <td>Surname</td><td> <asp:TextBox ID="txtSurname" runat="server" Width="216px"></asp:TextBox></td>  </tr>
        <tr><td>Department</td><td> <asp:TextBox ID="txtDepartment" runat="server" Width="216px"></asp:TextBox></td><td>Designation</td><td> <asp:TextBox ID="txtDesignation" runat="server" Width="216px"></asp:TextBox></td></tr>
        <tr><td>National ID #</td><td> <asp:TextBox ID="txtNationalIDNumber" runat="server" Width="216px"></asp:TextBox></td><td>License Number</td><td> <asp:TextBox ID="txtLicenseNumba" runat="server" Width="216px"></asp:TextBox></td></tr>
        <tr><td>Defensive License Expiry Date</td><td>
                                         <telerik:RadDatePicker ID="rdExpiryDate" runat="server" Culture="en-US" MinDate="1900-01-01"></telerik:RadDatePicker>
                                     </td><td></td><td></td></tr>
        <tr><td></td><td></td><td></td><td></td></tr>
        <tr><td>Application Date</td><td>
                                         <telerik:RadDatePicker ID="rdApplicationDate" runat="server" Culture="en-US" MinDate="1900-01-01"></telerik:RadDatePicker>
                                     </td><td>Application Form #</td><td> <asp:TextBox ID="txtApplicationFormNumber" runat="server" Width="216px"></asp:TextBox></td></tr>
        <tr><td></td><td></td><td></td><td></td></tr>
        <tr><td>Allocation Status</td><td>
                                         <telerik:RadComboBox ID="cboAllocationStatus" runat="server" Width="222px"></telerik:RadComboBox>
                                         </td><td></td><td></td></tr>
        <tr><td></td><td></td><td></td><td></td></tr>
        <tr><td colspan="4"><hr /></td></tr>       
        <tr><td></td><td colspan="3">
              <asp:Button ID="cmdAddNew" runat="server" Text="Save" Width="168px" />&nbsp
                            <asp:Button ID="cmdClear" runat="server" Text="Clear" Width="168px" />
            &nbsp;&nbsp
                 <asp:Button ID="cmdDelete" runat="server" Text="Delete" Width="214px" />
                            </td></tr>
         <tr><td colspan="4"><hr /></td></tr>
        
         <tr>
            <td></td>
            <td colspan="3">
                <telerik:RadTabStrip ID="PageLevelTabs" runat="server" MultiPageID="PageLevelMultiPage1" Width="100%"  CausesValidation="False" SelectedIndex="0">
                    <Tabs>
                        <telerik:RadTab runat="server" Text="Medicals" Value="Personal Details" PageViewID="RadPageViewMedicals" Selected="True" >
                        </telerik:RadTab>
                        <telerik:RadTab runat="server" Text="Retests" Value="Subjects" PageViewID="RadPageViewRetests">
                        </telerik:RadTab>
                        <telerik:RadTab runat="server" Text="Defensive Driver's Certificate" Value="Attendance" PageViewID="RadPageViewDDC" >
                        </telerik:RadTab>  
                        <telerik:RadTab runat="server" Text="Vehicle Allocation History" Value="VehicleAllocation" PageViewID="RadPageViewAllocations" Selected="True" >
                        </telerik:RadTab>                     
                    </Tabs>
               </telerik:RadTabStrip>
            </td>
        </tr>
        <tr>
            <td colspan="4">
                <asp:Label ID="lblMultipageLabels" runat="server" Text="Medicals" Font-Bold="True"></asp:Label>
            </td>
        </tr>
        <tr>
            <td></td>
            <td colspan="3">
                  <telerik:RadMultiPage ID="PageLevelMultiPage1" runat="server" Width="100%" SelectedIndex="0">
                    <telerik:RadPageView ID="RadPageViewMedicals" runat="server">
                        <table>
                             <tr><td>Examination Date</td><td>
                                         <telerik:RadDatePicker ID="rdMedicalsDateIssued" runat="server" Culture="en-US" MinDate="1900-01-01"></telerik:RadDatePicker>
                                  </td><td>Expiry Date</td>
                                 <td>
                                         <telerik:RadDatePicker ID="rdMedicalsExpiryDate" runat="server" Culture="en-US" MinDate="1900-01-01"></telerik:RadDatePicker>
                                 </td>
                             </tr>
                             <tr><td colspan="5"><hr /></td></tr>
                            <tr><td>&nbsp</td><td colspan="4" style="text-align:center">
                                    <asp:Button ID="cmdSaveMedical" runat="server" Text="Save" Width="150px" />&nbsp;&nbsp
                                    <asp:Button ID="cmdbtnDeleteMedical" runat="server" Text="Delete" Width="150px" />
                                </td></tr>
                        </table>
                    </telerik:RadPageView>         
                    <telerik:RadPageView ID="RadPageViewRetests" runat="server">
                        <table>
                             <tr><td>Date Retested</td><td>
                                         <telerik:RadDatePicker ID="radRetestedDate" runat="server" Culture="en-US" MinDate="1900-01-01"></telerik:RadDatePicker>
                                     </td><td>Expiry Date</td><td class="auto-style3">
                                         <telerik:RadDatePicker ID="radRetestedExpiryDate" runat="server" Culture="en-US" MinDate="1900-01-01"></telerik:RadDatePicker>
                                     </td></tr>
                            <tr><td colspan="5"><hr /></td></tr>
                            <tr><td>&nbsp</td><td colspan="4" style="text-align:center">
                                    <asp:Button ID="cmdSaveRetest" runat="server" Text="Save" Width="150px" />&nbsp;&nbsp
                                    <asp:Button ID="cmdDeleteRetest" runat="server" Text="Delete" Width="150px" />
                                </td></tr>
                        </table>
                    </telerik:RadPageView>
                    <telerik:RadPageView ID="RadPageViewDDC" runat="server">
                              <table>
                             <tr><td>Date Tested</td><td>
                                         <telerik:RadDatePicker ID="radDateDDCTested" runat="server" Culture="en-US" MinDate="1900-01-01"></telerik:RadDatePicker>
                                     </td><td>Expiry Date</td><td class="auto-style3">
                                         <telerik:RadDatePicker ID="radDateDDCExpiry" runat="server" Culture="en-US" MinDate="1900-01-01"></telerik:RadDatePicker>
                                     </td></tr>
                            <tr><td colspan="5"><hr /></td></tr>
                            <tr><td>&nbsp</td><td colspan="4" style="text-align:center">
                                    <asp:Button ID="cmdSaveDDC" runat="server" Text="Save" Width="150px" />&nbsp;&nbsp
                                    <asp:Button ID="cmdDeleteDDC" runat="server" Text="Delete" Width="150px" />
                                </td></tr>
                        </table>
                    </telerik:RadPageView>
                    <telerik:RadPageView ID="RadPageViewAllocations" runat="server">
                        <table>
        <tr><td colspan="3" width="100%">
          <telerik:RadGrid ID="gwList" runat="server"  BackColor="White"  AllowPaging="True"  DisplayMode="FirstLastPreviousNextNumeric, Text" PageSize="100" Width="100%"
         BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" AllowSorting="True" GroupPanelPosition="Top"  ForeColor="Black" AutoGenerateColumns="False" AllowMultiRowSelection="True" ClientSettings-Selecting-AllowRowSelect="true" >
                      
<ClientSettings>
<Selecting AllowRowSelect="True"></Selecting>
</ClientSettings>

              <AlternatingItemStyle BackColor="#E9E9E9" />

           <MasterTableView>
             <Columns>
                 
                 <telerik:GridBoundColumn DataField="allocationMode" FooterText="AllocationStatus" HeaderText="AllocationStatus"
                            UniqueName="AllocationStatus" FilterControlAltText="Filter AllocationStatus column">  </telerik:GridBoundColumn>
                 <telerik:GridBoundColumn DataField="dtDate" FilterControlAltText="Filter dtDate column" HeaderText="Date" UniqueName="dtDate">
                 </telerik:GridBoundColumn>
                 <telerik:GridBoundColumn FilterControlAltText="Filter Make column" HeaderText="Make" UniqueName="Make" DataField="Make">
                 </telerik:GridBoundColumn>
                 <telerik:GridBoundColumn FilterControlAltText="Filter Model column" HeaderText="Model" UniqueName="Model" DataField="Model">
                 </telerik:GridBoundColumn>
                 <telerik:GridBoundColumn FilterControlAltText="Filter RegistrationNumber column" HeaderText="Reg #" UniqueName="RegistrationNumber" DataField="RegistrationNumber">
                 </telerik:GridBoundColumn>
                 <telerik:GridBoundColumn FilterControlAltText="Filter FleetId column" HeaderText="FleetId" UniqueName="FleetId" DataField="FleetId">
                 </telerik:GridBoundColumn>
             </Columns>
              
         </MasterTableView>
                                 
     </telerik:RadGrid> 
            </td></tr>

                        </table>
                    </telerik:RadPageView>
                    <telerik:RadPageView ID="RadPageView6" runat="server">
                    </telerik:RadPageView>
                    <telerik:RadPageView ID="RadPageView7" runat="server">
                    </telerik:RadPageView>
                  </telerik:RadMultiPage>
            </td>            
        </tr>
    </table>
</asp:Content>
