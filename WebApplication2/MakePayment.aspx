<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="MakePayment.aspx.vb" Inherits="WebApplication2.MakePayment" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
    <style type="text/css">
    .auto-style1 {
        height: 24px;
    }
        .auto-style2 {
            height: 20px;
        }
    .RadComboBox_Default{color:#333;font-size:12px;font-family:"Segoe UI",Arial,Helvetica,sans-serif}.RadComboBox{text-align:left;display:inline-block;vertical-align:middle;white-space:nowrap;*display:inline;*zoom:1}.RadComboBox{text-align:left;display:inline-block;vertical-align:middle;white-space:nowrap;*display:inline;*zoom:1}.RadComboBox_Default{color:#333;font-size:12px;font-family:"Segoe UI",Arial,Helvetica,sans-serif}.RadComboBox{text-align:left;display:inline-block;vertical-align:middle;white-space:nowrap;*display:inline;*zoom:1}.RadComboBox_Default{color:#333;font-size:12px;font-family:"Segoe UI",Arial,Helvetica,sans-serif}.RadComboBox{text-align:left;display:inline-block;vertical-align:middle;white-space:nowrap;*display:inline;*zoom:1}
        .RadComboBox_Default{color:#333;font-size:12px;font-family:"Segoe UI",Arial,Helvetica,sans-serif}.RadComboBox .rcbReadOnly .rcbInputCellLeft{background-position:0 -88px}.RadComboBox .rcbReadOnly .rcbInputCellLeft{background-position:0 -88px}.RadComboBox .rcbReadOnly .rcbInputCellLeft{background-position:0 -88px}.RadComboBox .rcbReadOnly .rcbInputCellLeft{background-position:0 -88px}.RadComboBox_Default .rcbInputCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbInputCellLeft{background-position:0 0}.RadComboBox .rcbInputCell{padding-right:4px;padding-left:5px;width:100%;height:20px;line-height:20px;text-align:left;vertical-align:middle}.RadComboBox .rcbInputCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox .rcbInputCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox .rcbInputCell{padding-right:4px;padding-left:5px;width:100%;height:20px;line-height:20px;text-align:left;vertical-align:middle}.RadComboBox .rcbInputCellLeft{background-position:0 0}.RadComboBox_Default .rcbInputCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbInputCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox .rcbInputCell{padding-right:4px;padding-left:5px;width:100%;height:20px;line-height:20px;text-align:left;vertical-align:middle}.RadComboBox .rcbInputCellLeft{background-position:0 0}.RadComboBox_Default .rcbInputCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbInputCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox .rcbInputCell{padding-right:4px;padding-left:5px;width:100%;height:20px;line-height:20px;text-align:left;vertical-align:middle}.RadComboBox .rcbInputCellLeft{background-position:0 0}.RadComboBox_Default .rcbInputCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbReadOnly .rcbArrowCellRight{background-position:-162px -176px}.RadComboBox .rcbReadOnly .rcbArrowCellRight{background-position:-162px -176px}.RadComboBox .rcbReadOnly .rcbArrowCellRight{background-position:-162px -176px}.RadComboBox .rcbReadOnly .rcbArrowCellRight{background-position:-162px -176px}.RadComboBox_Default .rcbArrowCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbArrowCellRight{background-position:-18px -176px}.RadComboBox .rcbArrowCell{width:18px}.RadComboBox .rcbArrowCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox .rcbArrowCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}
        .RadComboBox .rcbArrowCell{width:18px}.RadComboBox .rcbArrowCellRight{background-position:-18px -176px}.RadComboBox_Default .rcbArrowCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbArrowCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox .rcbArrowCell{width:18px}.RadComboBox .rcbArrowCellRight{background-position:-18px -176px}.RadComboBox_Default .rcbArrowCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbArrowCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox .rcbArrowCell{width:18px}.RadComboBox .rcbArrowCellRight{background-position:-18px -176px}.RadComboBox_Default .rcbArrowCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}
        .auto-style3 {
            border-width: 0;
            padding-left: 5px;
            padding-right: 4px;
            padding-top: 0;
            padding-bottom: 0;
        }
        .auto-style4 {
            border-width: 0;
            padding: 0;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
     <table width ="80%">
    <tr>
        <td style="font-size:medium; color:darkblue ">
            Tuition, Levy and Registration Payment
        </td>
    </tr>
          <tr>
             <td>
                <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small"></asp:Label>
            </td>
          </tr>
      </table>
    <asp:Panel ID="Panel1" runat="server" GroupingText="Student Details">
    <table width ="80%">
        <tr>
            <td>
                StudentID
            </td>
            <td>
                <asp:TextBox ID="txtStudentID" runat="server"></asp:TextBox> &nbsp;&nbsp
                <asp:Button ID="cmdShowStudentDets" runat="server" Text="Search" Width="77px" />
            </td>
            <td>
                First Name
            </td>
            <td>
                <asp:TextBox ID="txtFirstName" runat="server" Enabled="False"></asp:TextBox>
            </td>
            <td>
                Surname
            </td>
            <td>
                <asp:TextBox ID="txtSurname" runat="server" Enabled="False"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                Stream
            </td>
            <td>
                <asp:TextBox ID="txtStream" runat="server" Enabled="False"></asp:TextBox>
            </td>
            <td>
              Class
            </td>
            <td>
                <asp:TextBox ID="txtClass" runat="server" Enabled="False"></asp:TextBox>

            </td>
               <td>Number of subjects </td>
            <td>
                <asp:TextBox ID="txtNumOfSubjects" runat="server" Enabled="False"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>Registration Date</td>
            <td>
                <asp:TextBox ID="txtRegistrationDate" runat="server" Enabled="False"></asp:TextBox>
            </td>
         
        </tr>
        <tr>
            <td> Student registered computers</td>
            <td>
                <asp:CheckBox ID="txtRegComps" runat="server" Enabled="False" />
            </td>
        </tr>
    </table>
        </asp:Panel>

<asp:Panel ID="Panel2" runat="server" GroupingText="Payments">
    <table>
        
        <tr><td>&nbsp</td></tr>
        <tr>
            <td class="auto-style2">
                
            </td>
            
            <td class="auto-style2">Arrears B/F </td>
            <td class="auto-style2"> Curr Amt</td>
            <td class="auto-style2"> Penalty </td>
            <td class="auto-style2"> Amt Due </td>
            <td class="auto-style2"> Amt Paid </td>
            <td class="auto-style2"> Balance </td>
        </tr>
<%--        <tr>
            <td class="auto-style1">Registration Fees</td>
                       <td class="auto-style1">
                <asp:TextBox ID="txtRegFeesArrears" runat="server"></asp:TextBox>
            </td>
            <td class="auto-style1">
                <asp:TextBox ID="txtRegFeesCurr" runat="server"></asp:TextBox>
            </td>
            <td class="auto-style1">
                <asp:TextBox ID="txtRegFeePenalty" runat="server"></asp:TextBox></td>
            <td class="auto-style1">
                <asp:TextBox ID="txtRegFeeAmtDue" runat="server"></asp:TextBox>
            </td>
            <td class="auto-style1"> <asp:TextBox ID="txtRegFeeAmtPaid" runat="server"></asp:TextBox></td>
            <td class="auto-style1">
                <asp:TextBox ID="txtRegFeeBalance" runat="server"></asp:TextBox></td>
        </tr>--%>
        <tr>
            <td>Tuition Fees</td>
            
            <td>
                <asp:TextBox ID="txtTuitionArrears" runat="server"></asp:TextBox>
            </td>
                <td>
                <asp:TextBox ID="txtTuitionCurr" runat="server"></asp:TextBox>
            </td>
            <td>
                <asp:TextBox ID="txtTuitionPenalty" runat="server"></asp:TextBox></td>
            <td>
                <asp:TextBox ID="txtTuitionAmtDue" runat="server"></asp:TextBox></td>
            <td>
                <asp:TextBox ID="txtTuitionAmtPaid" runat="server"></asp:TextBox></td>
            <td>
                <asp:TextBox ID="txtTuitionBalance" runat="server"></asp:TextBox></td>
            </tr>
        <tr>
            <td>Levy</td>
            
            <td>
                <asp:TextBox ID="txtLevyArrears" runat="server"></asp:TextBox>
            </td>
            <td>
                <asp:TextBox ID="txtLevyCurr" runat="server"></asp:TextBox>
            </td>
            <td>
                <asp:TextBox ID="txtLevyPenalty" runat="server"></asp:TextBox></td>
            <td>
                <asp:TextBox ID="txtLevyAmtDue" runat="server"></asp:TextBox></td>
            <td>
                <asp:TextBox ID="txtLevyAmtPaid" runat="server"></asp:TextBox></td>
            <td>
                <asp:TextBox ID="txtLevyBalance" runat="server"></asp:TextBox></td>
        </tr>
        <tr>
            <td></td>
        </tr>
        <tr><td><b>SubTotals</b></td>
            
            <td>
                <asp:TextBox ID="txtArrearsTotal" runat="server" BackColor="cyan"></asp:TextBox></td>
            <td>
                <asp:TextBox ID="txtCurrTotal" runat="server" BackColor="cyan"></asp:TextBox></td>
            <td>
                <asp:TextBox ID="txtPenaltyTotal" runat="server" BackColor="cyan"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="txtAmtDueTotal" runat="server" BackColor="cyan"></asp:TextBox></td>
            <td>
                <asp:TextBox ID="txtAmtPaidTotal" runat="server" BackColor="cyan"></asp:TextBox></td>
            <td>
                <asp:TextBox ID="txtBalanceTotal" runat="server" BackColor="cyan"></asp:TextBox></td>
        </tr>
       <%--   <tr>
              <td>
                  Payment Date
              </td>
              <td>
                  <telerik:RadDatePicker ID="datePenalt" runat="server"></telerik:RadDatePicker>
              </td>
          </tr>--%>
        <tr><td>&nbsp</td></tr>
                <tr><td>Method of Payment</td><td colspan="2">
            <telerik:RadComboBox ID="radCboMethodOfPayment" Runat="server" AutoPostBack="True" Height="16px" Width="248px">
            </telerik:RadComboBox>
            </td></tr>
        <tr><td></td></tr>
        <tr><td>Notes/Comments</td><td colspan="6"><asp:TextBox ID="txtNotesComments" runat="server" Height="55px" TextMode="MultiLine" Width="757px"></asp:TextBox></td></tr>
    <tr><td>&nbsp</td></tr>

    
    
    </table>
</asp:Panel>
    <asp:Panel ID="Panel3" runat="server" GroupingText="Other Payments" Visible="false">
        <table width="100%">
            <tr>
                <td>Other</td>
                <td>
                    <asp:DropDownList ID="DropDownListOtherPayments" runat="server"></asp:DropDownList>
                </td>
            </tr>

        </table>    </asp:Panel>
    <asp:Panel ID="Panel4" runat="server" >
        <telerik:RadListView ID="RadListViewPAYMENTS" runat="server"></telerik:RadListView>
        <table>
            <tr>
                <td>Receipt Number</td>
                <td>
                    <asp:TextBox ID="txtReceiptrNumber" runat="server" Enabled="False"></asp:TextBox></td>
                <td></td>
                <td>
                    <asp:Button ID="cmdSaveShow" runat="server" Text="Capture Payment" /></td>
            </tr>
        </table>
        

        <table width="100%">
           
             <tr>
                <td>&nbsp</td>
            </tr>

            
             <tr>
                <td><table>
                    <tr>
                <td>View Payments by Type</td><td>
                 <telerik:RadComboBox ID="cboItemType" runat="server">
                     <Items>
                         <telerik:RadComboBoxItem runat="server" Text="Tuition" Value="Tuition" />
                         <telerik:RadComboBoxItem runat="server" Text="Levy" Value="Levy" />
                         <telerik:RadComboBoxItem runat="server" Text="All Payments" Value="All Payments" />
                     </Items>
                 </telerik:RadComboBox>
                 </td><td><asp:Button ID="btnShowPaymentsGrid" runat="server" Text="Show Payments" /></td>
            </tr>
                    </table></td>
            </tr>
            <tr>
                <td>
                    <telerik:RadGrid ID="gwTuitionPayments" runat="server" AllowPaging="True" AllowSorting="True" BackColor="White" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" DisplayMode="FirstLastPreviousNextNumeric, Text" ForeColor="Black" GroupPanelPosition="Top" PageSize="50">
                        <ClientSettings>
                            <Scrolling AllowScroll="True" />
                        </ClientSettings>
                        <AlternatingItemStyle BackColor="#E5E5E5" />
                    </telerik:RadGrid>


                </td>
            </tr>
        </table>
    </asp:Panel>
</asp:Content>