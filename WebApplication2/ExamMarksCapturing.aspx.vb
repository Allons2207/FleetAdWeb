Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Telerik.Web.UI

Public Class ExamMarksCapturing
    Inherits System.Web.UI.Page

    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then
            If (CokkiesWrapper.UserID <= 0 AndAlso Not IsNumeric(CokkiesWrapper.UserID)) Then
                Response.Redirect("../Login.aspx")
                Exit Sub
            End If

            obj.loadComboBox(cboClasses, "SELECT [schoolClassId], [schoolClass] FROM [dbo].[tbl_schoolClasses]", "schoolClass", "schoolClassId")

            '  LoadClassStudentsAndMarks()

        End If

    End Sub


    Private Sub LoadClassStudentsAndMarks()

        Dim sql As String = "SELECT dbo.tbl_students.studentId, dbo.tbl_students.firstName, dbo.tbl_students.secondName, " & _
                            " dbo.tbl_students.surname, dbo.tbl_studentSubjects.subjectId, dbo.tbl_examinationMarks.markObtained AS CurrentMark " & _
                            " FROM dbo.tbl_students INNER JOIN  dbo.tbl_studentSubjects ON dbo.tbl_students.studentId = " & _
                            " dbo.tbl_studentSubjects.studentId INNER JOIN dbo.tbl_examinationMarks ON dbo.tbl_students.studentId = " & _
                            " dbo.tbl_examinationMarks.studentId WHERE (dbo.tbl_examinationMarks.examId = '" & txtExamCode.Text & "') AND (dbo.tbl_students.schoolClassId = " & cboClasses.SelectedValue & ")"

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            db.ExecuteDataSet(CommandType.Text, sql)

            If ds.Tables.Count > 0 Then
                If ds.Tables(0).Rows.Count > 0 Then
                    With gwClassList
                        Try
                            .DataSource = ds
                            .DataBind()
                        Catch ex As Exception
                            'log.Error(ex.Message)
                        End Try
                    End With
                Else

                    Dim sql2 As String = "SELECT DISTINCT dbo.tbl_students.studentId, dbo.tbl_students.firstName, dbo.tbl_students.secondName, " & _
                                         " dbo.tbl_students.surname, dbo.tbl_studentSubjects.subjectId, '' AS CurrentMark, '' AS Mark FROM dbo.tbl_students INNER JOIN " & _
                                        " dbo.tbl_studentSubjects ON dbo.tbl_students.studentId = dbo.tbl_studentSubjects.studentId " & _
                                        " WHERE (dbo.tbl_studentSubjects.subjectId = '" & txtSubject.Text & "') AND (dbo.tbl_students.schoolClassId = " & cboClasses.SelectedValue & ") "

                    loadStudentMarksAnew(sql2)

                End If
            End If

        Catch ex As Exception
            ' log.Error(ex)
        End Try
    End Sub


    Private Sub loadStudentMarksAnew(sql As String)

        refreshGrid()

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            db.ExecuteDataSet(CommandType.Text, sql)

            If ds.Tables.Count > 0 Then
                If ds.Tables(0).Rows.Count > 0 Then
                    With gwClassList
                        Try
                            .DataSource = ds
                            .DataBind()
                            ' .Columns(5).ItemStyle.
                            ' .Columns(5)
                        Catch ex As Exception
                            ' log.Error(ex.Message)
                        End Try
                    End With
                End If
            End If

        Catch ex As Exception
            ' log.Error(ex)
        End Try
    End Sub


    Private Sub refreshGrid()
        With gwClassList
            .DataSource = Nothing
            .DataBind()
        End With
    End Sub

    Protected Sub cmdSaveMarks_Click(sender As Object, e As EventArgs) Handles cmdSaveMarks.Click
        Dim qry As String = ""
        Dim txtBox As New TextBox

        Try
            For Each gridRow As GridDataItem In gwClassList.Items

                txtBox = gridRow.Item("mark").FindControl("mark")

                If txtBox.Text <> "" And Val(gridRow("CurrentMark").Text) = 0 Then
                    qry = " INSERT [dbo].[tbl_examinationMarks] ([examId], [studentId], [markObtained], [percentage],[stream], [schClass]) " & _
                            " VALUES ('" & txtExamCode.Text & "', '" & gridRow("studentId").Text & "', " & txtBox.Text & ", " & (Val(txtBox.Text) / Val(txtMaxMark.Text)) * 100 & ",'" & txtStream.Text & "', '" & cboClasses.Text & "') "
                    saveTestMarksEntry(qry)
                ElseIf txtBox.Text <> "" And Val(gridRow("CurrentMark").Text) <> 0 Then
                    qry = " UPDATE tbl_examinationMarks SET markObtained = " & txtBox.Text & " WHERE examId ='" & txtExamCode.Text & "' AND studentId = '" & gridRow("studentId").Text & "'"
                    saveTestMarksEntry(qry)
                End If
            Next
            LoadClassStudentsAndMarks()
        Catch ex As Exception

        End Try
    End Sub

    Private Sub saveTestMarksEntry(qry As String)
        obj.ConnectionString = con
        obj.ExecuteNonQRY(qry)

    End Sub


    Protected Sub cmdLoadClassList_Click(sender As Object, e As EventArgs) Handles cmdLoadClassList.Click
        LoadClassStudentsAndMarks()
    End Sub

    Protected Sub btnSearch_Click(sender As Object, e As EventArgs) Handles btnSearch.Click

        Dim qry As String = "SELECT [stream], [subject],[examDate],  [paper], [highestPossibleMark], [authourity] FROM [tbl_examinations] WHERE [examId] = '" & txtExamCode.Text & "' "

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, qry)
            db.ExecuteDataSet(CommandType.Text, qry)

            If ds.Tables.Count > 0 Then
                If ds.Tables(0).Rows.Count > 0 Then
                    txtExamDate.Text = ds.Tables(0).Rows(0)("examDate").ToString
                    txtStream.Text = ds.Tables(0).Rows(0)("stream").ToString
                    txtSubject.Text = ds.Tables(0).Rows(0)("subject").ToString
                    txtPaper.Text = ds.Tables(0).Rows(0)("paper").ToString
                    txtMaxMark.Text = ds.Tables(0).Rows(0)("highestPossibleMark").ToString
                    txtExamBoard.Text = ds.Tables(0).Rows(0)("authourity").ToString
                    '   cboClasses.Text = ds.Tables(0).Rows(0)("schoolClass").ToString
                End If
            End If

        Catch ex As Exception
            ' log.Error(ex)
        End Try
    End Sub




End Class