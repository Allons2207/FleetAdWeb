<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="StuffSearch.aspx.vb" Inherits="WebApplication2.StuffSearch" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%--<%@ Register Src="~/Controls/StuffSearch.ascx" TagName="StuffSearch" TagPrefix="uc1" %>--%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table width="90%">
     <tr>
        <td class="PageTitle"> Staff Search </td>
    </tr>
    <tr>
        <td colspan="4"><telerik:RadToolBar ID="RadToolBar1" runat="server" SingleClick="None" Skin="Office2007" Width="80%">
                <Items>
                    <telerik:RadToolBarButton runat="server" Text="Save Search">
                    </telerik:RadToolBarButton>
                    <telerik:RadToolBarButton runat="server" Text="Print">
                    </telerik:RadToolBarButton>
                    <telerik:RadToolBarButton runat="server" Text="Export">
                    </telerik:RadToolBarButton>
                </Items>
            </telerik:RadToolBar>
        </td>
     </tr>
     <tr>
        <td colspan="4">
            <table width="50%">
                <tr>
                    <td>Title</td> <td><asp:DropDownList ID="drpdwnTitle" runat="server"></asp:DropDownList></td>
                    <td> Employment No</td> <td><asp:TextBox ID="txtEmploymentNum" runat="server"></asp:TextBox> </td>
                </tr>
                <tr>
                    <td>FirstName</td><td><asp:TextBox ID="txtFName" runat="server"></asp:TextBox> </td>
                    <td>Surname</td><td><asp:TextBox ID="txtSurname" runat="server"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>Sex</td><td><asp:DropDownList ID="drpdnSex" runat="server"></asp:DropDownList></td>
                    <td>Marital Status</td><td><asp:DropDownList ID="drpdnMaritalStatus" runat="server"></asp:DropDownList> </td>
                </tr>
                <tr>
                    <td></td>
                    <td><asp:Button ID="btnSearch" runat="server" Text="Search" BackColor="Orange" /></td>
                </tr>
            </table>
        </td>
     </tr>
     
     <tr>
          <td colspan="4"><hr /></td>
     </tr>
     <tr>
          <td colspan="4">SEARCH RESULTS</td>
     </tr>
     <tr>
         <td colspan="4">
              <telerik:RadGrid ID="gvStuffSearch" runat="server" Width ="100%"  BackColor="White"  DisplayMode="FirstLastPreviousNextNumeric, Text" PageSize="50"
                    BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" AutoGenerateSelectButton ="true" CellSpacing="2" AllowSorting="True" GroupPanelPosition="Top" ForeColor="Black" AllowFilteringByColumn="True">
                    <AlternatingItemStyle BackColor="#E9E9E9" />
                    <MasterTableView DataKeyNames="EmploymentNumber">
                    <Columns>
                    <telerik:GridButtonColumn ButtonType="LinkButton" Text="View" CommandName="View"></telerik:GridButtonColumn>
                    </Columns>
                    </MasterTableView>
                </telerik:RadGrid>  
        </td>
    </tr>
</table>
</asp:Content>
