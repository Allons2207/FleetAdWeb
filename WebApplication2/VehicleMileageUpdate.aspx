<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="VehicleMileageUpdate.aspx.vb" Inherits="WebApplication2.VehicleMileageUpdate" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <h3 style="font-size:medium; color:gray "> Vehicle Mileage Updating</h3>
     <table style="margin-left:2%" width="60%">
         <tr>
         <td colspan="4" class="auto-style1">
             <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small" Width="100%"></asp:Label>
         </td>
        </tr>
        <tr><td colspan="4"><b>VEHICLE DETAILS:</b></td></tr>

                      <tr><td>Search by Fleet ID.</td><td><asp:TextBox ID="txtFleetIDSearch" runat="server" Width="211px"></asp:TextBox></td><td><asp:Button ID="btnSearchByFleetID" runat="server" Text="Find" Width="112px" /></td></tr>

          <tr><td>Search by Reg No.</td><td><asp:TextBox ID="txtRegNo" runat="server" Width="211px"></asp:TextBox></td><td><asp:Button ID="cmdClear0" runat="server" Text="Find" Width="110px" /></td></tr>
<tr>
    <td colspan="4"><hr /></td>
</tr>


        
        <tr><td>Make</td><td> <asp:TextBox ID="txtMake" runat="server" Width="212px" Enabled="False"></asp:TextBox></td><td>Model</td><td> <asp:TextBox ID="txtModel" runat="server" Width="212px" Enabled="False"></asp:TextBox></td></tr>
<tr><td></td></tr>
<tr><td colspan="4"><b>Mileage Details</b></td></tr>
       <tr><td>Last Recorded Mileage</td><td> <asp:TextBox ID="txtLastRecordedMileage" runat="server" Width="212px" Enabled="False"></asp:TextBox></td>
           <td>Date Recorded</td><td> <asp:TextBox ID="txtLastMileageDate" runat="server" Width="212px" Enabled="False"></asp:TextBox></td>
       </tr>
        <tr><td>Current Mileage</td><td>
                                         <asp:TextBox ID="txtCurrentMileage" runat="server" Width="212px"></asp:TextBox>
                                     </td>
        <td>&nbsp;Date</td><td>
                                         <telerik:RadDatePicker ID="rdCurrentDate" runat="server" Culture="en-US" MinDate="1900-01-01"></telerik:RadDatePicker>
                                     </td>
        </tr>
        <tr><td>Comments/Notes</td><td> <asp:TextBox ID="txtCommentsNotes" runat="server" Width="212px" Height="55px" TextMode="MultiLine"></asp:TextBox></td></tr>     
       
        
        <tr><td colspan="4"><hr /></td></tr>
        <tr><td></td><td colspan="3">
                 <asp:Button ID="cmdSave" runat="server" Text="Update Vehicle Mileage" Width="163px" />&nbsp;&nbsp;&nbsp
            <asp:Button ID="cmdClear" runat="server" Text="Clear" Width="113px" />&nbsp;&nbsp
                 <asp:Button ID="cmdDelete" runat="server" Text="Delete" Width="126px" />
             </td></tr>
         <tr><td colspan="4"><hr /></td></tr>
         <tr><td></td><td colspan="3"> 
          <telerik:RadGrid ID="gwList" runat="server"  BackColor="White"  AllowPaging="True"  DisplayMode="FirstLastPreviousNextNumeric, Text" PageSize="10"
         BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" AllowSorting="True" GroupPanelPosition="Top"  ForeColor="Black" AllowMultiRowSelection="True" ClientSettings-Selecting-AllowRowSelect="true" >
                      
                  <ClientSettings>
                        <Selecting AllowRowSelect="True"></Selecting>
                          </ClientSettings>

              <AlternatingItemStyle BackColor="#E9E9E9" />

     </telerik:RadGrid> 
             </td></tr>


         
             <tr><td></td><td>
                                         <telerik:RadComboBox ID="cboRegNumber" runat="server" Width="219px" AutoPostBack="True" Visible="False"></telerik:RadComboBox>
                                         </td> 
            <td></td><td> 
                                         <telerik:RadComboBox ID="cboFleetID" runat="server" Width="219px" AutoPostBack="True" Visible="False"></telerik:RadComboBox>
                                         </td>
            
        </tr>
         
    </table>


</asp:Content>
