<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="VehicleUsersDashboard.aspx.vb" Inherits="WebApplication2.VehicleUsersDashboard" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>

        <telerik:RadHtmlChart runat="server" ID="RadHtmlChart1" Height="400px" Width="800px">
        <PlotArea>
            <Series>
                <telerik:ColumnSeries DataFieldY="NoOfVehicleUsers">
                    <LabelsAppearance RotationAngle="-90" />
                    <TooltipsAppearance Color="White" />
                </telerik:ColumnSeries>
            </Series>
            <XAxis DataLabelsField="allocationStatus">
                <TitleAppearance Text="Allocation Status">
                    <TextStyle Margin="20" />
                </TitleAppearance>
                <LabelsAppearance RotationAngle="-90" />
                <MajorGridLines Visible="true" />
                <MinorGridLines Visible="true" />
            </XAxis>
            <YAxis>
                <TitleAppearance Text="No. Of Vehicle Users">
                    <TextStyle Margin="20" />
                </TitleAppearance>
                <MinorGridLines Visible="true" />
            </YAxis>
        </PlotArea>
        <ChartTitle Text="Active Vehicle Users by Allocation Status">
        </ChartTitle>
        <Legend>
            <Appearance BackgroundColor="Transparent" Position="Bottom" Visible="True">
            </Appearance>
        </Legend>
    </telerik:RadHtmlChart>

    </div>

</asp:Content>
