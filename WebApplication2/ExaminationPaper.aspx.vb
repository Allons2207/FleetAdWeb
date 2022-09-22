Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Telerik.Web.UI


Public Class ExaminationPaper
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

            obj.loadComboBox(cboSubject, "SELECT  subjectId, subject FROM tbl_subjects", "subject", "subjectId")
            obj.loadComboBox(cboStreams, "SELECT  [streamId], [stream] FROM [dbo].[tbl_streams]", "stream", "streamId")
            '  obj.loadComboBox(cboClasses, "SELECT [schoolClassId], [schoolClass] FROM [dbo].[tbl_schoolClasses]", "schoolClass", "schoolClassId")
            obj.loadComboBox(cboExamBoard, "SELECT  examinationBoardId, examinationBoard FROM [tbl_examinationBoards]", "examinationBoard", "examinationBoardId")

            loadDataGrid()


        End If

    End Sub

    Protected Sub cmdSaveExam_Click(sender As Object, e As EventArgs) Handles cmdSaveExam.Click

        Dim sql As String = "INSERT [dbo].[tbl_examinations] ([examId], [examDate], [stream], [subject], [paper], [highestPossibleMark], [authourity]) " & _
                            " VALUES ('" & txtExamCode.Text & "', '" & rdExamDate.SelectedDate & "', '" & cboStreams.Text & "' , '" & cboSubject.Text & "', '" & txtPaper.Text & "'," & txtMaxMark.Text & ", '" & cboExamBoard.Text & "')"
        Try
            obj.ConnectionString = con
            obj.ExecuteNonQRY(sql)
        Catch
        End Try

        loadDataGrid()
    End Sub

    Private Sub loadDataGrid()

        Dim sql As String = "SELECT examId AS [Examination Code], examDate AS [Exam Date], stream AS Stream, subject AS Subject, " & _
                            " paper AS Paper, highestPossibleMark AS [Marked out Of], authourity AS [Exam Board] FROM dbo.tbl_examinations "

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            db.ExecuteDataSet(CommandType.Text, sql)

            With gwExams
                Try
                    .DataSource = ds
                    .DataBind()
                Catch ex As Exception
                    ' log.Error(ex.Message)
                End Try
            End With
        Catch ex As Exception
            ' log.Error(ex)
        End Try

    End Sub



End Class