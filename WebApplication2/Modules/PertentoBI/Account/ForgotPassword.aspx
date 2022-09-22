<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Account.master" CodeBehind="ForgotPassword.aspx.cs" Inherits="PertentoBI.ForgotPassword" %>

<asp:content id="ClientArea" contentplaceholderid="Content" runat="server">
    <div class="accountHeader">
    <h2>Forgot password</h2>
</div>
<asp:PlaceHolder id="loginForm" runat="server">
    <h4>Enter your email</h4>
    <p><asp:Literal runat="server" ID="FailureText" /></p>
    <dx:BootstrapTextBox runat="server" ID="Email" Caption="Email">
        <ValidationSettings>
            <RequiredField IsRequired="true" ErrorText="Email is required" />
        </ValidationSettings>
    </dx:BootstrapTextBox><br />
    <dx:BootstrapButton ID="btnSubmit" runat="server" Text="Email Link" OnClick="Forgot" />
</asp:PlaceHolder>
<asp:PlaceHolder runat="server" ID="DisplayEmail" Visible="false">
    <p>Please check your email to reset your password.</p>
</asp:PlaceHolder>
</asp:content>