<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="Lending.aspx.vb" Inherits="WebApplication2.Lending" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Panel ID="Panel1" runat="server" GroupingText="Book Details">
    <table width ="100%">
        <tr>
            <td>
                Subject
            </td>
            <td>
                <asp:Label ID="lblSubject" runat="server" Text=""></asp:Label>
            </td>
            <td>
                Book Title
            </td>
            <td>
                <asp:Label ID="lblBookTitle" runat="server" Text=""></asp:Label>
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
                Level
            </td>
            <td>
                <asp:Label ID="lblLevel" runat="server" Text=""></asp:Label>
            </td>
            <td>
                Available
            </td>
            <td>
                <asp:Label ID="lblAvaible" runat="server" Text=""></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                Book Id
            </td>
            <td>
                <asp:Label ID="lblBookId" runat="server" Text=""></asp:Label>
              </td>
            <td>
                Book Serial Number
            </td>
            <td>
                <asp:Label ID="lblSerialNumber" runat="server" Text=""></asp:Label>
            </td>
        </tr>
    </table>
 </asp:Panel>
    <asp:Panel ID="Panel2"  GroupingText="Student Details" runat="server">
        <table width="100%">
            <tr>
                <td>
                    Name
                </td>
                <td>
                    <asp:TextBox ID="txtName" runat="server"></asp:TextBox>

                </td>
                <td>
                    Borrower Category
                </td>
                <td>
                    <asp:TextBox ID="txtBorrowerCategory" runat="server"></asp:TextBox>
                </td>
                <td>
                    Borrower
                </td>
                <td>
                    <asp:TextBox ID="txtBorrower" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Button ID="Button1" runat="server" Text="Check Borrowers History" BackColor="#FF9933" />
                </td>
            </tr>
        </table>
        
    </asp:Panel>
    <asp:Panel ID="Panel3" runat="server" GroupingText ="Loaning Details" >
        <table width ="100%">
            <tr>
                <td>
                    Date Loaned Out
                </td>
                <td>
                    <telerik:RadDatePicker ID="rdDateLoanedOut" runat="server"></telerik:RadDatePicker>
                </td>
                <td>
                    Loan Days
                </td>
                <td>
                    <asp:TextBox ID="txtLoanDays" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    Due Date
                </td>
                <td>
                    <telerik:RadDatePicker ID="rdDueDate" runat="server"></telerik:RadDatePicker>
                </td>
                <td>
                    Penalty Rate
                </td>
                <td>
                    <asp:TextBox ID="txtPenaltyRate" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    Comments
                </td>
                <td>
                    <asp:TextBox ID="txtComments" runat="server" TextMode="MultiLine"></asp:TextBox>
                </td>
            </tr>
        </table>
    </asp:Panel>
    <table>
        <tr>
            <td>
                <asp:Button ID="cmdSave" runat="server" Text="Save" BackColor="#FF9933" Width="73px" />
            </td>
        </tr>
    </table>
</asp:Content>
