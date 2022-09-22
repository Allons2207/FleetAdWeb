<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="CapturingBehaviour.aspx.vb" Inherits="WebApplication2.CapturingBehaviour" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

       <table>
    <tr>
        <td style="font-size:medium; color:darkblue ">
          Capturing Behaviour
        </td>
    </tr>
            <tr>
             <td>
                 <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small"></asp:Label>
             </td>
         </tr>
</table>
    <table width="100%">
        <tr>
            <td>
                Incident No
            </td>
            <td>
                <asp:TextBox ID="txtIncidentNo" runat="server"></asp:TextBox>
            </td>
            <td></td>
            <td>
                <asp:Button ID="cmdNew" runat="server" Text="Capture New" />
            </td>
        </tr>
        <tr>
            <td>Date</td>
            <td>
                <telerik:RadDatePicker ID="RadDatePicker" runat="server"></telerik:RadDatePicker>
                <asp:RequiredFieldValidator ID="rqvalRadDatePicker" runat="server" ControlToValidate="RadDatePicker"
                                ErrorMessage="Please supply Date">*</asp:RequiredFieldValidator>
            </td>
            <td>Incident Type</td>
            <td>
                <telerik:RadComboBox ID="cbIncidentType" runat="server"></telerik:RadComboBox>
                 <asp:RequiredFieldValidator ID="rqvalIncidentType" runat="server" ControlToValidate="cbIncidentType"
                                ErrorMessage="Please supply Incident Type">*</asp:RequiredFieldValidator>
            </td>
            <td>
                Incident Level
            </td><td>
                 <telerik:RadComboBox ID="cbIncidentLevel" runat="server"></telerik:RadComboBox>
                 <asp:RequiredFieldValidator ID="rqvalIncidentLevel" runat="server" ControlToValidate="cbIncidentLevel"
                                ErrorMessage="Please supply Incident Level">*</asp:RequiredFieldValidator>
                 </td>
            <td>
                Location
            </td>
            <td>
                 <asp:TextBox ID="txtLocation" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rqvalLocation" runat="server" ControlToValidate="txtLocation"
                                ErrorMessage="Please supply Incident Location">*</asp:RequiredFieldValidator>
            </td>
            <td>
                Offender Category
            </td>
            <td>
                 <telerik:RadComboBox ID="cbOffenderCategory" runat="server">
                     <Items>
                         <telerik:RadComboBoxItem runat="server" Text="" Value="RadComboBoxItem1" />
                         <telerik:RadComboBoxItem runat="server" Text="Student(s)" Value="RadComboBoxItem2" />
                      </Items>
                 </telerik:RadComboBox>
                 <asp:RequiredFieldValidator ID="rqvalOffendercategory" runat="server" ControlToValidate="cbOffenderCategory"
                                ErrorMessage="Please supply Offender Category">*</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                OffenderID
            </td>
            <td>
                <asp:TextBox ID="txOffenderID" runat="server"></asp:TextBox>
                 <asp:RequiredFieldValidator ID="rqvalOffenderID" runat="server" ControlToValidate="txOffenderID"
                                ErrorMessage="Please supply Offender ID(Student ID)">*</asp:RequiredFieldValidator>
            </td>
            <td>
            Offender
            </td>
            <td>
                <asp:TextBox ID="txtOffender" runat="server"></asp:TextBox>
            </td>
            
            <td>
                Class
            </td>
            <td>
                <asp:TextBox ID="txtClass" runat="server"></asp:TextBox></td>
           
            
                <td>
                    Stream</td>
            <td>
                <asp:TextBox ID="txtStream" runat="server"></asp:TextBox></td>
           
            <td>
                Displinary Action
            </td>
            <td>
                <telerik:RadComboBox ID="cbDisActions" runat="server"></telerik:RadComboBox>
                   <asp:RequiredFieldValidator ID="rqvalDisActions" runat="server" ControlToValidate="cbDisActions"
                                ErrorMessage="Please supply discipline action">*</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
             <td>
                Description
            </td>
           <td> <asp:TextBox ID="txtDescription" runat="server" TextMode ="MultiLine" Width="154px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rqvalDescription" runat="server" ControlToValidate="txtDescription"
                                ErrorMessage="Please supply Description">*</asp:RequiredFieldValidator>
            </td>
        </tr>
    </table>
    <table>
        <tr>
            <td>
                <asp:Button ID="cmdSave" runat="server" Text="Save" BackColor="#FF9900" />
            </td>
        </tr>
    </table>
</asp:Content>
