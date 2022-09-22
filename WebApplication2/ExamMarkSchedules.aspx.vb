
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Public Class MarkSchedules
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
            obj.loadComboBox(cboSubject, "SELECT  subjectId, subject FROM tbl_subjects", "subject", "subjectId")
            obj.loadComboBox(cboTerm, "SELECT termId, term FROM tbl_schoolTerms", "term", "termId")

        End If


    End Sub

    Private Sub loadMarksSchedule()

        Dim sql As String = "SELECT dbo.tbl_examinationMarksAggregatedBySubject.intYear AS Year, dbo.tbl_examinationMarksAggregatedBySubject.term AS " & _
                            " Term, dbo.tbl_examinationMarksAggregatedBySubject.subject AS Subject, dbo.tbl_examinationMarksAggregatedBySubject.stream " & _
                            " AS Stream, dbo.tbl_examinationMarksAggregatedBySubject.schClass AS Class, " & _
                            " dbo.tbl_examinationMarksAggregatedBySubject.studentId AS [Student ID], dbo.tbl_students.firstName AS [First Name], " & _
                            " dbo.tbl_students.secondName AS [Second Name], dbo.tbl_students.surname AS Surname, " & _
                            " dbo.tbl_examinationMarksAggregatedBySubject.percentMarkObtained AS [Percentage Mark], " & _
                            " dbo.tbl_examinationMarksAggregatedBySubject.grade AS Grade, dbo.tbl_examinationMarksAggregatedBySubject.classPosition " & _
                            " AS [Class Position], dbo.tbl_examinationMarksAggregatedBySubject.streamPosition AS [Stream Position] " & _
                            " FROM dbo.tbl_students INNER JOIN " & _
                            " dbo.tbl_examinationMarksAggregatedBySubject ON dbo.tbl_students.studentId = " & _
                            " dbo.tbl_examinationMarksAggregatedBySubject.studentId " & _
                            " WHERE (dbo.tbl_examinationMarksAggregatedBySubject.intYear = " & txtYear.Text & ") AND " & _
                            " (dbo.tbl_examinationMarksAggregatedBySubject.term = '" & cboTerm.Text & "') AND " & _
                            " (dbo.tbl_examinationMarksAggregatedBySubject.subject = '" & cboSubject.Text & "') AND (dbo.tbl_examinationMarksAggregatedBySubject.stream " & _
                            " = '" & cboStreams.Text & "') AND (dbo.tbl_examinationMarksAggregatedBySubject.schClass = '" & cboClasses.Text & "') " & _
                            " ORDER BY [Percentage Mark] DESC, [Stream Position], [Class Position] "

        With gwResults
            Try
                Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
                .DataSource = ds
                .DataBind()
            Catch ex As Exception
                'log.Error(ex.Message)
            End Try
        End With


    End Sub

    Protected Sub cmdShowMarks_Click(sender As Object, e As EventArgs) Handles cmdShowMarks.Click
        loadMarksSchedule()
    End Sub
End Class