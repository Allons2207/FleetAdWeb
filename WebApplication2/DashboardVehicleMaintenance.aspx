<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="DashboardVehicleMaintenance.aspx.vb" Inherits="WebApplication2.DashboardVehicleMaintenance" MaintainScrollPositionOnPostback="true" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">  
   <h3 style="font-size:medium; color:gray "> Vehicle Maintenance Costs</h3>
    <table width="95%" style="margin-left:2%" >
        <tr><td><hr /></td></tr>
         <tr><td>
                <asp:Label ID="Label2" runat="server" Text="Total Cost of Materials by Month" Width="100%" BackColor="#FFFF99" Font-Bold="True" Font-Size="Small" ForeColor="Black" Height="30px"></asp:Label>
         </td></tr>
        <tr>
            <td>
                
        <div>

        <telerik:RadHtmlChart runat="server" ID="RadHtmlChart2" Height="400px" Width="800px">
        <PlotArea>
            <Series>
                <telerik:ColumnSeries DataFieldY="TotalCost">
                    <LabelsAppearance RotationAngle="0" />
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
                <TitleAppearance Text="Cost">
                    <TextStyle Margin="20" />
                </TitleAppearance>
                <MinorGridLines Visible="true" />
            </YAxis>
        </PlotArea>
        <ChartTitle Text="Cost of Maintenance By Month">
        </ChartTitle>
        <Legend>
            <Appearance BackgroundColor="Transparent" Position="Bottom" Visible="True">
            </Appearance>
        </Legend>
    </telerik:RadHtmlChart>

        </div> 
            </td>
        </tr>
        <tr><td><hr /></td></tr>
        <tr>
            <td>
                <div>
             <table Width="100%">
                  
        <tr><td colspan="2">
                <asp:Label ID="Label4" runat="server" Text="Cost of Selected Materials" Width="100%" BackColor="#FFFF99" Font-Bold="True" Font-Size="Small" ForeColor="Black" Height="30px"></asp:Label>
                </td></tr>
        <tr>
            <td>Year&nbsp;&nbsp;           
                               <asp:DropDownList id="cboYear" runat="server" CssClass="form-control" Width="200px" AutoPostBack="True"></asp:DropDownList>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:Button ID="btnLoadSelectedCosts" runat="server" CssClass="auto-style4" Text="Show" Width="118px" />
                         </td>
            <td></td>
        </tr>
        <tr>
            <td style="vertical-align:top">
                             <telerik:RadGrid ID="gwList" runat="server" AllowMultiRowSelection="True" AutoGenerateColumns="False" CellPadding="0" GroupPanelPosition="Top" Height="100%" PageSize="20" Width="400px" AllowFilteringByColumn="True">
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
                              <telerik:GridBoundColumn DataField="serviceMaterialId" HeaderText="ServiceMaterialId" UniqueName="serviceMaterialId" FilterControlAltText="Filter serviceMaterialId column">
                                  <ColumnValidationSettings>
                                      <ModelErrorMessage Text="" />
                                  </ColumnValidationSettings>
                              </telerik:GridBoundColumn>
                              <telerik:GridBoundColumn DataField="serviceMaterial" FilterControlAltText="Filter serviceMaterial column" HeaderText="ServiceMaterial" UniqueName="serviceMaterial">
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
            <td>
                                   <telerik:RadHtmlChart runat="server" ID="LineChart" Width="800px" Height="500px" Visible="False">
            <Appearance>
                <FillStyle BackgroundColor="Transparent"></FillStyle>
            </Appearance>
            <ChartTitle Text="Cost of Selected Materials by Month">
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
                    <TitleAppearance Position="Center" RotationAngle="0" Text="Cost">
                    </TitleAppearance>
                </YAxis>
                <Series>
                   
                </Series>
            </PlotArea>
        </telerik:RadHtmlChart>
                             
                         </td>
        </tr>
    </table>
                </div>
            </td>
        </tr>
        <tr><td><hr /></td></tr>
         <tr><td>
                <asp:Label ID="Label1" runat="server" Text="Cost of Materials" Width="100%" BackColor="#FFFF99" Font-Bold="True" Font-Size="Small" ForeColor="Black" Height="30px"></asp:Label>
         </td></tr>
        <tr>
            <td>
                 <div class="demo-container size-wide">
        <telerik:RadHtmlChart runat="server" ID="RadHtmlChart1" Height="400px" Width="1200px">
             
            <PlotArea>

                <Series>
                    <telerik:ColumnSeries DataFieldY="TotCost">
                        <LabelsAppearance RotationAngle="-90" />
                        <TooltipsAppearance Color="White" />
                    </telerik:ColumnSeries>
                </Series>
                <XAxis DataLabelsField="descriptionOfMaterialsUsed">
                    <TitleAppearance Text="Material">
                        <TextStyle Margin="20" />
                    </TitleAppearance>
                    <LabelsAppearance RotationAngle="-90" />
                    <MajorGridLines Visible="true" />
                    <MinorGridLines Visible="true" />
                </XAxis>
                <YAxis>
                    <TitleAppearance Text="Total Cost">
                        <TextStyle Margin="20" />
                    </TitleAppearance>
                    <MinorGridLines Visible="true" />
                </YAxis>
            </PlotArea>
            <ChartTitle Text="Cost of Materials Used">
            </ChartTitle>
             <Legend>
                <Appearance BackgroundColor="Transparent" Position="Bottom" Visible="True">
                </Appearance>
            </Legend>
        </telerik:RadHtmlChart>
       </div>
            </td>
        </tr>
    </table>



   
        
               

    <br />
</asp:Content>
