<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/StudentsPortalMaster.Master" CodeBehind="StudentsPortalExtraCurriculaActivities.aspx.vb" Inherits="WebApplication2.StudentsPortalExtraCurriculaActivities" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table>
        <tr>
       <td style="font-size:medium; color:darkblue " colspan="3">
           Student Participation in Extra-curricula Activities
       </td>
       </tr>
       <tr>
         <td>
             <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small"></asp:Label>
         </td>
        </tr>
        <tr>
           <td style="vertical-align:top"  Width="300px" >
                <asp:Panel ID="Panel4" runat="server">
                    <B>Clubs</B>
                </asp:Panel>
             
                <asp:Panel ID="pnTreeClubs" runat="server">
                    <table>
                        <tr>
                            <td class="auto-style6">
                                Student Participates in 
                            </td>
                            <td class="auto-style6">
                                <asp:Label ID="Label1" runat="server" ></asp:Label>
                            </td>
                        </tr>
                        </table>
                           
        <telerik:RadTreeView ID="RadTreeClubs" width="100%" runat="server" CheckBoxes="true" 
                TriStateCheckBoxes="true" CheckChildNodes="True" Skin="Glow" BorderColor="Black" ForeColor="Black" Enabled="False" >
            </telerik:RadTreeView>
                           
                    </asp:Panel>
               </td>

               <td style="vertical-align:top" class="auto-style5"  Width="300px"> 
                  <asp:Panel ID="Panel6" runat="server">
                    <B>Sports</B>
                
                      <table>
                        <tr>
                            <td class="auto-style1">
                                Student Participates in 
                            </td>
                            <td class="auto-style1">
                                <asp:Label ID="Label2" runat="server" ></asp:Label>
                            </td>
                        </tr>
                       
                    </table>
                 <telerik:RadTreeView ID="RadTreeSports" width="100%" runat="server" CheckBoxes="true" 
                TriStateCheckBoxes="true" CheckChildNodes="True" Skin="Glow" BorderColor="Black" ForeColor="Black" Enabled="False" >
            </telerik:RadTreeView>
                 </asp:Panel>
               </td>
               <td style="vertical-align:top"  Width="300px">
                     <asp:Panel ID="pnOtherActivities" runat="server">
                    <B>Other Activities</B>
                </asp:Panel>
                
                  <asp:Panel ID="pnOtherActivitiesNumber" runat="server">
                    <table>
                        <tr>
                            <td>
                                Student Participates in 
                            </td>
                            <td>
                                <asp:Label ID="lbOtherActivitiesNum" runat="server" ></asp:Label>
                            </td>
                        </tr>
                       
                    </table>

                </asp:Panel>
                         <asp:Panel ID="pnTreeOtherActivities" runat="server">
                  
      <telerik:RadTreeView ID="RadTreeOtherActivities" width="100%" runat="server" CheckBoxes="true" 
                TriStateCheckBoxes="true" CheckChildNodes="True" Skin="Glow" BorderColor="Black" ForeColor="Black" Enabled="False" >
            </telerik:RadTreeView>
                     </asp:Panel>
              
                </td>
          </tr>
     </table>
</asp:Content>
