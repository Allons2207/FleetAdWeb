Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data

Public Class StudentsPortalTimeTable
    Inherits System.Web.UI.Page

    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        loadStudentTimeTable()

    End Sub

    Private Sub loadStudentTimeTable()

        Dim qry As String = "SELECT dbo.tbl_classTimeTable.dDay AS Day, CAST(dbo.tbl_classPeriods.fromTime AS Time) AS [From_Time], " & _
                            " CAST(dbo.tbl_classPeriods.toTime AS Time) AS [To_Time], dbo.tbl_classTimeTable.subject AS Subject, " & _
                            " dbo.tbl_classTimeTable.TeacherCode AS Teacher FROM dbo.tbl_classTimeTable INNER JOIN " & _
                         " dbo.tbl_classPeriods ON dbo.tbl_classTimeTable.periodNumber = dbo.tbl_classPeriods.period INNER JOIN " & _
                         " dbo.tbl_schoolClasses ON dbo.tbl_classTimeTable.schClass = dbo.tbl_schoolClasses.schoolClass INNER JOIN " & _
                         " dbo.tbl_students ON dbo.tbl_schoolClasses.schoolClassId = dbo.tbl_students.schoolClassId " & _
                        " WHERE        (dbo.tbl_students.studentId = '" & CokkiesWrapper.StudentID & "') " & _
                        " ORDER BY dbo.tbl_classTimeTable.dayNumba, dbo.tbl_classTimeTable.periodNumber"
        With gwTimeTable
            Try
                Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, qry)
                .DataSource = ds
                .DataBind()
            Catch ex As Exception
                'log.Error(ex.Message)
            End Try
        End With

    End Sub

End Class