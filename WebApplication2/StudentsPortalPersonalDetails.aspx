<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/StudentsPortalMaster.Master" CodeBehind="StudentsPortalPersonalDetails.aspx.vb" Inherits="WebApplication2.StudentsPortalPersonalDetails" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style2 {
            width: 108px;
        }
        .auto-style3 {
            height: 24px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table>
         <tr>
       <td style="font-size:medium; color:darkblue " colspan="6">
           Your Personal Details are
       </td>
       </tr>
       <tr>
         <td>
             <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small"></asp:Label>
         </td>
        </tr>
         <tr>
                                     <td >
                                         First Name</td>
                                     <td ><asp:TextBox ID="txtFName" runat="server" BackColor="#EFEFEF" Enabled="False"></asp:TextBox></td> 
                                    <td class="auto-style2" > Second Name</td>
                                     <td >
                                                                              <asp:TextBox ID="txtSecName" runat="server" BackColor="#EFEFEF" Enabled="False"></asp:TextBox>
                                       </td>
                                     <td > Surname</td>
                                     <td > <asp:TextBox ID="txtSurname" runat="server" BackColor="#EFEFEF" Enabled="False"></asp:TextBox></td> 
                                         
                                         </tr>
         <tr>

            <td> Stream </td>
                                     
                                     <td >
                                         <asp:TextBox ID="txtStream" runat="server" BackColor="#EFEFEF" Enabled="False"></asp:TextBox>
                                         </td>
                                     <td class="auto-style2" > Class </td>
                                      <td >  <asp:TextBox ID="txtClass" runat="server" BackColor="#EFEFEF" Enabled="False"></asp:TextBox> </td>
                                     <td >
                                         Student No
                                     </td>
                                     <td >
                                          <asp:TextBox ID="txtStudentNo" runat="server" BackColor="#EFEFEF" Enabled="False"></asp:TextBox></td>
                                         </tr>
                                        
                                     <tr>
                                     <td >
                                       Registration Date</td>
                                     <td>
                                         <asp:TextBox ID="txtRegNum" runat="server" BackColor="#EFEFEF" Enabled="False"></asp:TextBox>
                                     </td> 
                                     <td class="auto-style2"> Contact No</td>
                                     <td class="auto-style25">
                                         <asp:TextBox ID="txtStudentContactNum" runat="server" BackColor="#EFEFEF" Enabled="False"></asp:TextBox> </td>
                                     <td > &nbsp;</td>
                                     <td > &nbsp;</td> 
                                          </tr>
                                 <tr>
                                     <td>
                                         e-Mail Address</td>
                                     <td colspan="3">
                                         <asp:TextBox ID="txtStudentEmail" runat="server" Width="407px" BackColor="#EFEFEF" Enabled="False"></asp:TextBox> </td>
                                 </tr>




         <tr>
                       <td>Date of Birth </td>
                       <td><asp:TextBox ID="txtDOB" runat="server" BackColor="#EFEFEF" Enabled="False"></asp:TextBox>
                        </td>
                        <td class="auto-style2">Birth Certificate No </td>
                        <td><asp:TextBox ID="txtBirthNo" runat="server" BackColor="#EFEFEF" Enabled="False"></asp:TextBox></td>
                        <td>Nat. ID No </td>
                        <td class="auto-style4"><asp:TextBox ID="txtIDNo" runat="server" BackColor="#EFEFEF" Enabled="False"></asp:TextBox></td></tr>
                   <tr><td>Sex </td><td><asp:TextBox ID="txtSex" runat="server" BackColor="#EFEFEF" Enabled="False"></asp:TextBox></td>
                       <td class="auto-style2">&nbsp;</td><td>&nbsp;</td>
                       <td>&nbsp;</td><td class="auto-style4">&nbsp;</td></tr>
        

        <tr>
            <td>&nbsp</td>
        </tr>
        <tr><td colspan="6">Student Address Details</td></tr>
            
                 <tr>
                     <td class="auto-style3">City</td><td class="auto-style3"><asp:TextBox ID="txtCity" runat="server" BackColor="#EFEFEF" Enabled="False"></asp:TextBox></td>
                     <td class="auto-style3">Suburb</td><td class="auto-style3"><asp:TextBox ID="txtSuburb" runat="server" BackColor="#EFEFEF" Enabled="False"></asp:TextBox></td>
                     <td class="auto-style3">Unit/Section </td><td class="auto-style3"><asp:TextBox ID="txtSection" runat="server" BackColor="#EFEFEF" Enabled="False"></asp:TextBox></td>

                 </tr>
                 <tr><td>Street Address </td><td><asp:TextBox ID="txtStreetAddress" runat="server" TextMode="MultiLine" BackColor="#EFEFEF" Enabled="False" ></asp:TextBox>
                     </td></tr>
           
         <tr>
            <td>&nbsp</td>
        </tr>
        <tr><td colspan="6">Next of Kin Details</td></tr>
                 <tr><td>Title</td><td>
                     <asp:TextBox ID="txtGuardianTitle" runat="server" BackColor="#EFEFEF" Enabled="False"></asp:TextBox>
                     </td>
                     <td>First Name</td><td><asp:TextBox ID="txtGuardianFName" runat="server" BackColor="#EFEFEF" Enabled="False"></asp:TextBox></td><td>Surname </td>
                     <td><asp:TextBox ID="txtGuardianSurname" runat="server" BackColor="#EFEFEF" Enabled="False"></asp:TextBox></td>
                 </tr>
                 <tr><td>Relationship </td><td>
                     <asp:TextBox ID="txtGuardianToStudentRelationshp" runat="server" BackColor="#EFEFEF" Enabled="False"></asp:TextBox>
                     </td>
                     <td>Occupation </td>
                     <td><asp:TextBox ID="txtGuardianOccupation" runat="server" BackColor="#EFEFEF" Enabled="False"></asp:TextBox></td><td>Contact Number</td>
                     <td><asp:TextBox ID="txtGContactNo" runat="server" BackColor="#EFEFEF" Enabled="False"></asp:TextBox>
                     </td></tr><tr><td>Hse Address </td><td><asp:TextBox ID="txtGAddress" runat="server" TextMode="MultiLine" BackColor="#EFEFEF" Enabled="False"></asp:TextBox></td>
                     <td>Email Address </td><td colspan="3"><asp:TextBox ID="txtGEmail" runat="server" BackColor="#EFEFEF" Enabled="False" Width="362px"></asp:TextBox></td>
                     
                  </tr>
           
  </table>
    
</asp:Content>
