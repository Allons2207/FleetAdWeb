<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="LendBook.aspx.vb" Inherits="WebApplication2.LendBook" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
         <table>
        <tr>
            
<td style="font-size:medium; color:darkblue ">
           Lend Books      
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
                Author FirstName
            </td>
            <td>
                <asp:TextBox ID="txtAurthorFName" runat="server"></asp:TextBox>
            </td>
            <td>
                Author Surname
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
                    <telerik:RadGrid ID="gwSubjectSearch" runat="server"  BackColor="#DEBA84"  AllowPaging="True"  DisplayMode="FirstLastPreviousNextNumeric, Text" PageSize="50"
         BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" AllowSorting="True" GroupPanelPosition="Top"  ForeColor="Black" >
                      <MasterTableView DataKeyNames="bookId">
             <Columns>
                 <telerik:GridButtonColumn ButtonType="LinkButton" Text="Lend Book" CommandName="Lend"></telerik:GridButtonColumn>
             </Columns>

         </MasterTableView>
                                      
     </telerik:RadGrid> 
            </td>
        </tr>
    </table>
    <asp:Panel ID="Panel1" runat="server" GroupingText="Book Details" Visible="false" >
    <table width ="100%">
        <tr>
            <td>
                Subject
            </td>
            <td>
                <asp:Label ID="lblSubject" runat="server" Font-Bold="True"></asp:Label>
            </td>
            <td>
                Book Title
            </td>
            <td>
                <asp:Label ID="lblBookTitle" runat="server" Text="" style="font-weight: 700"></asp:Label>
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
                Level
            </td>
            <td>
                <asp:Label ID="lblLevel" runat="server" Text="" style="font-weight: 700"></asp:Label>
            </td>
            <td>
                Available
            </td>
            <td>
                <asp:Label ID="lblAvaible" runat="server" Text="" style="font-weight: 700"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                Book Id
            </td>
            <td>
                <asp:Label ID="lblBookId" runat="server" Text="" style="font-weight: 700"></asp:Label>
              </td>
            <td>
                Book Serial Number
            </td>
            <td>
                <asp:Label ID="lblSerialNumber" runat="server" Text="" style="font-weight: 700"></asp:Label>
            </td>
        </tr>
    </table>
 </asp:Panel>
    <asp:Panel ID="Panel2"  GroupingText="Student Details" runat="server" Visible="false" >
        <table width="100%">
            <tr>
                <td>
                    Borrower ID</td>
                <td>
                    <asp:TextBox ID="txtBorrowerID" runat="server"></asp:TextBox>

                </td>
                <td>
                    Borrower Category
                </td>
                <td>
                    <asp:TextBox ID="txtBorrowerCategory" runat="server" Enabled="False"></asp:TextBox>
                </td>
                <td>
                    Borrower Name</td>
                <td>
                    <asp:TextBox ID="txtBorrowerName" runat="server" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Button ID="cmdCheckerBorrowerHistory" runat="server" Text="Check Borrowers History" BackColor="#FF9933" />
                </td>
            </tr>
            </table>
        <table width = "100%">
            <tr>
                <td>
                    <telerik:RadGrid ID="RadListViewStaffQualifications" runat="server" BackColor="#DEBA84"  AllowPaging="True"  DisplayMode="FirstLastPreviousNextNumeric, Text" PageSize="50"
         BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" AutoGenerateSelectButton ="true" CellSpacing="2" AllowSorting="True" GroupPanelPosition="Top" ForeColor="Black"></telerik:RadGrid>
                </td>
            </tr>
        </table>
        
    </asp:Panel>
    <asp:Panel ID="Panel3" runat="server" GroupingText ="Loaning Details" visible="false"  >
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
                    <asp:TextBox ID="txtLoanDays" runat="server" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    Due Date
                </td>
                <td>
                    <telerik:RadDatePicker ID="rdDueDate" runat="server" AutoPostBack="True" Culture="en-ZW">
                        <Calendar EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;" UseColumnHeadersAsSelectors="False" UseRowHeadersAsSelectors="False">
                        </Calendar>
                        <DateInput AutoPostBack="True" DateFormat="d/M/yyyy" DisplayDateFormat="d/M/yyyy" LabelWidth="40%">
                            <EmptyMessageStyle Resize="None" />
                            <ReadOnlyStyle Resize="None" />
                            <FocusedStyle Resize="None" />
                            <DisabledStyle Resize="None" />
                            <InvalidStyle Resize="None" />
                            <HoveredStyle Resize="None" />
                            <EnabledStyle Resize="None" />
                        </DateInput>
                        <DatePopupButton HoverImageUrl="" ImageUrl="" />
                    </telerik:RadDatePicker>
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
         <table>
        <tr>
            <td>
                <asp:Button ID="cmdSave" runat="server" Text="Save" BackColor="#FF9933" Width="73px" />
            </td>
        </tr>
    </table>
    </asp:Panel>
   
</asp:Content>
