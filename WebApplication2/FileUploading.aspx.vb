
Imports System.IO
Imports Telerik.Web.UI
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing

Public Class FileUploading
    Inherits System.Web.UI.Page
    Private Shared ReadOnly log As log4net.ILog = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType)
    Dim insRec As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim objCBO As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = insRec.Database
    Dim con As String = db.ConnectionString

    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then
            If (CokkiesWrapper.UserID <= 0 AndAlso Not IsNumeric(CokkiesWrapper.UserID)) Then
                Response.Redirect("../Login.aspx")
                Exit Sub
            End If

            objCBO.loadComboBox(cboSchoolFileType, "SELECT [fileTypeId], [fileType] FROM [dbo].[tbl_schoolFileType]", "fileType", "fileTypeId")
            objCBO.loadComboBox(cboGrade, "SELECT [streamId], [stream] FROM [dbo].[tbl_streams]", "stream", "streamId")
            objCBO.loadComboBox(cboSubject, "SELECT [subjectId], [subject] FROM [dbo].[tbl_subjects]", "subject", "subjectId")
        End If

    End Sub

    Protected Sub cmdSave_Click(sender As Object, e As EventArgs) Handles cmdSave.Click
        If Not IsNumeric(txtFileID.Text) Then

            If fuFileUpload.HasFile Then

                Try

                    Dim FilePath As String = Path.GetFileName(fuFileUpload.FileName)
                    Dim Ext As String = Path.GetExtension(FilePath)

                    fuFileUpload.SaveAs(Server.MapPath("~/FileUploads/") & FilePath)

                    Save(FilePath, Ext)

                Catch ex As Exception

                    ' log.Error(ex)
                    ' ShowMessage("Error while uplading file...", MessageTypeEnum.Error)

                End Try

            Else

                ' ShowMessage("Please select a file before saving!!", MessageTypeEnum.Error)

            End If

        Else

            Save(txtFilePath.Text, Path.GetExtension(txtFilePath.Text))

        End If
    End Sub

    Private Sub save(filepath As String, fileExt As String)
        Dim applySecurity As Integer = 0

        If chkSecurity.Checked = True Then
            applySecurity = 1
        End If

        Dim qry As String = "INSERT INTO [tbl_Files]([Date], [FileTypeID],[Title],[Author], [Description], [FilePath], [FileExtension], [AuthorOrganization], [ApplySecurity],[CreatedDate], [CreatedBy]" & _
                        "		) VALUES ( '" & rdDtDate.SelectedDate.ToString & "', " & cboSchoolFileType.SelectedValue & ",'" & txtTitle.Text & "','" & CokkiesWrapper.UserName & "', '" & txtDescription.Text & _
                        "','" & filepath & "', '" & fileExt & "', '""'," & applySecurity & " ,'" & Now & "'," & CokkiesWrapper.UserID & ") "

        Try
            obj.ConnectionString = con
            obj.ExecuteNonQRY(qry)
        Catch
        End Try


    End Sub

    Private Sub loadGrid()
        '    Dim sql As String

        '    sql = "SELECT F.*, O.fileType As FileType FROM tblFiles F inner join tbl_schoolFileType O on F.FileTypeID = O.fileTypeId "

        '    Try
        '        Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
        '        db.ExecuteDataSet(CommandType.Text, sql)

        '        With radFileListing
        '            Try
        '                .DataSource = ds
        '                .DataBind()
        '            Catch ex As Exception
        '                log.Error(ex.Message)
        '            End Try
        '        End With
        '    Catch ex As Exception
        '        log.Error(ex)
        '    End Try
        'End Sub

    End Sub
End Class