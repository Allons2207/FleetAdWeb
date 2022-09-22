
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Public Class ExpectedAmountCorrection
    Inherits System.Web.UI.Page

    Dim objStudentTutionPayment As New studentTuitionPayments(CokkiesWrapper.thisConnectionName)
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)

    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If (CokkiesWrapper.UserID <= 0 AndAlso Not IsNumeric(CokkiesWrapper.UserID)) Then
            Response.Redirect("../Login.aspx")
            Exit Sub
        End If

        obj.ConnectionString = con
        Dim accessMode As String = obj.groupAccessPermissionsDs(CokkiesWrapper.UserGroup, 13)

        Select Case accessMode
            Case "AllowReadNRead"
            Case "ReadNReadOnly"
                ' cmdSave.Enabled = False
            Case "DenyAcces"
                Response.Redirect("~/AccessDenied.aspx")
                Exit Sub
            Case Else
                Response.Redirect("~/AccessDenied.aspx")
                Exit Sub
        End Select

    End Sub

    Protected Sub cmdShowStudentDets_Click(sender As Object, e As EventArgs) Handles cmdShowStudentDets.Click

        txtStudentName.Text = ""
        txtClass.Text = ""
        txtCurrentExpectedAmount.Text = ""

        If cboPaymentType.Text = "" Then
            lblMsg.Text = "Please specify the Payment Type"
            Exit Sub
        ElseIf txtYear.Text = "" Then
            lblMsg.Text = "Please specify the year"
            Exit Sub
        ElseIf cboMonth.Text = "" Then
            lblMsg.Text = "Please specify the month"
            Exit Sub
        ElseIf txtStudentID.Text = "" Then
            lblMsg.Text = "Please specify the Student ID"
            Exit Sub
        End If

        Dim strQry As String = ""

        If cboPaymentType.Text = "Tuition" Then
            strQry = "SELECT dbo.tbl_students.firstName + ' ' + dbo.tbl_students.secondName + ' ' + dbo.tbl_students.surname AS studentName, " & _
                    " dbo.tbl_schoolClasses.schoolClass, dbo.tbl_tuitionPayments.expectedAmt, " & _
                    " dbo.tbl_tuitionPayments.studentId, dbo.tbl_tuitionPayments.strMonth, dbo.tbl_tuitionPayments.intYear " & _
                    " FROM            dbo.tbl_tuitionPayments INNER JOIN " & _
                    " dbo.tbl_students ON dbo.tbl_tuitionPayments.studentId = dbo.tbl_students.studentId INNER JOIN " & _
                    " dbo.tbl_schoolClasses ON dbo.tbl_students.schoolClassId = dbo.tbl_schoolClasses.schoolClassId " & _
                    " WHERE  (dbo.tbl_tuitionPayments.studentId = '" & txtStudentID.Text & "') AND (dbo.tbl_tuitionPayments.strMonth = '" & cboMonth.SelectedValue & _
                    "') AND (dbo.tbl_tuitionPayments.intYear = " & txtYear.Text & ")"
        ElseIf cboPaymentType.Text = "Levy" Then
            strQry = "SELECT        dbo.tbl_students.firstName + ' ' + dbo.tbl_students.secondName + ' ' + dbo.tbl_students.surname AS studentName," & _
          " dbo.tbl_schoolClasses.schoolClass, dbo.tbl_LevyPayments.intYear, " & _
          " dbo.tbl_LevyPayments.strTerm, dbo.tbl_LevyPayments.expectedAmt, dbo.tbl_LevyPayments.termNumber " & _
          " FROM            dbo.tbl_students INNER JOIN " & _
          " dbo.tbl_schoolClasses ON dbo.tbl_students.schoolClassId = dbo.tbl_schoolClasses.schoolClassId INNER JOIN " & _
          " dbo.tbl_LevyPayments ON dbo.tbl_students.studentId = dbo.tbl_LevyPayments.studentd " & _
          " WHERE       (dbo.tbl_LevyPayments.studentId = '" & txtStudentID.Text & "')" & _
          " AND (dbo.tbl_LevyPayments.intYear = " & txtYear.Text & ") AND (dbo.tbl_LevyPayments.termNumber = " & cboTerm.SelectedValue & ")"
        End If

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, strQry)
            If ds.Tables().Count > 0 Then
                If ds.Tables(0).Rows.Count > 0 Then
                    txtStudentName.Text = ds.Tables(0).Rows(0)("studentName").ToString
                    txtClass.Text = ds.Tables(0).Rows(0)("schoolClass").ToString
                    txtCurrentExpectedAmount.Text = ds.Tables(0).Rows(0)("expectedAmt").ToString

                End If
            End If
        Catch ex As Exception

        End Try

    End Sub


    Protected Sub cmdSave_Click(sender As Object, e As EventArgs) Handles cmdSave.Click
        Dim strQry As String = ""

        If cboPaymentType.Text = "Tuition" Then
            strQry = "UPDATE [dbo].[tbl_tuitionPayments] SET [expectedAmt] = " & Val(txtNewExpectedAmount.Text) & _
                " WHERE [studentId] = '" & txtStudentID.Text & "' AND [intYear] = " & txtYear.Text & " AND [strMonth] = '" & cboMonth.SelectedValue & "'"
        ElseIf cboPaymentType.Text = "Levy" Then
            strQry = "UPDATE [dbo].[tbl_LevyPayments] SET [expectedAmt] = " & Val(txtNewExpectedAmount.Text) & _
                " WHERE [studentId] = '" & txtStudentID.Text & "' AND [intYear] = " & txtYear.Text & " AND [strTerm] = '" & cboTerm.SelectedValue & "'"
        End If

        Try
            obj.ConnectionString = con
            '.ConnectionString = con
            If obj.ExecuteNonQRY(strQry) = 1 Then
                lblMsg.Text = "Record updated successfully."
            Else
                lblMsg.Text = "Errors occurred while trying to update record."
            End If

        Catch ex As Exception

        End Try

    End Sub

End Class