<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="TyresDashboard.aspx.vb" Inherits="WebApplication2.TyresDashboard" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>

    <telerik:RadHtmlChart runat="server" ID="RadHtmlChart1" Height="400px" Width="800px">
        <PlotArea>
            <Series>
                <telerik:ColumnSeries DataFieldY="NoOfTyres">
                    <LabelsAppearance RotationAngle="-90" />
                    <TooltipsAppearance Color="White" />
                </telerik:ColumnSeries>
            </Series>
            <XAxis DataLabelsField="manufacturer">
                <TitleAppearance Text="Manufacturer">
                    <TextStyle Margin="20" />
                </TitleAppearance>
                <LabelsAppearance RotationAngle="-90" />
                <MajorGridLines Visible="true" />
                <MinorGridLines Visible="true" />
            </XAxis>
            <YAxis>
                <TitleAppearance Text="No. of Tyres">
                    <TextStyle Margin="20" />
                </TitleAppearance>
                <MinorGridLines Visible="true" />
            </YAxis>
        </PlotArea>
        <ChartTitle Text="Tyres in Store by Manufacturer">
        </ChartTitle>
        <Legend>
            <Appearance BackgroundColor="Transparent" Position="Bottom" Visible="True">
            </Appearance>
        </Legend>
    </telerik:RadHtmlChart>
        </div>
    <hr />
    <div>
        <telerik:RadHtmlChart runat="server" ID="RadHtmlChart2" Height="400px" Width="800px">
        <PlotArea>
            <Series>
                <telerik:ColumnSeries DataFieldY="TotalCost">
                    <LabelsAppearance RotationAngle="-90" />
                    <TooltipsAppearance Color="White" />
                </telerik:ColumnSeries>
            </Series>
            <XAxis DataLabelsField="mMonth">
                <TitleAppearance Text="Month">
                    <TextStyle Margin="20" />
                </TitleAppearance>
                <LabelsAppearance RotationAngle="-90" />
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
        <ChartTitle Text="Cost of Tyres by Month">
        </ChartTitle>
        <Legend>
            <Appearance BackgroundColor="Transparent" Position="Bottom" Visible="True">
            </Appearance>
        </Legend>
    </telerik:RadHtmlChart>
    </div>
     <hr />
    <div>
        <telerik:RadHtmlChart runat="server" ID="RadHtmlChart3" Height="400px" Width="800px">
        <PlotArea>
            <Series>
                <telerik:ColumnSeries DataFieldY="NoOfTyres">
                    <LabelsAppearance RotationAngle="-90" />
                    <TooltipsAppearance Color="White" />
                </telerik:ColumnSeries>
            </Series>
            <XAxis DataLabelsField="reasonForReplacement">
                <TitleAppearance Text="Reason for Replacement ">
                    <TextStyle Margin="20" />
                </TitleAppearance>
                <LabelsAppearance RotationAngle="-90" />
                <MajorGridLines Visible="true" />
                <MinorGridLines Visible="true" />
            </XAxis>
            <YAxis>
                <TitleAppearance Text="No. of Tyres">
                    <TextStyle Margin="20" />
                </TitleAppearance>
                <MinorGridLines Visible="true" />
            </YAxis>
        </PlotArea>
        <ChartTitle Text="Tyres Replacement/Disposal">
        </ChartTitle>
        <Legend>
            <Appearance BackgroundColor="Transparent" Position="Bottom" Visible="True">
            </Appearance>
        </Legend>
    </telerik:RadHtmlChart>
    </div>
     <hr />
    <div>
        <telerik:RadHtmlChart runat="server" ID="RadHtmlChart4" Height="400px" Width="800px">
        <PlotArea>
            <Series>
                <telerik:ColumnSeries DataFieldY="Required">
                    <LabelsAppearance RotationAngle="-90" />
                    <TooltipsAppearance Color="White" />
                </telerik:ColumnSeries>
            </Series>
            <Series>
                <telerik:ColumnSeries DataFieldY="Available">
                    <LabelsAppearance RotationAngle="-90" />
                    <TooltipsAppearance Color="White" />
                </telerik:ColumnSeries>
            </Series>
            <XAxis DataLabelsField="tyreSize">
                <TitleAppearance Text="Tyre Size">
                    <TextStyle Margin="20" />
                </TitleAppearance>
                <LabelsAppearance RotationAngle="-90" />
                <MajorGridLines Visible="true" />
                <MinorGridLines Visible="true" />
            </XAxis>
            <YAxis>
                <TitleAppearance Text="No. of Tyres">
                    <TextStyle Margin="20" />
                </TitleAppearance>
                <MinorGridLines Visible="true" />
            </YAxis>
        </PlotArea>
        <ChartTitle Text="Required VS Available Tyres in Stock">
        </ChartTitle>
        <Legend>
            <Appearance BackgroundColor="Transparent" Position="Bottom" Visible="True">
            </Appearance>
        </Legend>
    </telerik:RadHtmlChart>
    </div>
</asp:Content>
