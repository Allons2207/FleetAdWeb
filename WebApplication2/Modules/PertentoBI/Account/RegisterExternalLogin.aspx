<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Account.master" CodeBehind="RegisterExternalLogin.aspx.cs" Inherits="PertentoBI.RegisterExternalLogin" %>

<asp:content id="ClientArea" contentplaceholderid="Content" runat="server">
     
<div class="accountHeader">
    <h2>Associate your <%: ProviderName %> account</h2>
</div>
<asp:ValidationSummary runat="server" ShowModelStateErrors="true" />
<p>
    You've authenticated with <strong><%: ProviderName %></strong>. Please enter an email below for the current site
    and click the Log in button.
</p>
    <dx:BootstrapTextBox runat="server" ID="email" Caption="Email">
        <CaptionSettings Position="Before" />
        <ValidationSettings>
            <RequiredField IsRequired="true" ErrorText="Email is required" />
        </ValidationSettings>
    </dx:BootstrapTextBox><br />
    <dx:BootstrapButton runat="server" ID="LogIn" Text="Log in" OnClick="LogIn_Click" />
</asp:content>