Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing
Imports System
Public Class TransportBilling
    Inherits System.Web.UI.Page
    Dim objStudentTransPayments As New TransportPayments(CokkiesWrapper.thisConnectionName)
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim dsStudents As DataSet
    Dim db As Database = objStudentTransPayments.Database
    Dim con As String = db.ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (CokkiesWrapper.UserID <= 0 AndAlso Not IsNumeric(CokkiesWrapper.UserID)) Then
            Response.Redirect("../Login.aspx")
            Exit Sub
        End If

        obj.ConnectionString = con
        Dim accessMode As String = obj.groupAccessPermissionsDs(CokkiesWrapper.UserGroup, 4)

        Select Case accessMode
            Case "AllowReadNRead"
            Case "ReadNReadOnly"
                cmdBill.Enabled = False
            Case "DenyAcces"
                Response.Redirect("~/AccessDenied.aspx")
                Exit Sub
            Case Else
                Response.Redirect("~/AccessDenied.aspx")
                Exit Sub
        End Select

    End Sub

    Protected Sub cmdBill_Click(sender As Object, e As EventArgs) Handles cmdBill.Click



        If RadComboBoxBillingMonth.Text = "" Then
            Exit Sub
        ElseIf txtYear.Text = "" Then
            Exit Sub
        End If




        With objStudentTransPayments

            .ConnectionString = con
            .mMonth = RadComboBoxBillingMonth.Text
            .yYear = Year(RadDatePickerBillingDate.SelectedDate)
            .amountPaid = 0

            Dim sql As String = " SELECT * from tbl_students WHERE requiresTransportation = '1' AND tbl_students.studentId NOT IN (SELECT [studentId] FROM [tbl_transportPayments] WHERE [yYear] = " & Val(txtYear.Text) & " AND [mMonth] = '" & RadComboBoxBillingMonth.Text.Substring(0, 3) & "')"
            Dim setAmount As Integer = Val(obj.transportFee(RadComboBoxBillingMonth.Text))
            ' Dim x As String = RadComboBoxBillingMonth.Text.Substring(0, 3)
            Try
                dsStudents = db.ExecuteDataSet(CommandType.Text, sql)
                db.ExecuteDataSet(CommandType.Text, sql)

                Dim i As Integer = 0
                For Each row As DataRow In dsStudents.Tables(0).Rows

                    If i < dsStudents.Tables(0).Rows.Count Then

                        .studentId = dsStudents.Tables(0).Rows(i)("studentId")
                        .setAmount = setAmount

                        .Insert()

                        i = i + 1

                    End If

                Next

                lblMsg.BackColor = Color.Green
                lblMsg.ForeColor = Color.White
                lblMsg.Text = "Transport Billing was done successfully!!!"

            Catch ex As Exception

                lblMsg.BackColor = Color.Red
                lblMsg.ForeColor = Color.White
                lblMsg.Text = "Transport Billing was done successfully, Please contact system administrator!!!"

            End Try

        End With

    End Sub

    Protected Sub btnShowBillingGrid_Click(sender As Object, e As EventArgs) Handles btnShowBillingGrid.Click
        With gwBilling
            Try
                Dim sql As String = "SELECT        TOP (100) PERCENT dbo.tbl_streams.stream AS Stream, dbo.tbl_schoolClasses.schoolClass AS Class, " & _
                    " dbo.tbl_students.firstName AS [First Name], dbo.tbl_students.secondName AS [Second Name], " & _
                    "     dbo.tbl_students.surname AS Surname, dbo.tbl_transportPayments.setAmount AS [Set Amount], " & _
                    " dbo.tbl_transportPayments.amountPaid AS [Amount Paid], dbo.tbl_transportPayments.receiptNumber AS [Receipt #] " & _
                    " FROM            dbo.tbl_students INNER JOIN dbo.tbl_schoolClasses ON dbo.tbl_students.schoolClassId = " & _
                    " dbo.tbl_schoolClasses.schoolClassId INNER JOIN dbo.tbl_streams ON dbo.tbl_schoolClasses.streamId = " & _
                    " dbo.tbl_streams.streamId INNER JOIN dbo.tbl_transportPayments ON dbo.tbl_students.studentId = dbo.tbl_transportPayments.studentId " & _
                    " WHERE        (dbo.tbl_transportPayments.yYear = " & txtBillingVWYear.Text & ") AND (dbo.tbl_transportPayments.mMonth = '" & obj.monthNameFromMonthNumber(cboMonths.SelectedValue) & "') " & _
                    " ORDER BY Stream, Class "
                Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
                .DataSource = ds
                .DataBind()
            Catch ex As Exception
                'log.Error(ex.Message)
            End Try
        End With
    End Sub
End Class