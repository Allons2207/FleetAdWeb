<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="AccidentDetails.aspx.vb" Inherits="WebApplication2.AccidentDetails" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <h3 style="font-size:medium; color:gray "> Accident/Incident Details</h3>
    <table style="margin-left:2%" >
         <tr>
         <td colspan="4">
             <asp:Label ID="lblMsg" runat="server" Text=""  Font-Italic="True" Font-Size="Small" Width ="100%"></asp:Label>
         </td>
        </tr>
        <tr><td><b>SEARCH</b></td></tr>

            <tr><td>Search by Fleet ID.</td><td><asp:TextBox ID="txtFleetIDSearch" runat="server" Width="211px"></asp:TextBox></td><td><asp:Button ID="btnSearchByFleetID" runat="server" Text="Find" Width="150px" /></td></tr>
            <tr><td>Search by Reg No.</td><td><asp:TextBox ID="txtRegNo" runat="server" Width="211px"></asp:TextBox></td><td><asp:Button ID="cmdClear0" runat="server" Text="Find" Width="150px" /></td></tr>
        <tr><td colspan="5"><hr /></td></tr>
        
        <tr><td><b>Vehicle Details</b></td></tr>
         <tr> 
            <td>Fleet ID Number</td><td> <asp:TextBox ID="txtFleetId" runat="server" Width="209px" Enabled="False"></asp:TextBox></td>
          </tr>
        <tr><td>Make</td><td> <asp:TextBox ID="txtMake" runat="server" Width="212px" Enabled="False"></asp:TextBox></td><td>Model</td><td> <asp:TextBox ID="txtModel" runat="server" Width="212px" Enabled="False"></asp:TextBox></td></tr>
<tr><td></td></tr>
<tr><td><b>User Details</b></td></tr>
         <tr>
             <td>Firstname</td><td> <asp:TextBox ID="txtSearhFirstName" runat="server" Width="212px"></asp:TextBox></td><td>Surname</td><td> <asp:TextBox ID="txtSearchSurname" runat="server" Width="212px"></asp:TextBox></td>
             <td>
                 <asp:Button ID="cmdFind" runat="server" Text="Find" Width="105px" />
             </td>
         </tr>
        <tr><td>&nbsp</td></tr>
       <tr><td>Select by Nat. ID No</td><td> 
                                         <telerik:RadComboBox ID="cboNationalIDNos" runat="server" Width="222px" AutoPostBack="True"></telerik:RadComboBox>
                                         </td> 
            <td>&nbsp;Select by License #</td><td>
                                         <telerik:RadComboBox ID="cboLicense" runat="server" Width="222px" AutoPostBack="True"></telerik:RadComboBox>
                                         </td>

        </tr>
        <tr><td>First Name</td><td> <asp:TextBox ID="txtFirstName" runat="server" Width="208px" Enabled="False"></asp:TextBox></td>
            <td>Surname</td><td> <asp:TextBox ID="txtSurname" runat="server" Width="212px" Enabled="False"></asp:TextBox></td>
        </tr>
        <tr><td>Department</td><td> <asp:TextBox ID="txtDept" runat="server" Width="207px" Enabled="False"></asp:TextBox></td>
            <td>Designation</td><td> <asp:TextBox ID="txtDesignation" runat="server" Width="212px" Enabled="False"></asp:TextBox></td></tr>
        <tr><td colspan="5"><hr /></td></tr>
                                           
        <tr><td><b>Accident Details</b></td><td> 
                                         &nbsp;</td> 
            <td>&nbsp;</td><td>
                                         &nbsp;</td>

        </tr>
        <tr><td>Date</td>
            <td>
                <telerik:RadDatePicker ID="rdInspectionDate" runat="server" Culture="en-US" MinDate="1900-01-01"></telerik:RadDatePicker>
            </td>
            <td>Time</td><td> <asp:TextBox ID="txtAccidentTime" runat="server" Width="153px"></asp:TextBox></td>
        </tr>
        <tr><td>Location</td><td> <asp:TextBox ID="txtLocation" runat="server" Width="210px"></asp:TextBox></td>
            
        </tr>
        <tr><td>Details</td><td colspan="3"> <asp:TextBox ID="txtAccidentDetails" runat="server" Width="555px" Height="58px" TextMode="MultiLine"></asp:TextBox></td>
            
        </tr>
        
        <tr><td colspan="5"><hr /></td></tr>
        <tr><td></td><td colspan="4" style="text-align:center">
                 <asp:Button ID="cmdSave" runat="server" Text="Save Accident Details" Width="160px" />&nbsp;&nbsp
                 <asp:Button ID="cmdDelete" runat="server" Text="Delete" Width="160px" />&nbsp;&nbsp
                 <asp:Button ID="cmdClear" runat="server" Text="Clear" Width="160px" />
             </td></tr>
         <tr><td></td><td>
         </td></tr>
        <tr><td colspan="4"><h3 style="font-size:medium; color:gray "> Accident Files&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </h3></td><td>
                 &nbsp;</td></tr>
        <tr>
            <td style="vertical-align:top">
                 <asp:Button ID="cmdAddNewFile" runat="server" Text="Add New File" Width="160px" />
             </td>
            <td colspan="4">

                <telerik:RadGrid ID="radFileListing" runat="server" CellPadding="0" Height="100%" Width="100%" AutoGenerateColumns="False" GroupPanelPosition="Top">
                    <MasterTableView AllowFilteringByColumn="True" AllowMultiColumnSorting="true" AllowPaging="True" AllowSorting="true" PagerStyle-Mode="NextPrevNumericAndAdvanced">
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
                            <telerik:GridBoundColumn DataField="Description" HeaderText="Description" UniqueName="Description">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="DateUploaded" HeaderText="DateUploaded" UniqueName="DateUploaded">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="FileDate" HeaderText="FileDate" UniqueName="FileDate" FilterControlAltText="Filter FileDate column">
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
        <tr>
            <td>&nbsp;</td><td colspan="3">
                                         <telerik:RadComboBox ID="cboRegNumber" runat="server" Width="219px" AutoPostBack="True" Visible="False"></telerik:RadComboBox>
                                         <asp:TextBox ID="txtAccidentId" runat="server" Width="211px" Visible="False"></asp:TextBox>
                                         </td>
        </tr>
       </table>
   
    <hr />

  

       
    
</asp:Content>


   
      

