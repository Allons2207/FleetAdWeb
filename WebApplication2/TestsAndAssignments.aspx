<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="TestsAndAssignments.aspx.vb" Inherits="WebApplication2.Coarsework" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

      <style type="text/css">
        .auto-style1 {
            height: 20px;
        }
        .auto-style3 {
            height: 20px;
            width: 746px;
        }
        .RadComboBox_Default{color:#333;font-size:12px;font-family:"Segoe UI",Arial,Helvetica,sans-serif}.RadComboBox{text-align:left;display:inline-block;vertical-align:middle;white-space:nowrap;*display:inline;*zoom:1}.RadComboBox_Default{color:#333;font-size:12px;font-family:"Segoe UI",Arial,Helvetica,sans-serif}.RadComboBox{text-align:left;display:inline-block;vertical-align:middle;white-space:nowrap;*display:inline;*zoom:1}.RadComboBox_Default{color:#333;font-size:12px;font-family:"Segoe UI",Arial,Helvetica,sans-serif}.RadComboBox{text-align:left;display:inline-block;vertical-align:middle;white-space:nowrap;*display:inline;*zoom:1}.RadComboBox .rcbReadOnly .rcbInputCellLeft{background-position:0 -88px}.RadComboBox .rcbReadOnly .rcbInputCellLeft{background-position:0 -88px}.RadComboBox .rcbReadOnly .rcbInputCellLeft{background-position:0 -88px}.RadComboBox_Default .rcbInputCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbInputCellLeft{background-position:0 0}.RadComboBox .rcbInputCell{padding-right:4px;padding-left:5px;width:100%;height:20px;line-height:20px;text-align:left;vertical-align:middle}.RadComboBox .rcbInputCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox_Default .rcbInputCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbInputCellLeft{background-position:0 0}.RadComboBox .rcbInputCell{padding-right:4px;padding-left:5px;width:100%;height:20px;line-height:20px;text-align:left;vertical-align:middle}.RadComboBox .rcbInputCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox_Default .rcbInputCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbInputCellLeft{background-position:0 0}.RadComboBox .rcbInputCell{padding-right:4px;padding-left:5px;width:100%;height:20px;line-height:20px;text-align:left;vertical-align:middle}.RadComboBox .rcbInputCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox .rcbReadOnly .rcbArrowCellRight{background-position:-162px -176px}.RadComboBox .rcbReadOnly .rcbArrowCellRight{background-position:-162px -176px}.RadComboBox .rcbReadOnly .rcbArrowCellRight{background-position:-162px -176px}.RadComboBox_Default .rcbArrowCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbArrowCellRight{background-position:-18px -176px}.RadComboBox .rcbArrowCell{width:18px}.RadComboBox .rcbArrowCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox_Default .rcbArrowCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbArrowCellRight{background-position:-18px -176px}.RadComboBox .rcbArrowCell{width:18px}.RadComboBox .rcbArrowCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox_Default .rcbArrowCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbArrowCellRight{background-position:-18px -176px}.RadComboBox .rcbArrowCell{width:18px}.RadComboBox .rcbArrowCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}
          .auto-style4 {
              height: 19px;
          }
        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <table>
       <tr>
       <td style="font-size:medium; color:darkblue ">
           Tests and Assignments
       </td>
       </tr>
       <tr>
         <td>
             <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small"></asp:Label>
         </td>
        </tr>
     </table>  
     <table>
        <tr>
            <td class="auto-style3">
                <asp:Panel ID="Panel2" runat="server" Width="568px">
                    <table>
                        <tr>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style4">
                                Test Code</td>
                            <td class="auto-style4">                       
                               
                                <asp:TextBox ID="txtTestCode" runat="server"></asp:TextBox>
                               
                            </td>
                        </tr>
                       
                        <tr>
                            <td class="auto-style1">
                                Test Date</td>
                            <td class="auto-style1">
                                               
                                <telerik:RadDatePicker ID="rdDtDate" Runat="server">
                                </telerik:RadDatePicker>
                            </td>
                        </tr>
                      
                        <tr>
                            <td class="auto-style1">
                                Stream</td>
                            <td>
                               
                                                               
                                <telerik:RadComboBox ID="cboStream" runat="server">
                                    <Items>
                                        <telerik:RadComboBoxItem runat="server" Text="Opening Balance" Value="Opening Balance" />
                                        <telerik:RadComboBoxItem runat="server" Text="In Coming" Value="In Coming" />
                                        <telerik:RadComboBoxItem runat="server" Text="Out Going" Value="Out Going" />
                                        <telerik:RadComboBoxItem runat="server" Text="Closing Balance" Value="Closing Balance" />
                                    </Items>
                                </telerik:RadComboBox>
                               
                                                               
                            </td>
                        </tr>
                       
                        <tr>
                            <td class="auto-style1">
                                 Classes</td>
                            <td>
                                <telerik:RadComboBox ID="cboClasses" runat="server">
                                    <Items>
                                        <telerik:RadComboBoxItem runat="server" Text="Opening Balance" Value="Opening Balance" />
                                        <telerik:RadComboBoxItem runat="server" Text="In Coming" Value="In Coming" />
                                        <telerik:RadComboBoxItem runat="server" Text="Out Going" Value="Out Going" />
                                        <telerik:RadComboBoxItem runat="server" Text="Closing Balance" Value="Closing Balance" />
                                    </Items>
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        
                        <tr>
                            <td class="auto-style1">Description</td><td>
                            <asp:TextBox ID="txtNotes" runat="server" TextMode="MultiLine" Width="313px"></asp:TextBox>
                            </td>
                        </tr>
                     
                        <tr>
                            <td class="auto-style1">
                                 Subject</td>
                            <td>
                                <telerik:RadComboBox ID="cboSubjects" runat="server">
                                    <Items>
                                        <telerik:RadComboBoxItem runat="server" Text="Opening Balance" Value="Opening Balance" />
                                        <telerik:RadComboBoxItem runat="server" Text="In Coming" Value="In Coming" />
                                        <telerik:RadComboBoxItem runat="server" Text="Out Going" Value="Out Going" />
                                        <telerik:RadComboBoxItem runat="server" Text="Closing Balance" Value="Closing Balance" />
                                    </Items>
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        
                        <tr>
                            <td class="auto-style1">
                                 Highest Possible Mark</td>
                            <td>
                                <asp:TextBox ID="txtHighestPossibleMark" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                       
                        <tr>
                            <td class="auto-style4">
                                 Topics Covered</td>
                            <td class="auto-style4">
                                <asp:TextBox ID="txtTopicsCovered" runat="server"></asp:TextBox>
                                &nbsp; </td>
                        </tr>
                        <tr>
                            <td>Due Date</td><td><telerik:RadDatePicker ID="rdpDueDate" Runat="server">
                                </telerik:RadDatePicker></td>
                        </tr>
                        <tr>
                            <td>Upload Attachment</td>
                            <td><asp:FileUpload runat="server" ID="fuFileUpload" /></td>
                        </tr>
                        <tr>
                            <td>
                                 &nbsp;
                            </td>
                        </tr>
                       
                        <tr><td></td>
                            <td>
                                <asp:Button ID="cmdAddNew" runat="server" Text="Save Test/Assignment" />
                            </td>
                            <td>
                                <asp:Button ID="cmdAddQuestions" runat="server" Text="Add Questions" />
                            </td>
                        </tr>
                        <tr> 
		                    <td colspan="2"> 
			                    <asp:textbox id="txtFileID" runat="server" Visible="false"></asp:textbox>
                                <asp:TextBox ID="txtFilePath" runat="server" Visible="false"></asp:TextBox>
		                    </td> 
	                     </tr> 
                         <tr>
                            <td>
                                 &nbsp;
                            </td>
                        </tr>

                    </table>
                </asp:Panel>
               </td>
            <td style="vertical-align:top">
               
            </td>
        </tr>
    </table>  
    
    <table width="100%">
         <tr>
                            <td>
                                <asp:Label ID="lblGridLabel" runat="server" Text=""  Font-Italic="True" Font-Size="Small"></asp:Label>
                                 </td>
                        </tr>

        <tr><td>&nbsp</td></tr>
        <tr><td>
                 <telerik:RadGrid ID="radFileListing" runat="server" Height="100%" 
                    CellPadding="0" Width="100%" GroupPanelPosition="Top">
                    <MasterTableView AutoGenerateColumns="False" AllowFilteringByColumn="True" AllowPaging="True" 
                       AllowMultiColumnSorting="true" AllowSorting="true" PagerStyle-Mode="NextPrevNumericAndAdvanced">
                        <Columns>
                            <telerik:GridButtonColumn ButtonType="LinkButton" Text="Edit Details" UniqueName="column"
                                CommandName="View">
                            </telerik:GridButtonColumn>
                            <telerik:GridBoundColumn DataField="Test_Number" FilterControlAltText="Filter Test_Number column" HeaderText="Test_Number" UniqueName="Test_Number">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Subject" FilterControlAltText="Filter Subject column" HeaderText="Subject" UniqueName="Subject">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Stream" FilterControlAltText="Filter Stream column" HeaderText="Stream" UniqueName="Stream">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Class" FilterControlAltText="Filter Class column" HeaderText="Class" UniqueName="Class">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="TestCode" FilterControlAltText="Filter TestCode column" HeaderText="TestCode" UniqueName="TestCode">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Description" FilterControlAltText="Filter Description column" HeaderText="Description" UniqueName="Description">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="TestDate" FilterControlAltText="Filter TestDate column" HeaderText="TestDate" UniqueName="TestDate">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="ToBeMarkedOutOf" FilterControlAltText="Filter ToBeMarkedOutOf column" HeaderText="ToBeMarkedOutOf" UniqueName="ToBeMarkedOutOf">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="FileID" UniqueName="FileID" HeaderText="FileID"
                                Display="false">
                            </telerik:GridBoundColumn>
                             <telerik:GridBoundColumn DataField="FilePath" UniqueName="FilePath" HeaderText="FilePath" Display="false" >
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="FileType" UniqueName="FileType" HeaderText="FileType" Visible="False">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Date" UniqueName="DateUploaded" HeaderText="DateUploaded" Visible="False">
                            </telerik:GridBoundColumn>
                            <telerik:GridButtonColumn ButtonType="LinkButton" Text="Download File" UniqueName="DownloadFile"
                                CommandName="Download" ButtonCssClass="btn btn-default">
                            </telerik:GridButtonColumn>
                        </Columns>
                        <RowIndicatorColumn>
                            <HeaderStyle Width="20px"></HeaderStyle>
                        </RowIndicatorColumn>
                        <ExpandCollapseColumn>
                            <HeaderStyle Width="20px"></HeaderStyle>
                        </ExpandCollapseColumn>
                        <EditFormSettings>
                            <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                            </EditColumn>
                        </EditFormSettings>
                        <PagerStyle Position="Top" AlwaysVisible="true"/>
                    </MasterTableView>
                    <ClientSettings EnablePostBackOnRowClick="true">
                    </ClientSettings>
                    <FilterMenu EnableImageSprites="False">
                    </FilterMenu>
                </telerik:RadGrid>
            </td></tr>
        <tr><td></td></tr>
    </table>
</asp:Content>

