<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="ManagingParameters.aspx.vb" Inherits="WebApplication2.ManagingParameters" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <h3 style="font-size:medium; color:gray "> Managing System Parameters</h3>
    <table style="margin-left:2%" >
         <tr>
         <td colspan="4" class="auto-style2">
             <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small" Width ="100%"></asp:Label>
         </td>
        </tr>
        <tr><td><b></b></td></tr>

        <tr><td>Parameter Type</td><td> 
                                         <telerik:RadComboBox ID="cboParameters" runat="server" Width="300px" AutoPostBack="True"></telerik:RadComboBox>
                                         </td></tr>

        <tr><td>Value ID</td><td> <asp:TextBox ID="txtParameterID" runat="server" Width="300px" Enabled="False"></asp:TextBox></td></tr>
        <tr><td>Value</td><td> <asp:TextBox ID="txtParameterValue" runat="server" Width="300px"></asp:TextBox></td></tr>
        <tr><td>
             <asp:Label ID="lblParentParameter" runat="server"  Font-Italic="True" Font-Size="Small" Width ="100%"></asp:Label>
            </td><td> 
                                         <telerik:RadComboBox ID="cboParameterParent" runat="server" Width="300px" AutoPostBack="True" Visible="False"></telerik:RadComboBox><br />
                <asp:TextBox ID="txtSecondValue" runat="server" Width="300px" Visible ="False"></asp:TextBox>
                                         </td></tr>
        <tr><td></td><td><asp:Button ID="cmdSave" runat="server" Text="Save" Width="105px" />&nbsp
            <asp:Button ID="btnClear" runat="server" Text="Clear" Width="105px" />
             </td></tr>
        <tr><td colspan="2"><hr /></td></tr>
        <tr><td>&nbsp</td><td >Available Selected Parameter Values</td></tr>
        <tr><td>&nbsp</td><td > 
          <telerik:RadGrid ID="gwList" runat="server"  BackColor="White"  AllowPaging="True"  DisplayMode="FirstLastPreviousNextNumeric, Text" PageSize="100"
         BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" AllowSorting="True" GroupPanelPosition="Top"  ForeColor="Black" AutoGenerateColumns="False" AllowMultiRowSelection="True" ClientSettings-Selecting-AllowRowSelect="true" Width="300px" >
                      
                  <ClientSettings>
                        <Selecting AllowRowSelect="True"></Selecting>
                          </ClientSettings>

              <AlternatingItemStyle BackColor="#E9E9E9" />

                  <MasterTableView>
                      <Columns>
                          <telerik:GridButtonColumn CommandName="Edita" FilterControlAltText="Filter Edit column" HeaderText="Edit" Text="Edit" UniqueName="Edit">
                          </telerik:GridButtonColumn>
                          <telerik:GridBoundColumn DataField="ParameterId" FilterControlAltText="Filter ParameterId column" HeaderText="ParameterId" UniqueName="ParameterId">
                          </telerik:GridBoundColumn>
                          <telerik:GridBoundColumn DataField="Parameter" FilterControlAltText="Filter Parameter column" HeaderText="Parameter" UniqueName="Parameter">
                          </telerik:GridBoundColumn>
                          <telerik:GridBoundColumn DataField="Cost" FilterControlAltText="Filter Cost column" HeaderText="Cost" UniqueName="Cost">
                          </telerik:GridBoundColumn>
                      </Columns>
                  </MasterTableView>
                                 
     </telerik:RadGrid> 
            </td></tr>
    </table>

</asp:Content>
