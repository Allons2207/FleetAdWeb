<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Account.master" CodeBehind="ResetPassword.aspx.cs" Inherits="PertentoBI.ResetPassword" %>

<asp:content id="ClientArea" contentplaceholderid="Content" runat="server">
     
<div class="accountHeader">
    <h2>Reset password</h2>
</div>
<p><asp:Literal runat="server" ID="ErrorMessage" /></p>
<h4>Enter your new password</h4>
<dx:BootstrapTextBox runat="server" ID="Email" Caption="Email">
    <CaptionSettings Position="Before" />
    <ValidationSettings>
        <RequiredField IsRequired="true" ErrorText="Email is required" />
    </ValidationSettings>
</dx:BootstrapTextBox>
<dx:BootstrapTextBox runat="server" ID="Password" Caption="Password" Password="true" ClientInstanceName="Password">
    <CaptionSettings Position="Before" />
    <ValidationSettings>
        <RequiredField IsRequired="true" ErrorText="Password is required" />
    </ValidationSettings>
</dx:BootstrapTextBox>
<dx:BootstrapTextBox runat="server" ID="ConfirmPassword" Caption="Confirm Password" Password="true">
    <CaptionSettings Position="Before" />
    <ValidationSettings>
        <RequiredField ErrorText="Confirm Password is required." IsRequired="true" />
    </ValidationSettings>
    <ClientSideEvents Validation="function(s, e) {
        var originalPasswd = Password.GetText();
        var currentPasswd = s.GetText();
        e.isValid = (originalPasswd  == currentPasswd );
        e.errorText = 'The Password and Confirmation Password must match.';
    }" />
</dx:BootstrapTextBox><br />
<dx:BootstrapButton runat="server" ID="Reset" Text="Reset" OnClick="Reset_Click" />
</asp:content>