<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="DisposedVehiclesList.aspx.vb" Inherits="WebApplication2.DisposedVehiclesList" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

      <h3 style="font-size:medium; color:gray "> Disposed Vehicles List</h3>
    <table width="80%" style="margin-left:2%" >
      
        <tr><td>
              <asp:Button ID="cmdAddNew" runat="server" Text="Add New" Width="107px" />
                            </td></tr>
       <tr>
         <td>
             <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small"></asp:Label>
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
                            <telerik:GridButtonColumn CommandName="View" FilterControlAltText="Filter column column" HeaderText="View" Text="View" UniqueName="column">
                            </telerik:GridButtonColumn>
                            <telerik:GridBoundColumn DataField="DateDisposed" FilterControlAltText="Filter DateDisposed column" HeaderText="DateDisposed" UniqueName="DateDisposed">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Make" FilterControlAltText="Filter Make column" HeaderText="Make" UniqueName="Make">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Model" FilterControlAltText="Filter Model column" HeaderText="Model" UniqueName="Model">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="FleetID" FilterControlAltText="Filter FleetID column" HeaderText="FleetID" UniqueName="FleetID">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="RegNo" FilterControlAltText="Filter RegNo column" HeaderText="RegNo" UniqueName="RegNo">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="ReasonForDisposal" FilterControlAltText="Filter ReasonForDisposal column" HeaderText="ReasonForDisposal" UniqueName="ReasonForDisposal">
                            </telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </td>
        </tr>
    </table>

</asp:Content>
