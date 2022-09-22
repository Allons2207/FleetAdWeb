Imports ClassLibrary1
Imports Telerik.Web.UI
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing

Public Class SetLevyPayments
    Inherits System.Web.UI.Page
    Dim objSetLevyFee As New SetLevyPaymentsSchedule(CokkiesWrapper.thisConnectionName)
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)

    Dim db As Database = objSetLevyFee.Database
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
            With objSetLevyFee
                .ConnectionString = con
                .amountPerTerm = txtAmount.Text
                .streamId = RadComboBoxStream.SelectedValue

                .Insert()
            End With

            lblMsg.BackColor = Color.Green
            lblMsg.ForeColor = Color.White
            lblMsg.Text = "Levy was set successfully!!!"

        Catch ex As Exception

            lblMsg.BackColor = Color.Red
            lblMsg.ForeColor = Color.White
            lblMsg.Text = "Levy was not set successfully, Please contact system administrator!!!"

        End Try


    End Sub

    Private Sub RadComboBoxStream_Load(sender As Object, e As EventArgs) Handles RadComboBoxStream.Load
        If Not IsPostBack Then
            Dim objStream As New Streams(CokkiesWrapper.thisConnectionName)
            Dim ds As DataSet = objStream.SelectRecords()

            With RadComboBoxStream

                .DataSource = ds
                .DataTextField = "stream"
                .DataValueField = "streamid"
                .DataBind()

                .Items.Insert(0, New RadComboBoxItem("", "0"))

            End With
        End If
    End Sub

    Private Sub gwLevyPaymentsSchedule_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles gwLevyPaymentsSchedule.ItemCommand

        If e.CommandName = "View" Then

            Dim item As GridDataItem = e.Item
            'Dim LevyPaymentId As String = item("LevyPaymentId").Text

            txtAmount.Text = item("amountPerTerm").Text
            RadComboBoxStream.SelectedValue = item("LevyPaymentId").Text
            RadComboBoxStream.Text = item("stream").Text

        End If
    End Sub

    Private Sub gwLevyPaymentsSchedule_Load(sender As Object, e As EventArgs) Handles gwLevyPaymentsSchedule.Load
        Dim ds As DataSet = objSetLevyFee.SelectRecords()

        With gwLevyPaymentsSchedule

            Try
                .DataSource = ds
                .DataBind()

            Catch ex As Exception


            End Try

        End With
    End Sub

End Class