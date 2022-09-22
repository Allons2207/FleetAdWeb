<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="OdometerReadings.aspx.vb" Inherits="WebApplication2.OdometerReadings" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style3 {
            height: 30px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3 style="font-size:medium; color:gray "> Opening and Closing Odometer Readings </h3>
    <table width="90%" style="margin-left:2%" >
        <tr>
         
           <td class="auto-style3">Year  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <telerik:RadComboBox ID="radYear" runat="server" AutoPostBack="True">
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
            </telerik:RadComboBox> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Month &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<telerik:RadComboBox ID="radMonth" runat="server" AutoPostBack="True"></telerik:RadComboBox>
               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            
             <b>Task  &nbsp;&nbsp</b>   <telerik:RadComboBox ID="cboTask" runat="server" AutoPostBack="True" Width="340px">
            <Items>
                <telerik:RadComboBoxItem runat="server" Text="View Odometer Readings" Value="View Odometer Readings" />
                <telerik:RadComboBoxItem runat="server" Text="Capture Opening Odometer Readings" Value="Capture Opening Odometer Readings" />
                <telerik:RadComboBoxItem runat="server" Text="Capture Closing Odometer Readings" Value="Capture Closing Odometer Readings" />
            </Items>
            </telerik:RadComboBox>   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  </td>
       </tr>
       <tr>
         <td colspan="5">
             <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small" Width="100%"></asp:Label>
         </td>
        </tr>
        <tr>
            <td colspan="5">

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
                            <telerik:GridBoundColumn DataField="FleetId" FilterControlAltText="Filter FleetId column" HeaderText="FleetId" UniqueName="FleetId">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Make" FilterControlAltText="Filter Make column" HeaderText="Make" UniqueName="Make">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Model" FilterControlAltText="Filter Model column" HeaderText="Model" UniqueName="Model">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="VehicleCategory" FilterControlAltText="Filter VehicleCategory column" HeaderText="VehicleCategory" UniqueName="VehicleCategory">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="UserCategory" FilterControlAltText="Filter UserCategory column" HeaderText="UserCategory" UniqueName="UserCategory">
                            </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn DataField="OpeningReading" FilterControlAltText="Filter OpeningReading column" HeaderText="OpeningReading" UniqueName="OpeningReading">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtOpeningReading" runat="server" Width="200px"></asp:TextBox>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="ClosingReading" FilterControlAltText="Filter ClosingReading column" HeaderText="ClosingReading" UniqueName="ClosingReading">
                                 <ItemTemplate>
                                    <asp:TextBox ID="txtClosingReading" runat="server" Width="200px"></asp:TextBox>
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
         <td>
             <asp:Label ID="lblMgs2" runat="server" Text=""  Font-Italic="True" Font-Size="Small"></asp:Label>
         </td>
        </tr>
        <tr>
            <td colspan="5">
                  <asp:Button ID="btnSave" runat="server" Text="Save" Width="168px" Visible="False" /></td>
        </tr>
    </table>

</asp:Content>
