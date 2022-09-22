<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="ViewBehaviours.aspx.vb" Inherits="WebApplication2.ViewBehaviours" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <table>
    <tr>
        <td style="font-size:medium; color:darkblue ">
            View Students Behaviour
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
                Incident No
            </td>
            <td>
                <asp:TextBox ID="txtIncidentNo" runat="server"></asp:TextBox>
            </td>
            <td>
                Offender ID
            </td>
            <td>
                <asp:TextBox ID="txtOffenderID" runat="server"></asp:TextBox>
            </td>
            <td>
                Incident Type
            </td>
            <td>
                <telerik:RadComboBox ID="cbIncidentType" runat="server"></telerik:RadComboBox>
            </td>
        </tr>
        <tr>
            <td>
                Incident Level
            </td>
            <td>
                <telerik:RadComboBox ID="cbIncidentLevel" runat="server"></telerik:RadComboBox>
            </td>
            <td>
                Offender Category
            </td>
            <td>
                <telerik:RadComboBox ID="cbOffendeCategory" runat="server">
                    <Items>
                        <telerik:RadComboBoxItem runat="server" Value="1" />
                        <telerik:RadComboBoxItem runat="server" Text="Student(s)" Value="2" />
                    </Items>
                </telerik:RadComboBox>
            </td>
            <td>
                Disciplinary Action
            </td>
            <td>
                <telerik:RadComboBox ID="cbDisciplinaryAction" runat="server"></telerik:RadComboBox>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Button ID="cmdSearch" runat="server" Text="Search" BackColor="#FF9933" />
            </td>
        </tr>
    </table>
    <table width ="100%">
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
