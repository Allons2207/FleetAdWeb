<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="test.aspx.vb" Inherits="WebApplication2.test" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
  
    <div class="demo-container size-wide">
        <telerik:RadHtmlChart runat="server" ID="RadHtmlChart1" Width="800px" Height="500px"
            >
            <PlotArea>
                <Series>
                    <telerik:BarSeries DataFieldY="NumOfVehicles" Name="NumOfVehicles">
                        <TooltipsAppearance Visible="false"></TooltipsAppearance>
                    </telerik:BarSeries>
                </Series>
                <XAxis DataLabelsField="allocationStatus">
                    <MinorGridLines Visible="false"></MinorGridLines>
                    <MajorGridLines Visible="false"></MajorGridLines>
                </XAxis>
            </PlotArea>
            <Legend>
                <Appearance Visible="false"></Appearance>
            </Legend>
            <ChartTitle Text="Units In Stock">
            </ChartTitle>
        </telerik:RadHtmlChart>
    </div>
</asp:Content>
