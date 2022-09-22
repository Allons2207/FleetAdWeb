<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="MileageToNextService.aspx.vb" Inherits="WebApplication2.MileageToNextService" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
    .auto-style3 {
        font-size: medium;
        color: gray;
    }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <h3 class="auto-style3"> Vehicle Mileages towards next Service</h3>
    <table width="90%" style="margin-left:2%" > 
        <tr>     
        <td>
             <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small"></asp:Label>
         </td>
        </tr>
        <tr>
            <td>

                <asp:Button ID="cmdExportToExcel" runat="server" Text="Export to MS Excel" Width="150px" />

            </td>
        </tr>
        <tr>
            <td>
                <telerik:RadGrid ID="gwGrid" runat="server" AllowPaging="True" AllowSorting="True" BackColor="White" BorderColor="#003366" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" DisplayMode="FirstLastPreviousNextNumeric, Text" ForeColor="Black" GroupPanelPosition="Top" PageSize="100" AllowFilteringByColumn="True" ShowGroupPanel="True" AutoGenerateColumns="False">
                    <clientsettings AllowDragToGroup="True">
                        <Scrolling AllowScroll="True" UseStaticHeaders="True"  />
                    </clientsettings>
                    <MasterTableView>
                        <Columns>
                            <telerik:GridBoundColumn DataField="MileageTowardsNextService" FilterControlAltText="Filter MileageTowardsNextService column" HeaderText="MileageTowardsNextService" UniqueName="MileageTowardsNextService">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="FleetID" FilterControlAltText="Filter FleetID column" HeaderText="FleetID" UniqueName="FleetID">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="RegNumber" FilterControlAltText="Filter RegNumber column" HeaderText="RegNumber" UniqueName="RegNumber">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Make" FilterControlAltText="Filter Make column" HeaderText="Make" UniqueName="Make">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Model" FilterControlAltText="Filter Model column" HeaderText="Model" UniqueName="Model">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="MileageOnLastService" FilterControlAltText="Filter MileageOnLastService column" HeaderText="MileageOnLastService" UniqueName="MileageOnLastService">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="currentMileage" FilterControlAltText="Filter currentMileage column" HeaderText="CurrentMileage" UniqueName="currentMileage">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="ServiceMileage" FilterControlAltText="Filter ServiceMileage column" HeaderText="ServiceMileage" UniqueName="ServiceMileage">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="LastMileageDate" FilterControlAltText="Filter LastMileageDate column" HeaderText="LastMileageDate" UniqueName="LastMileageDate">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="LastServiceDate" FilterControlAltText="Filter LastServiceDate column" HeaderText="LastServiceDate" UniqueName="LastServiceDate">
                            </telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </td>
        </tr>
    </table>

</asp:Content>
