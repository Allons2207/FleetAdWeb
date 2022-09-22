<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="FarmerDetails.aspx.vb" Inherits="WebApplication2.FarmerDetails" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
.RadComboBox_Default{color:#333;font-size:12px;font-family:"Segoe UI",Arial,Helvetica,sans-serif}.RadComboBox{text-align:left;display:inline-block;vertical-align:middle;white-space:nowrap;*display:inline;*zoom:1}.RadComboBox_Default{color:#333;font-size:12px;font-family:"Segoe UI",Arial,Helvetica,sans-serif}.RadComboBox{text-align:left;display:inline-block;vertical-align:middle;white-space:nowrap;*display:inline;*zoom:1}.RadComboBox_Default{color:#333;font-size:12px;font-family:"Segoe UI",Arial,Helvetica,sans-serif}.RadComboBox{text-align:left;display:inline-block;vertical-align:middle;white-space:nowrap;*display:inline;*zoom:1}.RadComboBox_Default{color:#333;font-size:12px;font-family:"Segoe UI",Arial,Helvetica,sans-serif}.RadComboBox{text-align:left;display:inline-block;vertical-align:middle;white-space:nowrap;*display:inline;*zoom:1}.RadComboBox_Default{color:#333;font-size:12px;font-family:"Segoe UI",Arial,Helvetica,sans-serif}.RadComboBox{text-align:left;display:inline-block;vertical-align:middle;white-space:nowrap;*display:inline;*zoom:1}.RadComboBox .rcbReadOnly .rcbInputCellLeft{background-position:0 -88px}.RadComboBox .rcbReadOnly .rcbInputCellLeft{background-position:0 -88px}.RadComboBox .rcbReadOnly .rcbInputCellLeft{background-position:0 -88px}.RadComboBox .rcbReadOnly .rcbInputCellLeft{background-position:0 -88px}.RadComboBox .rcbReadOnly .rcbInputCellLeft{background-position:0 -88px}.RadComboBox_Default .rcbInputCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbInputCellLeft{background-position:0 0}.RadComboBox .rcbInputCell{padding-right:4px;padding-left:5px;width:100%;height:20px;line-height:20px;text-align:left;vertical-align:middle}.RadComboBox .rcbInputCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox_Default .rcbInputCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbInputCellLeft{background-position:0 0}.RadComboBox .rcbInputCell{padding-right:4px;padding-left:5px;width:100%;height:20px;line-height:20px;text-align:left;vertical-align:middle}.RadComboBox .rcbInputCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox_Default .rcbInputCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbInputCellLeft{background-position:0 0}.RadComboBox .rcbInputCell{padding-right:4px;padding-left:5px;width:100%;height:20px;line-height:20px;text-align:left;vertical-align:middle}.RadComboBox .rcbInputCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox_Default .rcbInputCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbInputCellLeft{background-position:0 0}.RadComboBox .rcbInputCell{padding-right:4px;padding-left:5px;width:100%;height:20px;line-height:20px;text-align:left;vertical-align:middle}.RadComboBox .rcbInputCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox_Default .rcbInputCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbInputCellLeft{background-position:0 0}.RadComboBox .rcbInputCell{padding-right:4px;padding-left:5px;width:100%;height:20px;line-height:20px;text-align:left;vertical-align:middle}.RadComboBox .rcbInputCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox .rcbReadOnly .rcbArrowCellRight{background-position:-162px -176px}.RadComboBox .rcbReadOnly .rcbArrowCellRight{background-position:-162px -176px}.RadComboBox .rcbReadOnly .rcbArrowCellRight{background-position:-162px -176px}.RadComboBox .rcbReadOnly .rcbArrowCellRight{background-position:-162px -176px}.RadComboBox .rcbReadOnly .rcbArrowCellRight{background-position:-162px -176px}.RadComboBox_Default .rcbArrowCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbArrowCellRight{background-position:-18px -176px}.RadComboBox .rcbArrowCell{width:18px}.RadComboBox .rcbArrowCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox_Default .rcbArrowCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbArrowCellRight{background-position:-18px -176px}.RadComboBox .rcbArrowCell{width:18px}.RadComboBox .rcbArrowCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox_Default .rcbArrowCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbArrowCellRight{background-position:-18px -176px}.RadComboBox .rcbArrowCell{width:18px}.RadComboBox .rcbArrowCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox_Default .rcbArrowCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbArrowCellRight{background-position:-18px -176px}.RadComboBox .rcbArrowCell{width:18px}.RadComboBox .rcbArrowCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox_Default .rcbArrowCell{background-image:url('mvwres://Telerik.Web.UI, Version=2015.1.225.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbArrowCellRight{background-position:-18px -176px}.RadComboBox .rcbArrowCell{width:18px}.RadComboBox .rcbArrowCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}
        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>Farmer Details</h3>
    <table>
         <tr><td>District</td><td>
               
                <telerik:RadComboBox ID="drpdwnBStatus0" runat="server" ></telerik:RadComboBox>
                                    </td>
            <td>&nbsp;</td><td>
               
                &nbsp;</td>
        </tr>
        <tr><td>First Name</td><td>
                                <asp:TextBox ID="txtExpected" runat="server"></asp:TextBox>
                            </td>
            <td>Surname</td><td>
                                <asp:TextBox ID="txtExpected0" runat="server"></asp:TextBox>
                            </td>
        </tr>
        <tr><td>National ID #</td><td>
                                <asp:TextBox ID="txtExpected1" runat="server"></asp:TextBox>
                            </td>
            <td>Sex</td><td>
               
                <telerik:RadComboBox ID="drpdwnBStatus1" runat="server" ></telerik:RadComboBox>
                                    </td>
        </tr>
        <tr><td>DOB</td><td>                   
                               
                                
                                <telerik:RadDatePicker ID="rdDtDate" Runat="server">
                                </telerik:RadDatePicker>
                                
                               
                                
                             </td>
            <td>Ethnicity</td><td>
               
                <telerik:RadComboBox ID="drpdwnBStatus2" runat="server" Enabled="False"></telerik:RadComboBox>
                                    </td>
        </tr>
        <tr><td>Farm Number</td><td>
                                <asp:TextBox ID="txtExpected2" runat="server"></asp:TextBox>
                            </td>
            <td>Farm Address</td><td>
                                <asp:TextBox ID="txtExpected4" runat="server" Height="71px" TextMode="MultiLine" Width="232px"></asp:TextBox>
                            </td>
        </tr>
        <tr><td>Farm Size (ha)</td><td>
                                <asp:TextBox ID="txtExpected3" runat="server"></asp:TextBox>
                            </td>
            <td>Soil Type</td><td>
               
                <telerik:RadComboBox ID="drpdwnBStatus3" runat="server" Enabled="False"></telerik:RadComboBox>
                                    </td>
        </tr>
        <tr>
         <td>Has access to which water-body?</td><td>
               
                <telerik:RadComboBox ID="RadComboBox2" runat="server"></telerik:RadComboBox>
                                    </td>
        </tr>
        <tr>
        <td>Irrigation Type</td><td>
               
                <telerik:RadComboBox ID="RadComboBox1" runat="server"></telerik:RadComboBox>
                                    </td>
        </tr>
        <tr><td>Crops Grown</td><td colspan="3">
                    <telerik:RadGrid ID="gwBillPayments" runat="server"  BackColor="#DEBA84"  AllowPaging="True"  DisplayMode="FirstLastPreviousNextNumeric, Text" PageSize="50"
         BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" AllowSorting="True" GroupPanelPosition="Top"  ForeColor="Black" AutoGenerateColumns="False" >
              
                        <ClientSettings>
                        <Scrolling AllowScroll="True"  />
                    </ClientSettings>
                   
                        <MasterTableView>
                            <Columns>
                                <telerik:GridBoundColumn FilterControlAltText="Filter column column" HeaderText="Season" UniqueName="column">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn FilterControlAltText="Filter column1 column" HeaderText="Crop" UniqueName="column1">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn FilterControlAltText="Filter column2 column" HeaderText="Acreage (ha)" UniqueName="column2">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn FilterControlAltText="Filter column3 column" HeaderText="Harvest (tons)" UniqueName="column3">
                                </telerik:GridBoundColumn>
                            </Columns>
                        </MasterTableView>
                   
     </telerik:RadGrid> 
            </td>
        </tr>
        <tr><td>&nbsp</td></tr>
         <tr><td>Qualifications and Experience</td><td colspan="3">
                    <telerik:RadGrid ID="RadGrid1" runat="server"  BackColor="#DEBA84"  AllowPaging="True"  DisplayMode="FirstLastPreviousNextNumeric, Text" PageSize="50"
         BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" AllowSorting="True" GroupPanelPosition="Top"  ForeColor="Black" AutoGenerateColumns="False" >
              
                        <ClientSettings>
                        <Scrolling AllowScroll="True"  />
                    </ClientSettings>
                   
                        <MasterTableView>
                            <Columns>
                                <telerik:GridBoundColumn FilterControlAltText="Filter column column" HeaderText="Qualification" UniqueName="column">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn FilterControlAltText="Filter column3 column" HeaderText="Level" UniqueName="column3">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn FilterControlAltText="Filter column1 column" HeaderText="Year Attainned" UniqueName="column1">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn FilterControlAltText="Filter column2 column" HeaderText="Institution" UniqueName="column2">
                                </telerik:GridBoundColumn>
                            </Columns>
                        </MasterTableView>
                   
     </telerik:RadGrid> 
            </td>
       
        </tr>
        <tr><td>&nbsp</td></tr>
        <tr><td>Farming Inputs Provided</td><td colspan="3">
                    <telerik:RadGrid ID="RadGrid2" runat="server"  BackColor="#DEBA84"  AllowPaging="True"  DisplayMode="FirstLastPreviousNextNumeric, Text" PageSize="50"
         BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" AllowSorting="True" GroupPanelPosition="Top"  ForeColor="Black" AutoGenerateColumns="False" >
              
                        <ClientSettings>
                        <Scrolling AllowScroll="True"  />
                    </ClientSettings>
                   
                        <MasterTableView>
                            <Columns>
                                <telerik:GridBoundColumn FilterControlAltText="Filter column column" HeaderText="Season" UniqueName="column">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn FilterControlAltText="Filter column column" HeaderText="Creditor" UniqueName="column4">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn FilterControlAltText="Filter column1 column" HeaderText="Type of Input" UniqueName="column1">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn FilterControlAltText="Filter column2 column" HeaderText="Unit" UniqueName="column2">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn FilterControlAltText="Filter column3 column" HeaderText="Quantity Received" UniqueName="column3">
                                </telerik:GridBoundColumn>
                            </Columns>
                        </MasterTableView>
                   
     </telerik:RadGrid> 
            </td>
        </tr>
    </table>
</asp:Content>
