<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="ExamSubjectPapersMarkConsolidation.aspx.vb" Inherits="WebApplication2.ExamSubjectPapersMarkConsolidation" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table width="50%">
        <tr><td class="auto-style1">&nbsp;</td></tr>
       <tr>
       <td style="font-size:medium; color:darkblue " colspan="4">
           Subject Examination Overall Aggregation 
       </td>
       </tr>
       <tr><td>&nbsp;</td></tr>
       <tr>
         <td >
             <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small"></asp:Label>
         </td>
        </tr>

        <tr>
            <td >Year</td>
            <td><asp:TextBox ID="txtYear" runat="server"></asp:TextBox></td>
            <td>Term</td>
            <td><telerik:RadComboBox ID="cboTerm" runat="server"> </telerik:RadComboBox></td>            
        </tr>
        <tr><td ></td></tr>
        <tr><td >Subject</td><td><telerik:RadComboBox ID="cboSubject" runat="server"> </telerik:RadComboBox></td>
            <td>Stream </td><td>
                                 <telerik:RadComboBox ID="cboStreams" runat="server"> </telerik:RadComboBox>
                             </td>
        </tr>
        <tr><td ></td></tr>
        <tr><td >Consider Examination Papers from Date</td><td>
                <telerik:RadDatePicker ID="rdpDateFrom" runat="server"></telerik:RadDatePicker>
            </td><td>To Date</td><td>
                <telerik:RadDatePicker ID="rdpDateTo" runat="server"></telerik:RadDatePicker>
            </td></tr>
        <tr><td >&nbsp;</td></tr>
        <tr><td ></td><td><asp:Button ID="cmdSearch" runat="server" Text="Search Subject Examination Papers" /></td></tr>
        <tr><td >&nbsp;</td></tr>
        <tr><td>RESULTS</td></tr>
        <tr>
             <td colspan="4">
                            <telerik:RadGrid ID="gwTests" runat="server" AllowPaging="True" AllowSorting="True" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" DisplayMode="FirstLastPreviousNextNumeric, Text" ForeColor="Black" GroupPanelPosition="Top" PageSize="50" AutoGenerateColumns="False" AllowMultiRowSelection="True">
                                <ClientSettings>
                                    <Selecting AllowRowSelect="True" />
                                    <Scrolling AllowScroll="True" />
                                </ClientSettings>
                                <AlternatingItemStyle BackColor="#E9E9E9" />
                                <MasterTableView>
                                    <Columns>
                                        <telerik:GridBoundColumn DataField="Exam_Code" FilterControlAltText="Filter Exam_Code column" HeaderText="Exam_Code" UniqueName="Exam_Code">
                                        </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="Paper" FilterControlAltText="Filter Paper column" HeaderText="Paper" UniqueName="Paper">
                                        </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="Marked_Out_Of" FilterControlAltText="Filter Marked_Out_Of column" FooterText="Marked_Out_Of" HeaderText="Marked_Out_Of" UniqueName="Marked_Out_Of">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridClientSelectColumn DataType="System.Boolean" FilterControlAltText="Filter Select column" FooterText="Select" HeaderText="Select" UniqueName="Select">
                                        </telerik:GridClientSelectColumn>
                                         <telerik:GridTemplateColumn HeaderText="Assigned_Percentage_Contribution"  UniqueName="Assigned_Percentage_Contribution">
                                                            <ItemTemplate>
                                                                         <asp:TextBox ID="txtAssigned_Percentage_Contribution"    FooterText="Assigned_Percentage_Contribution" HeaderText="Assigned_Percentage_Contribution"  DataTextField="Assigned_Percentage_Contribution" DataValueField="Assigned_Percentage_Contribution"   runat="server"></asp:TextBox>
                                                            </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                    </Columns>
                                </MasterTableView>
                            </telerik:RadGrid>
                </td>
        </tr>
        <tr><td>&nbsp;</td><td></td></tr>
         <tr><td colspan="2">
                             <asp:CheckBox ID="chkProcessForStream" runat="server" Text="Process for Stream" />
                             </td><td class="auto-style3">
                                 </td></tr>
         <tr><td ></td><td></td></tr>
         <tr><td>
                             <asp:CheckBox ID="chkProcessForClass" runat="server" Text="Process for Class" />
                             </td><td><telerik:RadComboBox ID="cboClasses" runat="server">
                                 </telerik:RadComboBox>
                             </td></tr>
         <tr><td class="auto-style4" ></td><td class="auto-style4"></td></tr>
         <tr><td  colspan="2" class="auto-style3">
                             <asp:CheckBox ID="chkAverageCoarseWorkMark" runat="server" Text="Compile Average Coarsework Mark" Checked="True" Enabled="False" />
                             </td><td class="auto-style3"></td></tr>
         <tr><td ></td><td></td></tr>
         <tr><td >
                             <asp:CheckBox ID="chkOverallGrade" runat="server" Text="Insert Overall Grade" />
                             </td><td><telerik:RadComboBox ID="cboGrading" runat="server"></telerik:RadComboBox></td></tr>
        <tr><td></td><td></td></tr>
        <tr><td  colspan="2">
                             <asp:CheckBox ID="chkInsertClassPosition" runat="server" Text="Insert Overall Class Position" />
                             </td><td></td></tr>
        <tr><td></td><td></td></tr>
       <tr><td colspan="2">
                             <asp:CheckBox ID="chkInsertStreamPosition" runat="server" Text="Insert Overall Stream Position" />
                             </td><td></td></tr>
       <tr><td></td><td></td></tr>
        <tr><td></td><td><asp:Button ID="cmdApply" runat="server" Text="Execute specified Tasks" /></td></tr>
        <tr><td>&nbsp</td></tr>
        <tr><td>RESULTS</td></tr>
        <tr><td colspan="4">
            <telerik:RadGrid ID="gwProcessedResults" runat="server" AllowPaging="True" AllowSorting="True" BackColor="White" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" DisplayMode="FirstLastPreviousNextNumeric, Text" ForeColor="Black" GroupPanelPosition="Top" PageSize="50" AllowMultiRowSelection="True">
                                <ClientSettings>
                                    <Selecting AllowRowSelect="True" />
                                    <Scrolling AllowScroll="True" />
                                </ClientSettings>
                                <AlternatingItemStyle BackColor="#E9E9E9" />
                            </telerik:RadGrid>

            </td>
        </tr>
     </table>  
</asp:Content>
