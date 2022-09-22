
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Public Class StudentsPortalCoarsework
    Inherits System.Web.UI.Page

    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        loadStudentCourseWork(CokkiesWrapper.StudentID)
    End Sub

    Sub loadStudentCourseWork(ByVal id As String)

        Dim sql As String = "SELECT stream_ AS Stream, class_ AS Class, studentId AS [Student ID], subject AS Subject, intYear AS Year, term AS Term, " & _
                            " markObtained AS Mark, percentage AS Percentage, grade AS Grade, " & _
                            "  classPosition AS [Class Position], streamPosition AS [Stream Position], positionDeviation AS [Position Difference] " & _
                            " FROM dbo.tbl_testMarkAggregatesBySubject WHERE (studentId = '" & id & "')"

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            If ds.Tables.Count > 0 Then

                With gwCoursework

                    .DataSource = ds
                    .DataBind()

                End With
            End If
        Catch ex As Exception

            '   log.Error(ex)
        End Try
    End Sub

End Class