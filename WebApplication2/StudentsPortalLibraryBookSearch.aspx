<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/StudentsPortalMaster.Master" CodeBehind="StudentsPortalLibraryBookSearch.aspx.vb" Inherits="WebApplication2.StudentsPortalLibraryBookSearch" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
             <table>
        <tr>
            
          <td style="font-size:medium; color:darkblue ">
           Search Books      
            </td>
        </tr>
         <tr>
             <td>
                 <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small"></asp:Label>
             </td>
         </tr>
    </table>
    <table width ="100%">
        <tr>
            <td>
                Book Number
            </td>
            <td>
                <asp:TextBox ID="txtBookNumber" runat="server"></asp:TextBox>
            </td>
            <td>
                Aurthor FirstName
            </td>
            <td>
                <asp:TextBox ID="txtAurthorFName" runat="server"></asp:TextBox>
            </td>
            <td>
                Aurthor Surname
            </td>
            <td>
                <asp:TextBox ID="txtAurthorSurname" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                 Book Level
            </td>
           <td>
               <telerik:RadComboBox ID="cblevel" runat="server"></telerik:RadComboBox>
           </td>
            <td>
                Book Subject
            </td>
            <td>
                <telerik:RadComboBox ID="cbSubject" runat="server"></telerik:RadComboBox>
            </td>
            <td>
                Book Type
            </td>
            <td>
                <telerik:RadComboBox ID="cbBookType" runat="server"></telerik:RadComboBox>
            </td>

        </tr>
        <tr>
            <td>
                Book Title
            </td>
            <td>
                <asp:TextBox ID="txtBookTitle" runat="server"></asp:TextBox>
            </td>
            <td>
                Book Serial Number
            </td>
            <td>
                <asp:TextBox ID="txtSerialNumber" runat="server"></asp:TextBox>
            </td>
            <td>
                Year Published
            </td>
            <td>
                <asp:TextBox ID="txtYearPublished" runat="server"></asp:TextBox>
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
                    <telerik:RadGrid ID="gwSubjectSearch" runat="server"  BackColor="White"  AllowPaging="True"  DisplayMode="FirstLastPreviousNextNumeric, Text" PageSize="50"
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