<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Account.master" CodeBehind="Manage.aspx.cs" Inherits="PertentoBI.Manage" %>

<asp:content id="ClientArea" contentplaceholderid="Content" runat="server">
    <p><%: SuccessMessage %></p>
<div class="accountHeader">
    <h2>Change your account settings</h2>
</div>
<ul>
    <li>
        Password: 
        <dx:BootstrapHyperLink NavigateUrl="/Account/ChangePassword.aspx" Text="[Change]" Visible="false" ID="ChangePassword" runat="server" />
        <dx:BootstrapHyperLink NavigateUrl="/Account/ChangePassword.aspx" Text="[Create]" Visible="false" ID="CreatePassword" runat="server" />
    </li>
    <li>
        External Logins: <%: LoginsCount %>
        <dx:BootstrapHyperLink NavigateUrl="/Account/ManageLogins.aspx" Text="[Manage]" runat="server" />
    </li>
        Phone Numbers can used as a second factor of verification in a two-factor authentication system.
        See <a href="http://go.microsoft.com/fwlink/?LinkId=403804">this article</a>
        for details on setting up this ASP.NET application to support two-factor authentication using SMS.
        Uncomment the following blocks after you have set up two-factor authentication

    <li>
        Phone Number:
    <% if (HasPhoneNumber) { %> 
        <dx:BootstrapHyperLink NavigateUrl="/Account/AddPhoneNumber.aspx" runat="server" Text="[Add]" />
    <% } else { %> 
        <dx:ASPxLabel Text="" ID="PhoneNumber" runat="server" />
        <dx:BootstrapHyperLink NavigateUrl="/Account/AddPhoneNumber.aspx" runat="server" Text="[Change]" /> &nbsp;|&nbsp;
    <dx:BootstrapButton runat="server" ID="RemovePhone" Text="[Remove]" OnClick="RemovePhone_Click">
      <SettingsBootstrap RenderOption="Link" />
    </dx:BootstrapButton>
    <% } %> 
    </li> 
    <li>
        Two-Factor Authentication:
        There are no two-factor authentication providers configured. See <a href="http://go.microsoft.com/fwlink/?LinkId=403804">this article</a>
        for details on setting up this ASP.NET application to support two-factor authentication.

        <% if (TwoFactorEnabled) { %> 
        <%--
        Enabled
        <dx:BootstrapButton runat="server" id="TwoFactorDisable" Text="[Disable]" CommandArgument="false" OnClick="TwoFactorDisable_Click">
      <SettingsBootstrap RenderOption="Link" />
    </dx:BootstrapButton>
        --%>
        <% } else { %>          
        <%--
        Disabled
        <dx:BootstrapButton runat="server" id="TwoFactorEnable" Text="[Enable]" CommandArgument="true" OnClick="TwoFactorEnable_Click">
      <SettingsBootstrap RenderOption="Link" />
    </dx:BootstrapButton>
        --%>
        <% } %>    </li>
</ul>
</asp:content>