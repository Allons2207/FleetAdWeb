
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data

Public Class StudentsPortalPaymentsHistory
    Inherits System.Web.UI.Page

    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub radComboPaymentsHistory_SelectedIndexChanged(sender As Object, e As Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs) Handles radComboPaymentsHistory.SelectedIndexChanged
        Dim sql As String

        Try

            If radComboPaymentsHistory.SelectedValue = 1 Then

                sql = "select studentId, strMonth Month, intYear Year, round(expectedAmt,2) [Amount Billed],round(amountPaid,2) [Amount Paid], Date [Payment Date]  from tbl_tuitionPayments where studentId = '" & CokkiesWrapper.StudentID & " '"

            ElseIf radComboPaymentsHistory.SelectedValue = 2 Then

                sql = "select studentd, strTerm Term, intYear Year, expectedAmt [Amount Billed],amountPaid [Amount Paid]  from tbl_LevyPayments where studentd = '" & CokkiesWrapper.StudentID & " '"

            ElseIf radComboPaymentsHistory.SelectedValue = 3 Then

                sql = "select studentId, mMonth Month, yYear Year, setAmount [Amount Billed],amountPaid [Amount Paid] from tbl_transportPayments where studentId = '" & CokkiesWrapper.StudentID & " '"

            ElseIf radComboPaymentsHistory.SelectedValue = 4 Then

                sql = "select studentId, intYear Year, Regdate [Registration Date], expectedAmt [Amount Billed],amountPaid [Amount Paid], regDate [Payment Date]  from tbl_registrationPayments where studentId = '" & CokkiesWrapper.StudentID & " '"

            ElseIf radComboPaymentsHistory.SelectedValue = 5 Then

                sql = "select studentId, dtDate [Sale Date], uniformItem, unitPrice, quantity, totalPrice  from tbl_uniformSales where studentId = '" & CokkiesWrapper.StudentID & " '"

            End If

            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            db.ExecuteDataSet(CommandType.Text, sql)

            With gwStudentPaymentHistory

                .DataSource = ds
                .DataBind()

            End With


        Catch ex As Exception
            ' log.Error(ex)

        End Try

    End Sub
End Class