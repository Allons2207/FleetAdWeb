<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="InspectionsDashboard.aspx.vb" Inherits="WebApplication2.InspectionsDashboard" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <h3 style="font-size:medium; color:gray "> Inspections Dashboard</h3>
     <div class="demo-container size-wide">
        <table>
            <tr><td colspan="5"><hr /></td></tr>
            <tr><td>From Date</td><td> <telerik:RadDatePicker ID="rdFromDate" runat="server" Culture="en-US" MinDate="1900-01-01"></telerik:RadDatePicker></td><td>To Date</td><td> <telerik:RadDatePicker ID="rdToDate" runat="server" Culture="en-US" MinDate="1900-01-01"></telerik:RadDatePicker></td><td><asp:Button ID="cmdShow" runat="server" Text="Show" Width="105px" /></td></tr>
            <tr><td colspan="5">
             <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small" Width="100%"></asp:Label></td>
                </tr>
            <tr><td colspan="5"><hr /></td></tr>

            <tr>
                <td colspan="5">
        
      <telerik:RadSkinManager ID="RadSkinManager1" runat="server" ShowChooser="true" />
           <telerik:RadHtmlChart runat="server" ID="RadHtmlChart1" Height="400px" Width="800px">
              <PlotArea>
                <Series>
                    <telerik:ColumnSeries DataFieldY="NoOfVehicles">
                        <LabelsAppearance RotationAngle="-90" />
                        <TooltipsAppearance Color="White" />
                    </telerik:ColumnSeries>
                </Series>
                <XAxis DataLabelsField="keyFinding">
                    <TitleAppearance Text="Key Finding">
                        <TextStyle Margin="20" />
                    </TitleAppearance>
                    <LabelsAppearance RotationAngle="-90" />
                    <MajorGridLines Visible="true" />
                    <MinorGridLines Visible="true" />
                </XAxis>
                <YAxis>
                    <TitleAppearance Text="Key Findings">
                        <TextStyle Margin="20" />
                    </TitleAppearance>
                    <MinorGridLines Visible="true" />
                </YAxis>
            </PlotArea>
            <ChartTitle Text="Inspection Key Findings">
            </ChartTitle>
             <Legend>
                <Appearance BackgroundColor="Transparent" Position="Bottom" Visible="True">
                </Appearance>
            </Legend>
        </telerik:RadHtmlChart>

            </td></tr>
            <tr><td colspan="5"><hr /></td></tr>
            <tr><td colspan="5">
                <asp:Label ID="lblAllocationStatus" runat="server" Text="Key Findings" Width="100%" BackColor="#FFFF99" Font-Bold="True" Font-Size="Small" ForeColor="Black" Height="30px"></asp:Label>
                </td></tr>
            <tr>
                <td colspan="5">
                   
                <telerik:RadHtmlChart ID="pieChart" runat="server" Height="400px" Width="800px">
                <PlotArea>
                    <Series>
                        <telerik:PieSeries DataFieldY="NoOfVehicles" />
                        
                    </Series>
                    </PlotArea>
                    </telerik:RadHtmlChart>
                </td>
            </tr>
            <tr><td colspan="5"><hr /></td></tr>
        </table>
         <br />
         <br />
         <br />

       </div>

</asp:Content>
