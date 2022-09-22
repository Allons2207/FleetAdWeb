<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="UserDetails.aspx.vb" Inherits="WebApplication2.UserDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <h3 style="font-size:medium; color:gray "> User Details</h3>
    <table style="margin-left:2%">
          <tr>
             <td colspan="2">
                 <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small" Width="100%"></asp:Label>
             </td>
         </tr>
            <tr>
                <td>Fleet System User Id</td>
           <td><asp:TextBox ID="txtUserId" runat="server" Enabled="False" Width="209px"></asp:TextBox> </td>
           </tr>
            <tr>
           
           <td>User Name</td>
           <td><asp:TextBox ID="txtUsername" runat="server" Width="207px"></asp:TextBox> </td>
       </tr>
           <tr><td>User Group</td><td>
                                         <telerik:radcombobox ID="cboUserGroup" runat="server" Width="209px">
                                         </telerik:radcombobox>
                                       </td></tr>
        <tr>
            <td>Active Status</td>
            <td>
                <asp:CheckBox ID="chkActiveStatus" runat="server" />
            </td>
        </tr>
            <tr>
               <td>&nbsp</td>
               <td>
                        <asp:Button ID="cmdSave" runat="server" Text="Save" Width="121px" />&nbsp
                        <asp:Button ID="cmdDelete" runat="server" Text="Delete" Width="121px" Enabled="False" />
                    </td>
           </tr>
           <tr><td colspan="2"><hr /></td></tr>

           <tr>
               <td>Permission Type</td><td> <telerik:RadComboBox ID="cboPermissionType" runat="server" Width="250px" AutoPostBack="True">
               <Items>
                   <telerik:RadComboBoxItem runat="server" Text="--Select--" Value="--Select--" />
                   <telerik:RadComboBoxItem runat="server" Text="Page Level Access" Value="Page Level Access" />
                   <telerik:RadComboBoxItem runat="server" Text="Report Level Access" Value="Report Level Access" />
                   <telerik:RadComboBoxItem runat="server" Text="Save/Edit and Delete Permissions" Value="Save/Edit and Delete Permissions" />
               </Items>
               </telerik:RadComboBox></td>
           </tr>
       <tr>
           <td>&nbsp</td>
           <td > 
          <telerik:RadGrid ID="gwList" runat="server"  BackColor="White"  AllowPaging="True"  DisplayMode="FirstLastPreviousNextNumeric, Text" PageSize="100"
         BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" AllowSorting="True" GroupPanelPosition="Top"  ForeColor="Black" AutoGenerateColumns="False" AllowMultiRowSelection="True" ClientSettings-Selecting-AllowRowSelect="true" Width="250px" >
                      
                  <ClientSettings>
                        <Selecting AllowRowSelect="True"></Selecting>
                          </ClientSettings>

              <AlternatingItemStyle BackColor="#E9E9E9" />

           <MasterTableView>
             <Columns>
                 
                 <telerik:GridBoundColumn DataField="sysModuleId" FilterControlAltText="Filter sysModuleId column" HeaderText="ModuleId" UniqueName="sysModuleId">
                 </telerik:GridBoundColumn>
                 
                 <telerik:GridBoundColumn DataField="Object" FooterText="Object" HeaderText="Object"
                            UniqueName="Object" FilterControlAltText="Filter Object column">  </telerik:GridBoundColumn>
                 
                 <telerik:GridClientSelectColumn DataType="System.Boolean" FilterControlAltText="Filter attendance column"
                            UniqueName="Read" HeaderText="Read" FooterText="Read">
                        </telerik:GridClientSelectColumn>
                 
             </Columns>
              
         </MasterTableView>
                                 
     </telerik:RadGrid> 
            </td>
       </tr>
        <tr>
            <td></td>
            <td><asp:Button ID="cmdSaveUserModules" runat="server" Text="Save User Modules" Width="212px" Visible="False" /></td>
        </tr>
    </table>

</asp:Content>
