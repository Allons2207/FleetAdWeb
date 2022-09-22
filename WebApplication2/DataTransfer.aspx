<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="DataTransfer.aspx.vb" Inherits="WebApplication2.DataTransfer" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <table>
        <tr>
            <td>  &nbsp;&nbsp
                </td>
        </tr>
            <tr><td></td>
        </tr>
        <tr>
            <td><asp:Button ID="cmdBackUp" runat="server" text="Back-up to System Path" />  </td>
            <td><asp:Button  ID="cmdBackToSelected" runat="server"  Text="Back-up to selected path"/>
                
            <asp:FileUpload runat="server" ID="fuFileUpload" />
            
            </td>
        </tr>
        <tr>
            <td></td>
        </tr>
        <tr>
            <td colspan="3">
          <telerik:RadGrid ID="radGrdFiles" runat="server"  BackColor="#DEBA84"  DisplayMode="FirstLastPreviousNextNumeric, Text" PageSize="100"
         BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" GroupPanelPosition="Top"  ForeColor="Black" AllowMultiRowSelection="True" ClientSettings-Selecting-AllowRowSelect="true" >
                      
<ClientSettings>
<Selecting AllowRowSelect="True"></Selecting>
</ClientSettings>

           <MasterTableView DataKeyNames="studentId">
                
         </MasterTableView>
                                      
     </telerik:RadGrid> 
            </td>
        </tr>
        <tr>
            <td></td>
        </tr>
    </table>
</asp:Content>
