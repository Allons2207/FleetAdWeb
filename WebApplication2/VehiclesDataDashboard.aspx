<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="VehiclesDataDashboard.aspx.vb" Inherits="WebApplication2.VehiclesDataDashboard" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
      <telerik:RadSkinManager ID="RadSkinManager1" runat="server" ShowChooser="true" />
    <div class="demo-container size-wide"  style="margin-left:2%">
        <table width="90%">
             <tr><td><hr /></td></tr>
            <tr><td>
                <asp:Label ID="lblAllocationStatus" runat="server" Text="Vehicle Allocation Status" Width="100%" BackColor="#FFFF99" Font-Bold="True" Font-Size="Small" ForeColor="Black" Height="30px"></asp:Label>
                </td></tr>
            <tr>
                <td>
                    <telerik:RadHtmlChart runat="server" ID="RadHtmlChart1" Height="400px" Width="800px">
             
            <PlotArea>

                <Series>
                    <telerik:ColumnSeries DataFieldY="NumOfVehicles">
                        <LabelsAppearance RotationAngle="-90" />
                        <TooltipsAppearance Color="White" />
                    </telerik:ColumnSeries>
                </Series>
                <XAxis DataLabelsField="allocationStatus">
                    <TitleAppearance Text="Allocation Status">
                        <TextStyle Margin="20" />
                    </TitleAppearance>
                    <LabelsAppearance RotationAngle="0" />
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
            <ChartTitle Text="Allocation Status">
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
                <asp:Label ID="Label1" runat="server" Text="Vehicles by Make" Width="100%" BackColor="#FFFF99" Font-Bold="True" Font-Size="Small" ForeColor="Black" Height="30px"></asp:Label>
                </td></tr>
        <tr>
            <td>
                <telerik:RadHtmlChart runat="server" ID="RadHtmlChart2" Height="400px" Width="800px">
             
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
            </td>
        </tr>
             <tr><td><hr /></td></tr>
            <tr><td>
                <asp:Label ID="Label2" runat="server" Text="Vehicles by Category" Width="100%" BackColor="#FFFF99" Font-Bold="True" Font-Size="Small" ForeColor="Black" Height="30px"></asp:Label>
                </td></tr>
              <tr>
            <td>
                <telerik:RadHtmlChart runat="server" ID="RadHtmlChart4" Height="400px" Width="800px">
             
            <PlotArea>

                <Series>
                    <telerik:ColumnSeries DataFieldY="NoOfVehicles">
                        <LabelsAppearance RotationAngle="-90" />
                        <TooltipsAppearance Color="White" />
                    </telerik:ColumnSeries>
                </Series>
                
                <XAxis DataLabelsField="Category">
                    <TitleAppearance Text="Vehicle Category">
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
            <ChartTitle Text="Vehicles by Vehicle Category">
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
                <asp:Label ID="Label3" runat="server" Text="Vehicles by Age in Years" Width="100%" BackColor="#FFFF99" Font-Bold="True" Font-Size="Small" ForeColor="Black" Height="30px"></asp:Label>
                </td></tr>

             <tr>
            <td>
                <telerik:RadHtmlChart runat="server" ID="RadHtmlChart3" Height="400px" Width="800px">
             
            <PlotArea>

                <Series>
                    <telerik:ColumnSeries DataFieldY="NoOfVehicles">
                        <LabelsAppearance RotationAngle="-90" />
                        <TooltipsAppearance Color="White" />
                    </telerik:ColumnSeries>
                </Series>
                
                <XAxis DataLabelsField="AgeFromPurchase">
                    <TitleAppearance Text="Age From Purchase Date (Yrs)">
                        <TextStyle Margin="20" />
                    </TitleAppearance>
                    <LabelsAppearance RotationAngle="0" />
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
            <ChartTitle Text="Vehicle Ages">
            </ChartTitle>
             <Legend>
                <Appearance BackgroundColor="Transparent" Position="Bottom" Visible="True">
                </Appearance>
            </Legend>
        </telerik:RadHtmlChart>
            </td>
        </tr>
           
    </table>


         </div>
</asp:Content>
