<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="EditFittedTyreDetails.aspx.vb" Inherits="WebApplication2.EditFittedTyreDetails" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
      <h3 style="font-size:medium; color:gray "> Editting Fitted Tyre Details</h3>
     <table style="margin-left:2%" >
        
          <tr>
         <td colspan="5">
             <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small" Width ="100%"></asp:Label>             
         </td>
        </tr>
         <tr>
             <td colspan="4"><hr /></td>
         </tr>
        <tr><td>Serial Number</td><td> 
                                         <asp:TextBox ID="txtSerialNumber" runat="server" Width="213px" Enabled="False"></asp:TextBox>
                                         </td> 
            
        </tr>
         <tr>
             <td>&nbsp;Fitting Status</td><td>
                                         <telerik:RadComboBox ID="cboFittingStatus" runat="server" Width="222px" AutoPostBack="True"></telerik:RadComboBox>
                                         </td>
         </tr>
        <tr><td>Date Fitted on Vehicle</td><td> <telerik:RadDatePicker ID="rdDateFittedOnVehicle" runat="server" Culture="en-US" MinDate="1900-01-01"></telerik:RadDatePicker></td>
            
            </tr>
         <tr>
             <td>Vehicle Fleet ID</td><td> <asp:TextBox ID="txtVehicleFleetID" runat="server" Width="212px"></asp:TextBox></td>
         </tr>
         <tr>
             <td>Mileage at Fitting</td><td> <asp:TextBox ID="txtMileageAtFitting" runat="server" Width="212px"></asp:TextBox></td>
         </tr>
         <tr>
             <td>&nbsp</td>
              <td>
                 <asp:Button ID="cmdSave" runat="server" Text="Save Changes" Width="105px" />&nbsp;&nbsp;
                  <asp:Button ID="cmdMoveBackToStores" runat="server" Text="Move Tyre Back to Stores" Width="105px" />
             </td>
         </tr>
         <tr>
             <td colspan="4"><hr /></td>
         </tr>
         </table>

</asp:Content>
