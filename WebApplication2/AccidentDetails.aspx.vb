
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Telerik.Web.UI
Imports System.IO


Public Class AccidentDetails
    Inherits System.Web.UI.Page
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        'Imports System.Drawing

        'Dim image1 As Image = Image.FromFile("C:\MyPictures\MyPicture.jpg")
        'Me.PictureBox1.Value = image1

        'Dim image2 As Image = Image.FromStream(imageStream)
        'Me.PictureBox2.Value = image2


        'Me.PictureBox1.Value = "=Fields.MyImageBinary" 'a binary data column
        'Me.PictureBox2.Value = "=Fields.MyImageURI" 'a data column containing an URI
        'Me.PictureBox3.Value = "C:\MyPictures\MyPicture.png" 'absolute file path
        'Me.PictureBox4.Value = ".\images\MyPicture.png" 'relative path
        'Me.PictureBox5.Value = "http://www.mysite.com/images/img1.gif" 'absolute URL

        If Not IsPostBack Then
            loadRegNumbers()
            loadVehicleUserLicences()
            loadVehicleUserNationalIDs()

            If Not IsNothing(Request.QueryString("op")) Then
                txtAccidentId.Text = Request.QueryString("op")
                loadExistingAccidentDetails()
                loadFiles()
            End If

            If grantPageWriteCommandPermission(CokkiesWrapper.UserID, 2) = True Then
                cmdSave.Enabled = True
                If Not IsNothing(Request.QueryString("op")) Then
                    cmdDelete.Enabled = True
                Else
                    cmdDelete.Enabled = False
                End If
            Else
                cmdSave.Enabled = False
            End If
        End If

    End Sub

    Private Sub loadVehicleUserLicences()
        obj.loadComboBox(cboLicense, "SELECT DISTINCT [licenseNumber] FROM [dbo].[tbl_vehicleUsers] ", "licenseNumber", "licenseNumber")
    End Sub

    Private Sub loadVehicleUserNationalIDs()
        obj.loadComboBox(cboNationalIDNos, "SELECT DISTINCT [nationalIDNo] FROM [dbo].[tbl_vehicleUsers] ", "nationalIDNo", "nationalIDNo")
    End Sub


    Private Sub loadRegNumbers()
        obj.loadComboBox(cboRegNumber, "SELECT DISTINCT [registrationNumber] FROM [dbo].[tbl_vehicleData] ORDER BY registrationNumber", "registrationNumber", "registrationNumber")
    End Sub


    Private Sub loadVehicleData()

        txtMake.Text = ""
        txtModel.Text = ""
        txtFleetId.Text = ""

        Dim qry As String = "SELECT dbo.tbl_vehicleMakes.vehicleMake, dbo.tbl_vehicleModels.vehicleModel, dbo.tbl_vehicleData.registrationNumber," &
                            " dbo.tbl_vehicleData.fleetId FROM dbo.tbl_vehicleModels INNER JOIN dbo.tbl_vehicleMakes ON " &
                            " dbo.tbl_vehicleModels.vehicleMakeId = dbo.tbl_vehicleMakes.vehicleMakeId INNER JOIN dbo.tbl_vehicleData ON " &
                            " dbo.tbl_vehicleModels.vehicleModelId = dbo.tbl_vehicleData.modelId WHERE (dbo.tbl_vehicleData.fleetId = '" & txtFleetIDSearch.Text & "')"

        Try
            obj.ConnectionString = con
            Dim ds As DataSet = obj.ExecuteDsQRY(qry)
            If ds.Tables(0).Rows.Count > 0 Then
                txtMake.Text = ds.Tables(0).Rows(0).Item("vehicleMake")
                txtModel.Text = ds.Tables(0).Rows(0).Item("vehicleModel")
                txtFleetId.Text = ds.Tables(0).Rows(0).Item("fleetId")
            Else
                obj.MessageLabel(lblMsg, "No such vehicle found under vehicle details.", "Yellow")
            End If
        Catch ex As Exception

        End Try

    End Sub

    Private Sub loadVehicleUserDetails()
        Dim qry As String = "SELECT DISTINCT [firstName], [surname], [department], [position] FROM [dbo].[tbl_vehicleUsers] WHERE [licenseNumber] = '" & cboLicense.Text & "'"

        Try
            obj.ConnectionString = con
            Dim ds As DataSet = obj.ExecuteDsQRY(qry)
            If ds.Tables(0).Rows.Count > 0 Then
                txtFirstName.Text = ds.Tables(0).Rows(0).Item("firstName")
                txtSurname.Text = ds.Tables(0).Rows(0).Item("surname")
                txtDept.Text = ds.Tables(0).Rows(0).Item("department")
                txtDesignation.Text = ds.Tables(0).Rows(0).Item("position")
                cboNationalIDNos.SelectedValue = ds.Tables(0).Rows(0).Item("nationalIDNo")
            End If
        Catch ex As Exception

        End Try

    End Sub


    Private Sub loadVehicleUserDetailsByNatIDNum()
        Dim qry As String = "SELECT DISTINCT [firstName], [surname], [department], [position], [licenseNumber], [NationalIDNo] FROM [dbo].[tbl_vehicleUsers] WHERE [licenseNumber] = '" & cboLicense.Text & "'"

        Try
            obj.ConnectionString = con
            Dim ds As DataSet = obj.ExecuteDsQRY(qry)
            If ds.Tables(0).Rows.Count > 0 Then
                txtFirstName.Text = ds.Tables(0).Rows(0).Item("firstName")
                txtSurname.Text = ds.Tables(0).Rows(0).Item("surname")
                txtDept.Text = ds.Tables(0).Rows(0).Item("department")
                txtDesignation.Text = ds.Tables(0).Rows(0).Item("position")
                cboNationalIDNos.SelectedValue = ds.Tables(0).Rows(0).Item("NationalIDNo")
            End If
        Catch ex As Exception

        End Try

    End Sub

    Protected Sub cboLicense_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboLicense.SelectedIndexChanged
        loadVehicleUserDetails()
    End Sub

    Protected Sub cmdSave_Click(sender As Object, e As EventArgs) Handles cmdSave.Click

        obj.ConnectionString = con

        If txtFleetIDSearch.Text = "" Then
            obj.MessageLabel(lblMsg, "Please specify the Fleet Number.", "Red")
            Exit Sub
            'ElseIf cboRegNumber.Text = "--Select--" Then
            '    obj.MessageLabel(lblMsg, "Please specify the Registration number.", "Red")
            '    Exit Sub
        ElseIf obj.fnVehicleExists(txtFleetIDSearch.Text) = False
            obj.MessageLabel(lblMsg, "The specified Vehicle fleet number could not be found in vehicles data.", "Red")
            Exit Sub

        ElseIf cboLicense.Text = "" Or cboLicense.Text = "--Select--" Then
            obj.MessageLabel(lblMsg, "The Vehicle User could not be established..!", "Red")
            Exit Sub
        End If

        If Not IsNothing(Request.QueryString("op")) Then
            updateAccidentDetails()
            Exit Sub
        Else
            Dim qry As String = "INSERT [tbl_accidentsIncidents] ([dtAccidentDate], [tTime], [location], [driverID], [fleetId], [accidentDetails])" &
                           "VALUES('" & rdInspectionDate.SelectedDate & "','" & txtAccidentTime.Text & "','" & txtLocation.Text &
                           "','" & cboLicense.SelectedValue & "','" & txtFleetIDSearch.Text & "','" & txtAccidentDetails.Text & "')"

            obj.ConnectionString = con

            If obj.ExecuteNonQRY(qry) = 1 Then
                obj.MessageLabel(lblMsg, "Accident details successfully saved.", "Green")
                setAccidentId()
            Else
                obj.MessageLabel(lblMsg, "Error while trying to save accident details.", "Red")
            End If
        End If


    End Sub

    Private Sub setAccidentId()

        txtAccidentId.Text = ""

        Dim sql As String = "SELECT TOP 1 [accidentIncidentId] FROM  [dbo].[tbl_accidentsIncidents] WHERE [dtAccidentDate] = '" & rdInspectionDate.SelectedDate &
            "' AND [tTime] = '" & txtAccidentTime.Text & "' AND [location] = '" & txtLocation.Text & "' AND [fleetId] = '" & txtFleetIDSearch.Text &
            "' AND [accidentDetails] = '" & txtAccidentDetails.Text & "' ORDER BY [accidentIncidentId] DESC "

        obj.ConnectionString = con
        Dim ds As DataSet = obj.ExecuteDsQRY(sql)
        If ds.Tables(0).Rows.Count > 0 Then
            txtAccidentId.Text = ds.Tables(0).Rows(0).Item("accidentIncidentId")
        End If

    End Sub
    Private Sub updateAccidentDetails()
        Dim qry As String = "UPDATE tbl_accidentsIncidents SET [dtAccidentDate] = '" & rdInspectionDate.SelectedDate & "' , [tTime] = '" & txtAccidentTime.Text &
            "', [location] = '" & txtLocation.Text & "', [driverID] = '" & cboLicense.SelectedValue & "', [fleetId] = '" & txtFleetIDSearch.Text &
            "', [accidentDetails] = '" & txtAccidentDetails.Text & "' WHERE accidentIncidentId = " & (Request.QueryString("op"))

        obj.ConnectionString = con

        If obj.ExecuteNonQRY(qry) = 1 Then
            obj.MessageLabel(lblMsg, "Accident details successfully updated.", "Green")
        Else
            obj.MessageLabel(lblMsg, "Error while trying to update accident details.", "Red")
        End If

    End Sub

    Protected Sub cboRegNumber_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboRegNumber.SelectedIndexChanged
        loadVehicleData()
    End Sub

    Protected Sub cboNationalIDNos_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboNationalIDNos.SelectedIndexChanged
        loadVehicleUserDetailsByNatIDNum()
    End Sub


    Private Sub loadExistingAccidentDetails()

        Dim qry As String = "SELECT DISTINCT dbo.tbl_vehicleMakes.vehicleMake, dbo.tbl_vehicleModels.vehicleModel, dbo.tbl_accidentsIncidents.fleetId, " &
                            " dbo.tbl_vehicleData.registrationNumber as RegNumber, dbo.tbl_vehicleUsers.nationalIDNo, dbo.tbl_vehicleUsers.licenseNumber, " &
                            " dbo.tbl_vehicleUsers.firstName, dbo.tbl_vehicleUsers.surname, dbo.tbl_vehicleUsers.department, " &
                            " dbo.tbl_vehicleUsers.position, dbo.tbl_accidentsIncidents.dtAccidentDate, dbo.tbl_accidentsIncidents.tTime, " &
                            " dbo.tbl_accidentsIncidents.location, dbo.tbl_accidentsIncidents.accidentDetails, dbo.tbl_accidentsIncidents.accidentIncidentId " &
                            " FROM  dbo.tbl_accidentsIncidents INNER JOIN dbo.tbl_vehicleModels INNER JOIN dbo.tbl_vehicleMakes ON " &
                            " dbo.tbl_vehicleModels.vehicleMakeId = dbo.tbl_vehicleMakes.vehicleMakeId INNER JOIN " &
                            " dbo.tbl_vehicleData ON dbo.tbl_vehicleModels.vehicleModelId = dbo.tbl_vehicleData.modelId ON " &
                            " dbo.tbl_accidentsIncidents.fleetId = dbo.tbl_vehicleData.fleetId INNER JOIN " &
                            " dbo.tbl_vehicleUsers ON dbo.tbl_accidentsIncidents.driverID = dbo.tbl_vehicleUsers.licenseNumber " &
                            " WHERE (dbo.tbl_accidentsIncidents.accidentIncidentId = " & (Request.QueryString("op")) & ")"

        obj.ConnectionString = con

        Dim ds As DataSet = obj.ExecuteDsQRY(qry)

        If ds.Tables(0).Rows.Count > 0 Then
            With ds.Tables(0).Rows(0)
                cboRegNumber.SelectedValue = .Item("regNumber")

                txtFleetIDSearch.Text = .Item("fleetId")
                txtRegNo.Text = .Item("regNumber")

                txtAccidentTime.Text = .Item("tTime")
                txtLocation.Text = .Item("location")

                txtAccidentDetails.Text = .Item("accidentDetails")
                rdInspectionDate.SelectedDate = .Item("dtAccidentDate")

                txtSearhFirstName.Text = .Item("firstName")
                txtSearchSurname.Text = .Item("surname")

                txtFirstName.Text = .Item("firstName")
                txtSurname.Text = .Item("surname")
                txtDept.Text = .Item("department")
                txtDesignation.Text = .Item("position")
                txtFleetId.Text = .Item("fleetId")
                txtMake.Text = .Item("vehicleMake")
                txtModel.Text = .Item("vehicleModel")
                cboLicense.SelectedValue = .Item("licenseNumber")
                cboNationalIDNos.SelectedValue = .Item("nationalIDNo")

            End With
        End If
    End Sub


    Public Function grantPageWriteCommandPermission(ByVal UserId As Integer, pageId As Integer) As Boolean
        grantPageWriteCommandPermission = False
        Dim qry As String = "SELECT * FROM [dbo].[tbl_userSysPermissions] WHERE [userId] = " & UserId & " AND [sysModuleSectionId] = " & pageId & " AND [sysWrite] = 1"

        Try
            obj.ConnectionString = con
            Dim ds As DataSet = obj.ExecuteDsQRY(qry)
            If ds.Tables(0).Rows.Count > 0 Then
                grantPageWriteCommandPermission = True
            End If
        Catch ex As Exception
        End Try
    End Function

    Protected Sub cmdDelete_Click(sender As Object, e As EventArgs) Handles cmdDelete.Click

        If Not IsNothing(Request.QueryString("op")) Then
            Dim qry As String = "DELETE FROM tbl_accidentsIncidents  WHERE (tbl_accidentsIncidents.accidentIncidentId = " & (Request.QueryString("op")) & ")"

            obj.ConnectionString = con

            If obj.ExecuteNonQRY(qry) = 1 Then
                obj.MessageLabel(lblMsg, "Accident details deleted.", "Green")
            Else
                obj.MessageLabel(lblMsg, "Error while trying to delete accident details.", "Red")
            End If
        Else
            obj.MessageLabel(lblMsg, "Error. System could not find the accident Id.", "Red")
        End If
    End Sub

    Protected Sub cmdClear0_Click(sender As Object, e As EventArgs) Handles cmdClear0.Click
        loadVehicleData()
    End Sub

    Protected Sub btnSearchByFleetID_Click(sender As Object, e As EventArgs) Handles btnSearchByFleetID.Click
        obj.ConnectionString = con
        txtRegNo.Text = obj.fnVehicleRegNumFromFleetID(txtFleetIDSearch.Text)
        loadVehicleData()
    End Sub

    Protected Sub cmdFind_Click(sender As Object, e As EventArgs) Handles cmdFind.Click

        If txtSearchSurname.Text = "" And txtSearhFirstName.Text = "" Then
            obj.MessageLabel(lblMsg, "Invalid search criteria. Please enter user firstname and/or surname.", "Red")
            Exit Sub
        End If


        Dim qry As String = "SELECT [nationalIDNo],[firstName], [surname], [department], [position], licenseNumber FROM [dbo].[tbl_vehicleUsers] WHERE Firstname LIKE '%" & txtSearhFirstName.Text &
            "%' AND surname LIKE '%" & txtSearchSurname.Text & "%'"

        cboNationalIDNos.ClearSelection()
        cboLicense.ClearSelection()
        txtFirstName.Text = ""
        txtSurname.Text = ""
        txtDept.Text = ""
        txtDesignation.Text = ""

        Try
            obj.ConnectionString = con
            Dim ds As DataSet = obj.ExecuteDsQRY(qry)
            If ds.Tables(0).Rows.Count > 0 Then
                If ds.Tables(0).Rows.Count = 1 Then

                    cboLicense.SelectedValue = ds.Tables(0).Rows(0).Item("licenseNumber")
                    txtFirstName.Text = ds.Tables(0).Rows(0).Item("firstName")
                    txtSurname.Text = ds.Tables(0).Rows(0).Item("surname")
                    txtDept.Text = ds.Tables(0).Rows(0).Item("department")
                    txtDesignation.Text = ds.Tables(0).Rows(0).Item("position")

                    cboLicense.SelectedValue = ds.Tables(0).Rows(0).Item("licenseNumber")
                    cboNationalIDNos.SelectedValue = ds.Tables(0).Rows(0).Item("nationalIDNo")
                Else
                    obj.MessageLabel(lblMsg, "Please refine your search criteria and/or text, more than one matching records have been found.", "Yellow")
                End If
            Else
                obj.MessageLabel(lblMsg, "No matching records have been found.", "Yellow")
            End If
        Catch ex As Exception
            obj.MessageLabel(lblMsg, "Error while searching Vehicle User details.", "Red")
        End Try
    End Sub

    Private Sub clearControls()

        obj.MessageLabel(lblMsg, "", "")
        cboNationalIDNos.ClearSelection()
        cboLicense.ClearSelection()
        txtFirstName.Text = ""
        txtSurname.Text = ""
        txtDept.Text = ""
        txtDesignation.Text = ""

        cboRegNumber.SelectedValue = ""



        txtFleetIDSearch.Text = ""
        txtRegNo.Text = ""
        txtAccidentTime.Text = ""
        txtLocation.Text = ""
        txtAccidentDetails.Text = ""
        rdInspectionDate.Clear()
        txtSearhFirstName.Text = ""
        txtSearchSurname.Text = ""
        txtFirstName.Text = ""
        txtSurname.Text = ""
        txtDept.Text = ""
        txtDesignation.Text = ""
        txtFleetId.Text = ""
        txtMake.Text = ""
        txtModel.Text = ""
        cboLicense.ClearSelection()
        cboNationalIDNos.ClearSelection()

    End Sub

    Protected Sub cmdClear_Click(sender As Object, e As EventArgs) Handles cmdClear.Click
        clearControls()
    End Sub

    Protected Sub cmdAddNewFile_Click(sender As Object, e As EventArgs) Handles cmdAddNewFile.Click
        If txtAccidentId.Text <> "" Then
            Response.Redirect("~/UploadFiles.aspx?accID=" & txtAccidentId.Text)
        Else
            obj.MessageLabel(lblMsg, "This accident has not been saved. First save before uploading accident files.", "Red")
        End If
    End Sub


    Private Sub loadFiles()

        Dim qry As String = "SELECT  dbo.lu_FileTypes.FileType,  dbo.tblFiles.FilePath, dbo.tblFiles.FileID, dbo.tblFiles.Title, dbo.tblFiles.Description," &
                            " dbo.tblFiles.FileDate, dbo.tblFiles.CreatedDate AS DateUploaded  FROM   dbo.tblFiles INNER JOIN " &
                        " dbo.lu_FileTypes ON dbo.tblFiles.FileTypeID = dbo.lu_FileTypes.FileTypeId " &
                        " WHERE(dbo.tblFiles.accidentId = " & txtAccidentId.Text & ")"

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

            '  FilePath = Server.HtmlDecode(item("FilePath").Text)

            If TypeOf e.Item Is GridDataItem Then
                Dim gridItem As GridDataItem = e.Item
                FilePath = gridItem("FilePath").Text
            End If

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
                        obj.MessageLabel(lblMsg, "Empty File.", "Red")
                    End If

                Catch ex As Exception
                    obj.MessageLabel(lblMsg, "An ERROR occurred..!", "Red")
                End Try

            Else
                ' ShowMessage("Error: File not found!!!", MessageTypeEnum.Error)
                obj.MessageLabel(lblMsg, "Error: File not found!!!", "Red")

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