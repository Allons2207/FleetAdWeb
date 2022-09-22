
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Telerik.Web.UI
Imports System.IO
Public Class FileLibrary
    Inherits System.Web.UI.Page

    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


        loadFiles()
    
    End Sub

    Private Sub loadFiles()

        Dim qry As String = "SELECT dbo.tbl_Files.FileID, dbo.tbl_Files.FileTypeID, dbo.tbl_Files.Author, dbo.tbl_Files.Title, " & _
                           " dbo.tbl_Files.Description, dbo.tbl_Files.Date, dbo.tbl_Files.FilePath, dbo.tbl_Files.FileExtension, " & _
                           " dbo.tbl_Files.AuthorOrganization, dbo.tbl_Files.CreatedBy, dbo.tbl_Files.CreatedDate, dbo.tbl_Files.UpdatedBy, " & _
                           " dbo.tbl_Files.UpdatedDate, dbo.tbl_Files.ApplySecurity, dbo.tbl_schoolFileType.fileType " & _
                           " FROM dbo.tbl_Files INNER JOIN dbo.tbl_schoolFileType ON dbo.tbl_Files.FileTypeID = dbo.tbl_schoolFileType.fileTypeId " & _
                           " ORDER BY dbo.tbl_Files.Date DESC "

        With radFileListing
            Try
                Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, qry)
                .DataSource = ds
                .DataBind()
            Catch ex As Exception
                'log.Error(ex.Message)
            End Try
        End With

    End Sub

    Private Sub radFileListing_ItemCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs) Handles radFileListing.ItemCommand

        If e.CommandName = "Download" Then

            '  Dim objFiles As New BusinessLogic.Files(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)

            Dim index As Integer = Convert.ToInt32(e.Item.ItemIndex.ToString)
            Dim item As GridDataItem = radFileListing.Items(index)
            Dim FilePath As String

            FilePath = Server.HtmlDecode(item("FilePath").Text)

            With Response

                .Clear()
                .ClearContent()
                .ClearHeaders()
                .BufferOutput = True

            End With

            If File.Exists(Request.PhysicalApplicationPath & FilePath) Or File.Exists(Server.MapPath("~/FileUploads/" & FilePath)) Then

                Dim oFileStream As FileStream
                Dim fileLen As Long

                Try

                    oFileStream = File.Open(Server.MapPath("~/FileUploads/" & FilePath), FileMode.Open, FileAccess.Read, FileShare.None)
                    fileLen = oFileStream.Length

                    Dim ByteFile(fileLen - 1) As Byte

                    If fileLen > 0 Then
                        oFileStream.Read(ByteFile, 0, oFileStream.Length - 1)
                        oFileStream.Close()

                        With Response

                            .AddHeader("Content-Disposition", "attachment; filename=" & FilePath.Replace(" ", "_"))
                            .ContentType = "application/octet-stream"
                            .BinaryWrite(ByteFile)
                            '.WriteFile(Server.MapPath("~/FileUploads/" & FilePath))

                            ' objFiles.UpdateDownloadCount(Server.HtmlDecode(item("FileID").Text))

                            .End()
                            HttpContext.Current.ApplicationInstance.CompleteRequest()

                        End With

                    Else
                        ' log.Error("Empty File...")
                    End If

                Catch ex As Exception

                End Try

            Else

                ' ShowMessage("Error: File not found!!!", MessageTypeEnum.Error)

            End If
        End If

        If e.CommandName = "View" Then

            Dim index1 As Integer = Convert.ToInt32(e.Item.ItemIndex.ToString)
            Dim item1 As GridDataItem = radFileListing.Items(index1)
            Dim FileID As Integer

            FileID = Server.HtmlDecode(item1("FileID").Text)

            ' Response.Redirect("~/FilesMapping.aspx?id=" & FileID)

        End If

    End Sub

    Protected Sub radFileListing_NeedDataSource(sender As Object, e As GridNeedDataSourceEventArgs) Handles radFileListing.NeedDataSource

    End Sub
End Class