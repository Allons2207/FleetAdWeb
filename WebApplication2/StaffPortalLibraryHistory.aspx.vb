Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data

Public Class StaffPortalLibraryHistory
    Inherits System.Web.UI.Page

    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        LibraryHistory(CokkiesWrapper.StudentID)
    End Sub

    Sub LibraryHistory(ByVal id As String)

        Dim sql As String = "SELECT [bookId],[title],[authour],[serialNumber],[bookType],[borrowerName],[borrowerType],[borrowerIdNumber],[dateLoanedOut],[loanDays] ,[dueDate] ,[returnDate],[returnStatus],[penaltyAmt],[comments],[penaltyPaid] FROM [SchoolAd].[dbo].[tbl_libraryBookLending] where borrowerIdNumber = '" & CokkiesWrapper.UserID & "'"

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            If ds.Tables.Count > 0 Then

                With gwLibrary

                    .DataSource = ds
                    .DataBind()

                End With
            End If
        Catch ex As Exception

            '  log.Error(ex)
        End Try

    End Sub
End Class