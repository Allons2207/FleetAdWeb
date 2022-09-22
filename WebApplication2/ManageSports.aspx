<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="ManageSports.aspx.vb" Inherits="WebApplication2.ManageSports" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style1 {
            height: 20px;
        }
        .auto-style2 {
            height: 20px;
            width: 674px;
        }
        .auto-style3 {
            height: 20px;
            width: 455px;
        }
        .auto-style4 {
            width: 720px;
        }
        .auto-style5 {
            width: 674px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <table>
        <tr>
    <td style="font-size:medium; color:darkblue ">
           Manage Sports
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
            <td class="auto-style3">
                <asp:Panel ID="Panel2" runat="server">
                    <table>
                        <tr>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style1">
                                Sports
                            </td>
                        </tr>
                        <tr>
                            <td>
                                 <asp:ListBox ID="lbSports" runat="server" Height="323px" Width="332px"></asp:ListBox>
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
                <asp:Panel ID="Panel1" runat="server">
                    <table width="100%">
                        <tr>
                            <td>
                                Sport Name
                            </td>
                            <td >
                                <asp:TextBox ID="txtSportName" runat="server" Width="206px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>

                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Button ID="cmdSave" runat="server" Text="Save" Width="90px" BackColor="#FF9900" />
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
    </table>  
</asp:Content>
