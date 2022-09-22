Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Telerik.Web.UI

Public Class CoarseworkSubjectMarksConsolidation
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

            obj.loadComboBox(cboTerm, "SELECT termId, term FROM tbl_schoolTerms", "term", "termId")
            obj.loadComboBox(cboSubject, "SELECT  subjectId, subject FROM tbl_subjects", "subject", "subjectId")

            obj.loadComboBox(cboStreams, "SELECT  [streamId], [stream] FROM [dbo].[tbl_streams]", "stream", "streamId")
            obj.loadComboBox(cboClasses, "SELECT [schoolClassId], [schoolClass] FROM [dbo].[tbl_schoolClasses]", "schoolClass", "schoolClassId")
            obj.loadComboBox(cboGrading, "SELECT [gradingId], [gradingName] FROM [dbo].[tbl_gradings]", "gradingName", "gradingId")

        End If

    End Sub

    Protected Sub cmdSearch_Click(sender As Object, e As EventArgs) Handles cmdSearch.Click

        Dim sql As String = "SELECT DISTINCT testId AS [Test_Code], highestPossibleMark AS [Marked_Out_Of], 0 AS [Select], 0 AS [Assigned_Percentage_Contribution] FROM dbo.tbl_tests " & _
                            " WHERE (subject = '" & cboSubject.Text & "') AND (stream = '" & cboStreams.Text & "') AND  ( (dtDate >= '" & rdpDateFrom.SelectedDate & "') AND (dtDate <= '" & rdpDateTo.SelectedDate & "')) "

        With gwTests
            Try
                Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
                .DataSource = ds
                .DataBind()
            Catch ex As Exception
                'log.Error(ex.Message)
            End Try
        End With

    End Sub

    Protected Sub gwTests_NeedDataSource(sender As Object, e As Telerik.Web.UI.GridNeedDataSourceEventArgs) Handles gwTests.NeedDataSource

    End Sub

    Protected Sub cmdApply_Click(sender As Object, e As EventArgs) Handles cmdApply.Click


        Dim sql As String = "UPDATE [tbl_testMarks] SET [selected] = 0, percentWeight = 0 "
        Try
            obj.ConnectionString = con
            obj.ExecuteNonQRY(sql)
        Catch
        End Try


        Dim tot As Integer = 0
        For Each gridRow As GridDataItem In gwTests.Items
            If gridRow.Selected Then
                Dim txtBox As TextBox = gridRow.Item("Assigned_Percentage_Contribution").FindControl("txtAssigned_Percentage_Contribution")
                tot = tot + Val(txtBox.Text)
            End If
        Next

        If tot <> 100 Then
            lblMsg.Text = "ERROR..! Weights not adding to 100%"
            Exit Sub
        End If


        For Each gridRow As GridDataItem In gwTests.Items
            If gridRow.Selected Then
                Dim txtBox As TextBox = gridRow.Item("Assigned_Percentage_Contribution").FindControl("txtAssigned_Percentage_Contribution")
                'tot = tot + Val(txtBox.Text)

                If chkProcessForClass.Checked = True Then
                    sql = "UPDATE [tbl_testMarks] SET [selected] = 1, percentWeight = " & Val(txtBox.Text) & " WHERE [testId] = '" & gridRow.Item("Test_Code").Text & "' AND class_ = '" & cboClasses.Text & "'"
                Else
                    sql = "UPDATE [tbl_testMarks] SET [selected] = 1, percentWeight = " & Val(txtBox.Text) & " WHERE [testId] = '" & gridRow.Item("Test_Code").Text & "'"
                End If

                Try
                    obj.ConnectionString = con
                    obj.ExecuteNonQRY(sql)
                Catch
                End Try

            End If
        Next

        If chkProcessForStream.Checked = True Then
            sql = "DELETE tbl_testMarkAggregatesBySubject WHERE  [intYear] = " & txtYear.Text & " AND [term] = '" & cboTerm.Text & "' AND  [subject] = '" & cboSubject.Text & "' AND [stream_] = '" & cboStreams.Text & "'"
        ElseIf chkProcessForClass.Checked = True Then
            sql = "DELETE tbl_testMarkAggregatesBySubject WHERE  [intYear] = " & txtYear.Text & " AND [term] = '" & cboTerm.Text & "' AND  [subject] = '" & cboSubject.Text & "' AND [stream_] = '" & cboStreams.Text & "' AND [class_] = '" & cboClasses.Text & "'"
        End If

        Try
            obj.ConnectionString = con
            obj.ExecuteNonQRY(sql)
        Catch
        End Try

        sql = "INSERT [dbo].[tbl_testMarkAggregatesBySubject] ([studentId], [subject], [intYear], [term], [markObtained], [selected], [stream_], [class_]) " & _
                            " (SELECT [studentId], '" & cboSubject.Text & "' AS [subject], " & txtYear.Text & " AS [intYear], '" & cboTerm.Text & "' AS [term], SUM((([percentWeight]/100)*[percentage])) AS " & _
                            " [markObtained], 1 , [stream_], [class_] FROM [tbl_testMarks] WHERE [Selected] = 1  GROUP BY StudentId, [stream_], [class_]) "

        Try
            obj.ConnectionString = con
            obj.ExecuteNonQRY(sql)
        Catch
        End Try

        applyGrading()


        If chkInsertStreamPosition.Checked = True Then
            generateStreamPositions()
        End If



        If chkInsertClassPosition.Checked = True Then
            If chkProcessForClass.Checked = True Then
                generateClassPositionsForSpecifiedClass()
            ElseIf chkInsertStreamPosition.Checked = True Then
                generateClassPositionsForWholeStream()
            Else

            End If
        End If

        loadProcessedResults()

    End Sub


    Private Sub generateClassPositionsForWholeStream()

        Dim studentPoz As Integer = 1
        Dim skipPoztns As Integer = 0
        Dim intMark As Integer = 100
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
                        qry = "UPDATE [tbl_testMarkAggregatesBySubject] SET classPosition = " & poz & " WHERE [selected] = 1 AND markObtained = " & ctrMak & " AND class_ ='" & schClass & "'"
                        obj.ExecuteNonQRY(qry)
                        skipPoztns = numberOfSameClassStudentsWithSameTestMark(ctrMak, schClass)
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
        Dim intMark As Integer = 100
        Dim poz As Integer = 1


        For ctrMak = intMark To 0 Step -1
            Dim qry As String = "UPDATE tbl_testMarks SET classPosition = " & poz & " WHERE [selected] = 1 AND markObtained = " & ctrMak & " AND class_ ='" & cboClasses.Text & "'"

            Try
                obj.ConnectionString = con
                obj.ExecuteNonQRY(qry)
            Catch
            End Try

            skipPoztns = numberOfSameClassStudentsWithSameTestMark(ctrMak, cboClasses.Text)
            poz = poz + skipPoztns
        Next


    End Sub


    Private Function numberOfSameClassStudentsWithSameTestMark(ByVal mark As Integer, ByVal schClass As String) As Integer
        Dim qry As String = "SELECT COUNT(StudentId) AS numberOfStudents FROM [tbl_testMarkAggregatesBySubject] WHERE [selected] = 1 AND markObtained = " & mark & " AND class_ = '" & schClass & "'"

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
    Private Function generateStreamPositions() As Integer


        If cboStreams.Text = "" Then
            lblMsg.Text = "Please specify the stream for which you want positions."
            Return 0
            Exit Function
        End If

        Dim studentPoz As Integer = 1
        Dim skipPoztns As Integer = 0
        Dim intMark As Integer = 100
        Dim poz As Integer = 1


        For ctrMak = intMark To 0 Step -1
            Dim qry As String = "UPDATE [tbl_testMarkAggregatesBySubject] SET streamPosition = " & poz & " WHERE [selected] = 1 AND markObtained = " & ctrMak

            Try
                obj.ConnectionString = con
                obj.ExecuteNonQRY(qry)
            Catch
            End Try

            skipPoztns = numberOfStudentsWithSameTestMark(ctrMak)
            poz = poz + skipPoztns
        Next

        Return 1

    End Function


    Private Function numberOfStudentsWithSameTestMark(ByVal mark As Integer) As Integer
        Dim qry As String = "SELECT COUNT(StudentId) AS numberOfStudents FROM [tbl_testMarkAggregatesBySubject] WHERE [selected] = 1 AND markObtained = " & mark

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
    Private Sub applyGrading()

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
                    qry = "UPDATE tbl_testMarkAggregatesBySubject SET grade = '" & grade & "' WHERE [selected] = 1  AND (markObtained >= " & fromMark & " AND markObtained <= " & toMark & ")"
                    obj.ExecuteNonQRY(qry)
                Next
            End If
        Catch
        End Try
    End Sub

    Private Sub loadProcessedResults()
        
        Dim sql As String = "SELECT dbo.tbl_testMarkAggregatesBySubject.studentId AS [Student ID], dbo.tbl_students.firstName AS [First Name], " & _
            " dbo.tbl_students.secondName AS [Second Name], dbo.tbl_students.surname AS Surname, " & _
            " dbo.tbl_testMarkAggregatesBySubject.markObtained AS Mark, dbo.tbl_testMarkAggregatesBySubject.grade AS Grade, " & _
            " dbo.tbl_testMarkAggregatesBySubject.classPosition AS [Class Position], dbo.tbl_testMarkAggregatesBySubject.streamPosition " & _
            " AS [Stream Position], dbo.tbl_testMarkAggregatesBySubject.stream_ AS Stream, dbo.tbl_testMarkAggregatesBySubject.class_ AS Class " & _
            " FROM dbo.tbl_testMarkAggregatesBySubject INNER JOIN dbo.tbl_students ON dbo.tbl_testMarkAggregatesBySubject.studentId " & _
            " = dbo.tbl_students.studentId WHERE (dbo.tbl_testMarkAggregatesBySubject.subject = '" & cboSubject.Text & "') AND " & _
            " (dbo.tbl_testMarkAggregatesBySubject.intYear = " & txtYear.Text & ") AND (dbo.tbl_testMarkAggregatesBySubject.term = '" & cboTerm.Text & "' )"


        If chkProcessForClass.Checked = True Then
            sql = sql & " AND tbl_testMarkAggregatesBySubject.class_ = '" & cboClasses.Text & "' "
        End If

        sql = sql & " ORDER BY tbl_testMarkAggregatesBySubject.markObtained DESC"

        With gwProcessedResults
            Try
                Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
                .DataSource = ds
                .DataBind()
            Catch ex As Exception
                'log.Error(ex.Message)
            End Try
        End With

    End Sub


End Class