<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="SinglePaperMarkProcessing.aspx.vb" Inherits="WebApplication2.SinglePaperMarkProcessing" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <table>
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
     <table>
        <tr>
            <td class="auto-style3">
                <asp:Panel ID="Panel2" runat="server" Width="568px">
                    <table>
                        <tr>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style4">
                                Test Code</td>
                            <td class="auto-style4">                       
                               
                                <asp:TextBox ID="txtTestCode" runat="server"></asp:TextBox>
                               
                            </td>
                            <td>
                                <asp:Button ID="cmdSearch" runat="server" Text="Search Test/Assignment" />
                            </td>
                        </tr>
                       
                        <tr>
                            <td class="auto-style1">
                                Test Date</td>
                            <td class="auto-style1">
                                               
                                <asp:TextBox ID="txtTestCode2" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                      
                        <tr>
                            <td class="auto-style1">
                                Stream</td>
                            <td>
                               
                                                               
                                <asp:TextBox ID="txtTestCode0" runat="server"></asp:TextBox>
                               
                                                               
                            </td>
                        </tr>
                       
                        <tr>
                            <td class="auto-style1">
                                 Classes</td>
                            <td>
                                <asp:TextBox ID="txtTestCode1" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        
                        <tr>
                            <td class="auto-style1">Description</td><td>
                            <asp:TextBox ID="txtNotes" runat="server" TextMode="MultiLine" Width="313px"></asp:TextBox>
                            </td>
                        </tr>
                     
                        <tr>
                            <td class="auto-style1">
                                 Subject</td>
                            <td>
                                <asp:TextBox ID="txtTestCode3" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        
                        <tr>
                            <td class="auto-style1">
                                 Highest Possible Mark</td>
                            <td>
                                <asp:TextBox ID="txtHighestPossibleMark" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                       
                        <tr>
                            <td class="auto-style4">
                                 Topics Covered</td>
                            <td class="auto-style4">
                                <asp:TextBox ID="txtTopicsCovered" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                         <tr>
                            <td>
                                 &nbsp;
                            </td>
                        </tr>
                       
                        <tr>
                            <td>
                                &nbsp;</td>
                        </tr>
                         <tr>
                            <td>
                                 &nbsp;
                            </td>
                        </tr>
                        
                        

                    </table>
                </asp:Panel>
               </td>
            <td style="vertical-align:top">
               
            </td>
        </tr>
    </table>  
</asp:Content>
