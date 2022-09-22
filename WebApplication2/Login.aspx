<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Login.Master" CodeBehind="Login.aspx.vb" Inherits="WebApplication2.Login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <center>
            <table>
                <tr><td>&nbsp</td></tr>
                <tr><td>&nbsp</td></tr>
                <tr><td>&nbsp</td></tr>
                    <tr>
                        <td style="text-align:center"><img src="images/fleetpro-icon.jpg"/></td>
                    </tr>
                             
    </table>
    <table width ="40%">
        <tr>
            <td>
                <h1> &nbsp;</h1>
            </td>
            <td>
                <asp:Panel ID="Panel1" runat="server" GroupingText= "Login Details" >
                        <center>
                            <table>
                                 
                             <tr>
                            <td>Username</td>
                            <td>
                                <asp:TextBox ID="txtUsername" runat="server" Width="80%"></asp:TextBox> </td>
                        </tr>
                        <tr>
                            <td>
                                Password
                            </td>
                            <td>
                                <asp:TextBox ID="txtpassword" runat="server" TextMode="Password" Width ="80%"></asp:TextBox></td>
                        </tr>
                         <tr>
                                       <td>&nbsp</td>     <td width="90%">
                                                <asp:Panel ID="pnlMessages" runat="server">
                                                    <asp:Label ID="lblMessages" runat="server" width="80%"></asp:Label>
                                                </asp:Panel>
                                            </td>
                                        </tr>
                      
                        <tr>
                            <td></td>
                            <td>
                                <asp:Button ID="cmdLogin" runat="server" Text="LOGIN" Width="150px" />
                            </td>
                        </tr>
                    </table>
                        </center>
                   </asp:Panel>
            </td>
        </tr>
       
        <tr><td>&nbsp</td></tr>
        <tr><td>&nbsp</td></tr>
        <tr><td>&nbsp</td></tr>
        <tr><td>&nbsp</td></tr>

        </table>
    </center>
</asp:Content>
