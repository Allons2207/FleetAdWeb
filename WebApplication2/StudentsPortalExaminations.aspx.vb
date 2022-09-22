
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Public Class StudentsPortalExaminations
    Inherits System.Web.UI.Page

    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        loadStudentExaminationResults(CokkiesWrapper.StudentID)
    End Sub


    Sub loadStudentExaminationResults(ByVal id As String)

        Dim sql As String = " SELECT studentId AS [Student ID], intYear AS Year, term AS Term, stream AS Stream, schClass AS Class, subject AS Subject, " & _
                            " percentMarkObtained AS [Mark Obtained], grade AS Grade, classPosition AS [Class Position], " & _
                            " streamPosition AS [Stream Position] FROM dbo.tbl_examinationMarksAggregatedBySubject " & _
                            " WHERE        (studentId = '" & id & "')"

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            If ds.Tables.Count > 0 Then

                With gwExams

                    .DataSource = ds
                    .DataBind()

                End With
            End If
        Catch ex As Exception

            ' log.Error(ex)
        End Try
    End Sub

End Class