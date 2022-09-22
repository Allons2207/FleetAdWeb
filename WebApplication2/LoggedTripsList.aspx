<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="LoggedTripsList.aspx.vb" Inherits="WebApplication2.LoggedTripsList" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <h3 style="font-size:medium; color:gray "> Logged Trips</h3>
    <table width="90%" style="margin-left:2%" >
      
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
                            <telerik:GridButtonColumn CommandName="View" FilterControlAltText="Filter View column" HeaderText="View" Text="View" UniqueName="View">
                            </telerik:GridButtonColumn>
                            <telerik:GridBoundColumn DataField="ReturnStatus" FilterControlAltText="Filter ReturnStatus column" HeaderText="ReturnStatus" UniqueName="ReturnStatus">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Make" FilterControlAltText="Filter Make column" HeaderText="Make" UniqueName="Make">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Model" FilterControlAltText="Filter Model column" HeaderText="Model" UniqueName="Model">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="RegNumber" FilterControlAltText="Filter RegNumber column" HeaderText="RegNumber" UniqueName="RegNumber">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="FleetID" FilterControlAltText="Filter FleetID column" HeaderText="FleetID" UniqueName="FleetID">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Destination" FilterControlAltText="Filter Destination column" HeaderText="Destination" UniqueName="Destination">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="DepartureDate" FilterControlAltText="Filter DepartureDate column" HeaderText="DepartureDate" UniqueName="DepartureDate">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="DepartureTime" FilterControlAltText="Filter DepartureTime column" HeaderText="DepartureTime" UniqueName="DepartureTime">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="ExpectedReturnDate" FilterControlAltText="Filter ExpectedReturnDate column" HeaderText="ExpectedReturnDate" UniqueName="ExpectedReturnDate">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="ExpectedReturnTime" FilterControlAltText="Filter ExpectedReturnTime column" HeaderText="ExpectedReturnTime" UniqueName="ExpectedReturnTime">
                            </telerik:GridBoundColumn>
                            <telerik:GridButtonColumn FilterControlAltText="Filter column column" UniqueName="column">
                            </telerik:GridButtonColumn>
                            <telerik:GridBoundColumn DataField="ActualReturnDate" FilterControlAltText="Filter ActualReturnDate column" HeaderText="ActualReturnDate" UniqueName="ActualReturnDate">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="ActualReturnTime" FilterControlAltText="Filter ActualReturnTime column" HeaderText="ActualReturnTime" UniqueName="ActualReturnTime">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="ID" Display="False" FilterControlAltText="Filter ID column" HeaderText="ID" UniqueName="ID">
                            </telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </td>
        </tr>
    </table>
</asp:Content>
