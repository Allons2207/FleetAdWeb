<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="FileMapping.aspx.vb" Inherits="WebApplication2.FileMapping" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
.RadGrid_Default{border:1px solid #828282;background-color:#fff;color:#333;font-family:"Segoe UI",Arial,Helvetica,sans-serif;font-size:12px;line-height:16px}.RadGrid table.rgMasterTable tr .rgExpandCol{padding-left:0;padding-right:0;text-align:center}.RadGrid_Default .rgHeader{color:#333}.RadGrid_Default .rgHeader{border:0;border-bottom:1px solid #828282;background:#eaeaea 0 -2300px repeat-x url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Grid.sprite.gif')}.RadGrid .rgHeader{padding-top:5px;padding-bottom:4px;text-align:left;font-weight:normal}.RadGrid .rgHeader{padding-left:7px;padding-right:7px}.RadGrid .rgHeader{cursor:default}
        .auto-style1 {
            border-color: #d9d9d9;
            background: #d9d9d9;
        }
        .auto-style2 {
            height: 23px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table>
        <tr>
            <td></td>
        </tr>
         <tr>
       <td style="font-size:medium; color:darkblue " colspan="4">
          File Mapping
       </td>
       </tr>
       <tr>
         <td colspan="4">
             <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small"></asp:Label>
         </td>
        </tr>
            <tr>
                <td>School File Type:</td><td><telerik:RadComboBox ID="cboSchoolFileType" runat="server">  </telerik:RadComboBox></td>
                <td>&nbsp;</td><td>&nbsp;</td>
            </tr>
        <tr>
        <td>&nbsp;</td><td>&nbsp;</td>
     </tr>
    <tr>
        <td>Title:</td>
        <td colspan="3"><asp:TextBox runat="server" ID="txtTitle" CssClass="form-control" Width="384px"></asp:TextBox></td>
    </tr>
    <tr>
        <td >Author</td>
        <td>                       
                                                             
                               
                                <asp:TextBox runat="server" ID="txtAuthor" CssClass="form-control"></asp:TextBox>
                                                      
                               
                            </td>
    </tr>
    <tr>
        <td>Description</td>
        <td><asp:TextBox runat="server" ID="txtTitle0" CssClass="form-control" Width="384px"></asp:TextBox></td>
    </tr>
        <tr><td></td><td><asp:button id="cmdFind" runat="server" width="150" Text="Find File"></asp:button> </td></tr>

<tr><td></td></tr>

<tr><td>Details of File Found</td></tr>
        <tr><td> </td><td><asp:TextBox runat="server" ID="txtFileID" CssClass="form-control" Enabled="False" Visible="False">1</asp:TextBox></td></tr>
        <tr><td class="auto-style2">File Type</td><td class="auto-style2"><asp:TextBox runat="server" ID="txtFileType" CssClass="form-control" Enabled="False"></asp:TextBox></td>
        <td class="auto-style2">File Name</td><td class="auto-style2"><asp:TextBox runat="server" ID="txtFileName" CssClass="form-control" Enabled="False"></asp:TextBox></td></tr>
        <tr><td>File Title</td><td><asp:TextBox runat="server" ID="txtFileTitle" CssClass="form-control" Enabled="False"></asp:TextBox></td>
        <td>Description</td><td><asp:TextBox runat="server" ID="txtDesc" CssClass="form-control" Enabled="False"></asp:TextBox></td></tr>
        <tr><td>File Date</td><td><asp:TextBox runat="server" ID="txtFileDate" CssClass="form-control" Enabled="False"></asp:TextBox></td>
        <td>Uploaded By</td><td><asp:TextBox runat="server" ID="txtUploadedBy" CssClass="form-control" Enabled="False"></asp:TextBox></td></tr>
<tr><td></td></tr>

<tr><td>Map File To</td><td><telerik:RadComboBox ID="cboObjectTypes" runat="server" AutoPostBack="True">  </telerik:RadComboBox></td><td></td><td ><asp:button id="cmdMap" runat="server" width="150" Text="Map File"></asp:button> </td></tr>
<tr><td></td><td colspan="3">
                            <telerik:RadGrid ID="gwMapping" runat="server" AllowPaging="True" AllowSorting="True" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" DisplayMode="FirstLastPreviousNextNumeric, Text" ForeColor="Black" GroupPanelPosition="Top" PageSize="50" AutoGenerateColumns="False" AllowMultiRowSelection="True">
                                <ClientSettings>
                                    <Selecting AllowRowSelect="True" />
                                    <Scrolling AllowScroll="True" />
                                </ClientSettings>
                                <AlternatingItemStyle BackColor="#E9E9E9" />
                                <MasterTableView>
                                    <Columns>
                                         <telerik:GridClientSelectColumn DataType="System.Boolean" FilterControlAltText="Filter Select column" FooterText="Select" HeaderText="Select" UniqueName="Select">
                                        </telerik:GridClientSelectColumn>
                                         <telerik:GridBoundColumn DataField="ObjectID" FilterControlAltText="Filter ObjectID column" HeaderText="ObjectID" UniqueName="ObjectID">
                                        </telerik:GridBoundColumn>                             
                                       
                                         <telerik:GridBoundColumn DataField="Details" FilterControlAltText="Filter Details column" HeaderText="Details" UniqueName="Details">
                                         </telerik:GridBoundColumn>
                                       
                                    </Columns>
                                </MasterTableView>
                            </telerik:RadGrid>
                </td></tr>






    </table>
</asp:Content>
