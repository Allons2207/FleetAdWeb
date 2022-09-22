﻿<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="VehicleWriteOff.aspx.vb" Inherits="WebApplication2.VehicleWriteOff" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <h3 style="font-size:medium; color:gray "> Writing off Vehicle</h3>
    <table style="margin-left:2%" >
         <tr>
         <td colspan="4">
             <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small" Width="100%"></asp:Label>
         </td>
        </tr>
        <tr><td><b>VEHICLE DETAILS:</b></td></tr>
                     <tr><td>Search by Fleet ID.</td><td><asp:TextBox ID="txtFleetIDSearch" runat="server" Width="211px"></asp:TextBox></td><td><asp:Button ID="btnSearchByFleetID" runat="server" Text="Find" Width="150px" /></td></tr>
        <tr><td colspan="4"><hr /></td></tr>
         <tr><td>Registration Number</td><td> 
                                         <telerik:RadComboBox ID="cboRegNumber" runat="server" Width="215px" AutoPostBack="True"></telerik:RadComboBox>
             </td>
             <td>Fleet ID Specification</td><td>
                                         <asp:TextBox ID="txtFleetID" runat="server" Width="210px" Enabled="False"></asp:TextBox>
             </td>
        </tr>
        <tr><td>Make</td><td> <asp:TextBox ID="txtMake" runat="server" Width="212px" Enabled="False"></asp:TextBox></td><td>Model</td><td> <asp:TextBox ID="txtModel" runat="server" Width="212px" Enabled="False"></asp:TextBox></td></tr>
       <tr><td>Reason</td><td> 
                                         <telerik:RadComboBox ID="cboReason" runat="server" Width="215px" AutoPostBack="True"></telerik:RadComboBox>
             </td>
           <td>Date Written Off</td><td>
                                         <telerik:RadDatePicker ID="rdDate" runat="server" Culture="en-US" MinDate="1900-01-01"></telerik:RadDatePicker>
                                     </td></tr>
         <tr><td>Notes</td><td> <asp:TextBox ID="txtMake0" runat="server" Width="212px" Height="51px" TextMode="MultiLine"></asp:TextBox></td></tr>

<tr><td colspan="4"><hr /></td></tr>
        <tr><td></td><td colspan="3">
                 <asp:Button ID="cmdSave" runat="server" Text="Write Off Vehicle" Width="217px" />&nbsp;&nbsp
                 <asp:Button ID="cmdDelete" runat="server" Text="Delete" Width="214px" />
             </td></tr>
        </table>
</asp:Content>
