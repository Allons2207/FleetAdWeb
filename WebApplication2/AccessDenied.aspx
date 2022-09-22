<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="AccessDenied.aspx.vb" Inherits="WebApplication2.AccessDenied" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <center>
   
      <p style="font-family:'Segoe UI';font-size:15pt;font-style:oblique; font-weight:bold;color:red;margin-left:2%;text-align:center">
         Sorry, Access to requested page is restricted...</p>
     <p style="font-family:'Segoe UI';font-size:10pt;font-style:normal;color:red;margin-left:2%;text-align:center">
        If you feel this is incorrect, please contact your administrator. User information summarised below</p>
         
    <div style="border:1px solid darkred;font-size:10pt;font-family:'Segoe UI';font-weight:200;color:olivedrab;margin-left:2%;width:25%">
        
        <table cellpadding="3">
            <tr>
                <td >&nbsp</td>
            </tr>
            <tr>
                <td style="text-align:left">
                    User Alias:
                </td>
                <td style="text-align:left">
                    <asp:Label ID="lblUserName" runat="server" ForeColor="Red" ></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="text-align:left">User Full Name:</td>
                <td style="text-align:left"><asp:Label ID="lblUserFullName" runat="server" ForeColor="Red" ></asp:Label></td>
            </tr>
            <tr>
                <td style="text-align:left">User Assigned Group:</td>
                <td style="text-align:left"><asp:Label ID="lblUserGroup" runat="server" ForeColor="Red" ></asp:Label></td>
            </tr>
            <tr><td>&nbsp</td></tr>
        </table>
    </div>
   
    </center>
</asp:Content>
