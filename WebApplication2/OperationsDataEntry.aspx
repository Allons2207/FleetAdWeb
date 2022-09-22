<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="OperationsDataEntry.aspx.vb" Inherits="WebApplication2.OperationsDataEntry" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3 style="font-size:medium; color:gray "> Operations Data Entry </h3>
    <table>
        <tr><td colspan="4"><hr /></td></tr>  
        <tr>
         <td colspan="5">
             <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small" Width="100%"></asp:Label>
         </td>
        </tr>
        <tr>
            <td></td>
        </tr>
         <tr>
             <td colspan="4">
                 <table>
                     <tr><td>&nbsp</td></tr>
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
                         <td><telerik:RadComboBox ID="radMonth" runat="server" AutoPostBack="True"></telerik:RadComboBox></td>
                         <td>&nbsp</td>
                         <td>From Date</td>
                                    <td>
                                         <telerik:RadDatePicker ID="rdFromDate" runat="server" Culture="en-US" MinDate="1900-01-01" AutoPostBack="True">
<Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;"></Calendar>

<DateInput DisplayDateFormat="M/d/yyyy" DateFormat="M/d/yyyy" LabelWidth="40%" AutoPostBack="True">
<EmptyMessageStyle Resize="None"></EmptyMessageStyle>

<ReadOnlyStyle Resize="None"></ReadOnlyStyle>

<FocusedStyle Resize="None"></FocusedStyle>

<DisabledStyle Resize="None"></DisabledStyle>

<InvalidStyle Resize="None"></InvalidStyle>

<HoveredStyle Resize="None"></HoveredStyle>

<EnabledStyle Resize="None"></EnabledStyle>
</DateInput>

<DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                         </telerik:RadDatePicker>
                                     </td>
                                    <td>To Date</td>
                                    <td>
                                         <telerik:RadDatePicker ID="rdToDate" runat="server" Culture="en-US" MinDate="1900-01-01" AutoPostBack="True">
<Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;"></Calendar>

<DateInput DisplayDateFormat="M/d/yyyy" DateFormat="M/d/yyyy" LabelWidth="40%" AutoPostBack="True">
<EmptyMessageStyle Resize="None"></EmptyMessageStyle>

<ReadOnlyStyle Resize="None"></ReadOnlyStyle>

<FocusedStyle Resize="None"></FocusedStyle>

<DisabledStyle Resize="None"></DisabledStyle>

<InvalidStyle Resize="None"></InvalidStyle>

<HoveredStyle Resize="None"></HoveredStyle>

<EnabledStyle Resize="None"></EnabledStyle>
</DateInput>

<DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                         </telerik:RadDatePicker>
                                     </td>
                         <td>No. of Hours in the Month</td><td>
                                <asp:TextBox ID="txtMaxPossibleHrs" runat="server"></asp:TextBox></td>

                     </tr>
                     <tr>
                         
                         
                         <td >
                             Cost of Diesel per Litre </td><td>
                                <asp:TextBox ID="txtCostOfDieselPerLitre" runat="server"></asp:TextBox>
                         </td>
                        
                         
                     </tr>
                 </table>
             </td>
         </tr>
        <tr><td>&nbsp</td></tr>
         <tr>
            <td colspan="4">
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
                            <telerik:GridButtonColumn CommandName="View" FilterControlAltText="Filter View column" HeaderText="View" Text="View" UniqueName="View">
                </telerik:GridButtonColumn>
                <telerik:GridBoundColumn DataField="SurfaceEquipmentID" FilterControlAltText="Filter SurfaceEquipmentID column" HeaderText="SurfaceEquipmentID" UniqueName="SurfaceEquipmentID">
                            <ColumnValidationSettings>
                            <ModelErrorMessage Text=""></ModelErrorMessage>
                            </ColumnValidationSettings>
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="SurfaceEquipmentType" FilterControlAltText="Filter SurfaceEquipmentType column" HeaderText="SurfaceEquipmentType" UniqueName="SurfaceEquipmentType">
<ColumnValidationSettings>
<ModelErrorMessage Text=""></ModelErrorMessage>
</ColumnValidationSettings>
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="AssetNumber" FilterControlAltText="Filter AssetNumber column" HeaderText="AssetNumber" UniqueName="AssetNumber">
<ColumnValidationSettings>
<ModelErrorMessage Text=""></ModelErrorMessage>
</ColumnValidationSettings>
                </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Description" FilterControlAltText="Filter Description column" HeaderText="Description" UniqueName="Description">
                                <ColumnValidationSettings>
                                    <ModelErrorMessage Text="" />
                                </ColumnValidationSettings>
                            </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn DataField="OpeningHrs" FilterControlAltText="Filter OpeningHrs column" HeaderText="OpeningHrs" UniqueName="OpeningHrs">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtOpeningHrs" runat="server" Width="200px"></asp:TextBox>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="ClosingHrs" FilterControlAltText="Filter ClosingHrs column" HeaderText="ClosingHrs" UniqueName="ClosingHrs">
                                 <ItemTemplate>
                                    <asp:TextBox ID="txtClosingHrs" runat="server" Width="200px"></asp:TextBox>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn DataField="TotalHrs" FilterControlAltText="Filter TotalHrs column" HeaderText="TotalHrs" UniqueName="TotalHrs">
                                 <ItemTemplate>
                                    <asp:TextBox ID="txtTotalHrs" runat="server" Width="200px" Enabled="false"></asp:TextBox>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            
                             <telerik:GridTemplateColumn DataField="TotalFuel" FilterControlAltText="Filter TotalFuel column" HeaderText="TotalFuel" UniqueName="TotalFuel">
                                 <ItemTemplate>
                                    <asp:TextBox ID="txtTotalFuel" runat="server" Width="200px"></asp:TextBox>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                             <telerik:GridTemplateColumn DataField="FuelCosts" FilterControlAltText="Filter FuelCosts column" HeaderText="FuelCosts" UniqueName="FuelCosts">
                                 <ItemTemplate>
                                    <asp:TextBox ID="txtFuelCosts" runat="server" Width="200px" Enabled="false"></asp:TextBox>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>


                             <telerik:GridTemplateColumn DataField="SparesCosts" FilterControlAltText="Filter SparesCosts column" HeaderText="SparesCosts" UniqueName="SparesCosts">
                                 <ItemTemplate>
                                    <asp:TextBox ID="txtSparesCosts" runat="server" Width="200px"></asp:TextBox>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>


                             <telerik:GridTemplateColumn DataField="TotalCosts" FilterControlAltText="Filter TotalCosts column" HeaderText="TotalCosts" UniqueName="TotalCosts">
                                 <ItemTemplate>
                                    <asp:TextBox ID="txtTotalCosts" runat="server" Width="200px" Enabled="false"></asp:TextBox>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn DataField="ConsumptionPerHr" FilterControlAltText="Filter ConsumptionPerHr column" HeaderText="ConsumptionPerHr" UniqueName="ConsumptionPerHr">
                                 <ItemTemplate>
                                    <asp:TextBox ID="txtConsumptionPerHr" runat="server" Width="200px" Enabled="false"></asp:TextBox>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn DataField="CostPerHr" FilterControlAltText="Filter CostPerHr column" HeaderText="CostPerHr" UniqueName="CostPerHr">
                                 <ItemTemplate>
                                    <asp:TextBox ID="txtCostPerHr" runat="server" Width="200px" Enabled="false"></asp:TextBox>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                             <telerik:GridTemplateColumn DataField="MaintHrs" FilterControlAltText="Filter MaintHrs column" HeaderText="MaintHrs" UniqueName="MaintHrs">
                                 <ItemTemplate>
                                    <asp:TextBox ID="txtMaintHrs" runat="server" Width="200px"></asp:TextBox>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                              <telerik:GridTemplateColumn DataField="BrkDownHrs" FilterControlAltText="Filter BrkDownHrs column" HeaderText="BrkDownHrs" UniqueName="BrkDownHrs">
                                 <ItemTemplate>
                                    <asp:TextBox ID="txtBrkDownHrs" runat="server" Width="200px"></asp:TextBox>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                             <telerik:GridTemplateColumn DataField="TotalDwnTime" FilterControlAltText="Filter TotalDwnTime column" HeaderText="TotalDwnTime" UniqueName="TotalDwnTime">
                                 <ItemTemplate>
                                    <asp:TextBox ID="txtTotalDwnTime" runat="server" Width="200px" Enabled="false"></asp:TextBox>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                             <telerik:GridTemplateColumn DataField="AvailableHrs" FilterControlAltText="Filter AvailableHrs column" HeaderText="AvailableHrs" UniqueName="AvailableHrs">
                                 <ItemTemplate>
                                    <asp:TextBox ID="txtAvailableHrs" runat="server" Width="200px" Enabled="false"></asp:TextBox>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                             <telerik:GridTemplateColumn DataField="Availability" FilterControlAltText="Filter Availability column" HeaderText="Availability" UniqueName="Availability">
                                 <ItemTemplate>
                                    <asp:TextBox ID="txtAvailability" runat="server" Width="200px" Enabled="false"></asp:TextBox>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                        </Columns>

                        <AlternatingItemStyle BackColor="#66CCFF" />
                        <PagerStyle Mode="NextPrevNumericAndAdvanced" />
                    </MasterTableView>
                    <ClientSettings EnablePostBackOnRowClick="true" Selecting-AllowRowSelect="true">
                        <Selecting AllowRowSelect="True" />
                    </ClientSettings>
                    <FilterMenu EnableImageSprites="False">
                    </FilterMenu>
                </telerik:RadGrid>
            </td>
        </tr>
        <tr>
            <td>&nbsp</td>
        </tr>
        <tr>
             <td>

                  <asp:Button ID="btnAutoFill" runat="server" Text="Autofill Computable Fields" Width="241px" />&nbsp;&nbsp;&nbsp&nbsp
                 <asp:Button ID="btnSave" runat="server" Text="Save" Width="241px" />

                         </td>
        </tr>
        <tr><td>&nbsp</td></tr>
    </table>
</asp:Content>
