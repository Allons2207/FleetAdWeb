Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data

Public Class ProcessingCoarseworkSinglePaperMarks
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
                    qry = "UPDATE tbl_testMarks SET grade = '" & grade & "' WHERE testId ='" & txtTestCode.Text & "' AND (markObtained >= " & fromMark & " AND markObtained <= " & toMark & ")  AND stream_ ='" & txtStream.Text & "'"
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
                    qry = "UPDATE tbl_testMarks SET grade = '" & grade & "' WHERE testId ='" & txtTestCode.Text & "' AND (markObtained >= " & fromMark & " AND markObtained <= " & toMark & ")  AND stream_ ='" & txtStream.Text & "' AND class_ = '" & cboClasses.Text & "'"
                    obj.ExecuteNonQRY(qry)
                Next
            End If
        Catch
        End Try

    End Sub

    Private Sub generateClassPositionsForWholeStream()


        Dim studentPoz As Integer = 1
        Dim skipPoztns As Integer = 0
        Dim intMark As Integer = Val(txtHighestPossibleMark.Text)
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
                        qry = "UPDATE tbl_testMarks SET classPosition = " & poz & " WHERE testId ='" & txtTestCode.Text & "' AND markObtained = " & ctrMak & " AND class_ ='" & schClass & "'"
                        obj.ExecuteNonQRY(qry)
                        skipPoztns = numberOfSameClassStudentsWithSameTestMark(txtTestCode.Text, ctrMak, schClass)
                        poz = poz + skipPoztns
                    Next
                Next
            End If
        Catch

        End Try




       


    End Sub

    Private Sub generateClassPositionsForSpecifiedClass()

        If cboClasses.Text = "" Then
            lblMsg.Text = "Please specify the class for which you want positions."
            Exit Sub
        End If

        Dim studentPoz As Integer = 1
        Dim skipPoztns As Integer = 0
        Dim intMark As Integer = Val(txtHighestPossibleMark.Text)
        Dim poz As Integer = 1


        For ctrMak = intMark To 0 Step -1
            Dim qry As String = "UPDATE tbl_testMarks SET classPosition = " & poz & " WHERE testId ='" & txtTestCode.Text & "' AND markObtained = " & ctrMak & " AND class_ ='" & cboClasses.Text & "'"

            Try
                obj.ConnectionString = con
                obj.ExecuteNonQRY(qry)
            Catch
            End Try

            skipPoztns = numberOfSameClassStudentsWithSameTestMark(txtTestCode.Text, ctrMak, cboClasses.Text)
            poz = poz + skipPoztns
        Next


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

    Private Function generateStreamPositions() As Integer


        If cboStreams.Text = "" Then
            lblMsg.Text = "Please specify the stream for which you want positions."
            Return 0
            Exit Function
        End If

        Dim studentPoz As Integer = 1
        Dim skipPoztns As Integer = 0
        Dim intMark As Integer = Val(txtHighestPossibleMark.Text)
        Dim poz As Integer = 1


        For ctrMak = intMark To 0 Step -1
            Dim qry As String = "UPDATE tbl_testMarks SET streamPosition = " & poz & " WHERE testId ='" & txtTestCode.Text & "' AND markObtained = " & ctrMak

            Try
                obj.ConnectionString = con
                obj.ExecuteNonQRY(qry)
            Catch
            End Try

            skipPoztns = numberOfStudentsWithSameTestMark(txtTestCode.Text, ctrMak)
            poz = poz + skipPoztns
        Next

        Return 1

    End Function

    Private Function numberOfStudentsWithSameTestMark(ByVal testCode As String, ByVal mark As Integer) As Integer
        Dim qry As String = "SELECT COUNT(StudentId) AS numberOfStudents FROM tbl_testMarks WHERE testId = '" & testCode & "' AND markObtained = " & mark

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


    Private Function numberOfSameClassStudentsWithSameTestMark(ByVal testCode As String, ByVal mark As Integer, ByVal schClass As String) As Integer
        Dim qry As String = "SELECT COUNT(StudentId) AS numberOfStudents FROM tbl_testMarks WHERE testId = '" & testCode & "' AND markObtained = " & mark & " AND class_ = '" & schClass & "'"

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


    Private Function numberOfSameStreamStudentsWithSameTestMark(ByVal testCode As String, ByVal mark As Integer, ByVal stream As String) As Integer
        Dim qry As String = "SELECT COUNT(StudentId) AS numberOfStudents FROM tbl_testMarks WHERE testId = '" & testCode & "' AND markObtained = " & mark & " AND stream_ = '" & stream & "'"

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

    Protected Sub cmdPreviewGradingMarks_Click(sender As Object, e As EventArgs) Handles cmdPreviewGradingMarks.Click
        loadGradingMarkRanges()
    End Sub

    Private Sub loadResults()

        Dim Sql As String = "SELECT dbo.tbl_students.studentId AS [Student ID], dbo.tbl_students.firstName AS [First Name], " & _
                      " dbo.tbl_students.secondName AS [Second Name], dbo.tbl_students.surname AS Surname, " & _
                      "   dbo.tbl_testMarks.class_ AS Class_, dbo.tbl_testMarks.markObtained AS [Mark Obtained], " & _
                      " dbo.tbl_testMarks.percentage AS Percentage, dbo.tbl_testMarks.grade AS Grade, " & _
                      "   dbo.tbl_testMarks.classPosition AS [Class Position], dbo.tbl_testMarks.streamPosition AS " & _
                      " [Stream Position], dbo.tbl_testMarks.positionDeviation AS [Position Deviation] " & _
                      " FROM dbo.tbl_testMarks INNER JOIN dbo.tbl_students ON dbo.tbl_testMarks.studentId = dbo.tbl_students.studentId " & _
                      " WHERE (dbo.tbl_testMarks.testId = '" & txtTestCode.Text & "') "

        If chkProcessForClass.Checked = True Then
            Sql = Sql & " AND dbo.tbl_testMarks.class_ '" & cboClasses.Text & "' "
        End If

        Sql = Sql & " ORDER BY tbl_testMarks.markObtained DESC"

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

    Protected Sub cmdSearch_Click(sender As Object, e As EventArgs) Handles cmdSearch.Click
        loadResults()
    End Sub

End Class