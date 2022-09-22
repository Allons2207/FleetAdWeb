<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="ExamMarkSchedules.aspx.vb" Inherits="WebApplication2.MarkSchedules" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .RadGrid_Default{border:1px solid #828282;background-color:#fff;color:#333;font-family:"Segoe UI",Arial,Helvetica,sans-serif;font-size:12px;line-height:16px}.RadGrid table.rgMasterTable tr .rgExpandCol{padding-left:0;padding-right:0;text-align:center}.RadGrid_Default .rgHeader{color:#333}.RadGrid_Default .rgHeader{border:0;border-bottom:1px solid #828282;background:#eaeaea 0 -2300px repeat-x url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Grid.sprite.gif')}.RadGrid .rgHeader{padding-top:5px;padding-bottom:4px;text-align:left;font-weight:normal}.RadGrid .rgHeader{padding-left:7px;padding-right:7px}.RadGrid .rgHeader{cursor:default}
        .auto-style5 {
            height: 19px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table width="80%"><tr><td>
       <table width="50%">
        <tr><td class="auto-style1">&nbsp;</td></tr>
       <tr>
       <td style="font-size:medium; color:darkblue " colspan="4" class="auto-style3">
           Examination Marks Schedule</td>
       </tr>
       <tr><td>&nbsp;</td></tr>
       <tr>
         <td colspan="4" class="auto-style5">
             <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small"></asp:Label>
         </td>
        </tr>
           <tr><td></td></tr>
        <tr><td >Subject</td><td class="auto-style4"><telerik:RadComboBox ID="cboSubject" runat="server"> </telerik:RadComboBox></td>
            
        </tr>
           <tr><td></td></tr>
        <tr>
            <td >Year</td>
            <td class="auto-style4" ><asp:TextBox ID="txtYear" runat="server"></asp:TextBox></td>
            <td >Term</td>
            <td ><telerik:RadComboBox ID="cboTerm" runat="server"> </telerik:RadComboBox></td>            
        </tr>
             
        <tr>
            <td>Stream </td>
            <td class="auto-style4">
               <telerik:RadComboBox ID="cboStreams" runat="server"> </telerik:RadComboBox>
            </td>
            <td>Class</td><td><telerik:RadComboBox ID="cboClasses" runat="server">
                 </telerik:RadComboBox>
            </td>
        </tr>
           <tr><td></td></tr>
           <tr><td></td><td class="auto-style4">
                                <asp:Button ID="cmdShowMarks" runat="server" Text="Show Marks" Width="195px" />
                            </td></tr>
           <tr><td></td></tr>


        </table>
    </td>
    </tr>
    <tr>
        <td></td>
    </tr>
    <tr>
        <td>
                                <telerik:RadGrid ID="gwResults" runat="server" AllowPaging="True" AllowSorting="True" BackColor="White" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" DisplayMode="FirstLastPreviousNextNumeric, Text" ForeColor="Black" GroupPanelPosition="Top" PageSize="50">
                                    <ClientSettings>
                                        <Scrolling AllowScroll="True" />
                                    </ClientSettings>
                                    <AlternatingItemStyle BackColor="#E9E9E9" />
                                </telerik:RadGrid>
                            </td>
    </tr>


    </table>




</asp:Content>
