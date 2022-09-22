<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="VehiclesByMake.aspx.vb" Inherits="WebApplication2.VehiclesByMake" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <telerik:RadSkinManager ID="RadSkinManager1" runat="server" ShowChooser="true" />
    <div class="demo-container size-wide">
        <telerik:RadHtmlChart runat="server" ID="RadHtmlChart1" Height="400px" Width="800px">
             
            <PlotArea>

                <Series>
                    <telerik:ColumnSeries DataFieldY="MakeCount">
                        <LabelsAppearance RotationAngle="-90" />
                        <TooltipsAppearance Color="White" />
                    </telerik:ColumnSeries>
                </Series>
                <Series>
                    <telerik:ColumnSeries DataFieldY="F">
                        <LabelsAppearance RotationAngle="-90" />
                        <TooltipsAppearance Color="White" />
                    </telerik:ColumnSeries>
                </Series>
                <XAxis DataLabelsField="Make">
                    <TitleAppearance Text="Make">
                        <TextStyle Margin="20" />
                    </TitleAppearance>
                    <LabelsAppearance RotationAngle="-90" />
                    <MajorGridLines Visible="false" />
                    <MinorGridLines Visible="false" />
                </XAxis>
                <YAxis>
                    <TitleAppearance Text="No. of Vehicles">
                        <TextStyle Margin="20" />
                    </TitleAppearance>
                    <MinorGridLines Visible="false" />
                </YAxis>
            </PlotArea>
            <ChartTitle Text="No. of Vehicle by Make">
            </ChartTitle>
             <Legend>
                <Appearance BackgroundColor="Transparent" Position="Bottom" Visible="True">
                </Appearance>
            </Legend>
        </telerik:RadHtmlChart>
       </div>
              
</asp:Content>
