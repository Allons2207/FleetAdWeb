<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="StudentPayments.aspx.vb" Inherits="WebApplication2.StudentPayments" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
      <table>
           <tr>
        <td class="PageTitle">
            Student Search
        </td>
    </tr>
        
           <tr>
             <td>
                 <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small"></asp:Label>
             </td>
         </tr>
    </table>
    <telerik:RadToolBar ID="RadToolBar1" runat="server" SingleClick="None" Width="100%" Skin="Office2010Black">
                <Items>
                    <telerik:RadToolBarButton runat="server" Text="Save Search">
                    </telerik:RadToolBarButton>
                    <telerik:RadToolBarButton runat="server" Text="Print">
                    </telerik:RadToolBarButton>
                    <telerik:RadToolBarButton runat="server" Text="Export">
                    </telerik:RadToolBarButton>
                </Items>
    </telerik:RadToolBar>
  <asp:Panel ID="Panel1" runat="server" Width="1076px">
    <table width="100%">
        <tr>
            <td>Student No</td> <td>
                <asp:TextBox ID="txtStudentNo" runat="server"></asp:TextBox> </td>
            <td> Marital Status</td> <td>
                <telerik:RadComboBox ID="drpdwnMStatus" runat="server" Enabled="False"></telerik:RadComboBox>
            </td>
            <td>Class</td> <td> 
                <telerik:RadComboBox ID="cbClass" runat="server" Enabled="False"></telerik:RadComboBox>
            </td>
            </tr>
        <tr>
            <td>FirstName</td><td>
                <asp:TextBox ID="txtFName" runat="server" Enabled="False"></asp:TextBox> </td>
            <td>Surname</td><td> 
                <asp:TextBox ID="txtSurname" runat="server" Enabled="False"></asp:TextBox></td>
            <td>Sex</td><td> 
                <telerik:RadComboBox ID="drpdnSex" runat="server" Enabled="False"></telerik:RadComboBox>
               </td>
            </tr>
        <tr>
            <td>Boarding Status</td><td>
               
                <telerik:RadComboBox ID="drpdwnBStatus" runat="server" Enabled="False"></telerik:RadComboBox>
                                    </td>
            <td>Orphan Status</td><td>
                              <telerik:RadComboBox ID="drpdwnOStatus" runat="server" Enabled="False"></telerik:RadComboBox>
                                  </td>
            <td>&nbsp;</td><td>
                &nbsp;</td>
        </tr>
       
     
    </table>

</asp:Panel>

    <table>
  

         
        <tr>
            <td>&nbsp</td>
        </tr>
        <tr>
            <td class="PageTitle" colspan="6">Student Payments</td>
        </tr>
        <tr>
            <td>&nbsp</td>
        </tr>
        <tr><td>Payment Type...........</td><td>
                <telerik:RadComboBox ID="cbPaymentType" runat="server">
                    <Items>
                        <telerik:RadComboBoxItem runat="server" Text="All Student Payments" Value="All Student Payments" />
                        <telerik:RadComboBoxItem runat="server" Text="Tuition" Value="Tuition" />
                        <telerik:RadComboBoxItem runat="server" Text="Levy" Value="Levy" />
                    </Items>
                </telerik:RadComboBox>
            </td></tr>
        <tr>
            <td>&nbsp</td>
        </tr>
        <tr><td>&nbsp</td>
            <td>
                 <asp:Button ID="btnSearch" runat="server" Text="Search" BackColor="Orange" />
            </td>
        </tr>
        <tr><td>&nbsp</td></tr>
    </table>
    
                    <telerik:RadGrid ID="gwStudentSearch" runat="server"  BackColor="White"  AllowPaging="True"  DisplayMode="FirstLastPreviousNextNumeric, Text" PageSize="50"
         BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" AllowSorting="True" GroupPanelPosition="Top"  ForeColor="Black" >
              
                        <ClientSettings>
                        <Scrolling AllowScroll="True"  />
                    </ClientSettings>
                   
                        <AlternatingItemStyle BackColor="#E9E9E9" />
                   
     </telerik:RadGrid> 
            
    
  </asp:Content>
