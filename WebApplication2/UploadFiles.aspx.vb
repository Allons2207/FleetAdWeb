Imports Telerik.Web.UI
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.IO

Public Class UploadFiles
    Inherits System.Web.UI.Page
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            If Not IsNothing(Request.QueryString("accID")) Then
                '  txtFileID.Text = Request.QueryString("accID")
                obj.loadComboBox(cboFileType, "SELECT [FileType], [FileTypeId] FROM [dbo].[lu_FileTypes] ORDER BY [FileType]", "FileType", "FileTypeId")
            End If
        End If
    End Sub

    Protected Sub cmdSaveFile_Click(sender As Object, e As EventArgs) Handles cmdSaveFile.Click

        If Not IsNumeric(txtFileID.Text) Then

            If fuFileUpload.HasFile Then

                Try

                    Dim FilePath As String = Path.GetFileName(fuFileUpload.FileName)
                    Dim Ext As String = Path.GetExtension(FilePath)

                    fuFileUpload.SaveAs(Server.MapPath("~/FileUploads/") & FilePath)

                    Save(FilePath, Ext)

                Catch ex As Exception

                    obj.MessageLabel(lblError, "Error while uploading file..", "Red")

                End Try

            Else

                obj.MessageLabel(lblError, "Please first select the file you want to upload before saving..!", "Red")

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

        If Not IsNothing(Request.QueryString("accID")) Then

            Dim sql As String = "INSERT [tblFiles] ([FileTypeID],[Title],[Description],[FileDate], [FilePath],[FileExtension]," &
            "[CreatedBy], [CreatedDate],[ApplySecurity], [accidentId]) " &
            " VALUES (" & cboFileType.SelectedValue & ",'" & txtTitle.Text & "','" & txtDescription.Text & "','" & rdDtDate.selecteddate & "','" &
            filepath & "','" & fileExt & "'," & CokkiesWrapper.UserID & ",'" & Now & "'," & applySecurity & ", " & Request.QueryString("accID") & ")"

            Try
                obj.ConnectionString = con
                If obj.ExecuteNonQRY(sql) = 1 Then
                    obj.MessageLabel(lblError, "File successfully save!", "Green")
                End If
            Catch ex As Exception
                obj.MessageLabel(lblError, "An error occurred while trying to save file..!", "Red")
            End Try
        End If

    End Sub

End Class