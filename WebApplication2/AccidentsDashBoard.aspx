<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="AccidentsDashBoard.aspx.vb" Inherits="WebApplication2.AccidentsDashBoard" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="demo-container size-wide"  style="margin-left:2%">
         <br />
    <table>
         <tr><td>
                <asp:Label ID="Label4" runat="server" Text="Vehicle Accidents Dashboard"  Width="800px" BackColor="#FFFF99" Font-Bold="True" Font-Size="Small" ForeColor="Black" Height="30px"></asp:Label>
                </td></tr>
        <tr><td><hr /></td></tr>
        <tr>
            <td>Specify Year<telerik:RadComboBox ID="cboYear" runat="server" AutoPostBack="True">
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
            </telerik:RadComboBox>



            </td>
        </tr>
        <tr>
            <td>

                                   <telerik:RadHtmlChart runat="server" ID="LineChart" Width="800px" Height="500px" Visible="False">
            <Appearance>
                <FillStyle BackgroundColor="Transparent"></FillStyle>
            </Appearance>
            <ChartTitle Text="Total Number of Accidents by Month">
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
                    <TitleAppearance Position="Center" RotationAngle="0" Text="No. of Accidents">
                    </TitleAppearance>
                </YAxis>
                <Series>
                   
                </Series>
            </PlotArea>
        </telerik:RadHtmlChart>
                             
            </td>
        </tr>
        <tr><td><hr /></td></tr>
    </table>
         </div>
    <br /><br /><br />
</asp:Content>
