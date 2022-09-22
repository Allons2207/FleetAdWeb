<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/StudentsPortalMaster.Master" CodeBehind="StudentsPortalAttendance.aspx.vb" Inherits="WebApplication2.StudentsPortalAttendance" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
.RadPicker{vertical-align:middle}
        .RadPicker .RadInput{vertical-align:baseline}.RadInput_Default{font:12px "segoe ui",arial,sans-serif}.RadInput{vertical-align:middle}.RadInput_Default{font:12px "segoe ui",arial,sans-serif}.RadInput{vertical-align:middle}.RadInput_Default{font:12px "segoe ui",arial,sans-serif}.RadInput{vertical-align:middle}
        .auto-style1 {
            width: 141px;
        }
        .auto-style2 {
            width: 449px;
        }
        .auto-style3 {
            width: 190px;
        }
    div.RadPicker table.rcSingle .rcInputCell{padding-right:0}div.RadPicker table.rcSingle .rcInputCell{padding-right:0}div.RadPicker table.rcSingle .rcInputCell{padding-right:0}.RadPicker table.rcTable .rcInputCell{padding:0 4px 0 0}
        .auto-style5 {
            width: 503px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <table width ="60%">
           <tr>
       <td style="font-size:medium; color:darkblue " colspan="6">
           Student Attendance</td>
       </tr>
       <tr>
         <td class="auto-style1" colspan="4">
             <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small"></asp:Label>
         </td>
        </tr>
         <tr><td class="auto-style5">&nbsp;</td></tr>
         <tr>
             <td class="auto-style5" >Fix dates from Date</td><td>
                                               
                                <telerik:RadDatePicker ID="rdDtFromDate" Runat="server">
                                </telerik:RadDatePicker>
                            </td>
             <td class="auto-style1">To Date</td><td>
                                               
                                <telerik:RadDatePicker ID="rdDtToDate" Runat="server">
                                </telerik:RadDatePicker>
                            </td>
             <td class="auto-style2">&nbsp;&nbsp;&nbsp;&nbsp;
                 <asp:CheckBox ID="chkAbsence" Text="Isolate Absence" runat="server" />
             </td>
             <td>
                                <asp:Button ID="btnLoadByDates" runat="server" Text="Show Specified Record" />
             </td>
         </tr>
         <tr><td class="auto-style5">&nbsp</td></tr>
         </table>
      
    
     <table width="80%">
                            <tr>
                                <td>
                                    <telerik:RadGrid ID="gwAttendance" runat="server" Width ="100%"  BackColor="White"  AllowPaging="True"  DisplayMode="FirstLastPreviousNextNumeric, Text" PageSize="50"
                                                    BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" AllowSorting="True" GroupPanelPosition="Top"  ForeColor="Black" AutoGenerateColumns="False">
                                    <ClientSettings>
                                        <Scrolling AllowScroll="True"  />
                                    </ClientSettings>
                   
                                        <AlternatingItemStyle BackColor="#E9E9E9" />
                   
                                        <MasterTableView>
                                            <Columns>
                                                <telerik:GridBoundColumn DataField="Date" FilterControlAltText="Filter Date column" HeaderText="Date" UniqueName="Date">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="Stream" FilterControlAltText="Filter Stream column" HeaderText="Stream" UniqueName="Stream">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="Class" FilterControlAltText="Filter Class column" HeaderText="Class" UniqueName="Class">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridCheckBoxColumn DataField="Attendance" DataType="System.Boolean" FilterControlAltText="Filter column column" HeaderText="Attendance" UniqueName="column">
                                                </telerik:GridCheckBoxColumn>
                                                <telerik:GridBoundColumn DataField="CheckInTime" FilterControlAltText="Filter CheckInTime column" HeaderText="CheckInTime" UniqueName="CheckInTime">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="CheckOutTime" FilterControlAltText="Filter CheckOutTime column" HeaderText="CheckOutTime" UniqueName="CheckOutTime">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="Comments" FilterControlAltText="Filter Comments column" HeaderText="Reason for Absence (If Absent)" UniqueName="Comments">
                                                </telerik:GridBoundColumn>
                                            </Columns>
                                        </MasterTableView>
                   
                                    </telerik:RadGrid>   
                                </td>
                            </tr>
                        </table>
</asp:Content>
