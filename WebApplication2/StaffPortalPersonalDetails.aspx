<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/StaffPortalMaster.Master" CodeBehind="StaffPortalPersonalDetails.aspx.vb" Inherits="WebApplication2.StaffPortalPersonalDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <telerik:RadStyleSheetManager ID="RadStyleSheetManager1" runat="server">
     </telerik:RadStyleSheetManager>
     <telerik:radwindowmanager ID="RadWindowManager1" runat="server" EnableShadow="True" Width="46%">
    </telerik:radwindowmanager>
    <telerik:radajaxmanager runat="server" ID="RadAjaxManager1">
    </telerik:radajaxmanager>

 <table width ="70%" >
    <tr>
        <td style="font-size:medium; color:darkblue" class="auto-style1">
                My Personal Details<br />
        </td>
   </tr>
   <tr>
        <td>
            <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small"></asp:Label>
        </td>
   </tr>
         
   <tr>
         <td>
          <asp:Panel ID="pnlDetails" runat="server" Width="100%" EnableViewState="false" GroupingText ="General Details">
                         
                             <table id="table2"  width ="100%">
                                 <tr>
                                     <td class="auto-style12">
                                         Title </td>
                                     
                                     <td class="auto-style29">
                                         <asp:DropDownList ID="DropDownTitle" runat="server" Enabled="false"></asp:DropDownList> </td>
                                     <td class="auto-style13"> Employment No: </td>
                                      <td class="auto-style25">   <asp:TextBox ID="txtEmploymentNo" runat="server" Enabled="false"></asp:TextBox></td>
                                     <td class="auto-style27">
                                        National ID No:
                                     </td>
                                     <td class="auto-style4">
                                          <asp:TextBox ID="txtNatIDNo" runat="server" Enabled="false"></asp:TextBox></td>
                                         </tr>
                                 <tr>
                                     <td class="auto-style21">
                                         First Name</td>
                                     <td class="auto-style22"><asp:TextBox ID="txtFirstname" runat="server" Enabled="false"></asp:TextBox></td> 
                                     <td class="auto-style23"> Second Name</td>
                                     <td class="auto-style26">
                                         <asp:TextBox ID="txtSecondName" runat="server" Enabled="false"></asp:TextBox>
                                       </td>
                                     <td class="auto-style28"> Surname</td>
                                     <td class="auto-style24"> <asp:TextBox ID="txtSurname" runat="server" Enabled="false"></asp:TextBox></td> 
                                         
                                         </tr>
                                
                                   </table>
                              
                            </asp:Panel>
         </td>
     </tr>
      
     <tr>
         <td>
             <asp:Panel ID="pnlGeneralDetails" runat="server" GroupingText="Personal Details:"
                Width="100%">
                                         <table id="table1" width="100%" class="Normal" >
                                 <tr>
                                     <td>
                                         Date of Birth </td>
                                     
                                     <td>
                                         <telerik:RadDatePicker ID="RadDatePickerDOB" runat="server" Culture="en-US" MinDate="1900-01-01"></telerik:RadDatePicker>
                                     </td>
                                     <td> Sex </td>
                                      <td>  <asp:DropDownList ID="DropDownSex" runat="server" Enabled="false"></asp:DropDownList> </td>
                                     <td>
                                         Marital Status
                                     </td>
                                     <td class="auto-style4">
                                         <asp:DropDownList ID="DropDownMStatus" runat="server" Enabled="false"></asp:DropDownList></td>
                                         </tr>
                                        <tr>
                                     <td>
                                         Job </td>
                                     
                                     <td>
                                         <asp:TextBox ID="txtBox" runat="server" Enabled="false"></asp:TextBox>
                                         </td>
                                     <td>Initiation Date </td>
                                            <td>
                                                <telerik:RadDatePicker ID="RadDatePickerInitDate" runat="server" Culture="en-US" MinDate="1900-01-01" Enabled="False"></telerik:RadDatePicker>  </td>
                                            
                                     <td>
                                         Appointment Date
                                     </td>
                                     <td class="auto-style4">
                                         <telerik:RadDatePicker ID="RadDatePickerADate" runat="server" Culture="en-US" MinDate="1900-01-01" Enabled="False"></telerik:RadDatePicker>
                                         </td>
                                         </tr>
                                              <tr>
                                     <td>
                                         Position </td>
                                     
                                     <td>
                                         <asp:TextBox ID="txtpostion" runat="server" Enabled="false"></asp:TextBox></td>
                                     <td> Salary</td>
                                      <td>   <asp:TextBox ID="txtSalary" runat="server" Enabled="false"></asp:TextBox></td>
                                     <td>
                                        Contact Number
                                     </td>
                                     <td class="auto-style4">
                                          <asp:TextBox ID="txtContactNumber" runat="server" Enabled="false"></asp:TextBox></td>
                                         </tr>
                                                   <tr>
                                     <td>
                                         Dependants No </td>
                                     
                                     <td>
                                         <asp:TextBox ID="txtDependantsNo" runat="server" Enabled="false"></asp:TextBox></td>
                                     <td>Health Conditions</td>
                                      <td>   <asp:TextBox ID="txtHealthConditions" runat="server" Enabled="false"></asp:TextBox></td>
                                     <td>
                                        Office Number
                                     </td>
                                     <td class="auto-style4">
                                          <asp:TextBox ID="txtOfficeNum" runat="server" Enabled="false"></asp:TextBox></td>
                                         </tr>
                                                  
                         </table>
            </asp:Panel> 
               </td>
     </tr>
     <tr>
               <td>
                     <asp:Panel ID="Panel2" runat="server" GroupingText="Qualifications:"
                Width="100%">
            <table id="table3" width="100%" class="Normal" >
                    <tr>
                                   
                                   <td>
                                       <telerik:RadGrid ID="RadListViewStaffQualifications" runat="server" BackColor="White"  AllowPaging="True"  DisplayMode="FirstLastPreviousNextNumeric, Text" PageSize="50"
         BorderColor="White" BorderStyle="None" BorderWidth="1px" CellPadding="3" AutoGenerateSelectButton ="true" CellSpacing="2" AllowSorting="True" GroupPanelPosition="Top" ForeColor="Black" Enabled="False">
                                           <AlternatingItemStyle BackColor="#E9E9E9" />
                                       </telerik:RadGrid>
                                       </td>
                                         </tr>
                
            </table>
          </asp:Panel> 
               </td>
     </tr>
     <tr>
              <td>
                     <asp:Panel ID="pnlHomeAddress" runat="server" GroupingText="Home Address Details:" Width="100%">
                    <table id="table8" width="100%" class="Normal" >
                    <tr>
                         <td >City</td><td ><asp:TextBox ID="txtCity" runat="server" Enabled="false"></asp:TextBox></td>
                         <td > Suburb</td><td>   <asp:TextBox ID="txtSuburb" runat="server" Enabled="false"></asp:TextBox></td>
                         <td > Unit/Section </td> <td ><asp:TextBox ID="txtUnit" runat="server" Enabled="false"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td >Contact Address</td><td class="auto-style14"><asp:TextBox ID="txtContactAddress" runat="server" Enabled="false" Width ="100%" TextMode ="MultiLine"></asp:TextBox></td>
                        <td>Email Address</td><td colspan="3"><asp:TextBox ID="txtEmailAddress" runat="server" Enabled="false" Width ="100%"></asp:TextBox></td>
                        
                    </tr>
                    </table>
              </asp:Panel> 
              </td>
     </tr>
     <tr>
              <td>
                     <asp:Panel ID="Panel1" runat="server" GroupingText="Next of Kin Details:" Width="100%">
                            <table id="table9" width="100%" class="Normal" >
                                <tr>
                                     <td >Firstname</td><td ><asp:TextBox ID="txtGuardianFirstName" runat="server" Enabled="false"></asp:TextBox></td>
                                     <td > Surname</td><td><asp:TextBox ID="txtGuardianSurname" runat="server" Enabled="false"></asp:TextBox></td>
                                     <td > Contact Number </td><td ><asp:TextBox ID="txtGuardianContactNum" runat="server" Enabled="false"></asp:TextBox></td>
                                </tr>
                                <tr>
                                     <td >Contact Address</td><td class="auto-style14"><asp:TextBox ID="txtGuardianContactAddress" runat="server" Enabled="false" Width ="100%" TextMode ="MultiLine"></asp:TextBox></td>
                                     <td>Email Address</td><td colspan="3"><asp:TextBox ID="txtGuardianEmailAddress" runat="server" Width ="100%" Enabled="false"></asp:TextBox></td>
                                </tr>
                                
                           </table>
                     </asp:Panel> 
              </td>
    </tr>

    </table>
</asp:Content>
