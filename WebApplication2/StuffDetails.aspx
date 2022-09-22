<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="StuffDetails.aspx.vb" Inherits="WebApplication2.StuffDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style1 {
            height: 24px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
       <telerik:RadStyleSheetManager ID="RadStyleSheetManager1" runat="server">
     </telerik:RadStyleSheetManager>
     <telerik:radwindowmanager ID="RadWindowManager1" runat="server" EnableShadow="True" Width="46%">
    </telerik:radwindowmanager>
    <telerik:radajaxmanager runat="server" ID="RadAjaxManager1">
    </telerik:radajaxmanager>

 <table width ="80%" >
   <tr>
        <td colspan="6"  style="font-size:medium; color:darkblue">
                Staff Details<br />
        </td>
   </tr>
   <tr>
        <td colspan="6">
            <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small"></asp:Label>
        </td>
   </tr>
   <tr>
        <td colspan="6"> 
            <telerik:RadToolBar ID="stDRadToolBar" runat="server" SingleClick="None" Width="100%" Skin="Windows7">
                                <Items>
                                    <telerik:RadToolBarDropDown runat="server" Text="Documents" />
                                    <telerik:RadToolBarDropDown runat="server" Text="Lists">
                                    </telerik:RadToolBarDropDown>
                                    <telerik:RadToolBarButton runat="server" Text="Save">
                                    </telerik:RadToolBarButton>
                                </Items>
            </telerik:RadToolBar>
            </td>
   </tr>
        
   <tr>
         <td colspan="6"> General Deatils <hr/></td>
   </tr> 
   <tr>
      <td>Title </td><td><asp:DropDownList ID="DropDownTitle" runat="server"></asp:DropDownList> </td>
      <td> Employment No: </td><td><asp:TextBox ID="txtEmploymentNo" runat="server"></asp:TextBox></td>
      <td> National ID No: </td><td><asp:TextBox ID="txtNatIDNo" runat="server"></asp:TextBox></td>
   </tr>
   <tr>
       <td>First Name</td><td><asp:TextBox ID="txtFirstname" runat="server"></asp:TextBox></td> 
       <td> Second Name</td><td><asp:TextBox ID="txtSecondName" runat="server"></asp:TextBox></td>
       <td> Surname</td><td> <asp:TextBox ID="txtSurname" runat="server"></asp:TextBox></td> 
    </tr>
    <tr>
       <td>Date of Birth </td><td><telerik:RadDatePicker ID="RadDatePickerDOB" runat="server" Culture="en-US" MinDate="1900-01-01"></telerik:RadDatePicker></td>
       <td> Sex </td><td>  <asp:DropDownList ID="DropDownSex" runat="server"></asp:DropDownList> </td>
       <td> Marital Status </td><td><asp:DropDownList ID="DropDownMStatus" runat="server"></asp:DropDownList></td>
    </tr>
    <tr>
       <td>Job </td><td><asp:TextBox ID="txtBox" runat="server"></asp:TextBox></td>
       <td>Initiation Date </td><td><telerik:RadDatePicker ID="RadDatePickerInitDate" runat="server" Culture="en-US" MinDate="1900-01-01"></telerik:RadDatePicker>  </td>
       <td>Appointment Date</td><td><telerik:RadDatePicker ID="RadDatePickerADate" runat="server" Culture="en-US" MinDate="1900-01-01"></telerik:RadDatePicker></td>
    </tr>
    <tr>
       <td>Position </td><td><asp:TextBox ID="txtpostion" runat="server"></asp:TextBox></td>
       <td>Salary</td><td><asp:TextBox ID="txtSalary" runat="server"></asp:TextBox></td>
       <td>Contact Number</td><td><asp:TextBox ID="txtContactNumber" runat="server"></asp:TextBox></td>
    </tr>
    <tr>
       <td>Dependants No </td><td><asp:TextBox ID="txtDependantsNo" runat="server"></asp:TextBox></td>
       <td>Health Conditions</td><td><asp:TextBox ID="txtHealthConditions" runat="server"></asp:TextBox></td>
       <td>Office Number</td><td><asp:TextBox ID="txtOfficeNum" runat="server"></asp:TextBox></td>
    </tr>
    <tr><td colspan="6"> <hr /></td></tr>
     <tr><td colspan="6">Qualifications:</td></tr>
    <tr>
       
                 <td colspan="2">
                    
                                           
                                                  <table width="100%">
                                                <tr>
                                            <td>
                                        Level</td>
                                                    <td >
                                          
                                                        <telerik:RadComboBox ID="RadComboBoxLevel" Runat="server">
                                                        </telerik:RadComboBox>
                                                    </td>
                                                    </tr>
                                                <tr>
                                                  <td > Qualification</td>
                                      <td>   
                                          <telerik:RadComboBox ID="RadComboBoxQualification" Runat="server">
                                          </telerik:RadComboBox>
                                                    </td>
                                   
                                                </tr>
                                              <tr>
                                                  <td > Institution</td>
                                      <td>   
                                          <telerik:RadComboBox ID="RadComboBoxInstitution" Runat="server">
                                          </telerik:RadComboBox>
                                                  </td>
                                     
                                                </tr>
                                                    <tr>
                                               <td>
                                       Year Awarded
                                     </td>
                                     <td >
                                         <telerik:RadDatePicker ID="RadDatePickerYearAwarded" runat="server"></telerik:RadDatePicker>
                                          </td>
                                                        </tr>
                                                <tr>
                                                        <td>
                                                            
                                                        </td>
                                                        <td>
                                                            <asp:Button ID="cmdAdd" runat="server" Text="Clear" BackColor="Orange" Width="69px" />
                                                            &nbsp;&nbsp;&nbsp;&nbsp
                                                           <asp:Button ID="cmdSave" runat="server" Text="Save" BackColor="Orange" Width="69px" />
                                                        </td>
                                                </tr>
                                                </table>
                                           
                 </td>
                 <td valign="top" colspan="4">
                                       <telerik:RadGrid ID="RadListViewStaffQualifications" runat="server" BackColor="White"  AllowPaging="True"  DisplayMode="FirstLastPreviousNextNumeric, Text" PageSize="50"
                                                        BorderColor="White" BorderStyle="None" BorderWidth="1px" CellPadding="3" AutoGenerateSelectButton ="true" CellSpacing="2" AllowSorting="True" GroupPanelPosition="Top" ForeColor="Black">
                                           <AlternatingItemStyle BackColor="#E9E9E9" />
                                       </telerik:RadGrid>
                 </td>
      </tr>
     <tr><td colspan="6"><hr /></td></tr>
     <tr><td colspan="6">Physical Address</td></tr>
      <tr>
          <td >City</td><td ><asp:TextBox ID="txtCity" runat="server"></asp:TextBox></td>
          <td > Suburb</td><td>   <asp:TextBox ID="txtSuburb" runat="server"></asp:TextBox></td>
          <td > Unit/Section </td> <td ><asp:TextBox ID="txtUnit" runat="server"></asp:TextBox></td>
      </tr>
      <tr>
          <td>Contact Address</td><td><asp:TextBox ID="txtContactAddress" runat="server" Width ="100%" TextMode ="MultiLine"></asp:TextBox></td>
          <td>Email Address</td><td colspan="3"><asp:TextBox ID="txtEmailAddress" runat="server" Width="100%" ></asp:TextBox></td>
      </tr>
      <tr>
          <td colspan="6"><hr /></td>
      </tr>
      <tr>
          <td colspan="6">Next of Kin Details:</td>
      </tr>        
      <tr>
          <td >Firstname</td><td ><asp:TextBox ID="txtGuardianFirstName" runat="server"></asp:TextBox></td>
          <td > Surname</td><td><asp:TextBox ID="txtGuardianSurname" runat="server"></asp:TextBox></td>
          <td > Contact Number </td><td ><asp:TextBox ID="txtGuardianContactNum" runat="server"></asp:TextBox></td>
      </tr>
      <tr>
          <td >Contact Address</td><td class="auto-style14"><asp:TextBox ID="txtGuardianContactAddress" runat="server" Width ="100%" TextMode ="MultiLine"></asp:TextBox></td>
          <td>Email Address</td><td colspan="3"><asp:TextBox ID="txtGuardianEmailAddress" runat="server" Width="100%"></asp:TextBox></td>
          <td></td>
       </tr>
      </table>
   </asp:Content>