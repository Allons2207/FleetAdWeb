<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="VehiclesBreakdownsByComponent.aspx.vb" Inherits="WebApplication2.VehiclesBreakdownsByComponent" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
      <h3 style="font-size:medium; color:gray "> Vehicles Downtime Tracking by Breakdown Modes </h3>
   <table style="margin-left:2%" width="70%">
       <tr><td colspan="4"><hr /></td></tr>      
        <tr>
         <td colspan="4">
             <asp:Label ID="lblMsg" runat="server"  Font-Italic="True" Font-Size="Small" Width ="100%"></asp:Label>
         </td>
        </tr>
       <tr><td>&nbsp</td></tr>
       <tr><td>
           <table>
                 <tr><td>Search by Fleet ID.</td><td><asp:TextBox ID="txtFleetIDSearch" runat="server" Width="211px"></asp:TextBox></td><td><asp:Button ID="btnSearchByFleetID" runat="server" Text="Find" Width="150px" /></td></tr>
             <tr><td>Search by Reg No.</td><td><asp:TextBox ID="txtRegNo" runat="server" Width="211px"></asp:TextBox></td><td><asp:Button ID="cmdFindVehicleDetsByRegNum" runat="server" Text="Find" Width="150px" /></td></tr>
              <tr>
             <td>Fleet ID</td> <td> <asp:TextBox ID="txtFleetID" runat="server" Width="211px" Enabled="False"></asp:TextBox></td>
        </tr>
        <tr>
            <td>Make</td> <td> <asp:TextBox ID="txtMake" runat="server" Width="211px" Enabled="False"></asp:TextBox></td> <td>Model</td> <td> <asp:TextBox ID="txtModel" runat="server" Width="211px" Enabled="False"></asp:TextBox></td>
        </tr>
                <tr><td colspan="4"><hr /></td></tr>  
        <tr>
            <td>&nbsp;</td> <td> &nbsp;</td> <td>&nbsp;</td> <td> &nbsp;</td>
        </tr> 
                   
                   <tr><td>Reporting Year</td>
                         <td> 
                            <telerik:RadComboBox ID="radYear" runat="server">
                            <Items>
                                 <telerik:RadComboBoxItem runat="server" Text="2017" Value="2017" />
                                 <telerik:RadComboBoxItem runat="server" Text="2018" Value="2018" />
                                 <telerik:RadComboBoxItem runat="server" Text="2019" Value="2019" />
                                 <telerik:RadComboBoxItem runat="server" Text="2020" Value="2020" />
                                 <telerik:RadComboBoxItem runat="server" Text="2021" Value="2021" />
                                 <telerik:RadComboBoxItem runat="server" Text="2022" Value="2022" />
                                 <telerik:RadComboBoxItem runat="server" Text="2023" Value="2023" />
                                 <telerik:RadComboBoxItem runat="server" Text="2024" Value="2024" />
                                 <telerik:RadComboBoxItem runat="server" Text="2025" Value="2025" />
                           </Items>
                           </telerik:RadComboBox> </td>
                         <td>Reporting Month</td>
                         <td><telerik:RadComboBox ID="radMonth" runat="server" AutoPostBack="True">
                             <Items>
                                 <telerik:RadComboBoxItem runat="server" Text="--Select--" Value="--Select--" />
                                 <telerik:RadComboBoxItem runat="server" Text="January" Value="1" />
                                 <telerik:RadComboBoxItem runat="server" Text="February" Value="2" />
                                 <telerik:RadComboBoxItem runat="server" Text="March" Value="3" />
                                 <telerik:RadComboBoxItem runat="server" Text="April" Value="4" />
                                 <telerik:RadComboBoxItem runat="server" Text="May" Value="5" />
                                 <telerik:RadComboBoxItem runat="server" Text="June" Value="6" />
                                 <telerik:RadComboBoxItem runat="server" Text="July" Value="7" />
                                 <telerik:RadComboBoxItem runat="server" Text="August" Value="8" />
                                 <telerik:RadComboBoxItem runat="server" Text="September" Value="9" />
                                 <telerik:RadComboBoxItem runat="server" Text="October" Value="10" />
                                 <telerik:RadComboBoxItem runat="server" Text="November" Value="11" />
                                 <telerik:RadComboBoxItem runat="server" Text="December" Value="12" />
                             </Items>
                             </telerik:RadComboBox></td>
               </tr>
       <tr><td>From Date</td><td>
                                         <telerik:RadDatePicker ID="rdFromDate" runat="server" Culture="en-US" MinDate="2000-01-01"></telerik:RadDatePicker>
                                     </td>
           <td>To Date</td><td>
                                         <telerik:RadDatePicker ID="rdToDate" runat="server" Culture="en-US" MinDate="2000-01-01"></telerik:RadDatePicker>
                                     </td>
       </tr>
       <tr><td></td></tr>
               <tr><td></td><td>

                  <asp:Button ID="btnAutoFill" runat="server" Text="Load" Width="168px" />

                         </td></tr>
               <tr><td></td></tr>
           </table>
           </td></tr>

       <tr><td colspan="4">
                <telerik:RadGrid ID="gwGrid" runat="server" AllowFilteringByColumn="True" AllowMultiRowSelection="True" AutoGenerateColumns="False" CellPadding="0" GroupPanelPosition="Top" Height="100%" PageSize="20" Width="80%">
                    <MasterTableView AllowPaging="True" AlternatingItemStyle-BackColor="#66ccff" PagerStyle-Mode="NextPrevNumericAndAdvanced">
                        <CommandItemSettings ExportToPdfText="Export to Pdf" />
                        <RowIndicatorColumn>
                            <HeaderStyle Width="20px" />
                        </RowIndicatorColumn>
                        <ExpandCollapseColumn>
                            <HeaderStyle Width="20px" />
                        </ExpandCollapseColumn>
                        <EditFormSettings>
                            <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                            </EditColumn>
                        </EditFormSettings>
                        <Columns>
                            <telerik:GridBoundColumn DataField="dtDate" FilterControlAltText="Filter dtDate column" HeaderText="dtDate" UniqueName="dtDate">
                                <ColumnValidationSettings>
                                    <ModelErrorMessage Text="" />
                                </ColumnValidationSettings>
                            </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn DataField="Maintenance" FilterControlAltText="Filter Maintenance column" HeaderText="Maintenance" UniqueName="Maintenance">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtMaintenance" runat="server" Width="200px"></asp:TextBox>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="Breakdowns" FilterControlAltText="Filter Breakdowns column" HeaderText="Breakdowns" UniqueName="Breakdowns">
                                 <ItemTemplate>
                                    <asp:TextBox ID="txtBreakdowns" runat="server" Width="200px" Enabled="false"></asp:TextBox>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="Available" FilterControlAltText="Filter Available column" HeaderText="Available" UniqueName="Available">
                                 <ItemTemplate>
                                    <asp:TextBox ID="txtAvailable" runat="server" Width="200px" Enabled="false"></asp:TextBox>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                              <telerik:GridTemplateColumn DataField="Availability" FilterControlAltText="Filter Availability column" HeaderText="Availability" UniqueName="Availability">
                                 <ItemTemplate>
                                    <asp:TextBox ID="txtAvailability" runat="server" Width="200px" Enabled="false"></asp:TextBox>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                             <telerik:GridTemplateColumn DataField="Engine" FilterControlAltText="Filter Engine column" HeaderText="Engine" UniqueName="Engine">
                                 <ItemTemplate>
                                    <asp:TextBox ID="txtEngine" runat="server" Width="200px"></asp:TextBox>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                             <telerik:GridTemplateColumn DataField="Windscreen_Replacement" FilterControlAltText="Filter Windscreen_Replacement column" HeaderText="Windscreen_Replacement" UniqueName="Windscreen_Replacement">
                                 <ItemTemplate>
                                    <asp:TextBox ID="txtWindscreen_Replacement" runat="server" Width="200px"></asp:TextBox>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                             <telerik:GridTemplateColumn DataField="Steering_Brakes" FilterControlAltText="Filter Steering_Brakes column" HeaderText="Steering_Brakes" UniqueName="Steering_Brakes">
                                 <ItemTemplate>
                                    <asp:TextBox ID="txtSteering_Brakes" runat="server" Width="200px"></asp:TextBox>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                             <telerik:GridTemplateColumn DataField="Pneumatics_Hose_Burst" FilterControlAltText="Filter Pneumatics_Hose_Burst column" HeaderText="Pneumatics_Hose_Burst" UniqueName="Pneumatics_Hose_Burst">
                                 <ItemTemplate>
                                    <asp:TextBox ID="txtPneumatics_Hose_Burst" runat="server" Width="200px"></asp:TextBox>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                             <telerik:GridTemplateColumn DataField="Electrical_Batteries" FilterControlAltText="Filter Electrical_Batteries column" HeaderText="Electrical_Batteries" UniqueName="Electrical_Batteries">
                                 <ItemTemplate>
                                    <asp:TextBox ID="txtElectrical_Batteries" runat="server" Width="200px"></asp:TextBox>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>   

                             <telerik:GridTemplateColumn DataField="Oil_analysis_results" FilterControlAltText="Filter Oil_analysis_results column" HeaderText="Oil_analysis_results" UniqueName="Oil_analysis_results">
                                 <ItemTemplate>
                                    <asp:TextBox ID="txtOil_analysis_results" runat="server" Width="200px"></asp:TextBox>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                             <telerik:GridTemplateColumn DataField="Body_repairs_Accident_damage" FilterControlAltText="Filter Body_repairs_Accident_damage column" HeaderText="Body_repairs_Accident_damage" UniqueName="Body_repairs_Accident_damage">
                                 <ItemTemplate>
                                    <asp:TextBox ID="txtBody_repairs_Accident_damage" runat="server" Width="200px"></asp:TextBox>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn DataField="Tyre_puncture_replacement" FilterControlAltText="Filter Tyre_puncture_replacement column" HeaderText="Tyre_puncture_replacement" UniqueName="Tyre_puncture_replacement">
                                 <ItemTemplate>
                                    <asp:TextBox ID="txtTyre_puncture_replacement" runat="server" Width="200px"></asp:TextBox>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn DataField="Cooling_System_Radiator" FilterControlAltText="Filter Cooling_System_Radiator column" HeaderText="Cooling_System_Radiator" UniqueName="Cooling_System_Radiator">
                                 <ItemTemplate>
                                    <asp:TextBox ID="txtCooling_System_Radiator" runat="server" Width="200px"></asp:TextBox>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                             <telerik:GridTemplateColumn DataField="Drive_train_system" FilterControlAltText="Filter Drive_train_system column" HeaderText="Drive_train_system" UniqueName="Drive_train_system">
                                 <ItemTemplate>
                                    <asp:TextBox ID="txtDrive_train_system" runat="server" Width="200px"></asp:TextBox>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                             <telerik:GridTemplateColumn DataField="Rear_Suspension" FilterControlAltText="Filter Rear_Suspension column" HeaderText="Rear_Suspension" UniqueName="Rear_Suspension">
                                 <ItemTemplate>
                                    <asp:TextBox ID="txtRear_Suspension" runat="server" Width="200px"></asp:TextBox>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn DataField="Front_Suspension" FilterControlAltText="Filter Front_Suspension column" HeaderText="Front_Suspension" UniqueName="Front_Suspension">
                                 <ItemTemplate>
                                    <asp:TextBox ID="txtFront_Suspension" runat="server" Width="200px"></asp:TextBox>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                              <telerik:GridTemplateColumn DataField="Status_report" FilterControlAltText="Filter Status_report column" HeaderText="Status_report" UniqueName="Status_report">
                                 <ItemTemplate>
                                    <asp:TextBox ID="txtStatus_report" runat="server" Width="200px"></asp:TextBox>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                              <telerik:GridTemplateColumn DataField="Mounted_Crane" FilterControlAltText="Filter Mounted_Crane column" HeaderText="Mounted_Crane" UniqueName="Mounted_Crane">
                                 <ItemTemplate>
                                    <asp:TextBox ID="txtMounted_Crane" runat="server" Width="200px"></asp:TextBox>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                             <telerik:GridTemplateColumn DataField="Trailers_FifthWheel_Repais" FilterControlAltText="Filter Trailers_FifthWheel_Repais column" HeaderText="Trailers_FifthWheel_Repais" UniqueName="Trailers_FifthWheel_Repais">
                                 <ItemTemplate>
                                    <asp:TextBox ID="txtTrailers_FifthWheel_Repais" runat="server" Width="200px"></asp:TextBox>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>                  
	
                        </Columns>

                        <AlternatingItemStyle BackColor="#66CCFF" />
                        <PagerStyle Mode="NextPrevNumericAndAdvanced" />
                    </MasterTableView>
                    <ExportSettings FileName="VehiclesDowntimeByComponent">
                    </ExportSettings>
                    <ClientSettings EnablePostBackOnRowClick="true" Selecting-AllowRowSelect="true">
                        <Selecting AllowRowSelect="True" />
                    </ClientSettings>
                    <FilterMenu EnableImageSprites="False">
                    </FilterMenu>
                </telerik:RadGrid>
            </td></tr>
       <tr><td></td></tr>
        <tr><td>

                  <asp:Button ID="btnProcess" runat="server" Text="Process" Width="168px" /> &nbsp;&nbsp;&nbsp&nbsp
            <asp:Button ID="btnSave" runat="server" Text="Save" Width="168px" />&nbsp;&nbsp;&nbsp&nbsp
            <asp:Button ID="btnExportToExcel" runat="server" Text="Export To Excel" Width="168px" />
                         </td></tr>
               <tr><td></td></tr>
       </table>
</asp:Content>
