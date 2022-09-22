﻿<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="VehiclesWithNumberOfFittedTyresList.aspx.vb" Inherits="WebApplication2.VehiclesWithNumberOfFittedTyresList" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <table>
       <tr>
       <td style="font-size:medium; color:darkblue ">
           <br />
           List of Vehicles by Number of Fitted Tyres
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
            <td>
                <telerik:RadGrid ID="gwGrid" runat="server" AllowPaging="True" AllowSorting="True" BackColor="#DEBA84" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" DisplayMode="FirstLastPreviousNextNumeric, Text" ForeColor="Black" GroupPanelPosition="Top" PageSize="50">
                    <ClientSettings>
                        <Scrolling AllowScroll="True" />
                    </ClientSettings>
                </telerik:RadGrid>
            </td>
        </tr>
    </table>
</asp:Content>
