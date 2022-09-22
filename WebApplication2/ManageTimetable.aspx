<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="ManageTimetable.aspx.vb" Inherits="WebApplication2.ManageTimetable" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style1 {
            height: 26px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <table>
    <tr>
        <td style="font-size:medium; color:darkblue ">
           Manage Timetable
        </td>
    </tr>
            <tr>
             <td>
                 <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small"></asp:Label>
             </td>
         </tr>
</table>
    <table width = "100%">
<tr>
   <td>
       Day
   </td>
    <td>
        Period
    </td>
    <td>
        FromTime
    </td>
    <td>
        ToTime
    </td>
    <td>
        Stream
    </td>
    <td>
        Class
    </td>
    <td>
        Subject
    </td>
   <td>
        Teacher
    </td>
   
</tr>
    <tr>
   <td class="auto-style1">
       <telerik:RadComboBox ID="cbDay" runat="server">
           <Items>
               <telerik:RadComboBoxItem runat="server" Value="8" />
               <telerik:RadComboBoxItem runat="server" Text="Monday" Value="2" />
               <telerik:RadComboBoxItem runat="server" Text="Tuesday" Value="3" />
               <telerik:RadComboBoxItem runat="server" Text="Wednesday" Value="4" />
               <telerik:RadComboBoxItem runat="server" Text="Thursday" Value="5" />
               <telerik:RadComboBoxItem runat="server" Text="Friday" Value="6" />
               <telerik:RadComboBoxItem runat="server" Text="Saturday" Value="7" />
               <telerik:RadComboBoxItem runat="server" Text="Sunday" Value="1" />
           </Items>
       </telerik:RadComboBox>
   </td>
    <td class="auto-style1">
         <telerik:RadComboBox ID="cbPeriod" runat="server" AutoPostBack="true"></telerik:RadComboBox>
    </td>
    <td class="auto-style1">
        <asp:TextBox ID="txtFromtime" runat="server"></asp:TextBox>
    </td>
    <td class="auto-style1">
        <asp:TextBox ID="txtToTime" runat="server"></asp:TextBox>
      
    </td>
    <td class="auto-style1">
     <telerik:RadComboBox ID="cbStream" runat="server"></telerik:RadComboBox>

    </td>
    <td class="auto-style1">
                 <telerik:RadComboBox ID="cbClass" runat="server"></telerik:RadComboBox>

    </td>
    <td class="auto-style1">
                 <telerik:RadComboBox ID="cbSubject" runat="server"></telerik:RadComboBox>

    </td>
   <td class="auto-style1">
                 <telerik:RadComboBox ID="cbTeacher" runat="server"></telerik:RadComboBox>

    </td>
</tr>
    <tr>
        <td>
            <asp:Button ID="cmdSave" runat="server" Text="Save" BackColor="#FF9933" Width="75px" />
        </td>
    </tr>
</table>
    <table width="100%">
        <tr>
            <td>
                   <telerik:RadGrid ID="gwTimeTable" runat="server" Width ="100%"  BackColor="#DEBA84"  AllowPaging="True"  DisplayMode="FirstLastPreviousNextNumeric, Text" PageSize="100"
         BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" AllowSorting="True" GroupPanelPosition="Top"  ForeColor="Black" AllowFilteringByColumn="True">
                    
                   
     </telerik:RadGrid> 
            </td>
        </tr>
    </table>
</asp:Content>
