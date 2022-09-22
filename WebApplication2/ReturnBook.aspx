<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="ReturnBook.aspx.vb" Inherits="WebApplication2.ReturnBook" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>




<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style1 {
            height: 24px;
        }
        .auto-style2 {
            height: 20px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
         <table>
        <tr>
            
<td style="font-size:medium; color:darkblue ">
           Return Books      
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
            <td class="auto-style1">
                Borrower ID
            </td>
            <td class="auto-style1">
                <asp:TextBox ID="txtBorrowerID" runat="server"></asp:TextBox>
            </td>
            <td class="auto-style1">
                Borrower Name</td>
            <td class="auto-style1">
                <asp:TextBox ID="txtBorrowerName" runat="server"></asp:TextBox>
            </td>
            <td class="auto-style1">
                Aurthour</td>
            <td class="auto-style1">
                <asp:TextBox ID="txtAurthor" runat="server"></asp:TextBox>
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
                Book Type
            </td>
            <td>
                <telerik:RadComboBox ID="cbBookType" runat="server"></telerik:RadComboBox>
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
                    <telerik:RadGrid ID="gwSubjectSearch" runat="server"  BackColor="#DEBA84"  AllowPaging="True"  DisplayMode="FirstLastPreviousNextNumeric, Text" PageSize="50"
         BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" AllowSorting="True" GroupPanelPosition="Top"  ForeColor="Black">
                          <MasterTableView DataKeyNames="serialNumber">
             <Columns>
                  <telerik:GridButtonColumn ButtonType="LinkButton" Text="Return Book" CommandName="Return"></telerik:GridButtonColumn>
             </Columns>

         </MasterTableView>
                                      
     </telerik:RadGrid> 
            </td>
        </tr>
    </table>
      <asp:Panel ID="Panel1" runat="server" GroupingText="Selected Loaned Book Details" Visible="false" >
        <table width="100%">
            <tr>
                <td>
                    Book title
                </td>
                <td>
                    <asp:Label ID="lblBooktitle" runat="server" Text="" style="font-weight: 700"></asp:Label>
                </td>
                <td>
                    Aurthour
                </td>
                <td>
                    <asp:Label ID="lblAurthour" runat="server" Text="" style="font-weight: 700"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    Book Type
                </td>
                <td>
                    <asp:Label ID="lblBookType" runat="server" Text="" style="font-weight: 700"></asp:Label>
                </td>
           
                <td>
                    Book ID
                </td>
                <td>
                    <asp:Label ID="lblBookID" runat="server" Text="" style="font-weight: 700"></asp:Label>
                </td>
            </tr>
            <tr>
            <td class="auto-style2">
                Borrower Name
            </td>
                <td class="auto-style2">
                    <asp:Label ID="lblBorrowerName" runat="server" Text="" style="font-weight: 700"></asp:Label>
                </td>
                <td class="auto-style2">
                    Borrower ID
                </td>
                <td class="auto-style2">
                    <asp:Label ID="lblBorrowerID" runat="server" Text="" style="font-weight: 700"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    Date Borrowed
                </td>
                <td>
                    <asp:Label ID="lblDateBorrowed" runat="server" Text="" style="font-weight: 700"></asp:Label>
                </td>
                <td>
                    Date Due
                </td>
                <td>
                    <asp:Label ID="lblDateDue" runat="server" Text="" style="font-weight: 700"></asp:Label>
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:Panel ID="Panel2" runat="server" Visible="false" >
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
                    <asp:Label ID="lblDaysOverDue" runat="server" Text=""></asp:Label>
                </td>
                <td>
                    return status
                </td> <td>
                    <telerik:RadComboBox ID="cbReturnStatus" runat="server">
                        <Items>
                            <telerik:RadComboBoxItem runat="server" Text="Good" Value="Available" />
                            <telerik:RadComboBoxItem runat="server" Text="Damaged" Value="Damaged" />
                            <telerik:RadComboBoxItem runat="server" Text="Lost" Value="Not Available" />
                        </Items>
                    </telerik:RadComboBox> </td>
            </tr><tr>
                <td>
                    <asp:Button ID="cmdSave" runat="server" Text="Save" Width="81px" BackColor="#FF9933" />
                </td>
                 </tr>
            
        </table>
    </asp:Panel>
</asp:Content>
