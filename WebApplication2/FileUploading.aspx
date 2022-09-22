<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="FileUploading.aspx.vb" Inherits="WebApplication2.FileUploading" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
.RadComboBox{text-align:left;display:inline-block;vertical-align:middle;white-space:nowrap;*display:inline;*zoom:1}.RadComboBox_Default{color:#333;font-size:12px;font-family:"Segoe UI",Arial,Helvetica,sans-serif}.RadComboBox{text-align:left;display:inline-block;vertical-align:middle;white-space:nowrap;*display:inline;*zoom:1}.RadComboBox_Default{color:#333;font-size:12px;font-family:"Segoe UI",Arial,Helvetica,sans-serif}.RadComboBox{text-align:left;display:inline-block;vertical-align:middle;white-space:nowrap;*display:inline;*zoom:1}
        .RadComboBox_Default{color:#333;font-size:12px;font-family:"Segoe UI",Arial,Helvetica,sans-serif}.RadComboBox .rcbReadOnly .rcbInputCellLeft{background-position:0 -88px}.RadComboBox .rcbReadOnly .rcbInputCellLeft{background-position:0 -88px}.RadComboBox .rcbReadOnly .rcbInputCellLeft{background-position:0 -88px}.RadComboBox .rcbInputCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox .rcbInputCell{padding-right:4px;padding-left:5px;width:100%;height:20px;line-height:20px;text-align:left;vertical-align:middle}.RadComboBox .rcbInputCellLeft{background-position:0 0}.RadComboBox_Default .rcbInputCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbInputCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox .rcbInputCell{padding-right:4px;padding-left:5px;width:100%;height:20px;line-height:20px;text-align:left;vertical-align:middle}.RadComboBox .rcbInputCellLeft{background-position:0 0}.RadComboBox_Default .rcbInputCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbInputCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox .rcbInputCell{padding-right:4px;padding-left:5px;width:100%;height:20px;line-height:20px;text-align:left;vertical-align:middle}.RadComboBox .rcbInputCellLeft{background-position:0 0}.RadComboBox_Default .rcbInputCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbReadOnly .rcbArrowCellRight{background-position:-162px -176px}.RadComboBox .rcbReadOnly .rcbArrowCellRight{background-position:-162px -176px}.RadComboBox .rcbReadOnly .rcbArrowCellRight{background-position:-162px -176px}.RadComboBox .rcbArrowCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}
        .RadComboBox .rcbArrowCell{width:18px}.RadComboBox .rcbArrowCellRight{background-position:-18px -176px}.RadComboBox_Default .rcbArrowCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbArrowCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox .rcbArrowCell{width:18px}.RadComboBox .rcbArrowCellRight{background-position:-18px -176px}.RadComboBox_Default .rcbArrowCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbArrowCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox .rcbArrowCell{width:18px}.RadComboBox .rcbArrowCellRight{background-position:-18px -176px}.RadComboBox_Default .rcbArrowCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}
        .auto-style1 {
            height: 49px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table width="40%" cellpadding="3">
    <tr>
        <td>
            <h3>File Details</h3>
        </td>
    </tr>
    <tr>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td>Upload File</td>
        <td>
            <asp:FileUpload runat="server" ID="fuFileUpload" />
        </td>
    </tr>
    <tr>
        <td>School File Type:</td>
        <td>
                                
                                <telerik:RadComboBox ID="cboSchoolFileType" runat="server">  </telerik:RadComboBox>
                                
                            </td>
     </tr>
        <tr>
        <td>Grade:</td>
        <td>
                                
                                <telerik:RadComboBox ID="cboGrade" runat="server">
                                   
                                </telerik:RadComboBox>
                                
                            </td>
     </tr>
        <tr>
        <td>Subject:</td>
        <td>
                                
                                <telerik:RadComboBox ID="cboSubject" runat="server">
                                   
                                </telerik:RadComboBox>
                                
                            </td>
     </tr>
    <tr>
        <td>Title:</td>
        <td><asp:TextBox runat="server" ID="txtTitle" CssClass="form-control"></asp:TextBox></td>
    </tr>
    <tr>
        <td class="auto-style1">Date:</td>
        <td class="auto-style1">                       
                                                             
                               
                                <telerik:RadDatePicker ID="rdDtDate" Runat="server">
                                </telerik:RadDatePicker>
                                                      
                               
                            </td>
    </tr>
    <tr>
        <td>Author</td>
        <td><asp:TextBox runat="server" ID="txtAuthor" CssClass="form-control"></asp:TextBox></td>
    </tr>
    <tr>
        <td>Description</td>
        <td><asp:TextBox runat="server" ID="txtDescription" TextMode="MultiLine" Rows="5" Columns="40" CssClass="form-control"></asp:TextBox></td>
    </tr>
     <tr>
        <td>&nbsp;</td>
        <td>
            <asp:CheckBox ID="chkSecurity" runat="server" TextAlign="Left" />
            Apply Security</td>
    </tr>
    <tr> 
		<td colspan="2"> 
            		<asp:Panel id="pnlError" width="95%" runat="server" EnableViewState="False"><asp:label id="lblError" Width="100%" runat="server" CssClass="Error" EnableViewState="False"></asp:label></asp:Panel> 
     </td> 
	</tr> 
    <tr>
        <td colspan="2">
            &nbsp;</td>
    </tr>
	<tr> 
		<td> 
            		<asp:button id="cmdSave" runat="server" Text="Save" class="btn btn-default" Width="75px"></asp:button> 
                    <asp:button id="cmdClear" runat="server" Text="New File" class="btn btn-default" Width="75px"></asp:button> 
     </td> 
        <td>
                    <asp:button id="cmdDelete" runat="server" Text="Delete" class="btn btn-default" Width="75px"></asp:button> 
        </td>
	</tr> 
	<tr> 
		<td colspan="2"> 
			<asp:textbox id="txtFileID" runat="server" Visible="false"></asp:textbox>
            <asp:TextBox ID="txtFilePath" runat="server" Visible="false"></asp:TextBox>
		</td> 
	</tr> 
</table>
      
</asp:Content>
