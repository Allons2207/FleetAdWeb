Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data

Public Class StudentsPortalFiles
    Inherits System.Web.UI.Page

    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        loadStudentFiles()
    End Sub

    Private Sub loadStudentFiles()
        Dim qry As String = "SELECT dbo.tbl_Files.FileID, dbo.tbl_Files.FileTypeID, dbo.tbl_Files.Author, dbo.tbl_Files.Title, " & _
                         " dbo.tbl_Files.Description, dbo.tbl_Files.Date, dbo.tbl_Files.FilePath, dbo.tbl_Files.FileExtension, " & _
                         " dbo.tbl_Files.AuthorOrganization, dbo.tbl_Files.CreatedBy, dbo.tbl_Files.CreatedDate, dbo.tbl_Files.UpdatedBy, " & _
                         " dbo.tbl_Files.UpdatedDate, dbo.tbl_Files.ApplySecurity, dbo.tbl_schoolFileType.fileType " & _
                         " FROM dbo.tbl_Files INNER JOIN dbo.tbl_schoolFileType ON dbo.tbl_Files.FileTypeID = dbo.tbl_schoolFileType.fileTypeId " & _
                         " ORDER BY dbo.tbl_Files.Date DESC "
        With gwFiles
            Try
                Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, qry)
                .DataSource = ds
                .DataBind()
            Catch ex As Exception
                'log.Error(ex.Message)
            End Try
        End With

    End Sub

    Protected Sub cboCategory_SelectedIndexChanged(sender As Object, e As Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs) Handles cboCategory.SelectedIndexChanged
        radFileListing.Visible = False
        gwFiles.Visible = False
        Select Case cboCategory.Text
            Case "My Files"
                loadStudentFiles()
                gwFiles.Visible = True
            Case "Tests and Assignments"
                loadStudentAssignments()
                radFileListing.Visible = True
        End Select
    End Sub

    Private Sub loadStudentAssignments()

        'Dim sql As String = "SELECT dbo.tbl_tests.ctr AS Test_Number, dbo.tbl_tests.subject AS Subject, dbo.tbl_tests.stream AS Stream, " & _
        '    " dbo.tbl_tests.schClass AS Class, dbo.tbl_tests.testId AS TestCode, dbo.tbl_tests.description AS Description, dbo.tbl_tests.testName AS TestName, " & _
        '    " CAST(dbo.tbl_tests.dtDate AS Date) AS TestDate, dbo.tbl_tests.highestPossibleMark AS ToBeMarkedOutOf,  " & _
        '    " dbo.tbl_Files.FileID, dbo.tbl_schoolFileType.fileType AS FileType, dbo.tbl_Files.FilePath, " & _
        '    " dbo.tbl_Files.CreatedDate AS DateUploaded FROM  dbo.tbl_schoolFileType INNER JOIN " & _
        '     "          dbo.tbl_Files ON dbo.tbl_schoolFileType.fileTypeId = dbo.tbl_Files.FileTypeID RIGHT OUTER JOIN " & _
        '  " dbo.tbl_tests ON dbo.tbl_Files.Title = dbo.tbl_tests.testId ORDER BY Test_Number DESC"

        Dim sql As String = "SELECT dbo.tbl_tests.ctr AS Test_Number, dbo.tbl_tests.subject AS Subject, dbo.tbl_tests.stream AS Stream, " & _
            " dbo.tbl_tests.schClass AS Class, dbo.tbl_tests.testId AS TestCode, dbo.tbl_tests.description AS Description, " & _
            " dbo.tbl_tests.testName AS TestName, dbo.tbl_tests.dtDate AS TestDate, dbo.tbl_tests.highestPossibleMark AS " & _
            " ToBeMarkedOutOf, dbo.tbl_Files.FileID, dbo.tbl_schoolFileType.fileType AS FileType, dbo.tbl_Files.FilePath, " & _
            " dbo.tbl_Files.CreatedDate AS DateUploaded, dbo.tbl_Files.DueDate " & _
            " FROM            dbo.tbl_schoolClasses INNER JOIN dbo.tbl_tests ON dbo.tbl_schoolClasses.schoolClass = dbo.tbl_tests.schClass " & _
            " INNER JOIN dbo.tbl_students ON dbo.tbl_schoolClasses.schoolClassId = dbo.tbl_students.schoolClassId LEFT OUTER JOIN " & _
            " dbo.tbl_schoolFileType INNER JOIN dbo.tbl_Files ON dbo.tbl_schoolFileType.fileTypeId = dbo.tbl_Files.FileTypeID ON " & _
            " dbo.tbl_tests.testId = dbo.tbl_Files.Title WHERE        (dbo.tbl_students.studentId ='" & CokkiesWrapper.StudentID & "') ORDER BY Test_Number DESC "
        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            db.ExecuteDataSet(CommandType.Text, sql)

            With radFileListing
                .DataSource = ds
                .DataBind()
            End With
        Catch ex As Exception
            lblMsg.Text = ex.Message
        End Try

    End Sub

End Class