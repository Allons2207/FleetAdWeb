<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="CaptureBookDetails.aspx.vb" Inherits="WebApplication2.CaptureBookDetails" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table>
        <tr>
            
<td style="font-size:medium; color:darkblue ">
           Capture Book Details
      
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
                Subjects
            </td>
            <td>
                <telerik:RadComboBox ID="cbSubjects" runat="server"></telerik:RadComboBox>
            </td>
        </tr>
        <tr>
            <td>
                Level
            </td>
            <td>
                <telerik:RadComboBox ID="cbLevel" runat="server"></telerik:RadComboBox>
            </td>
            <td>
                Book Title
            </td>
            <td>
                <asp:TextBox ID="txtBookTitle" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
         
            <td>
                Aurthor Firstname
            </td>
            <td>
                <asp:TextBox ID="txtAurthorFName" runat="server"></asp:TextBox>
            </td>
            
            <td>
                Aurthor Surname
            </td>
            <td>
                <asp:TextBox ID="txtAurthorSname" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                Version
            </td>
            <td>
                <telerik:RadComboBox ID="cbVersion" runat="server"></telerik:RadComboBox>
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
                Lending Days
            </td>
            <td>
                <asp:TextBox ID="txtLendingDays" runat="server"></asp:TextBox>
            </td>
            <td>
                Book Condition
            </td>
            <td>
                <telerik:RadComboBox ID="cbBookCondition" runat="server"></telerik:RadComboBox>
            </td>
        </tr>
        <tr>
            <td>
                Supplier
            </td>
            <td>
                <telerik:RadComboBox ID="cbSupplier" runat="server"></telerik:RadComboBox>
            </td>
            <td>
                Date Supplied
            </td>
            <td>
                <telerik:RadDatePicker ID="rdDateSupplied" runat="server"></telerik:RadDatePicker>
            </td>
        </tr>
        <tr>
               <td>
                Book Type
            </td>
            <td>
                <telerik:RadComboBox ID="cbBookType" runat="server"></telerik:RadComboBox>
            </td>
            <td>
                Book Serial Number
            </td>
            <td>
                <asp:TextBox ID="txtSerialNumber" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Button ID="cmdSave" runat="server" Text="Save" BackColor="#FF9933" Width="75px" />
            </td>
        </tr>
    </table>
</asp:Content>
