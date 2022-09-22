<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="StudentSearch.aspx.vb" Inherits="WebApplication2.StudentSearch" %>
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
    <telerik:RadToolBar ID="RadToolBar1" runat="server" SingleClick="None" Width="100%" Skin="Windows7">
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
                <telerik:RadComboBox ID="drpdwnMStatus" runat="server"></telerik:RadComboBox>
            </td>
            <td>Class</td> <td> 
                <telerik:RadComboBox ID="cbClass" runat="server"></telerik:RadComboBox>
            </td>
            </tr>
        <tr>
            <td>FirstName</td><td>
                <asp:TextBox ID="txtFName" runat="server"></asp:TextBox> </td>
            <td>Surname</td><td> 
                <asp:TextBox ID="txtSurname" runat="server"></asp:TextBox></td>
            <td>Sex</td><td> 
                <telerik:RadComboBox ID="drpdnSex" runat="server"></telerik:RadComboBox>
               </td>
            </tr>
        <tr>
            <td>Boarding Status</td><td>
               
                <telerik:RadComboBox ID="drpdwnBStatus" runat="server"></telerik:RadComboBox>
                                    </td>
            <td>Orphan Status</td><td>
                              <telerik:RadComboBox ID="drpdwnOStatus" runat="server"></telerik:RadComboBox>
                                  </td>
            <td>&nbsp;</td><td>
                &nbsp;</td>
        </tr>
       
     
    </table>

</asp:Panel>

    <table>
  

         <tr>
            <td>
                 <asp:Button ID="btnSearch" runat="server" Text="Search" BackColor="Orange" />
            </td>
        </tr>
    </table>
    
    <%--<asp:GridView ID="gwStudentSearch" runat="server" AutoGenerateSelectButton ="true" AllowPaging="true"  DisplayMode="FirstLastPreviousNextNumeric, Text" PageSize="10"  width="100%" BackColor="#DEBA84" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2">
        <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />
        <HeaderStyle BackColor="#A55129" Font-Bold="True" ForeColor="White" />
        <PagerStyle ForeColor="#8C4510" HorizontalAlign="Center" />
        <RowStyle BackColor="#FFF7E7" ForeColor="#8C4510" />
        <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="White" />
        <SortedAscendingCellStyle BackColor="#FFF1D4" />
        <SortedAscendingHeaderStyle BackColor="#B95C30" />
        <SortedDescendingCellStyle BackColor="#F1E5CE" />
        <SortedDescendingHeaderStyle BackColor="#93451F" />
    </asp:GridView>--%>
  <telerik:RadGrid ID="gwStudentSearch" runat="server" Width ="100%"  BackColor="White"  DisplayMode="FirstLastPreviousNextNumeric, Text" PageSize="25"
         BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" AllowSorting="True" GroupPanelPosition="Top"  ForeColor="Black" AllowFilteringByColumn="True" Skin="WebBlue">
         <AlternatingItemStyle BackColor="#E9E9E9" />
         <MasterTableView DataKeyNames="studentId">
             <Columns>
                 <telerik:GridButtonColumn ButtonType="LinkButton" Text="View" CommandName="View"></telerik:GridButtonColumn>
             </Columns>
         </MasterTableView>
                 
     </telerik:RadGrid>   
</asp:Content>
