<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Account.master" CodeBehind="ChangePassword.aspx.cs" Inherits="PertentoBI.ChangePassword" %>

<asp:Content ID="Content" contentplaceholderid="Content" runat="server">
    <div class="accountHeader">
    <h2 runat="server" ID="PageHeader">Change password</h2>
    <p runat="server" ID="PageDescription">Use the form below to change your password.</p>
    <p style="color:red">
      <asp:Literal runat="server" ID="ErrorMessage" />
    </p>
</div>

<dx:BootstrapTextBox ID="tbCurrentPassword" runat="server" Caption="Old Password" Password="true" Width="200px">
  <CaptionSettings Position="Before" />
  <ValidationSettings ValidationGroup="ChangeUserPasswordValidationGroup">
    <RequiredField ErrorText="Old Password is required." IsRequired="true" />
  </ValidationSettings>
</dx:BootstrapTextBox>
<dx:BootstrapTextBox ID="tbPassword" ClientInstanceName="Password" Caption="Password" Password="true" runat="server"
      Width="200px">
  <CaptionSettings Position="Before" />
  <ValidationSettings ValidationGroup="ChangeUserPasswordValidationGroup">
    <RequiredField ErrorText="Password is required." IsRequired="true" />
  </ValidationSettings>
</dx:BootstrapTextBox>
<dx:BootstrapTextBox ID="tbConfirmPassword" Password="true" Caption="Confirm password" runat="server" Width="200px">
  <CaptionSettings Position="Before" />
  <ValidationSettings ValidationGroup="ChangeUserPasswordValidationGroup">
    <RequiredField ErrorText="Confirm Password is required." IsRequired="true" />
  </ValidationSettings>
  <ClientSideEvents Validation="function(s, e) {
        var originalPasswd = Password.GetText();
        var currentPasswd = s.GetText();
        e.isValid = (originalPasswd  == currentPasswd );
        e.errorText = 'The Password and Confirmation Password must match.';
    }" />
</dx:BootstrapTextBox>
<br />
<dx:BootstrapButton ID="btnChangePassword" runat="server" Text="Change Password" ValidationGroup="ChangeUserPasswordValidationGroup"
    OnClick="btnChangePassword_Click">
</dx:BootstrapButton>
<dx:BootstrapButton ID="btnSetPassword" runat="server" Text="Set Password" Visible="false" ValidationGroup="ChangeUserPasswordValidationGroup"
    OnClick="btnSetPassword_Click">
</dx:BootstrapButton>
</asp:Content>