Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports ClassLibrary1
Imports Telerik.Web.UI
Imports System.Drawing

Public Class SetTransportFees
    Inherits System.Web.UI.Page
    Dim objSetTransportFee As New TransportSetAmounts(CokkiesWrapper.thisConnectionName)
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)

    Dim db As Database = objSetTransportFee.Database
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
            With objSetTransportFee
                .ConnectionString = con
                .amount = txtAmount.Text
                .mmonth = txtMonth.Text
                .yYear = txtYear.Text

                .Insert()
            End With

            lblMsg.BackColor = Color.Green
            lblMsg.ForeColor = Color.White
            lblMsg.Text = "Transport Fee was set successfully!!!"

        Catch ex As Exception

            lblMsg.BackColor = Color.Red
            lblMsg.ForeColor = Color.White
            lblMsg.Text = "Transport Fee was not set successfully, Please contact system administrator!!!"

        End Try


    End Sub

    Private Sub gwTransportPaymentsSchedule_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles gwTransportPaymentsSchedule.ItemCommand

        If e.CommandName = "View" Then

            Dim item As GridDataItem = e.Item
            Dim PaymentId As String = item("ctr").Text

            RadComboBoxMonth.Visible = False
            txtMonth.Visible = True

            txtAmount.Text = item("amount").Text
            txtYear.Text = item("yYear").Text
            txtMonth.Text = item("mmonth").Text
            ' RadComboBoxMonth.Text = item("ctr").Text

        End If
    End Sub

    Private Sub gwTransportPaymentsSchedule_Load(sender As Object, e As EventArgs) Handles gwTransportPaymentsSchedule.Load
        Dim ds As DataSet = objSetTransportFee.SelectRecords()

        With gwTransportPaymentsSchedule

            Try
                .DataSource = ds
                .DataBind()

            Catch ex As Exception


            End Try

        End With
    End Sub


End Class