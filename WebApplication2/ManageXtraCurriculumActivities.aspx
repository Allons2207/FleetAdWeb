<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="ManageXtraCurriculumActivities.aspx.vb" Inherits="WebApplication2.ManageXtraCurriculumActivities" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style2 {
            width: 614px;
        }
        .auto-style3 {
            width: 603px;
        }
        .auto-style4 {
            width: 595px;
        }
        .auto-style5 {
            width: 552px;
        }
        .auto-style6 {
            width: 442px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <table>
        <tr>
    <td style="font-size:medium; color:darkblue ">
           Manage Extra-Curriculum Activities
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
            <td class="auto-style6">
                <asp:Panel ID="Panel2" runat="server">
                    <table>
                        <tr>
                            <td>
                                Activities
                            </td>
                        </tr>
                        <tr>
                            <td>
                                 <asp:ListBox ID="lbActivities" runat="server" Height="323px" Width="332px"></asp:ListBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Button ID="cmdAddNew" runat="server" Text="Add New" />
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
               </td>
            <td style="vertical-align:top">
                <asp:Panel ID="Panel1" runat="server" Width="638px">
                    <table width="100%">
                        <tr>
                            <td></td>
                        </tr>
                        <tr>
                            <td class="auto-style4">
                                Activity Name
                            </td>
                            <td class="auto-style3">
                                <asp:TextBox ID="txtActivityName" runat="server" Width="211px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>

                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style2">
                                <asp:Button ID="cmdSave" runat="server" Text="Save" Width="90px" BackColor="#FF9900" />
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
    </table>   
</asp:Content>
