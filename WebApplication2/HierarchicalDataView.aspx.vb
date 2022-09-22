Imports System
Imports Telerik.Web.UI

Public Class HierarchicalDataView
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            'Setting Selected index prior to binding RadGrid:
            'If the index is in detail table, parent items will be expanded
            'automatically 
            RadGrid1.SelectedIndexes.Add(1, 0, 1, 0, 1)

            'Index of 1, 0, 1, 0, 0 means:
            '1 - item with index 1 in MasterTabelView
            '0 - detail table with index 0
            '1 - second (index 1) item in the detail table
            '0 - 0 sub-detail
            '1 - sub detail item with index 1
        End If
        ''<!--%@ Page Language="vb" AutoEventWireup="false" Inherits="Telerik.GridExamplesVBNET.DataEditing.ThreeLevel.DefaultVB"CodeFile="DefaultVB.aspx.vb"  %-->


    End Sub

    Protected Sub RadGrid1_ItemUpdated(ByVal source As Object, ByVal e As Telerik.Web.UI.GridUpdatedEventArgs) Handles RadGrid1.ItemUpdated
        Dim item As String = getItemName(e.Item.OwnerTableView.Name)
        Dim field As String = getFieldName(e.Item.OwnerTableView.Name)
        If Not e.Exception Is Nothing Then
            e.KeepInEditMode = True
            e.ExceptionHandled = True
            DisplayMessage(item + " " + e.Item(field).Text + " cannot be updated. Reason: " + e.Exception.Message)
        Else
            DisplayMessage(item + " " + e.Item(field).Text + " updated")
        End If
    End Sub

    Protected Sub RadGrid1_ItemInserted(ByVal source As Object, ByVal e As GridInsertedEventArgs) Handles RadGrid1.ItemInserted
        Dim item As String = getItemName(e.Item.OwnerTableView.Name)
        If Not e.Exception Is Nothing Then
            e.ExceptionHandled = True
            DisplayMessage(item + " cannot be inserted. Reason: " + e.Exception.Message)
        Else
            DisplayMessage(item + " inserted")
        End If
    End Sub

    Protected Sub RadGrid1_ItemDeleted(ByVal source As Object, ByVal e As GridDeletedEventArgs) Handles RadGrid1.ItemDeleted
        Dim item As String = getItemName(e.Item.OwnerTableView.Name)
        Dim field As String = getFieldName(e.Item.OwnerTableView.Name)
        If Not e.Exception Is Nothing Then
            e.ExceptionHandled = True
            DisplayMessage(item + " " + e.Item(field).Text + " cannot be deleted. Reason: " + e.Exception.Message)
        Else
            DisplayMessage(item + " " + e.Item(field).Text + " deleted")
        End If
    End Sub

    Protected Sub RadGrid1_InsertCommand(ByVal source As Object, ByVal e As GridCommandEventArgs) Handles RadGrid1.InsertCommand
        Select Case e.Item.OwnerTableView.Name
            Case "Orders"
                Dim parentItem As GridDataItem = DirectCast(e.Item.OwnerTableView.ParentItem, GridDataItem)
                SqlDataSource2.InsertParameters("CustomerID").DefaultValue = parentItem.OwnerTableView.DataKeyValues(parentItem.ItemIndex)("CustomerID").ToString()
            Case "Details"
                Dim parentItem As GridDataItem = DirectCast(e.Item.OwnerTableView.ParentItem, GridDataItem)
                SqlDataSource3.InsertParameters("OrderID").DefaultValue = parentItem.OwnerTableView.DataKeyValues(parentItem.ItemIndex)("OrderID").ToString()
        End Select
    End Sub

    Protected Sub RadGrid1_ItemCreated(sender As Object, e As GridItemEventArgs) Handles RadGrid1.ItemCreated
        If TypeOf (e.Item) Is GridEditFormItem And e.Item.IsInEditMode = True AndAlso Not (TypeOf (e.Item) Is IGridInsertItem) Then
            Dim item As GridEditFormItem = CType(e.Item, GridEditFormItem)
            Select Case item.OwnerTableView.Name
                Case "Customers"
                    Dim customerIDBox As TextBox = CType(item("CustomerID").Controls(0), TextBox)
                    customerIDBox.Enabled = False
                Case "Details"
                    Dim productIDBox As TextBox = CType(item("ProductID").Controls(0), TextBox)
                    productIDBox.Enabled = False
                Case Else
            End Select
        End If
    End Sub

    Private Function getItemName(ByVal tableName As String) As String
        Select Case tableName
            Case ("Customers")
                Return "Customer"
            Case ("Orders")
                Return "Order"
            Case ("Details")
                Return "Details for order"
            Case Else
                Return ""
        End Select
    End Function

    Private Function getFieldName(ByVal tableName As String) As String
        Select Case tableName
            Case ("Customers")
                Return "CustomerID"
            Case ("Orders")
                Return "OrderID"
            Case ("Details")
                Return "OrderID"
            Case Else
                Return ""
        End Select
    End Function

    Private Sub DisplayMessage(ByVal text As String)
        RadGrid1.Controls.Add(New LiteralControl(String.Format("<span style='color:red'>{0}</span>", text)))
    End Sub
End Class
