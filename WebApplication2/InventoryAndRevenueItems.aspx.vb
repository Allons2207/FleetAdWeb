Imports Telerik.Web.UI
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing

Public Class InventoryAndRevenueItems
    Inherits System.Web.UI.Page
    Private Shared ReadOnly log As log4net.ILog = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType)
    Dim insRec As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = insRec.Database
    Dim con As String = db.ConnectionString
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (CokkiesWrapper.UserID <= 0 AndAlso Not IsNumeric(CokkiesWrapper.UserID)) Then
            Response.Redirect("../Login.aspx")
            Exit Sub
        End If

        obj.ConnectionString = con
        Dim accessMode As String = obj.groupAccessPermissionsDs(CokkiesWrapper.UserGroup, 8)

        Select Case accessMode
            Case "AllowReadNRead"
            Case "ReadNReadOnly"
                cmdSave.Enabled = False
            Case "DenyAcces"
                Response.Redirect("~/AccessDenied.aspx")
                Exit Sub
            Case Else
                Response.Redirect("~/AccessDenied.aspx")
                Exit Sub
        End Select

        loadInventoryRevenueItems()

    End Sub

    Private Sub loadInventoryRevenueItems()

        Dim qry As String = "SELECT [itemTypeId], [itemType] FROM [dbo].[tbl_revenueItemTypes]"

        insRec.ConnectionString = con

        Dim ds As DataSet = insRec.ExecuteDsQRY(qry)
        With lbItems
            .DataValueField = "itemTypeId"
            .DataTextField = "itemType"
            .DataSource = ds
            .DataBind()
        End With

    End Sub

    Protected Sub cmdSave_Click(sender As Object, e As EventArgs) Handles cmdSave.Click
        Dim qry As String = "INSERT INTO [tbl_revenueItemTypes] ([itemType]) VALUES ('" & txtItemName.Text & "')"

        insRec.ConnectionString = con

        If Not insRec.ExecuteNonQRY(qry) = 1 Then
            lblMsg.Text = "Revenue/Inventory Item entry has been saved successfully."
            loadInventoryRevenueItems()
        Else
            lblMsg.Text = "Revenue/Inventory Item entry has not been saved successfully."
        End If
    End Sub

End Class