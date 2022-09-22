<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="FuelSuppliedByMonthByType.aspx.vb" Inherits="WebApplication2.FuelSuppliedByMonthByType" maintainScrollPositionOnPostBack="true" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
  
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

     <div class="demo-container size-wide"  style="margin-left:2%">
         <telerik:RadSkinManager ID="RadSkinManager1" runat="server" ShowChooser="true" />
         <table width="90%" >
             <tr><td><asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small" Width="100%"></asp:Label></td></tr>
              <tr><td><hr /></td></tr>
            <tr><td>
                <asp:Label ID="Label1" runat="server" Text="Total Fuel Supplied by Month by Fuel Type" Width="100%" BackColor="#FFFF99" Font-Bold="True" Font-Size="Small" ForeColor="Black" Height="30px"></asp:Label>
                </td></tr>
             <tr><td>
                  <telerik:RadHtmlChart runat="server" ID="RadHtmlChart1" Height="400px" Width="800px">
              <PlotArea>
                <Series>
                    <telerik:ColumnSeries DataFieldY="Diesel">
                        <LabelsAppearance RotationAngle="-90" />
                        <TooltipsAppearance Color="White" />
                    </telerik:ColumnSeries>
                </Series>
                   <Series>
                    <telerik:ColumnSeries DataFieldY="Petrol">
                        <LabelsAppearance RotationAngle="-90" />
                        <TooltipsAppearance Color="White" />
                    </telerik:ColumnSeries>
                </Series>
                <XAxis DataLabelsField="mMonth">
                    <TitleAppearance Text="Month">
                        <TextStyle Margin="20" />
                    </TitleAppearance>
                    <LabelsAppearance RotationAngle="0" />
                    <MajorGridLines Visible="true" />
                    <MinorGridLines Visible="true" />
                </XAxis>
                <YAxis>
                    <TitleAppearance Text="Quantity of Fuel">
                        <TextStyle Margin="20" />
                    </TitleAppearance>
                    <MinorGridLines Visible="true" />
                </YAxis>
            </PlotArea>
            <ChartTitle Text="Total Fuel Used by Month">
            </ChartTitle>
             <Legend>
                <Appearance BackgroundColor="Transparent" Position="Bottom" Visible="True">
                </Appearance>
            </Legend>
        </telerik:RadHtmlChart>
                 </td>

             </tr>
             <tr><td><hr /></td></tr>             
            <tr><td>
                <asp:Label ID="Label2" runat="server" Text="Fuel Supplied per Vehicle" Width="100%" BackColor="#FFFF99" Font-Bold="True" Font-Size="Small" ForeColor="Black" Height="30px"></asp:Label>
                </td></tr>
             <tr><td>&nbsp</td></tr>
             <tr><td>Specify Year<telerik:RadComboBox ID="radYear" runat="server" AutoPostBack="True">
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
            </telerik:RadComboBox> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Specify Month &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<telerik:RadComboBox ID="radMonth" runat="server" AutoPostBack="True"></telerik:RadComboBox>
             </td></tr>
             <tr><td>

        <telerik:RadHtmlChart runat="server" ID="RadHtmlChart2" Width="800px" Height="500px"
            >
            <PlotArea>
                <Series>
                    <telerik:BarSeries DataFieldY="FuelSupplied" Name="FuelSupplied">
                        <TooltipsAppearance Visible="false"></TooltipsAppearance>
                    </telerik:BarSeries>
                </Series>
                <XAxis DataLabelsField="fleetId">
                    <MinorGridLines Visible="false"></MinorGridLines>
                    <MajorGridLines Visible="false"></MajorGridLines>
                </XAxis>
            </PlotArea>
            <Legend>
                <Appearance Visible="false"></Appearance>
            </Legend>
            <ChartTitle Text="Fuel Supplied per Vehicle (Litres)">
            </ChartTitle>
        </telerik:RadHtmlChart>

                 </td></tr>
              <tr><td><hr /></td></tr>             
            <tr><td>
                <asp:Label ID="Label3" runat="server" Text="Fuel Consumption per Vehicle" Width="100%" BackColor="#FFFF99" Font-Bold="True" Font-Size="Small" ForeColor="Black" Height="30px"></asp:Label>
                </td></tr>
             <tr><td>&nbsp</td></tr>
             <tr><td>Specify Year<telerik:RadComboBox ID="radYearAveFuelCon" runat="server" AutoPostBack="True">
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
            </telerik:RadComboBox> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Specify Month &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<telerik:RadComboBox ID="radMonthAveFuelCon" runat="server" AutoPostBack="True"></telerik:RadComboBox>
             </td></tr>
             <tr><td>

        <telerik:RadHtmlChart runat="server" ID="RadHtmlChart3" Width="800px" Height="500px"
            >
            <PlotArea>
                <Series>
                    <telerik:BarSeries DataFieldY="FuelConsumptionRate" Name="FuelConsumptionRate">
                        <TooltipsAppearance Visible="false"></TooltipsAppearance>
                    </telerik:BarSeries>
                    <telerik:BarSeries DataFieldY="StandardConsumption" Name="StandardConsumption">
                        <TooltipsAppearance Visible="false"></TooltipsAppearance>
                    </telerik:BarSeries>
                </Series>
                <XAxis DataLabelsField="fleetId">
                    <MinorGridLines Visible="false"></MinorGridLines>
                    <MajorGridLines Visible="false"></MajorGridLines>
                </XAxis>
            </PlotArea>
            <Legend>
                <Appearance Visible="false"></Appearance>
            </Legend>
            <ChartTitle Text="Fuel Consuption per Vehicle (km/Litre)">
            </ChartTitle>
        </telerik:RadHtmlChart>

                 </td></tr>
             <tr><td><hr /></td></tr>             
            <tr><td>
                <asp:Label ID="Label4" runat="server" Text="Fuel Supplied per Vehicle" Width="100%" BackColor="#FFFF99" Font-Bold="True" Font-Size="Small" ForeColor="Black" Height="30px"></asp:Label>
                </td></tr>
                <tr>
            <td colspan="2">
                <table>
                    <tr>
                        <td style="vertical-align:top" >
                <table>
                      <tr>
                          <td style="vertical-align:top">Year</td>
                          <td style="vertical-align:top">           
                               <asp:DropDownList id="cboYear" runat="server" CssClass="form-control" Width="200px" AutoPostBack="True"></asp:DropDownList>
                              &nbsp;&nbsp <asp:Button ID="btnLoadBySpecificVehicles" runat="server" CssClass="auto-style4" Text="Show" Width="55px" />
                         <br />
                          </td>
                         
                      </tr>
                    <tr>
                        <td colspan="2">
                             <telerik:RadGrid ID="radVehiclesList" runat="server" AllowMultiRowSelection="True" AutoGenerateColumns="False" CellPadding="0" GroupPanelPosition="Top" Height="100%" PageSize="20" Width="400px" AllowFilteringByColumn="True">
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
                              <telerik:GridClientSelectColumn FilterControlAltText="Filter column column" HeaderText="Select" UniqueName="column">
                              </telerik:GridClientSelectColumn>
                              <telerik:GridBoundColumn DataField="FleetId" HeaderText="FleetId" UniqueName="FleetId" FilterControlAltText="Filter FleetId column">
                                  <ColumnValidationSettings>
                                      <ModelErrorMessage Text="" />
                                  </ColumnValidationSettings>
                              </telerik:GridBoundColumn>
                              <telerik:GridBoundColumn DataField="RegNumber" FilterControlAltText="Filter RegNumber column" HeaderText="RegNumber" UniqueName="RegNumber">
                                  <ColumnValidationSettings>
                                      <ModelErrorMessage Text="" />
                                  </ColumnValidationSettings>
                              </telerik:GridBoundColumn>
                              <telerik:GridBoundColumn DataField="Make" FilterControlAltText="Filter Make column" HeaderText="Make" UniqueName="Make">
                                  <ColumnValidationSettings>
                                      <ModelErrorMessage Text="" />
                                  </ColumnValidationSettings>
                              </telerik:GridBoundColumn>
                              <telerik:GridBoundColumn DataField="Model" HeaderText="Model" UniqueName="Model" FilterControlAltText="Filter Model column">
                                  <ColumnValidationSettings>
                                      <ModelErrorMessage Text="" />
                                  </ColumnValidationSettings>
                              </telerik:GridBoundColumn>
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
                  </table>
            </td> 
            
            <td>

                <table>
                     <tr>
                         <td>
                                   <telerik:RadHtmlChart runat="server" ID="LineChart" Width="800px" Height="500px" Visible="False">
            <Appearance>
                <FillStyle BackgroundColor="Transparent"></FillStyle>
            </Appearance>
            <ChartTitle Text="Fuel Supplied per Vehicle">
                <Appearance Align="Center" BackgroundColor="Transparent" Position="Top">
                </Appearance>
            </ChartTitle>
            <Legend>
                <Appearance BackgroundColor="Transparent" Position="Bottom">
                </Appearance>
            </Legend>
            <PlotArea>
                <Appearance>
                    <FillStyle BackgroundColor="Transparent"></FillStyle>
                </Appearance>
                <XAxis AxisCrossingValue="0" Color="black" MajorTickType="Outside" MinorTickType="Outside"
                    Reversed="false">
                    <Items>
                        <telerik:AxisItem LabelText="January"></telerik:AxisItem>
                        <telerik:AxisItem LabelText="February"></telerik:AxisItem>
                        <telerik:AxisItem LabelText="March"></telerik:AxisItem>
                        <telerik:AxisItem LabelText="April"></telerik:AxisItem>
                        <telerik:AxisItem LabelText="May"></telerik:AxisItem>
                        <telerik:AxisItem LabelText="June"></telerik:AxisItem>
                        <telerik:AxisItem LabelText="July"></telerik:AxisItem>
                        <telerik:AxisItem LabelText="August"></telerik:AxisItem>
                        <telerik:AxisItem LabelText="September"></telerik:AxisItem>
                        <telerik:AxisItem LabelText="October"></telerik:AxisItem>
                        <telerik:AxisItem LabelText="November"></telerik:AxisItem>
                        <telerik:AxisItem LabelText="December"></telerik:AxisItem>
                    </Items>
                    <LabelsAppearance DataFormatString="{0}" RotationAngle="0" Skip="0" Step="1">
                    </LabelsAppearance>
                    <TitleAppearance Position="Center" RotationAngle="0" Text="Months">
                    </TitleAppearance>
                </XAxis>
                <YAxis AxisCrossingValue="0" Color="black" MajorTickSize="1" MajorTickType="Outside"
                    MinorTickSize="1" MinorTickType="Outside" MinValue="0" Reversed="false">
                    <LabelsAppearance DataFormatString="{0}" RotationAngle="0" Skip="0" Step="1">
                    </LabelsAppearance>
                    <TitleAppearance Position="Center" RotationAngle="0" Text="Qty Supplied">
                    </TitleAppearance>
                </YAxis>
                <Series>
                   
                </Series>
            </PlotArea>
        </telerik:RadHtmlChart>
                             
                         </td>
                     </tr>          
                     
                </table>
            </td>
                    </tr>
                </table>
            </td>
          </tr>
         </table>
             
        
      
          

       </div>
</asp:Content>
