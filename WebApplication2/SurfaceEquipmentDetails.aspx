<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="SurfaceEquipmentDetails.aspx.vb" Inherits="WebApplication2.SurfaceEquipmentDetails" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <h3 style="font-size:medium; color:gray "> Surface Equipment Details</h3>
   <table style="margin-left:2%" width="70%">
       <tr><td colspan="6"><hr /></td></tr>      
        <tr>
         <td colspan="4">
             <asp:Label ID="lblMsg" runat="server"  Font-Italic="True" Font-Size="Small" Width ="100%"></asp:Label>
         </td>
        </tr>
       <tr>
           <td>&nbsp</td>
       </tr>
        <tr>
            <td>Asset Type</td><td><telerik:radcombobox ID="cboAssetType" runat="server" Width="200px"></telerik:radcombobox></td>
           
            <td>Category</td><td><telerik:radcombobox ID="cboEquipmentCategory" runat="server" Width="200px">
            </telerik:radcombobox></td>
       </tr>
       <tr>
            <td>Asset Number</td><td class="auto-style3"> <asp:TextBox ID="txtAssetNumber" runat="server" Width="200px"></asp:TextBox></td>
            <td>Reg. Number</td><td class="auto-style3"> <asp:TextBox ID="txtRegNumber" runat="server" Width="200px"></asp:TextBox></td>
       </tr>
       <tr>
            <td>Serial Number</td><td> <asp:TextBox ID="txtSerialNumber" runat="server" Width="200px"></asp:TextBox></td>
           <td>Chassis Number</td><td> <asp:TextBox ID="txtChassisNumber" runat="server" Width="200px"></asp:TextBox></td>
       </tr>
       <tr>
           <td>Description</td><td><asp:TextBox ID="txtDescription" runat="server" Width="200px"></asp:TextBox></td>
           <td>Color</td><td><asp:TextBox ID="txtColor" runat="server" Width="200px"></asp:TextBox></td>
       </tr>
       <tr><td>Engine Model</td><td><asp:TextBox ID="txtEngineModel" runat="server" Width="200px"></asp:TextBox></td>
            <td>Fuel Type</td><td><telerik:radcombobox ID="cboFuelType" runat="server" Width="200px"></telerik:radcombobox></td>           
       </tr>
       <tr>
           <td>Tyre Size</td><td><telerik:radcombobox ID="cboTyreSize" runat="server" Width="200px"></telerik:radcombobox></td>
           <td>Number of Tyres</td><td> <asp:TextBox ID="txtNumberOfTyres" runat="server" Width="200px"></asp:TextBox></td>
       </tr>
       <tr>
           <td class="auto-style3">
               Hour Meter
           </td><td><asp:TextBox ID="txtHourMeter" runat="server" Width="200px"></asp:TextBox></td><td>&nbsp</td><td><asp:TextBox ID="txtSurfaceEquipmentID" runat="server" Width="200px" Visible="False"></asp:TextBox></td>
       </tr>
       <tr>
           <td>
               Generator Size
           </td><td><asp:TextBox ID="txtGeneratorSize" runat="server" Width="200px"></asp:TextBox></td>
           <td>
               Trailer Size
           </td><td><asp:TextBox ID="txtTrailerSize" runat="server" Width="200px"></asp:TextBox></td>
       </tr>
       <tr><td>Active Mode</td><td><telerik:radcombobox ID="cboActiveMode" runat="server" Width="200px">
           <Items>
               <telerik:RadComboBoxItem runat="server" Text="Active" Value="Active" />
               <telerik:RadComboBoxItem runat="server" Text="InActive" Value="InActive" />
           </Items>
           </telerik:radcombobox></td></tr>
       <tr><td>&nbsp</td></tr>
       <tr><td>&nbsp</td>
           <td colspan="3">
            <asp:Button ID="btnSaveSurfaceEquipment" runat="server" Text="Save" Width="202px" />&nbsp;&nbsp;&nbsp;&nbsp
                <asp:Button ID="btnClear" runat="server" Text="Clear" Width="202px" />
           </td></tr>
       <tr><td>&nbsp</td></tr>
       <tr><td colspan="6"><hr /></td></tr>  
       <tr><td colspan="2"> <asp:LinkButton runat="server" ID="lnkBackToList" Text="<< Back to Surface Equipment List" Font-Size="14px" ></asp:LinkButton></td></tr>
    <tr><td>&nbsp</td></tr>
          </table>



</asp:Content>
