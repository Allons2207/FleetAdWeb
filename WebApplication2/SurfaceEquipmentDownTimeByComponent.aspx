<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="SurfaceEquipmentDownTimeByComponent.aspx.vb" Inherits="WebApplication2.SurfaceEquipmentDownTimeByComponent" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <h3 style="font-size:medium; color:gray ">Surface Equipment Downtime Tracking by Breakdown Modes </h3>
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
                <tr><td>Equipment Category</td><td><telerik:radcombobox ID="cboEquipmentCategory" runat="server" AutoPostBack="True">
            </telerik:radcombobox></td>
      <td>Equipment Type</td><td><telerik:radcombobox ID="cboAssetType" runat="server" AutoPostBack="True"></telerik:radcombobox></td></tr>
      <tr><td style="vertical-align:top">Asset ID</td><td style="vertical-align:top"><telerik:radcombobox ID="cboAssetNumber" runat="server" AutoPostBack="True" style="height: 16px"></telerik:radcombobox></td>
      <td style="vertical-align:top">Description</td><td> <asp:TextBox ID="txtDescription" runat="server" Width="390px" Height="94px" TextMode="MultiLine"></asp:TextBox></td></tr>

       <tr><td><asp:TextBox ID="txtSurfaceEquipmentID" runat="server" Width="81px" Visible="False"></asp:TextBox></td></tr>
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
                                         <telerik:RadDatePicker ID="rdFromDate" runat="server" Culture="en-US" MinDate="1900-01-01"></telerik:RadDatePicker>
                                     </td>
           <td>To Date</td><td>
                                         <telerik:RadDatePicker ID="rdToDate" runat="server" Culture="en-US" MinDate="1900-01-01"></telerik:RadDatePicker>
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
                <telerik:RadGrid ID="gwGrid" runat="server" AllowFilteringByColumn="True" AllowMultiRowSelection="True" AutoGenerateColumns="False" CellPadding="0" GroupPanelPosition="Top" Height="100%" PageSize="30" Width="80%">
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
                             <telerik:GridTemplateColumn DataField="Bucket_Ripper_repair" FilterControlAltText="Filter Bucket_Ripper_repair column" HeaderText="Bucket_Ripper_repair" UniqueName="Bucket_Ripper_repair">
                                 <ItemTemplate>
                                    <asp:TextBox ID="txtBucket_Ripper_repair" runat="server" Width="200px"></asp:TextBox>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                             <telerik:GridTemplateColumn DataField="Power_Train_System]" FilterControlAltText="Filter Power_Train_System column" HeaderText="Power_Train_System" UniqueName="Power_Train_System">
                                 <ItemTemplate>
                                    <asp:TextBox ID="txtPower_Train_System" runat="server" Width="200px"></asp:TextBox>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn DataField="Steering_Brakes" FilterControlAltText="Filter Steering_Brakes column" HeaderText="Steering_Brakes" UniqueName="Steering_Brakes">
                                 <ItemTemplate>
                                    <asp:TextBox ID="txtSteering_Brakes" runat="server" Width="200px"></asp:TextBox>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                             <telerik:GridTemplateColumn DataField="Hydraulics_Hose_Burst" FilterControlAltText="Filter Hydraulics_Hose_Burst column" HeaderText="Hydraulics_Hose_Burst" UniqueName="Hydraulics_Hose_Burst">
                                 <ItemTemplate>
                                    <asp:TextBox ID="txtHydraulics_Hose_Burst" runat="server" Width="200px"></asp:TextBox>
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

                            <telerik:GridTemplateColumn DataField="Undercarriage" FilterControlAltText="Filter Undercarriage column" HeaderText="Undercarriage" UniqueName="Undercarriage">
                                 <ItemTemplate>
                                    <asp:TextBox ID="txtUndercarriage" runat="server" Width="200px"></asp:TextBox>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn DataField="Boom_assembly_repairs" FilterControlAltText="Filter Boom_assembly_repairs column" HeaderText="Boom_assembly_repairs" UniqueName="Boom_assembly_repairs">
                                 <ItemTemplate>
                                    <asp:TextBox ID="txtBoom_assembly_repairs" runat="server" Width="200px"></asp:TextBox>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                             <telerik:GridTemplateColumn DataField="Status_report" FilterControlAltText="Filter Status_report column" HeaderText="Status_report" UniqueName="Status_report">
                                 <ItemTemplate>
                                    <asp:TextBox ID="txtStatus_report" runat="server" Width="200px"></asp:TextBox>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

	                        <telerik:GridTemplateColumn DataField="Mast_Assembly_Fork_Carriage_repairs" FilterControlAltText="Filter Mast_Assembly_Fork_Carriage_repairs column" HeaderText="Mast_Assembly_Fork_Carriage_repairs" UniqueName="Mast_Assembly_Fork_Carriage_repairs">
                                 <ItemTemplate>
                                    <asp:TextBox ID="txtMast_Assembly_Fork_Carriage_repairs" runat="server" Width="200px"></asp:TextBox>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn DataField="Loading_Chains" FilterControlAltText="Filter Loading_Chains column" HeaderText="Loading_Chains" UniqueName="Loading_Chains">
                                 <ItemTemplate>
                                    <asp:TextBox ID="txtLoading_Chains" runat="server" Width="200px"></asp:TextBox>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                             <telerik:GridTemplateColumn DataField="Blower_bearing_repairs_Outrigger" FilterControlAltText="Filter Blower_bearing_repairs_Outrigger column" HeaderText="Blower_bearing_repairs_Outrigger" UniqueName="Blower_bearing_repairs_Outrigger">
                                 <ItemTemplate>
                                    <asp:TextBox ID="txtBlower_bearing_repairs_Outrigger" runat="server" Width="200px"></asp:TextBox>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn DataField="Backhoe_repairs_Counter_weights" FilterControlAltText="Filter Backhoe_repairs_Counter_weights column" HeaderText="Backhoe_repairs_Counter_weights" UniqueName="Backhoe_repairs_Counter_weights">
                                 <ItemTemplate>
                                    <asp:TextBox ID="txtBackhoe_repairs_Counter_weights" runat="server" Width="200px"></asp:TextBox>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>


                           
	
                        </Columns>

                        <AlternatingItemStyle BackColor="#66CCFF" />
                        <PagerStyle Mode="NextPrevNumericAndAdvanced" />
                    </MasterTableView>
                    <ExportSettings FileName="DowntimeByComponent">
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

                  <asp:Button ID="btnProcess" runat="server" Text="Autofill Computable Fields" Width="229px" /> &nbsp;&nbsp;&nbsp&nbsp
            <asp:Button ID="btnSave" runat="server" Text="Save" Width="168px" />&nbsp;&nbsp;&nbsp;&nbsp
            <asp:Button ID="btnExportToExcel" runat="server" Text="Export To Excel" Width="168px" />
                         </td></tr>
               <tr><td></td></tr>
       </table>
</asp:Content>
