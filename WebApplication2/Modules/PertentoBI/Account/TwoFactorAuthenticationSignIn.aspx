<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Account.master" CodeBehind="TwoFactorAuthenticationSignIn.aspx.cs" Inherits="PertentoBI.TwoFactorAuthenticationSignIn" %>

<asp:content id="ClientArea" contentplaceholderid="Content" runat="server">
     
<div class="accountHeader">
    <h2>Two-Factor Authentication</h2>
</div>
<asp:PlaceHolder runat="server" ID="sendcode">
    <h4>Send verification code</h4>
    <dx:BootstrapComboBox Caption="Select Two-Factor Authentication Provider" runat="server" ID="Providers">
        <CaptionSettings Position="Before" />
    </dx:BootstrapComboBox><br />
    <dx:BootstrapButton runat="server" ID="SelectProvider" Text="Submit" OnClick="ProviderSubmit_Click" />
</asp:PlaceHolder>
<asp:PlaceHolder runat="server" ID="verifycode" Visible="false">
    <h4>Enter verification code</h4>
    <dx:ASPxHiddenField runat="server" ID="HiddenField"/>
    <dx:BootstrapTextBox runat="server" ID="Code" Caption="Code">
        <CaptionSettings Position="Before"/>
        <ValidationSettings>
            <RequiredField IsRequired="true" ErrorText="Code is required"/>
        </ValidationSettings>
    </dx:BootstrapTextBox>
    <dx:BootstrapCheckBox runat="server" ID="RememberBrowser" Text="Remember Me" /><br />
    <dx:BootstrapButton runat="server" ID="CodeSubmit" Text="Submit" OnClick="CodeSubmit_Click" />
</asp:PlaceHolder>
</asp:content>