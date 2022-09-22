<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="CapturingOfCoarseworkMarks.aspx.vb" Inherits="WebApplication2.CapturingOfCoarseworkMarks" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
  
     <table width="100%">
       <tr>
       <td style="font-size:medium; color:darkblue ">
           Tests and Assignments
       </td>
       </tr>
       <tr>
         <td>
             <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small"></asp:Label>
         </td>
        </tr>
     </table>  
     <table width="50%">
        <tr>
            <td >
                <asp:Panel ID="Panel2" runat="server" >
                    <table width="100%">
                        <tr>
                            <td></td>
                             <td>
                                 
                            </td>
                             <td>
                                 
                            </td>
                        </tr>
                        <tr>
                            <td >
                                Test Code</td>
                            <td >                       
                               
                                <asp:TextBox ID="txtTestCode" runat="server"></asp:TextBox>
                               
                            </td>
                            <td>
                                 <asp:Button ID="cmdFindTest" runat="server" Text="Find Test" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                
                            </td>
                        </tr>
                        <tr>
                            <td >
                                Test Date</td>
                            <td >
                                               
                                
                                <asp:TextBox ID="txtTestDate" runat="server"></asp:TextBox>
                                               
                                
                            </td>
                        </tr>
                        <tr>
                            <td>
                                 &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style1">
                                Stream</td>
                            <td>                                                   
                                <asp:TextBox ID="txtStream" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                         <tr>
                            <td>
                                 &nbsp;
                            </td>
                        </tr>
                        
                         
                        <tr>
                            <td class="auto-style1">Description</td><td>
                            <asp:TextBox ID="txtNotes" runat="server" TextMode="MultiLine" Width="313px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style1">
                                 Subject</td>
                            <td>
                                
                                <asp:TextBox ID="txtSubject" runat="server"></asp:TextBox>
                                
                            </td>
                        </tr>
                         <tr>
                            <td>
                                 &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style1">
                                 Highest Possible Mark</td>
                            <td >
                                <asp:TextBox ID="txtHighestPossibleMark" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                         <tr>
                            <td>
                                 &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style4">
                                 Classes</td>
                            <td class="auto-style4">

                                <telerik:RadComboBox ID="cboClasses" runat="server">
                                    <Items>
                                        
                                    </Items>
                                </telerik:RadComboBox>
                         
                            </td>
                            <td>
                                <asp:Button ID="cmdLoadClassStudentsAndMarks" runat="server" Text="Load Class Students" />
                            </td>
                        </tr>
                        
                        
                        

                    </table>
                </asp:Panel>
               </td>
            <td style="vertical-align:top">
               
            </td>
        </tr>
    </table>  

    <table  width="80%">
         <tr>
                            <td>
                                 &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td>
                                
                            </td>
                            <td>
                                <asp:Button ID="cmdSaveMarks" runat="server" Text="Save Class Marks" /> 
                            </td>
                        </tr>
                         <tr>
                            <td>
                                 &nbsp;
                            </td>
                             <td>
                                 &nbsp;
                            </td>
                        </tr>
                         <tr>
                            <td   bgcolor="lightgreen" colspan="3" align="center" >
                                 Capture the Student Marks Below
                            </td>
                             
                        </tr>
                        <tr>
                            <td colspan="3">
                                 &nbsp;
                            </td>
                             
                        </tr>
                         <tr>
                            <td colspan="3">
                                 <telerik:RadGrid ID="gwBillPayments" runat="server" AllowPaging="True" AllowSorting="True" BackColor="White" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" DisplayMode="FirstLastPreviousNextNumeric, Text" ForeColor="Black" GroupPanelPosition="Top" PageSize="50" AutoGenerateColumns="False" AutoGenerateEditColumn="True">
                                     <ClientSettings>
                                         <Scrolling AllowScroll="True" />
                                     </ClientSettings>
                                     <AlternatingItemStyle BackColor="#E9E9E9" />
                                     <MasterTableView>
                                         <Columns>
                                             <telerik:GridBoundColumn DataField="studentId" FilterControlAltText="Filter studentId column" HeaderText="Student Id" UniqueName="studentId">
                                             </telerik:GridBoundColumn>
                                             <telerik:GridBoundColumn DataField="firstName" FilterControlAltText="Filter firstName column" HeaderText="First Name" UniqueName="firstName">
                                             </telerik:GridBoundColumn>
                                             <telerik:GridBoundColumn DataField="secondName" FilterControlAltText="Filter secondName column" HeaderText="Second Name" UniqueName="secondName">
                                             </telerik:GridBoundColumn>
                                             <telerik:GridBoundColumn DataField="surname" FilterControlAltText="Filter surname column" HeaderText="Surname" UniqueName="surname">
                                             </telerik:GridBoundColumn>
                                               <telerik:GridBoundColumn DataField="CurrentMark" FilterControlAltText="Filter CurrentMark column" HeaderText="CurrentMark" UniqueName="CurrentMark">
                                             </telerik:GridBoundColumn>
                                               <telerik:GridTemplateColumn HeaderText="New Mark"  UniqueName="mark" FilterControlAltText="Filter mark column" DataField="mark">
                                                            <ItemTemplate>
                                                                         <asp:TextBox ID="mark"    FooterText="Mark Obtained" HeaderText="Mark Obtained"  DataTextField="mark" DataValueField="mark"   runat="server"></asp:TextBox>
                                                            </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                         </Columns>
                                     </MasterTableView>
                                 </telerik:RadGrid>
                            </td>
                             
                        </tr>
                         <tr>
                            <td>
                                 &nbsp;
                            </td>
                             <td>
                                 &nbsp;
                            </td>
                        </tr>
                         <tr>
                            <td>
                                 &nbsp;
                            </td>
                             <td>
                                 &nbsp;
                            </td>
                        </tr>
    </table>




</asp:Content>
