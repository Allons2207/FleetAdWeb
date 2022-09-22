<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="CoarseworkOverallConsolidation.aspx.vb" Inherits="WebApplication2.CoarseworkOverallConsolidation" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style1 {
            height: 26px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <table width="60%">
        <tr><td class="auto-style1">&nbsp;</td></tr>
       <tr>
       <td style="font-size:medium; color:darkblue " colspan="4">
           Overall Coursework Aggregation 
       </td>
       </tr>
       <tr>
         <td class="auto-style1">
             <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small"></asp:Label>
         </td>
        </tr>

        <tr>
            <td class="auto-style1">Year</td>
            <td><asp:TextBox ID="txtYear" runat="server"></asp:TextBox></td>
            <td>Term</td>
            <td><telerik:RadComboBox ID="cboTerm" runat="server"> </telerik:RadComboBox></td>            
        </tr>
        <tr><td class="auto-style1"></td></tr>
        <tr><td class="auto-style1">&nbsp;</td><td>
                             <asp:CheckBox ID="chkProcessForStream" runat="server" Text="Process for Stream" />
                             </td>
            <td>Stream </td><td>
                                 <telerik:RadComboBox ID="cboStreams" runat="server"> </telerik:RadComboBox>
                             </td>
        </tr>
        <tr><td class="auto-style1"></td><td class="auto-style1">
                             <asp:CheckBox ID="chkProcessForClass" runat="server" Text="Process for Class" />
                             </td><td class="auto-style1">Class</td><td class="auto-style1"><telerik:RadComboBox ID="cboClasses" runat="server">
                                 </telerik:RadComboBox>
                             </td></tr>
        <tr><td class="auto-style1"></td></tr>
        <tr><td class="auto-style1"></td><td><asp:Button ID="cmdSearch" runat="server" Text="Search " /></td></tr>
        <tr><td class="auto-style1">RESULTS</td></tr>
        <tr>
             <td colspan="4">
                            <telerik:RadGrid ID="gwTests" runat="server" AllowPaging="True" AllowSorting="True" BackColor="White" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" DisplayMode="FirstLastPreviousNextNumeric, Text" ForeColor="Black" GroupPanelPosition="Top" PageSize="50" AutoGenerateColumns="False" AllowMultiRowSelection="True">
                                <ClientSettings>
                                    <Selecting AllowRowSelect="True" />
                                    <Scrolling AllowScroll="True" />
                                </ClientSettings>
                                <AlternatingItemStyle BackColor="#E9E9E9" />
                                <MasterTableView>
                                    <Columns>
                                        <telerik:GridBoundColumn DataField="Subject" FilterControlAltText="Filter Subject column" HeaderText="Subject" UniqueName="Subject">
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
