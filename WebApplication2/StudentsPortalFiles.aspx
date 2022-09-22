<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/StudentsPortalMaster.Master" CodeBehind="StudentsPortalFiles.aspx.vb" Inherits="WebApplication2.StudentsPortalFiles" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
.RadComboBox_Default{color:#333;font-size:12px;font-family:"Segoe UI",Arial,Helvetica,sans-serif}.RadComboBox{text-align:left;display:inline-block;vertical-align:middle;white-space:nowrap;*display:inline;*zoom:1}.RadComboBox_Default{color:#333;font-size:12px;font-family:"Segoe UI",Arial,Helvetica,sans-serif}.RadComboBox{text-align:left;display:inline-block;vertical-align:middle;white-space:nowrap;*display:inline;*zoom:1}.RadComboBox{text-align:left;display:inline-block;vertical-align:middle;white-space:nowrap;*display:inline;*zoom:1}.RadComboBox_Default{color:#333;font-size:12px;font-family:"Segoe UI",Arial,Helvetica,sans-serif}.RadComboBox{text-align:left;display:inline-block;vertical-align:middle;white-space:nowrap;*display:inline;*zoom:1}.RadComboBox_Default{color:#333;font-size:12px;font-family:"Segoe UI",Arial,Helvetica,sans-serif}.RadComboBox{text-align:left;display:inline-block;vertical-align:middle;white-space:nowrap;*display:inline;*zoom:1}
        .RadComboBox_Default{color:#333;font-size:12px;font-family:"Segoe UI",Arial,Helvetica,sans-serif}.RadComboBox .rcbReadOnly .rcbInputCellLeft{background-position:0 -88px}.RadComboBox .rcbReadOnly .rcbInputCellLeft{background-position:0 -88px}.RadComboBox .rcbReadOnly .rcbInputCellLeft{background-position:0 -88px}.RadComboBox .rcbReadOnly .rcbInputCellLeft{background-position:0 -88px}.RadComboBox .rcbReadOnly .rcbInputCellLeft{background-position:0 -88px}.RadComboBox_Default .rcbInputCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbInputCellLeft{background-position:0 0}.RadComboBox .rcbInputCell{padding-right:4px;padding-left:5px;width:100%;height:20px;line-height:20px;text-align:left;vertical-align:middle}.RadComboBox .rcbInputCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox_Default .rcbInputCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbInputCellLeft{background-position:0 0}.RadComboBox .rcbInputCell{padding-right:4px;padding-left:5px;width:100%;height:20px;line-height:20px;text-align:left;vertical-align:middle}.RadComboBox .rcbInputCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox .rcbInputCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox .rcbInputCell{padding-right:4px;padding-left:5px;width:100%;height:20px;line-height:20px;text-align:left;vertical-align:middle}.RadComboBox .rcbInputCellLeft{background-position:0 0}.RadComboBox_Default .rcbInputCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbInputCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox .rcbInputCell{padding-right:4px;padding-left:5px;width:100%;height:20px;line-height:20px;text-align:left;vertical-align:middle}.RadComboBox .rcbInputCellLeft{background-position:0 0}.RadComboBox_Default .rcbInputCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbInputCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox .rcbInputCell{padding-right:4px;padding-left:5px;width:100%;height:20px;line-height:20px;text-align:left;vertical-align:middle}.RadComboBox .rcbInputCellLeft{background-position:0 0}.RadComboBox_Default .rcbInputCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbReadOnly .rcbArrowCellRight{background-position:-162px -176px}.RadComboBox .rcbReadOnly .rcbArrowCellRight{background-position:-162px -176px}.RadComboBox .rcbReadOnly .rcbArrowCellRight{background-position:-162px -176px}.RadComboBox .rcbReadOnly .rcbArrowCellRight{background-position:-162px -176px}.RadComboBox .rcbReadOnly .rcbArrowCellRight{background-position:-162px -176px}.RadComboBox_Default .rcbArrowCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbArrowCellRight{background-position:-18px -176px}.RadComboBox .rcbArrowCell{width:18px}.RadComboBox .rcbArrowCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox_Default .rcbArrowCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbArrowCellRight{background-position:-18px -176px}.RadComboBox .rcbArrowCell{width:18px}.RadComboBox .rcbArrowCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox .rcbArrowCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}
          .RadComboBox .rcbArrowCell{width:18px}.RadComboBox .rcbArrowCellRight{background-position:-18px -176px}.RadComboBox_Default .rcbArrowCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbArrowCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox .rcbArrowCell{width:18px}.RadComboBox .rcbArrowCellRight{background-position:-18px -176px}.RadComboBox_Default .rcbArrowCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbArrowCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox .rcbArrowCell{width:18px}.RadComboBox .rcbArrowCellRight{background-position:-18px -176px}.RadComboBox_Default .rcbArrowCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}
        .auto-style3 {
            width: 173px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <table width = "90%">
         <tr>
       <td style="font-size:medium; color:darkblue " colspan="6">
          Student Files</td>
       </tr>
       <tr>
         <td colspan="2">
             <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small"></asp:Label>
         </td>
        </tr>
         <tr><td class="auto-style3">Choose file category to view</td><td>
                                <telerik:RadComboBox ID="cboCategory" runat="server" Width="278px" AutoPostBack="True">
                                    <Items>
                                        <telerik:RadComboBoxItem runat="server" Text="My Files" Value="My Files" />
                                        <telerik:RadComboBoxItem runat="server" Text="Tests and Assignments" Value="Tests and Assignments" />
                                    </Items>
                                </telerik:RadComboBox>
                            </td></tr>
         <tr><td>&nbsp</td></tr>
                           
                        </table>
    <table width="80%">
       
             <tr>
                                <td>
                                        <telerik:RadGrid ID="gwFiles" runat="server" CellPadding="0" GridLines="None" Height="100%" Width="100%">
                                            <MasterTableView AllowFilteringByColumn="True" AllowMultiColumnSorting="true" AllowPaging="True" AllowSorting="true" AutoGenerateColumns="False" PagerStyle-Mode="NextPrevNumericAndAdvanced">
                                                <Columns>
                                                    <telerik:GridBoundColumn DataField="FileID" Display="false" HeaderText="FileID" UniqueName="FileID">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="FilePath" Display="false" HeaderText="FilePath" UniqueName="FilePath">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridButtonColumn ButtonType="LinkButton" CommandName="View" Text="Edit Details" UniqueName="column">
                                                    </telerik:GridButtonColumn>
                                                    <telerik:GridBoundColumn DataField="Title" HeaderText="Title" UniqueName="Title">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="FileType" HeaderText="FileType" UniqueName="FileType">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="Author" HeaderText="Author" UniqueName="Author">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="AuthorOrganization" HeaderText="AuthorOrganization" UniqueName="AuthorOrganization">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="Description" HeaderText="Description" UniqueName="Description">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="Date" HeaderText="DateUploaded" UniqueName="DateUploaded">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridButtonColumn ButtonCssClass="btn btn-default" ButtonType="LinkButton" CommandName="Download" Text="Download File" UniqueName="DownloadFile">
                                                    </telerik:GridButtonColumn>
                                                </Columns>
                                                <RowIndicatorColumn>
                                                    <HeaderStyle Width="20px" />
                                                </RowIndicatorColumn>
                                                <ExpandCollapseColumn>
                                                    <HeaderStyle Width="20px" />
                                                </ExpandCollapseColumn>
                                                <EditFormSettings>
                                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                    </EditColumn>
                                                </EditFormSettings>
                                                <PagerStyle AlwaysVisible="true" Position="Top" />
                                            </MasterTableView>
                                            <ClientSettings EnablePostBackOnRowClick="true">
                                            </ClientSettings>
                                            <FilterMenu EnableImageSprites="False">
                                            </FilterMenu>
                                        </telerik:RadGrid>
                                </td>
                            </tr>
        <tr>
            <td>
                 <telerik:RadGrid ID="radFileListing" runat="server" Height="100%" 
                    CellPadding="0" Width="100%" GroupPanelPosition="Top" AutoGenerateColumns="False">
                    <MasterTableView AllowFilteringByColumn="True" AllowPaging="True" 
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
                            <telerik:GridBoundColumn DataField="DueDate" FilterControlAltText="Filter DueDate column" HeaderText="DueDate" UniqueName="DueDate">
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
            </td>
        </tr>
           
    </table>
</asp:Content>
