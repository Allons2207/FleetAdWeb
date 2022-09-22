Imports Telerik.Web.UI
Imports Microsoft.Practices.EnterpriseLibrary.Data

Public Class StudentsPortalAttendance
    Inherits System.Web.UI.Page

    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        LoadStudentAttendance(CokkiesWrapper.StudentID)
    End Sub


    Sub LoadStudentAttendance(ByVal id As String)

        Dim sql As String = "SELECT  CAST(dtDate AS Date) AS [Date], stream AS Stream, schClass AS Class, attendance AS Attendance, CheckInTime, CheckOutTime, comments AS Comments FROM tbl_classAttendanceRegister WHERE  studentId = '" & id & "' ORDER BY [Date] DESC"

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            If ds.Tables.Count > 0 Then

                With gwAttendance

                    .DataSource = ds
                    .DataBind()

                End With
            End If
        Catch ex As Exception

            '  log.Error(ex)
        End Try

    End Sub


    Sub LoadStudentAttendanceByDates(ByVal id As String)

        Dim sql As String = ""

        If chkAbsence.Checked = True Then
            sql = "SELECT  CAST(dtDate AS Date) AS [Date], stream AS Stream, schClass AS Class, attendance AS Attendance, " & _
          " CheckInTime, CheckOutTime, comments AS Comments FROM tbl_classAttendanceRegister WHERE attendance = 0 AND " & _
          " studentId = '" & id & "' AND (dtDate >= '" & rdDtFromDate.SelectedDate & "' AND dtDate <= '" & rdDtToDate.SelectedDate & "') ORDER BY [Date] DESC"
        Else
            sql = "SELECT  CAST(dtDate AS Date) AS [Date], stream AS Stream, schClass AS Class, attendance AS Attendance, " & _
         " CheckInTime, CheckOutTime, comments AS Comments FROM tbl_classAttendanceRegister WHERE  " & _
         " studentId = '" & id & "' AND (dtDate >= '" & rdDtFromDate.SelectedDate & "' AND dtDate <= '" & rdDtToDate.SelectedDate & "') ORDER BY [Date] DESC"

        End If

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            If ds.Tables.Count > 0 Then

                With gwAttendance

                    .DataSource = ds
                    .DataBind()

                End With
            End If
        Catch ex As Exception

            '  log.Error(ex)
        End Try

    End Sub


    Protected Sub btnLoadByDates_Click(sender As Object, e As EventArgs) Handles btnLoadByDates.Click
        LoadStudentAttendanceByDates(CokkiesWrapper.StudentID)
    End Sub
End Class