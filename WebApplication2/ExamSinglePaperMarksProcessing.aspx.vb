Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Public Class ExamSinglePaperMarksProcessing
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

            obj.loadComboBox(cboStreams, "SELECT  [streamId], [stream] FROM [dbo].[tbl_streams]", "stream", "streamId")
            obj.loadComboBox(cboClasses, "SELECT [schoolClassId], [schoolClass] FROM [dbo].[tbl_schoolClasses]", "schoolClass", "schoolClassId")
            '  obj.loadComboBox(cboStreams, "SELECT  [streamId], [stream] FROM [dbo].[tbl_streams]", "stream", "streamId")
            obj.loadComboBox(cboGrading, "SELECT [gradingId], [gradingName] FROM [dbo].[tbl_gradings]", "gradingName", "gradingId")

        End If
    End Sub

    Protected Sub cmdSearch_Click(sender As Object, e As EventArgs) Handles cmdSearch.Click

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

    Protected Sub cmdPreviewGradingMarks_Click(sender As Object, e As EventArgs) Handles cmdPreviewGradingMarks.Click
        loadGradingMarkRanges()
    End Sub

    Private Sub loadGradingMarkRanges()

        With gwGradeRanges
            Try
                Dim sql As String = "SELECT fromMark AS [From Mark], toMark AS [To Mark], grade AS Grade FROM " & _
                                    " tbl_gradeRanges WHERE (gradingId = " & cboGrading.SelectedValue & ") ORDER BY gradingId, [From Mark] DESC"
                Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
                .DataSource = ds
                .DataBind()
            Catch ex As Exception
                'log.Error(ex.Message)
            End Try
        End With

    End Sub


    Protected Sub cmdApplyActions_Click(sender As Object, e As EventArgs) Handles cmdApplyActions.Click
        If chkGenerateStreamPoz.Checked = False And chkGenerateClassPoz.Checked = False And chkEffectGrades.Checked = False Then
            lblMsg.Text = "There are NO VALID actions marked for application..!"
            Exit Sub
        End If

        If chkGenerateStreamPoz.Checked = True Then
            generateStreamPositions()
        End If

        If chkGenerateClassPoz.Checked = True Then
            If chkProcessForClass.Checked = True Then
                generateClassPositionsForSpecifiedClass()
            ElseIf chkGenerateStreamPoz.Checked = True Then
                generateClassPositionsForWholeStream()
            Else

            End If
        End If

        If chkEffectGrades.Checked = True Then
            If chkProcessForStream.Checked = True Then
                applyGradingToStream()
            ElseIf chkProcessForClass.Checked = True Then
                applyGradingToClass()
            End If
        End If

        loadResults()

    End Sub

    Private Sub loadResults()

        Dim sql As String = "SELECT dbo.tbl_examinationMarks.studentId AS [Student ID], dbo.tbl_students.firstName AS [First Name], " & _
                            " dbo.tbl_students.secondName AS [Second Name], dbo.tbl_students.surname AS Surname, " & _
                            " dbo.tbl_examinationMarks.percentage AS [Percentage Mark], dbo.tbl_examinationMarks.grade AS Grade, " & _
                            " dbo.tbl_examinationMarks.classPosition AS [Class Position], dbo.tbl_examinationMarks.streamPosition AS " & _
                            " [Stream Position], dbo.tbl_examinationMarks.positionDeviation AS [Position Deviation], " & _
                            " dbo.tbl_examinationMarks.schClass AS Class FROM            dbo.tbl_examinationMarks INNER JOIN " & _
                            " dbo.tbl_students ON dbo.tbl_examinationMarks.studentId = dbo.tbl_students.studentId " & _
                            " WHERE (dbo.tbl_examinationMarks.examId = '" & txtExamCode.Text & "') "
        If chkProcessForClass.Checked = True Then
            sql = sql & " AND dbo.tbl_examinationMarks.schClass '" & cboClasses.Text & "' "
        End If

        sql = sql & " ORDER BY [Percentage Mark] DESC, [Stream Position] DESC, [Class Position] DESC, Surname"

        With gwResults
            Try
                Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, Sql)
                .DataSource = ds
                .DataBind()
            Catch ex As Exception
                'log.Error(ex.Message)
            End Try
        End With

    End Sub

    Private Function generateStreamPositions() As Integer


        If cboStreams.Text = "" Then
            lblMsg.Text = "Please specify the stream for which you want positions."
            Return 0
            Exit Function
        End If

        Dim studentPoz As Integer = 1
        Dim skipPoztns As Integer = 0
        Dim intMark As Integer = Val(txtMaxMark.Text)
        Dim poz As Integer = 1

        For ctrMak = intMark To 0 Step -1
            Dim qry As String = "UPDATE tbl_examinationMarks SET streamPosition = " & poz & " WHERE examId ='" & txtExamCode.Text & "' AND markObtained = " & ctrMak

            Try
                obj.ConnectionString = con
                obj.ExecuteNonQRY(qry)
            Catch
            End Try

            skipPoztns = numberOfStudentsWithSameTestMark(txtExamCode.Text, ctrMak)
            poz = poz + skipPoztns
        Next

        Return 1

    End Function

    Private Sub generateClassPositionsForSpecifiedClass()

        If cboClasses.Text = "" Then
            lblMsg.Text = "Please specify the class for which you want positions."
            Exit Sub
        End If

        Dim studentPoz As Integer = 1
        Dim skipPoztns As Integer = 0
        Dim intMark As Integer = Val(txtMaxMark.Text)
        Dim poz As Integer = 1


        For ctrMak = intMark To 0 Step -1
            Dim qry As String = "UPDATE tbl_examinationMarks SET classPosition = " & poz & " WHERE examId ='" & txtExamCode.Text & "' AND markObtained = " & ctrMak & " AND schClass ='" & cboClasses.Text & "'"

            Try
                obj.ConnectionString = con
                obj.ExecuteNonQRY(qry)
            Catch
            End Try

            skipPoztns = numberOfSameClassStudentsWithSameTestMark(txtExamCode.Text, ctrMak, cboClasses.Text)
            poz = poz + skipPoztns
        Next


    End Sub


    Private Sub generateClassPositionsForWholeStream()


        Dim studentPoz As Integer = 1
        Dim skipPoztns As Integer = 0
        Dim intMark As Integer = Val(txtMaxMark.Text)
        Dim poz As Integer = 1

        'get stream classes that wrote specified test

        Dim qry As String = " Select schoolClass FROM tbl_schoolClasses WHERE (streamId = " & cboStreams.SelectedValue & ")"

        obj.ConnectionString = con
        Dim schClass As String = ""

        Try
            Dim ds As DataSet = obj.ExecuteDsQRY(qry)
            If ds.Tables.Count > 0 Then
                For ctrRow = 0 To ds.Tables(0).Rows.Count
                    schClass = ds.Tables(0).Rows(ctrRow)("schoolClass").ToString
                    poz = 1
                    For ctrMak = intMark To 0 Step -1
                        qry = "UPDATE tbl_examinationMarks SET classPosition = " & poz & " WHERE examId ='" & txtExamCode.Text & "' AND markObtained = " & ctrMak & " AND schClass ='" & schClass & "'"
                        obj.ExecuteNonQRY(qry)
                        skipPoztns = numberOfSameClassStudentsWithSameTestMark(txtExamCode.Text, ctrMak, schClass)
                        poz = poz + skipPoztns
                    Next
                Next
            End If
        Catch

        End Try
    End Sub


    Private Sub applyGradingToStream()

        Dim qry As String = "SELECT grade, fromMark, toMark FROM tbl_gradeRanges WHERE (gradingId = " & cboGrading.SelectedValue & ")"

        obj.ConnectionString = con
        Dim grade As String = ""
        Dim fromMark As Integer = 0
        Dim toMark As Integer = 0

        Try
            Dim ds As DataSet = obj.ExecuteDsQRY(qry)
            If ds.Tables.Count > 0 Then
                For ctrRow = 0 To ds.Tables(0).Rows.Count
                    grade = ds.Tables(0).Rows(ctrRow)("grade")
                    fromMark = ds.Tables(0).Rows(ctrRow)("fromMark")
                    toMark = ds.Tables(0).Rows(ctrRow)("toMark")
                    qry = "UPDATE tbl_examinationMarks SET grade = '" & grade & "' WHERE examId ='" & txtExamCode.Text & "' AND (markObtained >= " & fromMark & " AND markObtained <= " & toMark & ")  AND stream ='" & txtStream.Text & "'"
                    obj.ExecuteNonQRY(qry)
                Next
            End If
        Catch
        End Try
    End Sub

    Private Sub applyGradingToClass()

        Dim qry As String = "SELECT grade, fromMark, toMark FROM tbl_gradeRanges WHERE (gradingId = " & cboGrading.SelectedValue & ")"

        obj.ConnectionString = con
        Dim grade As String = ""
        Dim fromMark As Integer = 0
        Dim toMark As Integer = 0

        Try
            Dim ds As DataSet = obj.ExecuteDsQRY(qry)
            If ds.Tables.Count > 0 Then
                For ctrRow = 0 To ds.Tables(0).Rows.Count
                    grade = ds.Tables(0).Rows(ctrRow)("grade")
                    fromMark = ds.Tables(0).Rows(ctrRow)("fromMark")
                    toMark = ds.Tables(0).Rows(ctrRow)("toMark")
                    qry = "UPDATE tbl_examinationMarks SET grade = '" & grade & "' WHERE examId ='" & txtExamCode.Text & "' AND (markObtained >= " & fromMark & " AND markObtained <= " & toMark & ")  AND stream ='" & txtStream.Text & "' AND schClass = '" & cboClasses.Text & "'"
                    obj.ExecuteNonQRY(qry)
                Next
            End If
        Catch
        End Try

    End Sub
    Private Function numberOfStudentsWithSameTestMark(ByVal examCode As String, ByVal mark As Integer) As Integer

        Dim qry As String = "SELECT COUNT(StudentId) AS numberOfStudents FROM tbl_examinationMarks WHERE examId = '" & examCode & "' AND markObtained = " & mark

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, qry)

            If ds.Tables(0).Rows.Count > 0 Then
                Return ds.Tables(0).Rows(0)("numberOfStudents").ToString
                Exit Function
            Else
                Return 0
                Exit Function
            End If
        Catch ex As Exception
        End Try

        Return 0

    End Function
    Private Function numberOfSameClassStudentsWithSameTestMark(ByVal examCode As String, ByVal mark As Integer, ByVal schClass As String) As Integer

        Dim qry As String = "SELECT COUNT(StudentId) AS numberOfStudents FROM tbl_examinationMarks WHERE examId = '" & examCode & "' AND markObtained = " & mark & " AND schClass = '" & schClass & "'"

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, qry)

            If ds.Tables(0).Rows.Count > 0 Then
                Return ds.Tables(0).Rows(0)("numberOfStudents").ToString
                Exit Function
            Else
                Return 0
                Exit Function
            End If
        Catch ex As Exception
        End Try

        Return 0

    End Function


    Private Function numberOfSameStreamStudentsWithSameTestMark(ByVal examCode As String, ByVal mark As Integer, ByVal stream As String) As Integer
        Dim qry As String = "SELECT COUNT(StudentId) AS numberOfStudents FROM tbl_examinationMarks WHERE examId = '" & examCode & "' AND markObtained = " & mark & " AND stream = '" & stream & "'"

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, qry)

            If ds.Tables(0).Rows.Count > 0 Then
                Return ds.Tables(0).Rows(0)("numberOfStudents").ToString
                Exit Function
            Else
                Return 0
                Exit Function
            End If
        Catch ex As Exception
        End Try

        Return 0
    End Function
End Class