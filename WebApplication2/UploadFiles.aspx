<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="UploadFiles.aspx.vb" Inherits="WebApplication2.UploadFiles" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <h3 style="font-size:medium; color:gray "> File Upload</h3>
     <table style="margin-left:2%"  width="40%" >      
    
     <tr>
        <td>File Type:</td>
        <td>
                                
                                <telerik:radcombobox ID="cboFileType" runat="server">  </telerik:radcombobox>
                                
                            </td>
     </tr>
      
    <tr>
        <td>File Title:</td>
        <td><asp:TextBox runat="server" ID="txtTitle" CssClass="form-control" Width="759px"></asp:TextBox></td>
    </tr>
    <tr>
        <td class="auto-style4">File Date:</td>
        <td class="auto-style4">                       
                                                             
                               
                                <telerik:raddatepicker ID="rdDtDate" Runat="server">
                                </telerik:raddatepicker>
                                                      
                               
                            </td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td>Description</td>
        <td><asp:TextBox runat="server" ID="txtDescription" TextMode="MultiLine" Rows="5" Columns="40" CssClass="form-control" Width="422px"></asp:TextBox></td>
    </tr>
          <tr>
        <td>Upload File</td>
        <td>
            <asp:FileUpload runat="server" ID="fuFileUpload" />
        </td>
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
	<tr> <td></td>
		<td colspan="3"> 
            		<asp:button id="cmdSaveFile" runat="server" Text="Save" class="btn btn-default" Width="75px"></asp:button> 
                    <asp:button id="Button2" runat="server" Text="New File" class="btn btn-default" Width="75px"></asp:button> 
     
                    <asp:button id="Button3" runat="server" Text="Delete" class="btn btn-default" Width="75px"></asp:button> 
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
