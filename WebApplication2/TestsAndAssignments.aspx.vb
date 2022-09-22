Imports System.IO
Imports Telerik.Web.UI
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing
Public Class Coarsework
    Inherits System.Web.UI.Page
    Private Shared ReadOnly log As log4net.ILog = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType)
    Dim insRec As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim objCBO As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = insRec.Database
    Dim con As String = db.ConnectionString

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If (CokkiesWrapper.UserID <= 0 AndAlso Not IsNumeric(CokkiesWrapper.UserID)) Then
            Response.Redirect("../Login.aspx")
            Exit Sub
        End If

        obj.ConnectionString = con
        Dim accessMode As String = obj.groupAccessPermissionsDs(CokkiesWrapper.UserGroup, 12)

        Select Case accessMode
            Case "AllowReadNRead"
            Case "ReadNReadOnly"
                cmdAddNew.Enabled = False
            Case "DenyAcces"
                Response.Redirect("~/AccessDenied.aspx")
                Exit Sub
            Case Else
                Response.Redirect("~/AccessDenied.aspx")
                Exit Sub
        End Select

        lblGridLabel.Text = ""

        objCBO.loadComboBox(cboStream, "SELECT  [streamId], [stream] FROM [dbo].[tbl_streams]", "stream", "streamId")
        objCBO.loadComboBox(cboClasses, "SELECT [schoolClassId], [schoolClass] FROM [dbo].[tbl_schoolClasses]", "schoolClass", "schoolClassId")
        objCBO.loadComboBox(cboSubjects, "SELECT [subject],[subjectId] FROM [dbo].[tbl_subjects]", "subject", "subjectId")

        loadDataGrid()

    End Sub

    Protected Sub cmdAddNew_Click(sender As Object, e As EventArgs) Handles cmdAddNew.Click

        Dim insRec As New commonFunction(CokkiesWrapper.thisConnectionName)

        insRec.ConnectionString = con

        Dim qryString As String = " INSERT INTO [dbo].[tbl_tests] " & _
             " ([testId] " & _
              " ,[subject] " & _
              " ,[testName] " & _
             "  ,[stream] " & _
             "  ,[dtDate] " & _
             "  ,[highestPossibleMark] " & _
             "  ,[description] " & _
             "  ,[schClass]) " & _
        " VALUES " & _
             " ('" & txtTestCode.Text & _
             "' ,'" & cboSubjects.Text & _
             "'  ,'[testName]'" & _
             "  ,'" & cboStream.Text & _
             "'  ,'" & rdDtDate.SelectedDate & _
             "'  ," & txtHighestPossibleMark.Text & _
             "  ,'" & txtNotes.Text & _
             "'  ,'" & cboClasses.Text & "') "

        saveAttachment()

        If insRec.ExecuteNonQRY(qryString) = 1 Then
            lblMsg.Text = "Test/Assignment entry has been saved successfully."
            loadDataGrid()
        Else
            lblMsg.Text = "Test/Assignment entry has not been saved successfully."
        End If


    End Sub

    Private Sub saveAttachment()
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
        Dim applySecurity As Integer = 1

        Dim qry As String = "INSERT INTO [tbl_Files]([Date], [FileTypeID],[Title],[Author], [Description], [FilePath], [FileExtension], [AuthorOrganization], [ApplySecurity],[CreatedDate], [CreatedBy], " & _
                        " [DueDate] ) VALUES ( '" & rdDtDate.SelectedDate.ToString & "',1002,'" & txtTestCode.Text & "','" & CokkiesWrapper.UserName & "', '" & txtNotes.Text & _
                        "','" & filepath & "', '" & fileExt & "', '""'," & applySecurity & " ,'" & Now & "'," & CokkiesWrapper.UserID & ", '" & rdpDueDate.SelectedDate & "') "

        Try
            obj.ConnectionString = con
            obj.ExecuteNonQRY(qry)
        Catch
        End Try


    End Sub

    Private Sub loadDataGrid()
        '   Dim sql As String = "SELECT ctr as [Test Number],  [subject] AS [Subject] ,[stream], [schClass], [testId], [testName] , [dtDate], [highestPossibleMark] ,[description] FROM tbl_tests ORDER BY ctr DESC"
       
        Dim sql As String = "SELECT dbo.tbl_tests.ctr AS Test_Number, dbo.tbl_tests.subject AS Subject, dbo.tbl_tests.stream AS Stream, " & _
              " dbo.tbl_tests.schClass AS Class, dbo.tbl_tests.testId AS TestCode, dbo.tbl_tests.description AS Description, dbo.tbl_tests.testName AS TestName, " & _
              " CAST(dbo.tbl_tests.dtDate AS Date) AS TestDate, dbo.tbl_tests.highestPossibleMark AS ToBeMarkedOutOf,  " & _
              " dbo.tbl_Files.FileID, dbo.tbl_schoolFileType.fileType AS FileType, dbo.tbl_Files.FilePath, " & _
              " dbo.tbl_Files.CreatedDate AS DateUploaded FROM  dbo.tbl_schoolFileType INNER JOIN " & _
               "          dbo.tbl_Files ON dbo.tbl_schoolFileType.fileTypeId = dbo.tbl_Files.FileTypeID RIGHT OUTER JOIN " & _
            " dbo.tbl_tests ON dbo.tbl_Files.Title = dbo.tbl_tests.testId ORDER BY Test_Number DESC"

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            db.ExecuteDataSet(CommandType.Text, sql)

            With radFileListing
                Try
                    .DataSource = ds
                    .DataBind()
                Catch ex As Exception
                    log.Error(ex.Message)
                End Try
            End With
        Catch ex As Exception
            log.Error(ex)
        End Try


    End Sub

    Protected Sub cmdAddQuestions_Click(sender As Object, e As EventArgs) Handles cmdAddQuestions.Click
        Response.Redirect("~/testQuestions.aspx")
    End Sub

    Private Sub radFileListing_ItemCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs) Handles radFileListing.ItemCommand

        lblGridLabel.Text = ""

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
                lblGridLabel.Text = "No file attachment found...!!"


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