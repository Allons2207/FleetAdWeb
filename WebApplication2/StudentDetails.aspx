<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="StudentDetails.aspx.vb" Inherits="WebApplication2.StudentDetails" %>
<%--<%@ Register Src="~/Controls/StudentPersonalDetails.ascx" TagName="StudentPersonalDetails" TagPrefix="uc1" %>
<%@ Register Src="~/Controls/StudentSubjects.ascx" TagName="StudentSubjects" TagPrefix="uc2" %>
<%@ Register Src="~/Controls/ExtraCurricula.ascx" TagName="ExtraCurricula" TagPrefix="uc3" %>--%>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

   <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
       <style type="text/css">
        .auto-style1 {
            width: 222px;
        }
        .auto-style2 {
            width: 293px;
        }
        .auto-style3 {
            width: 623px;
        }
        .auto-style4 {
            width: 611px;
        }
        .auto-style5 {
            width: 351px;
        }
        .auto-style6 {
            height: 20px;
        }
    </style>
    
  </asp:Content>
  <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
      <telerik:RadStyleSheetManager ID="RadStyleSheetManager1" runat="server">   </telerik:RadStyleSheetManager>
  <telerik:radwindowmanager ID="RadWindowManager1" runat="server" EnableShadow="True" Width="46%"></telerik:radwindowmanager>
  <telerik:radajaxmanager runat="server" ID="RadAjaxManager1"></telerik:radajaxmanager>
  
    <table width ="80%" class ="normal">
        <tr>
            <td style="font-size:medium; color:darkblue" >
                Student Details<br />
            </td>
        </tr>
        <tr>
             <td>
                 <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small"></asp:Label>
             </td>
         </tr>
        <tr>
            <td> <telerik:RadToolBar ID="radtlbrMemberActions" runat="server"   Skin="Windows7" Width="100%" SingleClick="None">
                                <Items>
                                    <telerik:RadToolBarDropDown runat="server" Text="Documents" />
                                    <telerik:RadToolBarDropDown runat="server" Text="Lists">
                                    </telerik:RadToolBarDropDown>
                                    <telerik:RadToolBarButton runat="server" Text="Save">
                                    </telerik:RadToolBarButton>
                                </Items>
                            </telerik:RadToolBar>
                <asp:Label ID="lblMessage" runat="server" ></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Panel ID="pnlDetails" runat="server" Width="100%" EnableViewState="false">
                     <table id="table2" width ="100%" >
                                 <tr>
                                     <td>
                                         Stream </td>
                                     
                                     <td>
                                         <telerik:RadComboBox ID="DropDownListStreams" runat="server"></telerik:RadComboBox>
                                     </td>
                                     <td> Class </td>
                                      <td>  <telerik:RadComboBox ID="DropDownListClass" runat="server"></telerik:RadComboBox> </td>
                                     <td> Student No </td>
                                     <td><asp:TextBox ID="txtStudentNo" runat="server"></asp:TextBox></td>
                                  </tr>
                                  <tr>
                                     <td>First Name</td>
                                     <td><asp:TextBox ID="txtFName" runat="server"></asp:TextBox></td> 
                                    <td> Second Name</td>
                                     <td><asp:TextBox ID="txtSecName" runat="server"></asp:TextBox></td>
                                     <td> Surname</td>
                                     <td> <asp:TextBox ID="txtSurname" runat="server"></asp:TextBox></td> 
                                  </tr>
                                  <tr>
                                     <td>Registration Date</td>
                                     <td>
                                         <telerik:RadDatePicker ID="dateRegistration" runat="server" Culture="en-US" MinDate="1900-01-01"></telerik:RadDatePicker>
                                     </td> 
                                     <td> Current Position</td>
                                     <td>
                                         <telerik:RadComboBox ID="DropDownListStudentPosition" runat="server">
                                         </telerik:RadComboBox>
                                     </td>
                                     <td> Contact No</td>
                                     <td> <asp:TextBox ID="txtContactno" runat="server"></asp:TextBox></td> 
                                 </tr>
                                 <tr>
                                     <td>Student Status</td>
                                     <td>
                                         <telerik:RadComboBox ID="cbStudentStatus" runat="server">
                                             <Items>
                                                 <telerik:RadComboBoxItem runat="server" Text="In-School" Value="In-School" />
                                                 <telerik:RadComboBoxItem runat="server" Text="Transfered" Value="Transfered" />
                                                 <telerik:RadComboBoxItem runat="server" Text="Absconded" Value="Absconded" />
                                                 <telerik:RadComboBoxItem runat="server" Text="Completed" Value="Completed" />
                                             </Items>
                                         </telerik:RadComboBox>
                                     </td>
                                 </tr>
                          </table>
                </asp:Panel>
            </td>
        </tr>
        <tr>
            <td>
                <telerik:RadTabStrip ID="PageLevelTabs" runat="server" MultiPageID="PageLevelMultiPage1" Width="100%"  CausesValidation="False" SelectedIndex="0">
                    <Tabs>
                        <telerik:RadTab runat="server" Text="Student Details" Value="Personal Details" PageViewID="RadPageView1" Selected="True" >
                        </telerik:RadTab>
                        <telerik:RadTab runat="server" Text="Subjects" Value="Subjects" PageViewID="RadPageView2">
                        </telerik:RadTab>
                        <telerik:RadTab runat="server" Text="Extra-Curricula" Value="Attendance" PageViewID="RadPageView3" >
                        </telerik:RadTab>
                        <telerik:RadTab runat="server" Text="Payments History" Value="Payment History" PageViewID="RadPageView4">
                        </telerik:RadTab>
                        <telerik:RadTab runat="server" Text="Behaviour" Value="Library Assets" PageViewID="RadPageView5">
                        </telerik:RadTab>
                        <telerik:RadTab runat="server" Text="Attendance" Value="Extra-Curricula" PageViewID="RadPageView6" >
                        </telerik:RadTab>
                        <telerik:RadTab runat="server" Text="Library History" PageViewID="RadPageView7">
                        </telerik:RadTab>
                        <telerik:RadTab runat="server" PageViewID="RadPageView8" Text="Coursework">
                        </telerik:RadTab>
                        <telerik:RadTab runat="server" PageViewID="RadPageView9" Text="Examinations">
                        </telerik:RadTab>
                        <telerik:RadTab runat="server" PageViewID="RadPageView10" Text="Files">
                        </telerik:RadTab>
                    </Tabs>
               </telerik:RadTabStrip> 
          
          <telerik:RadMultiPage ID="PageLevelMultiPage1" runat="server" Width="100%" SelectedIndex="0" >
          <telerik:RadPageView ID="RadPageView1" runat="server">
          <asp:Panel ID="Panel1" runat="server" GroupingText="General Details:" Width="100%">
              <table id="table1" class="Normal" width="100%">
                   <tr>
                       <td>Date of Birth </td>
                       <td><telerik:RadDatePicker ID="dateDOB" runat="server" Culture="en-US" MinDate="1900-01-01" Skin="Default">
                                <Calendar EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;" UseColumnHeadersAsSelectors="False" UseRowHeadersAsSelectors="False" runat="server"></Calendar>
                                    <DateInput DateFormat="M/d/yyyy" DisplayDateFormat="M/d/yyyy" LabelWidth="40%" runat="server">
                                        <EmptyMessageStyle Resize="None" />
                                        <ReadOnlyStyle Resize="None" />
                                        <FocusedStyle Resize="None" />
                                        <DisabledStyle Resize="None" />
                                        <InvalidStyle Resize="None" />
                                        <HoveredStyle Resize="None" />
                                        <EnabledStyle Resize="None" />
                                    </DateInput>
                                    <DatePopupButton/>
                             </telerik:RadDatePicker>
                        </td>
                        <td>Birth Certificate No </td>
                        <td><asp:TextBox ID="txtBirthNo" runat="server"></asp:TextBox></td>
                        <td>Nat. ID No </td>
                        <td class="auto-style4"><asp:TextBox ID="txtIDNo" runat="server"></asp:TextBox></td></tr>
                   <tr><td>Sex </td><td><telerik:RadComboBox ID="drpdwnSex" runat="server" ></telerik:RadComboBox></td>
                       <td>Marital Status</td><td><telerik:RadComboBox ID="drpdwnMaritalStatus" runat="server" ></telerik:RadComboBox></td>
                       <td>Orphan Status </td><td class="auto-style4"><telerik:RadComboBox ID="drpdwnOpharnStatus" runat="server" ></telerik:RadComboBox></td></tr>
                   <tr><td>Health Condition </td>
                       <td>
                           <telerik:RadComboBox ID="DropDownListHealthCndtn" runat="server"></telerik:RadComboBox>
                       </td>
                       <td>Hostel</td>
                       <td>
                           <telerik:RadComboBox ID="DropDownListHostel" runat="server"></telerik:RadComboBox></td>
                       <td>Disability </td>
                       <td class="auto-style4">
                           <telerik:RadComboBox ID="DropDownListDisability" runat="server"></telerik:RadComboBox></td>
                   </tr>
                   <tr><td>Religion </td><td><telerik:RadComboBox ID="DropDownListReligion" runat="server"></telerik:RadComboBox></td><td>Sports House</td><td><telerik:RadComboBox ID="DropDownListSportHse" runat="server"></telerik:RadComboBox></td><td>Boarding Status </td><td><telerik:RadComboBox ID="drpdwnBoardingStatus" runat="server"></telerik:RadComboBox></td></tr><tr><td>Student Requires Transport </td><td><telerik:RadComboBox ID="drpdwnStudentTranspt" runat="server" >
                   <Items>
                       <telerik:RadComboBoxItem runat="server" Text="" Value="" />
                       <telerik:RadComboBoxItem runat="server" Text="Transport" Value="1" />
                       <telerik:RadComboBoxItem runat="server" Text="No Transport" Value="0" />
                   </Items>
                   </telerik:RadComboBox></td><td></td><td></td><td></td><td class="auto-style4"></td></tr>

               </table>
               </asp:Panel>
         
         <asp:Panel ID="Panel2" runat="server" GroupingText="Home Address Details:" Width="100%">
             <table id="table3" class="Normal"  width="90%"><tr><td>City</td><td><asp:TextBox ID="txtCity" runat="server"></asp:TextBox></td><td>Suburb</td><td><asp:TextBox ID="txtSuburb" runat="server"></asp:TextBox></td><td>Unit/Section </td><td><asp:TextBox ID="txtSection" runat="server"></asp:TextBox></td></tr><tr><td>Street Address </td><td><asp:TextBox ID="txtStreetAddress" runat="server" TextMode="MultiLine" ></asp:TextBox></td></tr></table></asp:Panel>
                   <asp:Panel ID="Panel3" runat="server" GroupingText="Guardian Details:" Width="100%"><table id="tblGuardianDetails" class="Normal" width="100%"><tr><td>Title</td><td><telerik:RadComboBox ID="txtGuardianTitle" runat="server" Width="42%"></telerik:RadComboBox></td><td>First Name</td><td><asp:TextBox ID="txtGuardianFName" runat="server"></asp:TextBox></td><td>Surname </td><td><asp:TextBox ID="txtGuardianSurname" runat="server"></asp:TextBox></td></tr><tr><td>Relationship </td><td><telerik:RadComboBox ID="drpdwnGuardianRelationshp" runat="server" Width="42%"></telerik:RadComboBox></td><td>Occupation </td>
                       <td><telerik:RadComboBox ID="txtGuardianOccupation" runat="server" ></telerik:RadComboBox></td><td>Marital Status </td>
                       <td><telerik:RadComboBox ID="drpdwnGuardianMarital" runat="server"></telerik:RadComboBox>
                       </td></tr><tr><td>Hse Address </td><td><asp:TextBox ID="txtGAddress" runat="server" TextMode="MultiLine"></asp:TextBox></td><td>Email Address </td><td><asp:TextBox ID="txtGEmail" runat="server"></asp:TextBox></td><td>Contact Number </td><td><asp:TextBox ID="txtGContactNo" runat="server"></asp:TextBox></td></tr></table></asp:Panel>

               </telerik:RadPageView>         

                 <telerik:RadPageView ID="RadPageView2" runat="server"><table><tr><td>Subject List Details </td></tr><tr><td><asp:Button ID="Button1" runat="server" Text="Save" BackColor="#FF9900" ForeColor="White" Width="85px" /></td></tr><tr><td><telerik:RadTreeView ID="RadTreeSubjects"  runat="server" CheckBoxes="true" 
                TriStateCheckBoxes="true" CheckChildNodes="True" Skin="Glow"  BorderColor="Black" ForeColor="Black">
            </telerik:RadTreeView><asp:TextBox ID="txtStudentID" runat="server" Visible="False"></asp:TextBox>-</td></tr></table></telerik:RadPageView>

                    
                   <telerik:RadPageView ID="RadPageView3" runat="server"><div width ="100%">
                        <table>
        <tr>
           <td style="vertical-align:top" >
                <asp:Panel ID="Panel4" runat="server" Width="257px">
                    <B>Clubs</B>
                </asp:Panel>
             
                <asp:Panel ID="pnTreeClubs" runat="server">
                    <table>
                        <tr>
                            <td class="auto-style6">
                                Student Participates in 
                            </td>
                            <td class="auto-style6">
                                <asp:Label ID="Label1" runat="server" ></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Button ID="SaveClubs" runat="server" Text="Save" BackColor="#FF9900" Width="107px" />
                            </td>
                            </tr>
                        </table>
                           
        <telerik:RadTreeView ID="RadTreeClubs" width="100%" runat="server" CheckBoxes="true" 
                TriStateCheckBoxes="true" CheckChildNodes="True" Skin="Glow" BorderColor="Black" ForeColor="Black" >
            </telerik:RadTreeView>
                           
                    </asp:Panel>
               </td>

                  <td style="vertical-align:top" class="auto-style5"> 
                  <asp:Panel ID="Panel6" runat="server">
                    <B>Sports</B>
                
                      <table>
                        <tr>
                            <td class="auto-style1">
                                Student Participates in 
                            </td>
                            <td class="auto-style1">
                                <asp:Label ID="Label2" runat="server" ></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Button ID="SaveSports" runat="server" Text="Save" BackColor="#FF9900" Width="107px" />
                            </td>
                        </tr>
                    </table>
                 <telerik:RadTreeView ID="RadTreeSports" width="100%" runat="server" CheckBoxes="true" 
                TriStateCheckBoxes="true" CheckChildNodes="True" Skin="Glow" BorderColor="Black" ForeColor="Black" >
            </telerik:RadTreeView>
                 </asp:Panel>
                            </td>
                       <td style="vertical-align:top">
                     <asp:Panel ID="pnOtherActivities" runat="server">
                    <B>Other Activities</B>
                </asp:Panel>
                
                  <asp:Panel ID="pnOtherActivitiesNumber" runat="server">
                    <table>
                        <tr>
                            <td>
                                Student Participates in 
                            </td>
                            <td>
                                <asp:Label ID="lbOtherActivitiesNum" runat="server" ></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Button ID="cmdSaveOtherActivitiesNum" runat="server" Text="Save" BackColor="#FF9900" Width="107px" />
                            </td>
                        </tr>
                    </table>

                </asp:Panel>
                         <asp:Panel ID="pnTreeOtherActivities" runat="server">
                  
      <telerik:RadTreeView ID="RadTreeOtherActivities" width="100%" runat="server" CheckBoxes="true" 
                TriStateCheckBoxes="true" CheckChildNodes="True" Skin="Glow" BorderColor="Black" ForeColor="Black" >
            </telerik:RadTreeView>
                     </asp:Panel>
              
                            </td>
                        </tr>
                    </table>

              </div>
    </telerik:RadPageView>
                    <telerik:RadPageView ID="RadPageView4" runat="server">
                        <table>
                            <tr>
                                <td>
                                    Select Payment History To View
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="radComboPaymentsHistory" runat="server" AutoPostBack="True" >
                                        <Items>
                                            <telerik:RadComboBoxItem runat="server" Text="--Select--" Value="--Select--" />
                                            <telerik:RadComboBoxItem runat="server" Text="Tuition" Value="1" />
                                            <telerik:RadComboBoxItem runat="server" Text="Levy" Value="2" />
                                            <telerik:RadComboBoxItem runat="server" Text="Transport" Value="3" />
                                            <telerik:RadComboBoxItem runat="server" Text="Registration" Value="4" />
                                            <telerik:RadComboBoxItem runat="server" Text="Uniforms" Value="5" />
                                        </Items>
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                        </table>
                        <table width ="100%">
                            <tr>
                                <td class="auto-style2">
                                     <telerik:RadGrid ID="gwStudentPaymentHistory" runat="server" Width ="100%"  BackColor="White"  AllowPaging="True"  DisplayMode="FirstLastPreviousNextNumeric, Text" PageSize="50"
         BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" AllowSorting="True" GroupPanelPosition="Top"  ForeColor="Black">
   
                    <ClientSettings>
                        <Scrolling AllowScroll="True"  />
                    </ClientSettings>
                   
                                         <AlternatingItemStyle BackColor="#E9E9E9" />
                   
     </telerik:RadGrid>   
                                </td>
                            </tr>
                        </table>
                    </telerik:RadPageView>
                    <telerik:RadPageView ID="RadPageView5" runat="server">
                         <table width ="100%">
                            <tr>
                                <td>
                                    <telerik:RadGrid ID="gwBehaviourSearch" runat="server" Width ="100%"  BackColor="White"  AllowPaging="True"  DisplayMode="FirstLastPreviousNextNumeric, Text" PageSize="50"
                                                    BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" AllowSorting="True" GroupPanelPosition="Top"  ForeColor="Black">
                                    <ClientSettings>
                                        <Scrolling AllowScroll="True"  />
                                    </ClientSettings>
                   
                                        <AlternatingItemStyle BackColor="#E9E9E9" />
                   
                                    </telerik:RadGrid>   
                                </td>
                            </tr>
                        </table>
                    </telerik:RadPageView>

                    <telerik:RadPageView ID="RadPageView6" runat="server">
                         <table width ="100%">
                            <tr>
                                <td>
                                    <telerik:RadGrid ID="gwAttendance" runat="server" Width ="100%"  BackColor="White"  AllowPaging="True"  DisplayMode="FirstLastPreviousNextNumeric, Text" PageSize="50"
                                                    BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" AllowSorting="True" GroupPanelPosition="Top"  ForeColor="Black" AutoGenerateColumns="False">
                                    <ClientSettings>
                                        <Scrolling AllowScroll="True"  />
                                    </ClientSettings>
                   
                                        <AlternatingItemStyle BackColor="#E9E9E9" />
                   
                                        <MasterTableView>
                                            <Columns>
                                                <telerik:GridBoundColumn DataField="Date" FilterControlAltText="Filter Date column" HeaderText="Date" UniqueName="Date">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="Stream" FilterControlAltText="Filter Stream column" HeaderText="Stream" UniqueName="Stream">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="Class" FilterControlAltText="Filter Class column" HeaderText="Class" UniqueName="Class">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridCheckBoxColumn DataField="Attendance" DataType="System.Boolean" FilterControlAltText="Filter column column" HeaderText="Attendance" UniqueName="column">
                                                </telerik:GridCheckBoxColumn>
                                                <telerik:GridBoundColumn DataField="Comments" FilterControlAltText="Filter Comments column" HeaderText="Reason for Absence (If Absent)" UniqueName="Comments">
                                                </telerik:GridBoundColumn>
                                            </Columns>
                                        </MasterTableView>
                   
                                    </telerik:RadGrid>   
                                </td>
                            </tr>
                        </table>
                    </telerik:RadPageView>
                    <telerik:RadPageView ID="RadPageView7" runat="server">
                        <table width = "100%">
                            <tr>
                                <td>
                                        <telerik:RadGrid ID="gwLibrary" runat="server" BackColor="White"  AllowPaging="True"  DisplayMode="FirstLastPreviousNextNumeric, Text" PageSize="50"
                                            BorderColor="White" BorderStyle="None" BorderWidth="1px" CellPadding="3" AutoGenerateSelectButton ="true" CellSpacing="2" AllowSorting="True" GroupPanelPosition="Top" ForeColor="Black">
                                            <AlternatingItemStyle BackColor="#E9E9E9" />
                                        </telerik:RadGrid>
                                </td>
                            </tr>
                        </table>
                    </telerik:RadPageView>

                    <telerik:RadPageView ID="RadPageView8" runat="server">
                        <table width = "100%">
                            <tr>
                                <td>
                                        <telerik:RadGrid ID="gwCoursework" runat="server" BackColor="White"  AllowPaging="True"  DisplayMode="FirstLastPreviousNextNumeric, Text" PageSize="50"
                                            BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" AutoGenerateSelectButton ="true" CellSpacing="2" AllowSorting="True" GroupPanelPosition="Top" ForeColor="Black">
                                            <AlternatingItemStyle BackColor="#E9E9E9" />
                                        </telerik:RadGrid>
                                </td>
                            </tr>
                        </table>
                    </telerik:RadPageView>
                    <telerik:RadPageView ID="RadPageView9" runat="server">
                        <table width = "100%">
                            <tr>
                                <td>
                                        <telerik:RadGrid ID="gwExams" runat="server" BackColor="White"  AllowPaging="True"  DisplayMode="FirstLastPreviousNextNumeric, Text" PageSize="50"
                                            BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" AutoGenerateSelectButton ="true" CellSpacing="2" AllowSorting="True" GroupPanelPosition="Top" ForeColor="Black">
                                            <AlternatingItemStyle BackColor="#E9E9E9" />
                                        </telerik:RadGrid>
                                </td>
                            </tr>
                        </table>
                    </telerik:RadPageView>
                    <telerik:RadPageView ID="RadPageView10" runat="server">
                        <table width = "100%">
                            <tr>
                                <td>
                                        <telerik:RadGrid ID="gwFiles" runat="server" CellPadding="0" GridLines="None" Height="100%" Width="100%">
                                            <MasterTableView AllowFilteringByColumn="True" AllowMultiColumnSorting="true" AllowPaging="True" AllowSorting="true" AutoGenerateColumns="False" PagerStyle-Mode="NextPrevNumericAndAdvanced">
                                                <Columns>
                                                    <telerik:GridBoundColumn DataField="FileID" Display="false" HeaderText="FileID" UniqueName="FileID">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="FilePath" Display="false" HeaderText="FilePath" UniqueName="FilePath">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridButtonColumn ButtonType="LinkButton" CommandName="View" Text="Edit Details" UniqueName="column">
                                                    </telerik:GridButtonColumn>
                                                    <telerik:GridBoundColumn DataField="Title" HeaderText="Title" UniqueName="Title">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="FileType" HeaderText="FileType" UniqueName="FileType">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="Author" HeaderText="Author" UniqueName="Author">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="AuthorOrganization" HeaderText="AuthorOrganization" UniqueName="AuthorOrganization">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="Description" HeaderText="Description" UniqueName="Description">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="Date" HeaderText="DateUploaded" UniqueName="DateUploaded">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridButtonColumn ButtonCssClass="btn btn-default" ButtonType="LinkButton" CommandName="Download" Text="Download File" UniqueName="DownloadFile">
                                                    </telerik:GridButtonColumn>
                                                </Columns>
                                                <RowIndicatorColumn>
                                                    <HeaderStyle Width="20px" />
                                                </RowIndicatorColumn>
                                                <ExpandCollapseColumn>
                                                    <HeaderStyle Width="20px" />
                                                </ExpandCollapseColumn>
                                                <EditFormSettings>
                                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                    </EditColumn>
                                                </EditFormSettings>
                                                <PagerStyle AlwaysVisible="true" Position="Top" />
                                            </MasterTableView>
                                            <ClientSettings EnablePostBackOnRowClick="true">
                                            </ClientSettings>
                                            <FilterMenu EnableImageSprites="False">
                                            </FilterMenu>
                                        </telerik:RadGrid>
                                </td>
                            </tr>
                        </table>
                    </telerik:RadPageView>

        </telerik:RadMultiPage>
        </td>
        </tr>
        </table>
           
    </asp:Content>
