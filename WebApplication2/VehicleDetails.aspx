<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="VehicleDetails.aspx.vb" Inherits="WebApplication2.VehicleDetails"   MaintainScrollPositionOnPostback ="true"     %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3 style="font-size:medium; color:gray "> Vehicle Details</h3>
   <table style="margin-left:2%" width="70%">
       <tr><td colspan="6"><hr /></td></tr>      
        <tr>
         <td colspan="6">
             <asp:Label ID="lblMsg" runat="server"  Font-Italic="True" Font-Size="Small" Width ="100%"></asp:Label>
         </td>
        </tr>
       <tr>
           <td>&nbsp</td>
       </tr>
        <tr>
            <td>Fleet ID</td><td> <asp:TextBox ID="txtFleetID" runat="server" Width="153px"></asp:TextBox></td><td>Registration #</td><td> <asp:TextBox ID="txtRegNumber" runat="server" Width="153px"></asp:TextBox></td>
            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td>Accessories</td>
        </tr>
        <tr>
            <td>Satellite Z-track #</td><td> <asp:TextBox ID="txtZTrackNumba" runat="server" Width="153px"></asp:TextBox></td><td>Cell Number</td><td> <asp:TextBox ID="txtCellNumba" runat="server" Width="153px"></asp:TextBox></td> 
            <td>&nbsp</td><td rowspan="100%" style="vertical-align:top"> 
          <telerik:RadGrid ID="gwList" runat="server"  BackColor="White"  AllowPaging="True"  DisplayMode="FirstLastPreviousNextNumeric, Text" PageSize="100"
         BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" AllowSorting="True" GroupPanelPosition="Top"  ForeColor="Black" AutoGenerateColumns="False" AllowMultiRowSelection="True" ClientSettings-Selecting-AllowRowSelect="true" Width="250px" >
                      
                  <ClientSettings>
                        <Selecting AllowRowSelect="True"></Selecting>
                          </ClientSettings>

              <AlternatingItemStyle BackColor="#E9E9E9" />

           <MasterTableView>
             <Columns>
                 
                 <telerik:GridClientSelectColumn DataType="System.Boolean" FilterControlAltText="Filter attendance column"
                            UniqueName="attendance" HeaderText="attendance" FooterText="attendance">
                        </telerik:GridClientSelectColumn>
                 
                 <telerik:GridBoundColumn DataField="Accessory" FooterText="Accessory" HeaderText="Accessory"
                            UniqueName="Accessory" FilterControlAltText="Filter Accessory column">  </telerik:GridBoundColumn>
             </Columns>
              
         </MasterTableView>
                                 
     </telerik:RadGrid> 
            </td>


        </tr>
        <tr>
            <td>User Category</td><td>
                                         <telerik:RadComboBox ID="cboUserCategory" runat="server"></telerik:RadComboBox>
                                         </td><td>Vehicle Type</td><td>
                                         <telerik:RadComboBox ID="cboVehicleType" runat="server"></telerik:RadComboBox>
                                         </td> </tr>
            <tr>
            <td>Make</td><td>
                                         <telerik:RadComboBox ID="cboMake" runat="server" AutoPostBack="True"></telerik:RadComboBox>
                                         </td><td>Model</td><td>
                                         <telerik:RadComboBox ID="cboModel" runat="server"></telerik:RadComboBox>
                                         </td> </tr>
                <tr>
            <td>Year of Manufacture</td><td>
                                         <asp:DropDownList ID="cboYearOfManufacture" runat="server" CssClass="form-control" Width="149px">
                                         </asp:DropDownList>
                                         </td><td>Engine Capacity</td><td> <asp:TextBox ID="txtEngineCapacity" runat="server" Width="153px"></asp:TextBox></td> </tr>
                    <tr>
            <td>Engine #</td><td> <asp:TextBox ID="txtEngineNumba" runat="server" Width="153px"></asp:TextBox></td><td>Chassis Number</td><td> <asp:TextBox ID="txtChassisNumba" runat="server" Width="153px"></asp:TextBox></td> </tr>
                       
                            <tr>
            <td>&nbsp;</td> </tr>

         <tr>
            <td>GVM (kgs)</td><td> <asp:TextBox ID="txtGVM" runat="server" Width="153px"></asp:TextBox></td><td>Net Mass (kgs)</td><td> <asp:TextBox ID="txtNVM" runat="server" Width="153px"></asp:TextBox></td> </tr>
                        
          
                        
          <tr>

            <td>Purchase Date</td><td>
                                         <telerik:RadDatePicker ID="rdPurchaseDate" runat="server" Culture="en-US" MinDate="1900-01-01"></telerik:RadDatePicker>
                                     </td><td>Purchase Amount</td><td> <asp:TextBox ID="txtPurchaseAmt" runat="server" Width="153px"></asp:TextBox></td> </tr>
                                    <tr>
            <td>Purchase Currency</td><td>
                                         <telerik:RadComboBox ID="cboPurchaseCurrency" runat="server"></telerik:RadComboBox>
                                         </td><td>Rate vs USD</td><td> <asp:TextBox ID="txtPurchaseRateToUSD" runat="server" Width="153px"></asp:TextBox></td> </tr>
        <tr><td>Service Mileage</td><td><asp:TextBox ID="txtServiceMileage" runat="server" Width="153px"></asp:TextBox></td>
            <td>Current Mileage</td><td><asp:TextBox ID="txtCurrentMileage" runat="server" Width="153px"></asp:TextBox></td>
        </tr>     
        <tr><td>No. of Tyres</td><td><asp:TextBox ID="txtNumOfTyres" runat="server" Width="153px"></asp:TextBox></td>
            <td>Tyre Size</td><td>
                                         <telerik:RadComboBox ID="cboTyreSizeId" runat="server"></telerik:RadComboBox>
                                         </td>
        </tr>   
        <tr>
            <td>Vehicle Color</td><td>
                                         <telerik:RadComboBox ID="cboColor" runat="server"></telerik:RadComboBox>
                                         </td>
            <td>Passenger carrying capacity</td><td> <asp:TextBox ID="txtCarryingCapacity" runat="server" Width="153px"></asp:TextBox></td>

        </tr>  
       <tr>
           <td>Fuel Type</td><td>
                                         <telerik:RadComboBox ID="cboFuelType" runat="server"></telerik:RadComboBox>
                                         </td>
           <td>Fuel Consumption Rate</td><td><asp:TextBox ID="txtFuelConsumptionRate" runat="server" Width="153px"></asp:TextBox></td>
       </tr>  
       <tr>
           <td>&nbsp</td>
       </tr>                        
        <tr>
            <td colspan="5"><hr /></td>
        </tr>
        <tr><td></td><td colspan="3">
                 
             <asp:Button ID="cmdSave" runat="server" Text="Save Vehicle Details" Width="134px" /> &nbsp;&nbsp 
             <asp:Button ID="cmdDelete" runat="server" Text="Delete" Width="95px" /> &nbsp;&nbsp 
             <asp:Button ID="btnClear" runat="server" Text="Clear Vehicle Details" Width="140px" /></td></tr>
       <tr>
            <td colspan="5"><hr /></td>
        </tr>
       <tr>
           <td colspan="4"><b><asp:Label ID="lblVehicleAllocation" runat="server" Text="Vehicle Allocation"></asp:Label></b></td>

       </tr>
       <tr><td><asp:Label ID="lblAllocateTo" runat="server" Text="Allocate To;"></asp:Label></td></tr>

        <tr>
             <td><asp:Label ID="lblFirstNameSearch" runat="server" Text="Firstname"></asp:Label></td><td> <asp:TextBox ID="txtSearhFirstName" runat="server" Width="212px"></asp:TextBox></td><td><asp:Label ID="lblSurnameSearch" runat="server" Text="Surname"></asp:Label></td><td> <asp:TextBox ID="txtSearchSurname" runat="server" Width="212px"></asp:TextBox></td>
             <td>
                 <asp:Button ID="cmdFind" runat="server" Text="Find" Width="105px" />
             </td>
         </tr>
       <tr><td colspan="5"> <asp:Label ID="lblSecndMsg" runat="server"  Font-Italic="True" Font-Size="Small" Width ="100%"></asp:Label></td></tr>
       <tr><td><asp:Label ID="lblLicenseNo" runat="server" Text="License No."></asp:Label></td><td><asp:TextBox ID="txtLicenceNo" runat="server" Width="211px" Enabled="False"></asp:TextBox></td></tr>
        <tr><td><asp:Label ID="lblFirstname" runat="server" Text="Firstname"></asp:Label></td><td> <asp:TextBox ID="txtFirstName" runat="server" Width="211px" Enabled="False"></asp:TextBox></td>
            <td><asp:Label ID="lblSurname" runat="server" Text="Surname"></asp:Label>
            </td><td> <asp:TextBox ID="txtSurname" runat="server" Width="212px" Enabled="False"></asp:TextBox></td>
        </tr>
        <tr><td><asp:Label ID="lblDepartment" runat="server" Text="Department"></asp:Label></td><td> <asp:TextBox ID="txtDept" runat="server" Width="213px" Enabled="False"></asp:TextBox></td>
            <td><asp:Label ID="lblDesignation" runat="server" Text="Designation"></asp:Label></td><td> <asp:TextBox ID="txtDesignation" runat="server" Width="212px" Enabled="False"></asp:TextBox></td></tr>
        <tr><td colspan="5"><asp:Label ID="lblHR" runat="server" Text=""><hr /></asp:Label></td></tr>
        <tr><td></td><td colspan="3">
                 <asp:Button ID="btnAllocateVehicle" runat="server" Text="Allocate" Width="217px" Enabled="False" />
             &nbsp;&nbsp;&nbsp
                <asp:Button ID="btnAllocateToNewUser" runat="server" Text="Allocate to New User" Width="217px" />
            </td>
        </tr>
    




       <tr><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td></tr></table>

</asp:Content>
