<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SchoolAppMaster.Master" CodeBehind="HierarchicalDataView.aspx.vb" Inherits="WebApplication2.HierarchicalDataView" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <telerik:RadSkinManager ID="RadSkinManager1" runat="server" ShowChooser="true" />
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadFormDecorator RenderMode="Lightweight" ID="RadFormDecorator1" runat="server" DecorationZoneID="demo" DecoratedControls="All" EnableRoundedCorners="false" />
    <div id="demo" class="demo-container no-bg">
        <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid1" DataSourceID="SqlDataSource1" runat="server" ShowStatusBar="True"
            AutoGenerateColumns="False" PageSize="3" AllowSorting="True"
            AllowPaging="True" AllowAutomaticDeletes="True" AllowAutomaticInserts="True"
            AllowAutomaticUpdates="True" OnItemUpdated="RadGrid1_ItemUpdated" OnItemDeleted="RadGrid1_ItemDeleted"
            OnItemInserted="RadGrid1_ItemInserted" OnInsertCommand="RadGrid1_InsertCommand"
            OnItemCreated="RadGrid1_ItemCreated" GroupPanelPosition="Top">
            <PagerStyle Mode="NumericPages"></PagerStyle>
            <MasterTableView DataSourceID="SqlDataSource1" DataKeyNames="CustomerID" AllowMultiColumnSorting="True"
                Width="100%" CommandItemDisplay="Top" Name="Customers">
                <DetailTables>
                    <telerik:GridTableView DataKeyNames="OrderID" DataSourceID="SqlDataSource2" Width="100%"
                        runat="server" CommandItemDisplay="Top" Name="Orders">
                        <ParentTableRelation>
                            <telerik:GridRelationFields DetailKeyField="CustomerID" MasterKeyField="CustomerID"></telerik:GridRelationFields>
                        </ParentTableRelation>
                        <DetailTables>
                            <telerik:GridTableView DataKeyNames="OrderID,ProductID" DataSourceID="SqlDataSource3"
                                Width="100%" runat="server" CommandItemDisplay="Top" Name="Details">
                                <ParentTableRelation>
                                    <telerik:GridRelationFields DetailKeyField="OrderID" MasterKeyField="OrderID"></telerik:GridRelationFields>
                                </ParentTableRelation>
                                <Columns>
                                    <telerik:GridEditCommandColumn UniqueName="EditCommandColumn1">
                                        <HeaderStyle Width="20px"></HeaderStyle>
                                        <ItemStyle CssClass="MyImageButton"></ItemStyle>
                                    </telerik:GridEditCommandColumn>
                                    <telerik:GridBoundColumn SortExpression="OrderID" HeaderText="OrderID" HeaderButtonType="TextButton"
                                        DataField="OrderID" UniqueName="OrderID" ReadOnly="true" Visible="false">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn SortExpression="ProductID" HeaderText="ProductID" HeaderButtonType="TextButton"
                                        DataField="ProductID" UniqueName="ProductID">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn SortExpression="UnitPrice" HeaderText="Unit Price" HeaderButtonType="TextButton"
                                        DataField="UnitPrice" UniqueName="UnitPrice">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn SortExpression="Quantity" HeaderText="Quantity" HeaderButtonType="TextButton"
                                        DataField="Quantity" UniqueName="Quantity">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn SortExpression="Discount" HeaderText="Discount" HeaderButtonType="TextButton"
                                        DataField="Discount" UniqueName="Discount">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridButtonColumn ConfirmText="Delete this product?" 
                                        CommandName="Delete" Text="Delete" UniqueName="DeleteColumn1">
                                        <HeaderStyle Width="20px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Center" CssClass="MyImageButton"></ItemStyle>
                                    </telerik:GridButtonColumn>
                                </Columns>
                                <SortExpressions>
                                    <telerik:GridSortExpression FieldName="Quantity" SortOrder="Descending"></telerik:GridSortExpression>
                                </SortExpressions>
                            </telerik:GridTableView>
                        </DetailTables>
                        <Columns>
                            <telerik:GridEditCommandColumn UniqueName="EditCommandColumn2">
                                <HeaderStyle Width="20px"></HeaderStyle>
                                <ItemStyle CssClass="MyImageButton"></ItemStyle>
                            </telerik:GridEditCommandColumn>
                            <telerik:GridBoundColumn SortExpression="OrderID" HeaderText="OrderID" HeaderButtonType="TextButton"
                                DataField="OrderID" UniqueName="OrderID" ReadOnly="true">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn SortExpression="OrderDate" HeaderText="Date Ordered" HeaderButtonType="TextButton"
                                DataField="OrderDate" UniqueName="OrderDate">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn SortExpression="RequiredDate" HeaderText="RequiredDate"
                                HeaderButtonType="TextButton" DataField="RequiredDate" UniqueName="RequiredDate">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn SortExpression="EmployeeID" HeaderText="EmployeeID" HeaderButtonType="TextButton"
                                DataField="EmployeeID" UniqueName="EmployeeID">
                            </telerik:GridBoundColumn>
                            <telerik:GridButtonColumn ConfirmText="Delete these details record?"
                                CommandName="Delete" Text="Delete" UniqueName="DeleteColumn2">
                                <HeaderStyle Width="20px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Center" CssClass="MyImageButton"></ItemStyle>
                            </telerik:GridButtonColumn>
                        </Columns>
                        <SortExpressions>
                            <telerik:GridSortExpression FieldName="OrderDate"></telerik:GridSortExpression>
                        </SortExpressions>
                    </telerik:GridTableView>
                </DetailTables>
                <Columns>
                    <telerik:GridEditCommandColumn UniqueName="EditCommandColumn">
                        <HeaderStyle Width="20px"></HeaderStyle>
                        <ItemStyle CssClass="MyImageButton"></ItemStyle>
                    </telerik:GridEditCommandColumn>
                    <telerik:GridBoundColumn SortExpression="CustomerID" HeaderText="CustomerID" HeaderButtonType="TextButton"
                        DataField="CustomerID" UniqueName="CustomerID" MaxLength="5">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn SortExpression="ContactName" HeaderText="Contact Name" HeaderButtonType="TextButton"
                        DataField="ContactName" UniqueName="ContactName">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn SortExpression="CompanyName" HeaderText="Company" HeaderButtonType="TextButton"
                        DataField="CompanyName" UniqueName="CompanyName">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn SortExpression="Address" HeaderText="Address" HeaderButtonType="TextButton"
                        DataField="Address" UniqueName="Address">
                    </telerik:GridBoundColumn>
                    <telerik:GridButtonColumn ConfirmText="Delete this customer?" 
                        CommandName="Delete" Text="Delete" UniqueName="DeleteColumn">
                        <HeaderStyle Width="20px"></HeaderStyle>
                        <ItemStyle HorizontalAlign="Center" CssClass="MyImageButton"></ItemStyle>
                    </telerik:GridButtonColumn>
                </Columns>
                <SortExpressions>
                    <telerik:GridSortExpression FieldName="CompanyName"></telerik:GridSortExpression>
                </SortExpressions>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server"
        ConnectionString="<%$ ConnectionStrings:NorthwindConnectionString35 %>"
        DeleteCommand="DELETE FROM [Customers] WHERE [CustomerID] = @CustomerID"
        InsertCommand="INSERT INTO [Customers] ([CustomerID], [CompanyName], [ContactName], [Address]) VALUES (@CustomerID, @CompanyName, @ContactName, @Address)"
        SelectCommand="SELECT * FROM [Customers]"
        UpdateCommand="UPDATE [Customers] SET [CompanyName] = @CompanyName, [ContactName] = @ContactName, [Address] = @Address WHERE [CustomerID] = @CustomerID">
        <DeleteParameters>
            <asp:Parameter Name="CustomerID" Type="String"></asp:Parameter>
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="CustomerID" Type="String"></asp:Parameter>
            <asp:Parameter Name="CompanyName" Type="String"></asp:Parameter>
            <asp:Parameter Name="ContactName" Type="String"></asp:Parameter>
            <asp:Parameter Name="Address" Type="String"></asp:Parameter>
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="CompanyName" Type="String"></asp:Parameter>
            <asp:Parameter Name="ContactName" Type="String"></asp:Parameter>
            <asp:Parameter Name="Address" Type="String"></asp:Parameter>
            <asp:Parameter Name="CustomerID" Type="String"></asp:Parameter>
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server"
        ConnectionString="<%$ ConnectionStrings:NorthwindConnectionString35 %>"
        DeleteCommand="DELETE FROM [Orders] WHERE [OrderID] = @OrderID"
        InsertCommand="INSERT INTO [Orders] ([CustomerID], [EmployeeID], [OrderDate], [RequiredDate]) VALUES (@CustomerID, @EmployeeID, @OrderDate, @RequiredDate)"
        SelectCommand="SELECT * FROM [Orders] WHERE [CustomerID] = @CustomerID"
        UpdateCommand="UPDATE [Orders] SET [EmployeeID] = @EmployeeID, [OrderDate] = @OrderDate, [RequiredDate] = @RequiredDate WHERE [OrderID] = @OrderID">
        <SelectParameters>
            <asp:Parameter Name="CustomerID" Type="String"></asp:Parameter>
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="OrderID" Type="Int32"></asp:Parameter>
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="CustomerID" Type="String"></asp:Parameter>
            <asp:Parameter Name="EmployeeID" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="OrderDate" Type="DateTime"></asp:Parameter>
            <asp:Parameter Name="RequiredDate" Type="DateTime"></asp:Parameter>
            <asp:Parameter Name="ShippedDate" Type="DateTime"></asp:Parameter>
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="EmployeeID" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="OrderDate" Type="DateTime"></asp:Parameter>
            <asp:Parameter Name="RequiredDate" Type="DateTime"></asp:Parameter>
            <asp:Parameter Name="OrderID" Type="Int32"></asp:Parameter>
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource3" runat="server"
        ConnectionString="<%$ ConnectionStrings:NorthwindConnectionString35 %>"
        DeleteCommand="DELETE FROM [Order Details] WHERE [OrderID] = @OrderID AND [ProductID] = @ProductID"
        InsertCommand="INSERT INTO [Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (@OrderID, @ProductID, @UnitPrice, @Quantity, @Discount)"
        SelectCommand="SELECT * FROM [Order Details] WHERE [OrderID] = @OrderID"
        UpdateCommand="UPDATE [Order Details] SET [UnitPrice] = @UnitPrice, [Quantity] = @Quantity, [Discount] = @Discount WHERE [OrderID] = @OrderID AND [ProductID] = @ProductID">
        <SelectParameters>
            <asp:Parameter Name="OrderID" Type="Int32"></asp:Parameter>
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="OrderID" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="ProductID" Type="Int32"></asp:Parameter>
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="OrderID" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="ProductID" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="UnitPrice" Type="Decimal"></asp:Parameter>
            <asp:Parameter Name="Quantity" Type="Int16"></asp:Parameter>
            <asp:Parameter Name="Discount" Type="Single"></asp:Parameter>
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="UnitPrice" Type="Decimal"></asp:Parameter>
            <asp:Parameter Name="Quantity" Type="Int16"></asp:Parameter>
            <asp:Parameter Name="Discount" Type="Single"></asp:Parameter>
            <asp:Parameter Name="OrderID" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="ProductID" Type="Int32"></asp:Parameter>
        </UpdateParameters>
    </asp:SqlDataSource>
    <br />



</asp:Content>
