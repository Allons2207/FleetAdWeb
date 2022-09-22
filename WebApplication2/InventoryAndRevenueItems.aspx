<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="InventoryAndRevenueItems.aspx.vb" Inherits="WebApplication2.InventoryAndRevenueItems" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style1 {
            width: 418px;
        }
        .auto-style2 {
            width: 225px;
        }
        .auto-style3 {
            width: 200px;
            height: 25px;
        }
        .auto-style4 {
            width: 225px;
            height: 25px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
       <table>
        <tr>
    <td style="font-size:medium; color:darkblue ">
           Inventory and Revenue Items Management
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
            <td class="auto-style1">
                <asp:Panel ID="Panel2" runat="server">
                    <table>
                        <tr>
                            <td>
                                Existing Inventory and Revenue Items
                            </td>
                        </tr>
                        <tr>
                            <td>
                                 <asp:ListBox ID="lbItems" runat="server" Height="323px" Width="332px"></asp:ListBox>
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
                            <td class="auto-style4">
                                Inventory or Revenue Item Name
                            </td>
                            <td class="auto-style3">
                                <asp:TextBox ID="txtItemName" runat="server" Width="211px"></asp:TextBox>
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

