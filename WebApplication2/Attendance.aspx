<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="Attendance.aspx.vb" Inherits="WebApplication2.Attendance" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table>
        <tr>
    <td style="font-size:medium; color:darkblue ">
           Students Attendance Register
      
            </td>
        </tr>
         <tr>
             <td>
                 <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small"></asp:Label>
             </td>
         </tr>
       
    </table>
    <table width="100%">
        <tr>
            <td>
                Attendance Date
            </td>
            <td>
                <telerik:RadDatePicker ID="rdAttendanceDate" runat="server"></telerik:RadDatePicker>
            </td>
            <td>
                Stream
            </td>
            <td>
                <telerik:RadComboBox ID="cbStream" runat="server"></telerik:RadComboBox>
            </td>
            <td>
                Class
            </td>
            <td>
                <telerik:RadComboBox ID="cbClass" runat="server"></telerik:RadComboBox>
            </td>
        </tr>
         <tr>
            <td>
                <asp:Button ID="cmdRegSelected" runat="server" Text="Register Selected" />
                
            </td>
             <td>
                 <asp:Button ID="cmdViewStudents" runat="server" Text="View Students" />
             </td>
        </tr>
    </table>
    <table width="100%">
       <tr>
            <td>
          <telerik:RadGrid ID="gwAttendance" runat="server"  BackColor="White"  AllowPaging="True"  DisplayMode="FirstLastPreviousNextNumeric, Text" PageSize="100"
         BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" AllowSorting="True" GroupPanelPosition="Top"  ForeColor="Black" AutoGenerateColumns="False" AllowMultiRowSelection="True" ClientSettings-Selecting-AllowRowSelect="true" >
                      
<ClientSettings>
<Selecting AllowRowSelect="True"></Selecting>
</ClientSettings>

              <AlternatingItemStyle BackColor="#E9E9E9" />

           <MasterTableView DataKeyNames="studentId">
             <Columns>
                 
                 <telerik:GridBoundColumn DataField="stream" FooterText="stream" HeaderText="stream"
                            UniqueName="stream">  </telerik:GridBoundColumn>
                 <telerik:GridBoundColumn DataField="schoolClass" FooterText="schClass" HeaderText="schoolClass"
                            UniqueName="schoolClass">  </telerik:GridBoundColumn>
                 <telerik:GridBoundColumn DataField="studentId" FooterText="studentId" HeaderText="studentId"
                            UniqueName="studentId">  </telerik:GridBoundColumn>
                  <telerik:GridBoundColumn DataField="firstname" FooterText="firstname" HeaderText="firstname"
                            UniqueName="firstname">  </telerik:GridBoundColumn>
                  <telerik:GridBoundColumn DataField="surname" FooterText="surname" HeaderText="surname"
                            UniqueName="surname">  </telerik:GridBoundColumn>
                 <telerik:GridClientSelectColumn DataType="System.Boolean" FilterControlAltText="Filter attendance column"
                            UniqueName="attendance" HeaderText="attendance" FooterText="attendance">
                        </telerik:GridClientSelectColumn>
                <telerik:GridTemplateColumn HeaderText="Reason For Absence"  UniqueName="comments">
                <ItemTemplate>
                <asp:DropDownList ID="cbComments"    FooterText="Reason For Absense" HeaderText="Reason For Absense"  DataTextField="reasonForAbsence" DataValueField="reasonForAbsence"   runat="server"></asp:DropDownList>
                </ItemTemplate>
                </telerik:GridTemplateColumn>
                
             </Columns>
                
         </MasterTableView>
                                      
     </telerik:RadGrid> 
            </td>
        </tr>
    </table>
</asp:Content>
