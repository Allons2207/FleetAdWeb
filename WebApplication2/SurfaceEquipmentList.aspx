<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="SurfaceEquipmentList.aspx.vb" Inherits="WebApplication2.SurfaceEquipmentList" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <h3 style="font-size:medium; color:gray "> Surface Equipment List </h3>

   <table style="margin-left:2%" width="70%">
       <tr><td><asp:Button ID="btnAddNew" runat="server" Text="Add New" Width="164px" />&nbsp;&nbsp;&nbsp;&nbsp<asp:Button ID="cmdExport" runat="server" Text="Export List to MS Excel" Width="201px" /><br /></td></tr>
       <tr><td>&nbsp</td></tr>
       <tr><td>
    <telerik:RadGrid ID="gwGrid" runat="server" AllowPaging="True" AllowSorting="True" BackColor="White" BorderColor="#003366" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" DisplayMode="FirstLastPreviousNextNumeric, Text" ForeColor="Black" GroupPanelPosition="Top" PageSize="100" AllowFilteringByColumn="True" ShowGroupPanel="True" AutoGenerateColumns="False">
        <ExportSettings FileName="SurfaceEquipmentList">
        </ExportSettings>
        <clientsettings AllowDragToGroup="True">
            <Scrolling AllowScroll="True" UseStaticHeaders="True"  />
        </clientsettings>
        <MasterTableView>
            <Columns>
                <telerik:GridButtonColumn CommandName="View" FilterControlAltText="Filter View column" HeaderText="View" Text="View" UniqueName="View">
                </telerik:GridButtonColumn>
                <telerik:GridBoundColumn DataField="SurfaceEquipmentID" FilterControlAltText="Filter SurfaceEquipmentID column" HeaderText="SurfaceEquipmentID" UniqueName="SurfaceEquipmentID">
<ColumnValidationSettings>
<ModelErrorMessage Text=""></ModelErrorMessage>
</ColumnValidationSettings>
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="SurfaceEquipmentType" FilterControlAltText="Filter SurfaceEquipmentType column" HeaderText="SurfaceEquipmentType" UniqueName="SurfaceEquipmentType">
<ColumnValidationSettings>
<ModelErrorMessage Text=""></ModelErrorMessage>
</ColumnValidationSettings>
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Category" FilterControlAltText="Filter Category column" HeaderText="Category" UniqueName="Category">
                    <ColumnValidationSettings>
                        <ModelErrorMessage Text="" />
                    </ColumnValidationSettings>
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="AssetNumber" FilterControlAltText="Filter AssetNumber column" HeaderText="AssetNumber" UniqueName="AssetNumber">
<ColumnValidationSettings>
<ModelErrorMessage Text=""></ModelErrorMessage>
</ColumnValidationSettings>
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="SerialNumber" FilterControlAltText="Filter SerialNumber column" HeaderText="SerialNumber" UniqueName="SerialNumber">
<ColumnValidationSettings>
<ModelErrorMessage Text=""></ModelErrorMessage>
</ColumnValidationSettings>
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="RegNumber" FilterControlAltText="Filter RegNumber column" HeaderText="RegNumber" UniqueName="RegNumber">
<ColumnValidationSettings>
<ModelErrorMessage Text=""></ModelErrorMessage>
</ColumnValidationSettings>
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="ChassisNumber" FilterControlAltText="Filter ChassisNumber column" HeaderText="ChassisNumber" UniqueName="ChassisNumber">
<ColumnValidationSettings>
<ModelErrorMessage Text=""></ModelErrorMessage>
</ColumnValidationSettings>
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Description" FilterControlAltText="Filter Description column" HeaderText="Description" UniqueName="Description">
<ColumnValidationSettings>
<ModelErrorMessage Text=""></ModelErrorMessage>
</ColumnValidationSettings>
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Color" FilterControlAltText="Filter Color column" HeaderText="Color" UniqueName="Color">
<ColumnValidationSettings>
<ModelErrorMessage Text=""></ModelErrorMessage>
</ColumnValidationSettings>
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="FuelType" FilterControlAltText="Filter FuelType column" HeaderText="FuelType" UniqueName="FuelType">
<ColumnValidationSettings>
<ModelErrorMessage Text=""></ModelErrorMessage>
</ColumnValidationSettings>
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="TyreSize" FilterControlAltText="Filter TyreSize column" HeaderText="TyreSize" UniqueName="TyreSize">
<ColumnValidationSettings>
<ModelErrorMessage Text=""></ModelErrorMessage>
</ColumnValidationSettings>
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="NumberOfTyres" FilterControlAltText="Filter NumberOfTyres column" HeaderText="NumberOfTyres" UniqueName="NumberOfTyres">
<ColumnValidationSettings>
<ModelErrorMessage Text=""></ModelErrorMessage>
</ColumnValidationSettings>
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="HourMeter" FilterControlAltText="Filter HourMeter column" HeaderText="HourMeter" UniqueName="HourMeter">
<ColumnValidationSettings>
<ModelErrorMessage Text=""></ModelErrorMessage>
</ColumnValidationSettings>
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="GeneratorSize" FilterControlAltText="Filter GeneratorSize column" HeaderText="GeneratorSize" UniqueName="GeneratorSize">
<ColumnValidationSettings>
<ModelErrorMessage Text=""></ModelErrorMessage>
</ColumnValidationSettings>
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="TrailerSize" FilterControlAltText="Filter TrailerSize column" HeaderText="TrailerSize" UniqueName="TrailerSize">
                    <ColumnValidationSettings>
                        <ModelErrorMessage Text="" />
                    </ColumnValidationSettings>
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="EngineModel" FilterControlAltText="Filter EngineModel column" HeaderText="EngineModel" UniqueName="EngineModel">
                    <ColumnValidationSettings>
                        <ModelErrorMessage Text="" />
                    </ColumnValidationSettings>
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="ActiveMode" FilterControlAltText="Filter ActiveMode column" HeaderText="ActiveMode" UniqueName="ActiveMode">
                    <ColumnValidationSettings>
                        <ModelErrorMessage Text="" />
                    </ColumnValidationSettings>
                </telerik:GridBoundColumn>
                <telerik:GridButtonColumn CommandName="Delete" FilterControlAltText="Filter Delete column" Text="Delete" UniqueName="Delete">
                </telerik:GridButtonColumn>
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>
       </td></tr>
       </table>
</asp:Content>
