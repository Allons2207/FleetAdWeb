Imports System
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.IO
Imports System.IO.Compression

Public Class DataTransfer
    Inherits System.Web.UI.Page

    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


        ' loadExistingBackUps()


    End Sub

    Protected Sub cmdBackUp_Click(sender As Object, e As EventArgs) Handles cmdBackUp.Click

        Try
            Dim destdir As String = Server.MapPath("~/DatabaseBackUps")

            If System.IO.Directory.Exists(destdir) Then
                Dim ext As String = DateTime.Now.ToString("ddMMyyyy_HHmmss") & ".Bak'"
                Dim sql As String = "Backup database SchoolAd to disk='" & destdir & "/SchoolAd" & ext
                obj.ConnectionString = con

                If obj.ExecuteNonQRY(sql) = 1 Then
                    ''zip the file...!!
                Else
                    ' MsgBox(ex.Message)
                End If
                ' Dim startPath As String = Path.GetFullPath(fuFileUpload.FileName)
            End If

            '  Dim Ext As String = Path.GetExtension(FilePath)

            '  fuFileUpload.SaveAs(Server.MapPath("~/DatabaseBackUps/") & Path.GetFileName(fuFileUpload.FileName))

            ' Dim startPath As String = Server.MapPath("~\DatabaseBackUps\") & Path.GetFileName(fuFileUpload.FileName)

            ' Dim strPath As String = fuFileUpload

            ' Dim zipPath As String = Server.MapPath("~\DatabaseBackUps\") & Path.GetFileName(fuFileUpload.FileName) & ".zip"
            '  Dim extractPath As String = Server.MapPath("~\DatabaseBackUps\")

            ' ZipFile.CreateFromDirectory(startPath, zipPath)

            '  ZipFile.ExtractToDirectory(zipPath, extractPath)

            ' Save(FilePath, Ext)

            'Dim startPath As String = "c:\example\start"
            'Dim zipPath As String = "c:\example\result.zip"
            'Dim extractPath As String = "c:\example\extract"

        Catch ex As Exception

            ' log.Error(ex)
            ' ShowMessage("Error while uplading file...", MessageTypeEnum.Error)

        End Try

     



        ' Save(txtFilePath.Text, Path.GetExtension(txtFilePath.Text))
    End Sub

    Private Sub loadExistingBackUps()


        Dim workTable As DataTable = New DataTable("Customers")

        workTable.Columns.Add("CustLName", Type.GetType("System.String"))

        workTable(0).Item("CustLName") = "fymt"
        ' radGrdFiles.DataSource = ds
        radGrdFiles.DataBind()

        Exit Sub

        Try
            Dim str As String = ""
            Dim fileEntries As String() = Directory.GetFiles(Server.MapPath("~/DatabaseBackUps"))

            Dim fileName As String

            Dim ds As New DataSet

            ds.Tables.Add(New DataTable)

            ds.Tables(0).Columns.Add(New DataColumn("fileNem"))

            For Each fileName In fileEntries
                ' ProcessFile(fileName)
                Dim dr As DataRow = ds.Tables(0).NewRow
                ' dr("fileNem") = fileName.ToString

                dr("fileNem") = "khkk"

                ds.Tables(0).Rows.Add(dr)

            Next fileName

            With radGrdFiles
                If ds.Tables.Count > 0 Then
                    .DataSource = ds
                    .DataBind()
                Else
                    .DataSource = String.Empty
                    .DataBind()
                End If
            End With
            'With gwAttendance
            '    .DataSource = ds
            'RadGrid1.DataSource = String.Empty
            '    .DataBind()
            'End With

        Catch ex As Exception

            'lblMsg.BackColor = Color.Red
            'lblMsg.ForeColor = Color.White
            'lblMsg.Text = "Grid not loaded successfully, Please check your searching criteria"

            'log.Error(ex.Message)

        End Try
    End Sub
End Class