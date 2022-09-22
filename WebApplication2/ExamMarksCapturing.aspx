<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="ExamMarksCapturing.aspx.vb" Inherits="WebApplication2.ExamMarksCapturing" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
.RadComboBox_Default{color:#333;font-size:12px;font-family:"Segoe UI",Arial,Helvetica,sans-serif}.RadComboBox{text-align:left;display:inline-block;vertical-align:middle;white-space:nowrap;*display:inline;*zoom:1}.RadComboBox_Default{color:#333;font-size:12px;font-family:"Segoe UI",Arial,Helvetica,sans-serif}.RadComboBox{text-align:left;display:inline-block;vertical-align:middle;white-space:nowrap;*display:inline;*zoom:1}.RadComboBox{text-align:left;display:inline-block;vertical-align:middle;white-space:nowrap;*display:inline;*zoom:1}.RadComboBox_Default{color:#333;font-size:12px;font-family:"Segoe UI",Arial,Helvetica,sans-serif}.RadComboBox{text-align:left;display:inline-block;vertical-align:middle;white-space:nowrap;*display:inline;*zoom:1}.RadComboBox_Default{color:#333;font-size:12px;font-family:"Segoe UI",Arial,Helvetica,sans-serif}.RadComboBox{text-align:left;display:inline-block;vertical-align:middle;white-space:nowrap;*display:inline;*zoom:1}.RadComboBox_Default{color:#333;font-size:12px;font-family:"Segoe UI",Arial,Helvetica,sans-serif}.RadComboBox{text-align:left;display:inline-block;vertical-align:middle;white-space:nowrap;*display:inline;*zoom:1}
.RadComboBox_Default{color:#333;font-size:12px;font-family:"Segoe UI",Arial,Helvetica,sans-serif}.RadComboBox .rcbReadOnly .rcbInputCellLeft{background-position:0 -88px}.RadComboBox .rcbReadOnly .rcbInputCellLeft{background-position:0 -88px}.RadComboBox .rcbReadOnly .rcbInputCellLeft{background-position:0 -88px}.RadComboBox .rcbReadOnly .rcbInputCellLeft{background-position:0 -88px}.RadComboBox .rcbReadOnly .rcbInputCellLeft{background-position:0 -88px}.RadComboBox .rcbReadOnly .rcbInputCellLeft{background-position:0 -88px}.RadComboBox_Default .rcbInputCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbInputCellLeft{background-position:0 0}.RadComboBox .rcbInputCell{padding-right:4px;padding-left:5px;width:100%;height:20px;line-height:20px;text-align:left;vertical-align:middle}.RadComboBox .rcbInputCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox_Default .rcbInputCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbInputCellLeft{background-position:0 0}.RadComboBox .rcbInputCell{padding-right:4px;padding-left:5px;width:100%;height:20px;line-height:20px;text-align:left;vertical-align:middle}.RadComboBox .rcbInputCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox .rcbInputCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox .rcbInputCell{padding-right:4px;padding-left:5px;width:100%;height:20px;line-height:20px;text-align:left;vertical-align:middle}.RadComboBox .rcbInputCellLeft{background-position:0 0}.RadComboBox_Default .rcbInputCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbInputCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox .rcbInputCell{padding-right:4px;padding-left:5px;width:100%;height:20px;line-height:20px;text-align:left;vertical-align:middle}.RadComboBox .rcbInputCellLeft{background-position:0 0}.RadComboBox_Default .rcbInputCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbInputCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox .rcbInputCell{padding-right:4px;padding-left:5px;width:100%;height:20px;line-height:20px;text-align:left;vertical-align:middle}.RadComboBox .rcbInputCellLeft{background-position:0 0}.RadComboBox_Default .rcbInputCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbInputCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox .rcbInputCell{padding-right:4px;padding-left:5px;width:100%;height:20px;line-height:20px;text-align:left;vertical-align:middle}.RadComboBox .rcbInputCellLeft{background-position:0 0}.RadComboBox_Default .rcbInputCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbReadOnly .rcbArrowCellRight{background-position:-162px -176px}.RadComboBox .rcbReadOnly .rcbArrowCellRight{background-position:-162px -176px}.RadComboBox .rcbReadOnly .rcbArrowCellRight{background-position:-162px -176px}.RadComboBox .rcbReadOnly .rcbArrowCellRight{background-position:-162px -176px}.RadComboBox .rcbReadOnly .rcbArrowCellRight{background-position:-162px -176px}.RadComboBox .rcbReadOnly .rcbArrowCellRight{background-position:-162px -176px}.RadComboBox_Default .rcbArrowCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbArrowCellRight{background-position:-18px -176px}.RadComboBox .rcbArrowCell{width:18px}.RadComboBox .rcbArrowCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox_Default .rcbArrowCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbArrowCellRight{background-position:-18px -176px}.RadComboBox .rcbArrowCell{width:18px}.RadComboBox .rcbArrowCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox .rcbArrowCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}
    .RadComboBox .rcbArrowCell{width:18px}.RadComboBox .rcbArrowCellRight{background-position:-18px -176px}.RadComboBox_Default .rcbArrowCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbArrowCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox .rcbArrowCell{width:18px}.RadComboBox .rcbArrowCellRight{background-position:-18px -176px}.RadComboBox_Default .rcbArrowCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbArrowCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox .rcbArrowCell{width:18px}.RadComboBox .rcbArrowCellRight{background-position:-18px -176px}.RadComboBox_Default .rcbArrowCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbArrowCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox .rcbArrowCell{width:18px}.RadComboBox .rcbArrowCellRight{background-position:-18px -176px}.RadComboBox_Default .rcbArrowCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}
    .auto-style1 {
        border-width: 0;
        padding-left: 5px;
        padding-right: 4px;
        padding-top: 0;
        padding-bottom: 0;
    }
    .auto-style2 {
        border-width: 0;
        padding: 0;
    }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table width ="75%">
      
      <tr><td colspan="4">

          <table>

               <tr><td>&nbsp</td></tr>
       <tr>
       <td style="font-size:medium; color:darkblue ">
           Examination Marks Capturing
       </td>
       </tr>
       <tr>
         <td>
             <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small"></asp:Label>
         </td>
        </tr>
       <tr><td>&nbsp</td></tr>
       <tr><td>Exam Code</td><td>                      
                                <asp:TextBox ID="txtExamCode" runat="server"></asp:TextBox>
                               
                            </td><td> <asp:Button ID="btnSearch" runat="server" Text="Search Examination" /></td> </tr>
       <tr><td>Examination Date</td><td>
           
                                <asp:TextBox ID="txtExamDate" runat="server"></asp:TextBox>
                               
           </td></tr>
       <tr><td>Stream</td><td>
                               
                                <asp:TextBox ID="txtStream" runat="server"></asp:TextBox>
                               
                             </td></tr>
       <tr><td>Subject</td><td>                       
                               
                                <asp:TextBox ID="txtSubject" runat="server"></asp:TextBox>
                               
                            </td></tr>
       <tr><td>Paper</td><td>                       
                               
                                <asp:TextBox ID="txtPaper" runat="server"></asp:TextBox>
                               
                            </td></tr>
       <tr><td>Marked Out Of</td><td>                       
                               
                                <asp:TextBox ID="txtMaxMark" runat="server"></asp:TextBox>
                               
                            </td></tr>
       <tr><td>Examination Board</td><td>                       
                               
                                <asp:TextBox ID="txtExamBoard" runat="server"></asp:TextBox>
                               
                            </td></tr>
       <tr><td>&nbsp;</td><td></td></tr>
              <tr><td>Specify Class</td><td>
                                 <telerik:RadComboBox ID="cboClasses" runat="server"> </telerik:RadComboBox>
                             </td></tr>
       <tr><td></td></tr>
       <tr><td></td><td><asp:Button ID="cmdLoadClassList" runat="server" Text="Load Class List" /></td><td>
                                <asp:Button ID="cmdSaveMarks" runat="server" Text="Save Class Marks" /> 
                            </td></tr>


          </table>

          </td>
          </tr>
       <tr><td></td></tr>


         <tr>
                            <td   bgcolor="lightgreen" colspan="4" align="center" >
                                 Capture the Student Marks Below
                            </td>
                             
                        </tr>
                        <tr>
                            <td colspan="4">
                                 &nbsp;
                            </td>
                             
                        </tr>
                         <tr>
                            <td colspan="4">
                                 <telerik:RadGrid ID="gwClassList" runat="server" AllowPaging="True" AllowSorting="True" BackColor="White" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" DisplayMode="FirstLastPreviousNextNumeric, Text" ForeColor="Black" GroupPanelPosition="Top" PageSize="50" AutoGenerateColumns="False">
                                     <ClientSettings>
                                         <Scrolling AllowScroll="True" />
                                     </ClientSettings>
                                     <AlternatingItemStyle BackColor="#E9E9E9" />
                                     <MasterTableView>
                                         <Columns>
                                             <telerik:GridBoundColumn DataField="studentId" FilterControlAltText="Filter studentId column" HeaderText="Student Id" UniqueName="studentId">
                                             </telerik:GridBoundColumn>
                                             <telerik:GridBoundColumn DataField="firstName" FilterControlAltText="Filter firstName column" HeaderText="First Name" UniqueName="firstName">
                                             </telerik:GridBoundColumn>
                                             <telerik:GridBoundColumn DataField="secondName" FilterControlAltText="Filter secondName column" HeaderText="Second Name" UniqueName="secondName">
                                             </telerik:GridBoundColumn>
                                             <telerik:GridBoundColumn DataField="surname" FilterControlAltText="Filter surname column" HeaderText="Surname" UniqueName="surname">
                                             </telerik:GridBoundColumn>
                                               <telerik:GridBoundColumn DataField="CurrentMark" FilterControlAltText="Filter CurrentMark column" HeaderText="CurrentMark" UniqueName="CurrentMark">
                                             </telerik:GridBoundColumn>
                                               <telerik:GridTemplateColumn HeaderText="New Mark"  UniqueName="mark" FilterControlAltText="Filter mark column" DataField="mark">
                                                            <ItemTemplate>
                                                                         <asp:TextBox ID="mark"    FooterText="Mark Obtained" HeaderText="Mark Obtained"  DataTextField="mark" DataValueField="mark"   runat="server"></asp:TextBox>
                                                            </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                         </Columns>
                                     </MasterTableView>
                                 </telerik:RadGrid>
                            </td>
                             
                        </tr>
   </table>
</asp:Content>
