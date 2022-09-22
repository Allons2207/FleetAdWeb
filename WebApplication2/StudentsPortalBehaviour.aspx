<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/StudentsPortalMaster.Master" CodeBehind="StudentsPortalBehaviour.aspx.vb" Inherits="WebApplication2.StudentsPortalBehaviour" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table width ="90%">
         <tr>
       <td style="font-size:medium; color:darkblue " colspan="6">
           Student Behavior</td>
       </tr>
       <tr>
         <td>
             <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small"></asp:Label>
         </td>
        </tr>
                            <tr>
                                <td>
                                    <telerik:RadGrid ID="gwBehaviourSearch" runat="server" Width ="100%"  BackColor="White"  AllowPaging="True"  DisplayMode="FirstLastPreviousNextNumeric, Text" PageSize="50"
                                                    BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" AllowSorting="True" GroupPanelPosition="Top"  ForeColor="Black">
                                    <ClientSettings>
                                        <Scrolling AllowScroll="True"  />
                                    </ClientSettings>
                   
                                        <AlternatingItemStyle BackColor="#E9E9E9" />
                   
                                    </telerik:RadGrid>   
                                </td>
                            </tr>
                        </table>
</asp:Content>
