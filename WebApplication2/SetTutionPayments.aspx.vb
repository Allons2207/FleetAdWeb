Imports ClassLibrary1
Imports Telerik.Web.UI
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing

Public Class SetTutionPayments
    Inherits System.Web.UI.Page
    Dim objSetTutionFee As New SetTuitionPaymentsSchedule(CokkiesWrapper.thisConnectionName)
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = objSetTutionFee.Database
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
            With objSetTutionFee
                .ConnectionString = con
                .amountPerExtraSubject = txtAmountPerXSub.Text
                .amountPerMonth = txtAmountPM.Text
                .computersFee = txtComputerFee.Text
                .streamId = RadComboBoxStream.SelectedValue

                .Insert()
            End With

            lblMsg.BackColor = Color.Green
            lblMsg.ForeColor = Color.White
            lblMsg.Text = "Tuition Fee was set successfully!!!"

        Catch ex As Exception

            lblMsg.BackColor = Color.Red
            lblMsg.ForeColor = Color.White
            lblMsg.Text = "Tuition Fee was not set successfully, Please contact system administrator!!!"

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

    Private Sub gwTuitionPaymentsSchedule_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles gwTuitionPaymentsSchedule.ItemCommand

        If e.CommandName = "View" Then

            Dim item As GridDataItem = e.Item
            Dim tuitionPaymentId As String = item("tuitionPaymentId").Text

            txtAmountPM.Text = item("amountPerMonth").Text
            RadComboBoxStream.SelectedValue = item("TuitionPaymentId").Text
            RadComboBoxStream.Text = item("stream").Text
            txtAmountPerXSub.Text = item("amountPerExtraSubject").Text
            ' txtComputerFee.Text = item("computersFee").Text

        End If
    End Sub

    Private Sub gwTuitionPaymentsSchedule_Load(sender As Object, e As EventArgs) Handles gwTuitionPaymentsSchedule.Load
        Dim ds As DataSet = objSetTutionFee.SelectRecords()

        With gwTuitionPaymentsSchedule

            Try
                .DataSource = ds
                .DataBind()

            Catch ex As Exception


            End Try

        End With
    End Sub



End Class