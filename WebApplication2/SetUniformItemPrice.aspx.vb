Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing
Imports Telerik.Web.UI

Public Class SetUniformItemPrice
    Inherits System.Web.UI.Page
    Dim objItems As New UniformItems(CokkiesWrapper.thisConnectionName)
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)

    Dim ds As DataSet = objItems.SelectRecords()
    Dim db As Database = objItems.Database
    Dim con As String = db.ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (CokkiesWrapper.UserID <= 0 AndAlso Not IsNumeric(CokkiesWrapper.UserID)) Then
            Response.Redirect("../Login.aspx")
        End If


        obj.ConnectionString = con
        Dim accessMode As String = obj.groupAccessPermissionsDs(CokkiesWrapper.UserGroup, 4)

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

    End Sub

    Private Sub cmdSave_Click(sender As Object, e As EventArgs) Handles cmdSave.Click
        Try
            With objItems

                .ConnectionString = con
                .uniformItem = txtUniformItem.Text
                .price = txtItemPrice.Text

                .Insert()

            End With


            lblMsg.BackColor = Color.Green
            lblMsg.ForeColor = Color.White
            lblMsg.Text = "Uniform item price was set successfully!!!"

        Catch ex As Exception

            lblMsg.BackColor = Color.Red
            lblMsg.ForeColor = Color.White
            lblMsg.Text = "Uniform item price was not set successfully, Please contact system administrator!!!"

        End Try
    End Sub

    Private Sub gwUniformItemsSchedule_Load(sender As Object, e As EventArgs) Handles gwUniformItemsSchedule.Load

        Dim ds As DataSet = objItems.SelectRecords()

        With gwUniformItemsSchedule

            Try
                .DataSource = ds
                .DataBind()

            Catch ex As Exception


            End Try

        End With

    End Sub

    Private Sub gwTuitionPaymentsSchedule_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles gwUniformItemsSchedule.ItemCommand

        If e.CommandName = "View" Then

            Dim item As GridDataItem = e.Item
            'Dim PaymentId As String = item("tuitionPaymentId").Text

            txtUniformItem.Text = item("uniformItem").Text
            txtItemPrice.Text = item("price").Text
            'txtItemCode.Text = item("itemCode").Text

        End If
    End Sub
End Class