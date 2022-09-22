<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="ExamSinglePaperMarksProcessing.aspx.vb" Inherits="WebApplication2.ExamSinglePaperMarksProcessing" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <br />
    <table>
        <tr>
            <td>


                <table>
       <tr>
       <td style="font-size:medium; color:darkblue ">
           Examination Paper Marks Processing
       </td>
       </tr>
       <tr>
         <td>
             <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small"></asp:Label>
         </td>
        </tr>
     </table>  
     <table>
        <tr>
            <td >
                <asp:Panel ID="Panel2" runat="server">
                    <table>
                        
                        <tr>
                            <td>Exam Code</td>
                            <td class="auto-style4">                       
                               <asp:TextBox ID="txtExamCode" runat="server"></asp:TextBox>
                           </td>
                            <td><asp:Button ID="cmdSearch" runat="server" Text="Search Examination Paper" /></td><td></td>
                            <td>
                        </td>
                        </tr>

                        <tr>
                            <td >
                                Examination Board</td>
                            <td>
                                <asp:TextBox ID="txtExamBoard" runat="server"></asp:TextBox>
                            </td>
                             <td >
                                </td>
                         </tr>
                        <tr>
                            <td >
                                Stream</td>
                            <td>
                                <asp:TextBox ID="txtStream" runat="server"></asp:TextBox>
                            </td>
                             <td >
                                </td>
                       
                        </tr>
                        <tr>
                             <td >
                                 Subject</td>
                            <td>
                                <asp:TextBox ID="txtSubject" runat="server"></asp:TextBox>
                            </td>

                        </tr>
                       
                             <tr><td >Paper</td><td><asp:TextBox ID="txtPaper" runat="server"></asp:TextBox></td></tr>          
                     
                        <tr>
                           
                             <td >
                                 Highest Possible Mark</td>
                            <td>
                                <asp:TextBox ID="txtMaxMark" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                              <tr>
                            <td>Exam Date</td>
                            <td>                                               
                                <asp:TextBox ID="txtExamDate" runat="server"></asp:TextBox>
                            </td>
                        </tr>                
                        <tr>
                            <td >
                                &nbsp;</td>
                        </tr>
                         <tr>
                            <td>&nbsp;</td><td>
                             <asp:CheckBox ID="chkProcessForStream" runat="server" Text="Process for Stream" />
                             </td><td>
                                Specify Stream</td>
                             <td>
                                 <telerik:RadComboBox ID="cboStreams" runat="server"> </telerik:RadComboBox>
                             </td>
                        </tr>
                         <tr>
                            <td>&nbsp;</td><td>
                             <asp:CheckBox ID="chkProcessForClass" runat="server" Text="Process for Class" />
                             </td><td>
                                 Specify Class
                             </td>
                             <td><telerik:RadComboBox ID="cboClasses" runat="server">
                                 </telerik:RadComboBox>
                             </td>
                        </tr>
                       
                        <tr><td></td><td><asp:CheckBox ID="chkGenerateStreamPoz" runat="server" Text="Generate Stream Positions" /></td> </tr>
                        <tr><td></td><td><asp:CheckBox ID="chkGenerateClassPoz" runat="server" Text="Generate Class Positions" /></td> </tr>
                        <tr><td></td><td><asp:CheckBox ID="chkEffectGrades" runat="server" Text="Effect Grades" /></td></tr>
                        <tr><td>Grading</td><td><telerik:RadComboBox ID="cboGrading" runat="server"></telerik:RadComboBox></td> </tr>  
                            
                        <tr><td>&nbsp</td></tr>
                        <tr><td>&nbsp</td><td>
                                <asp:Button ID="cmdPreviewGradingMarks" runat="server" Text="Preview Grading Marks" Width="339px" />
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td colspan="3">
                                <telerik:RadGrid ID="gwGradeRanges" runat="server" AllowPaging="True" AllowSorting="True" BackColor="White" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" DisplayMode="FirstLastPreviousNextNumeric, Text" ForeColor="Black" GroupPanelPosition="Top" PageSize="50">
                                    <ClientSettings>
                                        <Scrolling AllowScroll="True" />
                                    </ClientSettings>
                                    <AlternatingItemStyle BackColor="#E9E9E9" />
                                </telerik:RadGrid>
                            </td>

                        </tr>
                        <tr><td></td><td>&nbsp;</td> </tr>
                        <tr><td></td><td>
                            <asp:Button ID="cmdApplyActions" runat="server" Text="Apply Specified Actions" Width="333px" />
                            </td></tr>
                        <tr><td></td></tr>
                        <tr><td colspan="5">RESULTS</td></tr>
                        <tr><td colspan="5">
                            <telerik:RadGrid ID="gwResults" runat="server" AllowPaging="True" AllowSorting="True" BackColor="White" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" DisplayMode="FirstLastPreviousNextNumeric, Text" ForeColor="Black" GroupPanelPosition="Top" PageSize="50">
                                <ClientSettings>
                                    <Scrolling AllowScroll="True" />
                                </ClientSettings>
                                <AlternatingItemStyle BackColor="#E9E9E9" />
                            </telerik:RadGrid>
                            </td></tr>
                    </table>
                </asp:Panel>
               </td>
            <td>
               
            </td>
        </tr>
    </table> 




            </td>
        </tr>
    </table>
</asp:Content>
