<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="Returning.aspx.vb" Inherits="WebApplication2.Returning" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Panel ID="Panel1" runat="server" GroupingText="Selected Loaned Book Details">
        <table width="100%">
            <tr>
                <td>
                    Book title
                </td>
                <td>
                    <asp:Label ID="lblBooktitle" runat="server" Text=""></asp:Label>
                </td>
                <td>
                    Aurthour
                </td>
                <td>
                    <asp:Label ID="lblAurthour" runat="server" Text=""></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    Book Type
                </td>
                <td>
                    <asp:Label ID="lblBookType" runat="server" Text=""></asp:Label>
                </td>
           
                <td>
                    Book ID
                </td>
                <td>
                    <asp:Label ID="lblBookID" runat="server" Text=""></asp:Label>
                </td>
            </tr>
            <tr>
            <td>
                Borrower Name
            </td>
                <td>
                    <asp:Label ID="lblBorrowerName" runat="server" Text=""></asp:Label>
                </td>
                <td>
                    Borrower ID
                </td>
                <td>
                    <asp:Label ID="lblBorrowerID" runat="server" Text=""></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    Date Borrowed
                </td>
                <td>
                    <asp:Label ID="lblDateBorrowed" runat="server" Text=""></asp:Label>
                </td>
                <td>
                    Date Due
                </td>
                <td>
                    <asp:Label ID="lblDateDue" runat="server" Text=""></asp:Label>
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:Panel ID="Panel2" runat="server">
        <table width ="100%">
            <tr>
                <td>
                    Return Date
                </td>
                <td>
                    <telerik:RadDatePicker ID="rdReturnDate" runat="server"></telerik:RadDatePicker>
                </td>
                <td>
                    Penalty
                </td>
                <td>
                    <asp:TextBox ID="txtPenalty" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    Days OverDue
                </td>
                <td>
                    <asp:Label ID="lblDaysOverDue" runat="server" Text="Label"></asp:Label>
                </td>
                <td>

                </td><td> <asp:Button ID="cmdSave" runat="server" Text="Save" Width="81px" /></td>
            </tr>
        </table>
    </asp:Panel>
</asp:Content>
