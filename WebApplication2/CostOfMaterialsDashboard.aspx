<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="CostOfMaterialsDashboard.aspx.vb" Inherits="WebApplication2.CostOfMaterialsDashboard" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table>
        <tr><td colspan="2">
                <asp:Label ID="Label4" runat="server" Text="Cost of Materials" Width="100%" BackColor="#FFFF99" Font-Bold="True" Font-Size="Small" ForeColor="Black" Height="30px"></asp:Label>
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
</asp:Content>
