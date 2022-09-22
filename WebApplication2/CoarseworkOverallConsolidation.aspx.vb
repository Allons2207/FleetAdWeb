Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Telerik.Web.UI


Public Class CoarseworkOverallConsolidation
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
            obj.loadComboBox(cboStreams, "SELECT  [streamId], [stream] FROM [dbo].[tbl_streams]", "stream", "streamId")
            obj.loadComboBox(cboClasses, "SELECT [schoolClassId], [schoolClass] FROM [dbo].[tbl_schoolClasses]", "schoolClass", "schoolClassId")
            obj.loadComboBox(cboGrading, "SELECT [gradingId], [gradingName] FROM [dbo].[tbl_gradings]", "gradingName", "gradingId")

        End If

    End Sub


    Protected Sub cmdSearch_Click(sender As Object, e As EventArgs) Handles cmdSearch.Click

        Dim sql As String = "SELECT DISTINCT [subject], 0 AS [Select], 0 AS [Assigned_Percentage_Contribution] FROM [dbo].[tbl_testMarkAggregatesBySubject] WHERE [intYear] = " & txtYear.Text & " AND [term] = '" & cboTerm.Text & "'  AND [stream_] = '" & cboStreams.Text & "'"

        If chkProcessForClass.Checked = True Then
            sql = sql & " AND class_ = '" & cboClasses.Text & "' "
        End If

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

    Protected Sub cmdApply_Click(sender As Object, e As EventArgs) Handles cmdApply.Click

        Dim sql As String = "UPDATE [tbl_testMarkAggregatesBySubject] SET [selected] = 0"
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
                    sql = "UPDATE [tbl_testMarkAggregatesBySubject] SET [selected] = 1, percentWeight = " & Val(txtBox.Text) & " WHERE [subject] = '" & gridRow.Item("Subject").Text & _
                          "'  AND intYear = " & txtYear.Text & " AND term = '" & cboTerm.Text & "' AND class_ = '" & cboClasses.Text & "'"
                Else
                    sql = "UPDATE [tbl_testMarkAggregatesBySubject] SET [selected] = 1, percentWeight = " & Val(txtBox.Text) & " WHERE [subject] = '" & gridRow.Item("Subject").Text & _
                          "'  AND intYear = " & txtYear.Text & " AND term = '" & cboTerm.Text & "' AND stream_ = '" & cboStreams.Text & "'"
                End If

                Try
                    obj.ConnectionString = con
                    obj.ExecuteNonQRY(sql)
                Catch
                End Try

            End If
        Next

        sql = "UPDATE [dbo].[tbl_testMarkOveralAggregation] SET [Selected] = 0"

        Try
            obj.ConnectionString = con
            obj.ExecuteNonQRY(sql)
        Catch
        End Try

        'delete any existing entries 
        If chkProcessForStream.Checked = True Then
            sql = "DELETE tbl_testMarkOveralAggregation WHERE [yYear] = " & txtYear.Text & " AND [tTerm] = '" & cboTerm.Text & "' AND  [stream_] = '" & cboStreams.Text & "'"
        ElseIf chkProcessForClass.Checked = True Then
            sql = "DELETE tbl_testMarkOveralAggregation WHERE [yYear] = " & txtYear.Text & " AND [tTerm] = '" & cboTerm.Text & "' AND  [class_] = '" & cboClasses.Text & "'"
        End If


        sql = "INSERT INTO [dbo].[tbl_testMarkOveralAggregation] ([yYear],[tTerm],[studentId],[overalPercntgMark], [Selected], [class_], [stream_]) " & _
                " SELECT " & txtYear.Text & " AS [yYear], '" & cboTerm.Text & "' AS [tTerm] , studentId, AVG([markObtained]) AS [overalPercntgMark], 1 AS [Selected], " & _
                " [class_], [stream_] FROM [dbo].[tbl_testMarkAggregatesBySubject] WHERE [selected] = 1 GROUP BY studentId, [class_], [stream_] "

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


    Private Sub loadProcessedResults()

        Dim sql As String = "SELECT  dbo.tbl_testMarkOveralAggregation.yYear, dbo.tbl_testMarkOveralAggregation.tTerm, " & _
                            " dbo.tbl_testMarkOveralAggregation.studentId AS [Student Id], dbo.tbl_students.firstName AS Firstname, " & _
                            " dbo.tbl_students.secondName AS [Second Name], dbo.tbl_students.surname AS Surname, " & _
                            " dbo.tbl_testMarkOveralAggregation.stream_ AS Stream_, dbo.tbl_testMarkOveralAggregation.class_ AS Class_, " & _
                            " dbo.tbl_testMarkOveralAggregation.overalPercntgMark AS [Overall Mark], " & _
                            " dbo.tbl_testMarkOveralAggregation.overallGrade AS [Overall Grade], " & _
                            " dbo.tbl_testMarkOveralAggregation.overallClassPosition AS [Overall Class Position], " & _
                            " dbo.tbl_testMarkOveralAggregation.overallStreamPosition AS [Overall Stream Position] " & _
                            " FROM            dbo.tbl_testMarkOveralAggregation INNER JOIN " & _
                            " dbo.tbl_students ON dbo.tbl_testMarkOveralAggregation.studentId = dbo.tbl_students.studentId " & _
                            " WHERE (dbo.tbl_testMarkOveralAggregation.yYear =  " & txtYear.Text & ") AND (dbo.tbl_testMarkOveralAggregation.tTerm = '" & cboTerm.Text & "' ) " & _
                            " AND  stream_ = '" & cboStreams.Text & "'  "

        If chkProcessForClass.Checked = True Then
            sql = sql & " AND tbl_testMarkOveralAggregation.class_ = '" & cboClasses.Text & "' "
        End If

        sql = sql & " ORDER BY tbl_testMarkOveralAggregation.[overalPercntgMark] DESC,Class_  DESC "

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
                    qry = "UPDATE tbl_testMarkOveralAggregation SET [overallGrade] = '" & grade & "' WHERE [selected] = 1  AND ([overalPercntgMark] >= " & fromMark & " AND [overalPercntgMark] <= " & toMark & ")"
                    obj.ExecuteNonQRY(qry)
                Next
            End If
        Catch
        End Try
    End Sub

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
            Dim qry As String = "UPDATE [tbl_testMarkOveralAggregation] SET [overallStreamPosition] = " & poz & " WHERE [selected] = 1 AND [overalPercntgMark] = " & ctrMak

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
        Dim qry As String = "SELECT COUNT(StudentId) AS numberOfStudents FROM [tbl_testMarkOveralAggregation] WHERE [selected] = 1 AND [overalPercntgMark] = " & mark

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
            Dim qry As String = "UPDATE [tbl_testMarkOveralAggregation] SET [overallClassPosition] = " & poz & " WHERE [selected] = 1 AND [overalPercntgMark] = " & ctrMak & " AND class_ ='" & cboClasses.Text & "'"

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

        Dim qry As String = "SELECT COUNT(StudentId) AS numberOfStudents FROM [tbl_testMarkOveralAggregation] WHERE [selected] = 1 AND [overalPercntgMark] = " & mark & " AND class_ ='" & schClass & "'"

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
                        qry = "UPDATE [tbl_testMarkOveralAggregation] SET [overallClassPosition] = " & poz & " WHERE [selected] = 1 AND [overalPercntgMark] = " & ctrMak & " AND class_ ='" & schClass & "'"
                        obj.ExecuteNonQRY(qry)
                        skipPoztns = numberOfSameClassStudentsWithSameTestMark(ctrMak, schClass)
                        poz = poz + skipPoztns
                    Next
                Next
            End If
        Catch

        End Try
    End Sub

End Class