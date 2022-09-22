<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="AccidentsAndIncidentsList.aspx.vb" Inherits="WebApplication2.AccidentsAndIncidentsList" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <h3 style="font-size:medium; color:gray "> Accidents and Incidents List</h3>
    <table width="90%" style="margin-left:2%" >
      
        <tr><td>
              <asp:Button ID="cmdAddNew" runat="server" Text="Add New" Width="107px" />
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:Button ID="cmdExportToExcel" runat="server" Text="Export to MS Excel" Width="150px"/>
                            </td></tr>
       <tr>
         <td>
             <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small"></asp:Label>
         </td>
        </tr>
        <tr>
            <td>
                <telerik:RadGrid ID="gwGrid" runat="server" AllowPaging="True" AllowSorting="True" BackColor="White" BorderColor="#003366" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" DisplayMode="FirstLastPreviousNextNumeric, Text" ForeColor="Black" GroupPanelPosition="Top" PageSize="100" AllowFilteringByColumn="True" ShowGroupPanel="True" AutoGenerateColumns="False">
                    <GroupingSettings CaseSensitive="False" />
                    <clientsettings AllowDragToGroup="True">
                        <Scrolling AllowScroll="True" UseStaticHeaders="True"  />
                    </clientsettings>
                    <MasterTableView>
                        <Columns>
                            <telerik:GridButtonColumn CommandName="View" FilterControlAltText="Filter View column" HeaderText="View" Text="View" UniqueName="View">
                            </telerik:GridButtonColumn>
                            <telerik:GridBoundColumn DataField="ID" Display="False" FilterControlAltText="Filter ID column" HeaderText="ID" UniqueName="ID">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="AccidentDate" FilterControlAltText="Filter AccidentDate column" HeaderText="AccidentDate" UniqueName="AccidentDate">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="AccidentTime" FilterControlAltText="Filter AccidentTime column" HeaderText="AccidentTime" UniqueName="AccidentTime">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Location" FilterControlAltText="Filter Location column" HeaderText="Location" UniqueName="Location">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="FleetId" FilterControlAltText="Filter FleetId column" HeaderText="FleetId" UniqueName="FleetId">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Driver" FilterControlAltText="Filter Driver column" HeaderText="Driver" UniqueName="Driver">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Department" FilterControlAltText="Filter Department column" HeaderText="Department" UniqueName="Department">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Position" FilterControlAltText="Filter Position column" HeaderText="Position" UniqueName="Position">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="LicenseNo" FilterControlAltText="Filter LicenseNo column" HeaderText="LicenseNo" UniqueName="LicenseNo">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="NationalIDNo" FilterControlAltText="Filter NationalIDNo column" HeaderText="NationalIDNo" UniqueName="NationalIDNo">
                            </telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </td>
        </tr>
    </table>
</asp:Content>
