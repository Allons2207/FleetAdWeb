Imports Telerik.Web.UI
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing

Public Class CapturingOfCoarseworkMarks
    Inherits System.Web.UI.Page
    Private Shared ReadOnly log As log4net.ILog = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType)
    Dim insRec As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim objCBO As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = insRec.Database
    Dim con As String = db.ConnectionString
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (CokkiesWrapper.UserID <= 0 AndAlso Not IsNumeric(CokkiesWrapper.UserID)) Then
            Response.Redirect("../Login.aspx")
            Exit Sub
        End If

        'obj.ConnectionString = con
        'Dim accessMode As String = obj.groupAccessPermissionsDs(CokkiesWrapper.UserGroup, 12)

        'Select Case accessMode
        '    Case "AllowReadNRead"
        '    Case "ReadNReadOnly"
        '        cmdSaveMarks.Enabled = False
        '    Case "DenyAcces"
        '        Response.Redirect("~/AccessDenied.aspx")
        '        Exit Sub
        '    Case Else
        '        Response.Redirect("~/AccessDenied.aspx")
        '        Exit Sub
        'End Select

    End Sub

    Protected Sub cmdLoadClassStudentsAndMarks_Click(sender As Object, e As EventArgs) Handles cmdLoadClassStudentsAndMarks.Click
        LoadClassStudentsAndMarks()
    End Sub

    Private Sub LoadClassStudentsAndMarks()
        Dim sql As String = "SELECT dbo.tbl_testMarks.studentId, dbo.tbl_students.firstName , dbo.tbl_students.secondName , dbo.tbl_students.surname AS Surname, " & _
                         " dbo.tbl_testMarks.markObtained AS CurrentMark FROM  dbo.tbl_testMarks INNER JOIN dbo.tbl_students ON dbo.tbl_testMarks.studentId = dbo.tbl_students.studentId INNER JOIN " & _
                         " dbo.tbl_schoolClasses ON dbo.tbl_students.schoolClassId = dbo.tbl_schoolClasses.schoolClassId " & _
                         " WHERE   (dbo.tbl_testMarks.testId = '" & txtTestCode.Text & "') AND (dbo.tbl_schoolClasses.schoolClass ='" & cboClasses.Text & "')"
        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            db.ExecuteDataSet(CommandType.Text, sql)

            If ds.Tables.Count > 0 Then
                If ds.Tables(0).Rows.Count > 0 Then
                    With gwBillPayments
                        Try
                            .DataSource = ds
                            .DataBind()
                        Catch ex As Exception
                            log.Error(ex.Message)
                        End Try
                    End With
                Else
                    Dim sql2 As String = "SELECT dbo.tbl_students.studentId, dbo.tbl_students.firstName, dbo.tbl_students.secondName, dbo.tbl_students.surname, '' AS CurrentMark,    '' AS Mark " & _
                         " FROM  dbo.tbl_subjects INNER JOIN dbo.tbl_schoolClasses INNER JOIN dbo.tbl_students INNER JOIN " & _
                         " dbo.tbl_studentSubjects ON dbo.tbl_students.studentId = dbo.tbl_studentSubjects.studentId ON dbo.tbl_schoolClasses.schoolClassId = dbo.tbl_students.schoolClassId ON " & _
                         " dbo.tbl_subjects.subject = dbo.tbl_studentSubjects.subjectId WHERE (dbo.tbl_schoolClasses.schoolClass = '" & cboClasses.Text & "') AND (dbo.tbl_subjects.subject = '" & txtSubject.Text & "')"

                    loadStudentMarksAnew(sql2)

                End If
            End If

        Catch ex As Exception
            log.Error(ex)
        End Try
    End Sub

    Private Sub refreshGrid()
        With gwBillPayments
            .DataSource = Nothing
            .DataBind()
        End With
    End Sub

    Private Sub loadStudentMarksAnew(sql As String)

        refreshGrid()

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            db.ExecuteDataSet(CommandType.Text, sql)

            If ds.Tables.Count > 0 Then
                If ds.Tables(0).Rows.Count > 0 Then
                    With gwBillPayments
                        Try
                            .DataSource = ds
                            .DataBind()
                            ' .Columns(5).ItemStyle.
                            ' .Columns(5)
                        Catch ex As Exception
                            log.Error(ex.Message)
                        End Try
                    End With
                End If
            End If

        Catch ex As Exception
            log.Error(ex)
        End Try
    End Sub
    Protected Sub cmdFindTest_Click(sender As Object, e As EventArgs) Handles cmdFindTest.Click
        refreshGrid()
        txtTestDate.Text = ""
        txtHighestPossibleMark.Text = ""
        txtNotes.Text = ""
        txtStream.Text = ""
        txtSubject.Text = ""

        Dim qry As String = "SELECT [testId], [subject], [testName], [stream], [dtDate], [highestPossibleMark], [description] FROM [dbo].[tbl_tests] WHERE [testId] = '" & txtTestCode.Text & "'"
        Try
            ' Dim ds As DataSet = insRec.ExecuteDsQRY(qry)

            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, qry)
            db.ExecuteDataSet(CommandType.Text, qry)

            If ds.Tables.Count > 0 Then
                If ds.Tables(0).Rows.Count > 0 Then
                    txtTestDate.Text = ds.Tables(0).Rows(0)("dtDate")
                    txtHighestPossibleMark.Text = ds.Tables(0).Rows(0)("highestPossibleMark")
                    txtNotes.Text = ds.Tables(0).Rows(0)("description")
                    txtStream.Text = ds.Tables(0).Rows(0)("stream")
                    txtSubject.Text = ds.Tables(0).Rows(0)("subject")
                End If
            End If

        Catch ex As Exception
            log.Error(ex)
        End Try

        '  objCBO.loadComboBox(cboClasses, "SELECT dbo.tbl_schoolClasses.schoolClass, dbo.tbl_schoolClasses.schoolClassId FROM dbo.tbl_schoolClasses INNER JOIN  dbo.tbl_streams ON dbo.tbl_schoolClasses.streamId = dbo.tbl_streams.streamId WHERE (dbo.tbl_streams.stream = '" & txtStream.Text & "')", "schoolClass", "schoolClassId")

        objCBO.loadComboBox(cboClasses, "SELECT dbo.tbl_schoolClasses.schoolClass, dbo.tbl_schoolClasses.schoolClassId, dbo.tbl_tests.testId FROM dbo.tbl_schoolClasses INNER JOIN dbo.tbl_tests ON dbo.tbl_schoolClasses.schoolClass = dbo.tbl_tests.schClass WHERE (dbo.tbl_tests.testId = '" & txtTestCode.Text & "') ", "schoolClass", "schoolClassId")

    End Sub

    Protected Sub cmdSaveMarks_Click(sender As Object, e As EventArgs) Handles cmdSaveMarks.Click
        Dim qry As String = ""
        Dim txtBox As New TextBox

        Try
            For Each gridRow As GridDataItem In gwBillPayments.Items

                txtBox = gridRow.Item("mark").FindControl("mark")

                If txtBox.Text <> "" And Val(gridRow("CurrentMark").Text) = 0 Then
                    qry = "INSERT tbl_testMarks ([testId], [studentId], [markObtained], [percentage], [class_], [stream_]) " & _
                              " VALUES ('" & txtTestCode.Text & "', '" & gridRow("studentId").Text & "', " & txtBox.Text & ", " & (Val(txtBox.Text) / Val(txtHighestPossibleMark.Text)) * 100 & ", '" & cboClasses.Text & "','" & txtStream.Text & "') "
                    saveTestMarksEntry(qry)
                ElseIf txtBox.Text <> "" And Val(gridRow("CurrentMark").Text) <> 0 Then
                    qry = "UPDATE tbl_testMarks SET markObtained = " & txtBox.Text & " WHERE testId = '" & txtTestCode.Text & "' AND studentId = '" & gridRow("studentId").Text & "'"
                    saveTestMarksEntry(qry)
                End If
            Next
            LoadClassStudentsAndMarks()
        Catch ex As Exception

        End Try

    End Sub

    Private Sub saveTestMarksEntry(qry As String)
        Dim insRec As New commonFunction(CokkiesWrapper.thisConnectionName)
        insRec.ConnectionString = con
        If Not insRec.ExecuteNonQRY(qry) = 1 Then
            ' lblMsg.Text = "Inventory entry has been saved successfully."
        Else
            ' lblMsg.Text = "Inventory entry has not been saved successfully."
        End If
    End Sub

End Class