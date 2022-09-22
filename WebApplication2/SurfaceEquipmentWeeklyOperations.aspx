﻿<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="SurfaceEquipmentWeeklyOperations.aspx.vb" Inherits="WebApplication2.SurfaceEquipmentWeeklyOperations" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <h3 style="font-size:medium; color:gray "> Surface Equipment Weekly Operations Data Entry </h3>
    <table>
        <tr><td colspan="4"><hr /></td></tr>  
        <tr>
         <td colspan="4">
             <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small" Width="100%"></asp:Label>
         </td>
        </tr>
        
         <tr>
             <td colspan="4">
                 <table>
                     <tr><td>&nbsp</td></tr>
                     <tr>
                         <td><b>Week Dates :</b></td>                        
                         <td>From Date</td>
                                    <td>
                                         <telerik:RadDatePicker ID="rdFromDate" runat="server" Culture="en-US" MinDate="1900-01-01"></telerik:RadDatePicker>
                                     </td>
                                    <td>To Date</td>
                                    <td>
                                         <telerik:RadDatePicker ID="rdToDate" runat="server" Culture="en-US" MinDate="1900-01-01"></telerik:RadDatePicker>
                                     </td>
                     </tr>
                     <tr>                      
                         <td >
                             &nbsp </td><td>&nbsp </td>                        
                     </tr>
                 </table>
             </td>
         </tr>
        <tr><td>&nbsp</td></tr>
         <tr>
            <td colspan="4">
                <telerik:RadGrid ID="gwGrid" runat="server" AllowFilteringByColumn="True" AllowMultiRowSelection="True" AutoGenerateColumns="False" CellPadding="0" GroupPanelPosition="Top" Height="100%" PageSize="2" Width="80%">
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
                            <telerik:GridButtonColumn CommandName="View" FilterControlAltText="Filter View column" HeaderText="View" Text="View" UniqueName="View"> </telerik:GridButtonColumn>
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

                            <telerik:GridTemplateColumn DataField="TotalHrs" FilterControlAltText="Filter TotalHrs column" HeaderText="TotalRunningHrs" UniqueName="TotalHrs">
                                 <ItemTemplate>
                                    <asp:TextBox ID="txtTotalHrs" runat="server" Width="200px" Enabled="false"></asp:TextBox>
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

                             <telerik:GridTemplateColumn DataField="PlannedTime" FilterControlAltText="Filter PlannedTime column" HeaderText="PlannedTime" UniqueName="PlannedTime">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtPlannedTime" runat="server" Width="200px" Enabled="false"></asp:TextBox>
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

                    <ExportSettings FileName="WeeklyOperations">
                    </ExportSettings>

                    <ClientSettings EnablePostBackOnRowClick="true" Selecting-AllowRowSelect="true">
                        <Selecting AllowRowSelect="True" />
                    </ClientSettings>
                    <FilterMenu EnableImageSprites="False"> </FilterMenu>
                </telerik:RadGrid>

            </td>
        </tr>
        <tr>
            <td>&nbsp</td>
        </tr>
        <tr>
             <td>

                  <asp:Button ID="btnAutoFill" runat="server" Text="Autofill Computed Values" Width="223px" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp
                   <asp:Button ID="btnSave" runat="server" Text="Save" Width="223px" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp
                 <asp:Button ID="btnExportToExcel" runat="server" Text="Export To Excel" Width="168px" />
                         </td>
        </tr>
        <tr><td>&nbsp</td></tr>
    </table>
</asp:Content>
