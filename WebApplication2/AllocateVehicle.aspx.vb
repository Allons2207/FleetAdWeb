
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Telerik.Web.UI
Public Class AllocateVehicle
    Inherits System.Web.UI.Page
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            loadUnAllocatedRegNumbers()
            loadUnAllocatedVehicleUserLicences()
            loadUnAllocatedVehicleUserNationalIDs()

            If grantPageWriteCommandPermission(CokkiesWrapper.UserID, 1) = True Then
                cmdSave.Enabled = True
            Else
                cmdSave.Enabled = False
            End If

        End If
    End Sub

    Private Sub loadUnAllocatedVehicleUserLicences()
        obj.loadComboBox(cboLicense, "SELECT DISTINCT  [licenseNumber] FROM [dbo].[tbl_vehicleUsers] WHERE [allocationStatusId] = 2", "licenseNumber", "licenseNumber")
    End Sub

    Private Sub loadUnAllocatedVehicleUserNationalIDs()
        obj.loadComboBox(cboNationalIDNos, "SELECT DISTINCT [nationalIDNo] FROM [dbo].[tbl_vehicleUsers] WHERE [tbl_vehicleUsers].[allocationStatusId] = 2", "nationalIDNo", "nationalIDNo")
    End Sub

    Private Sub loadUnAllocatedRegNumbers()
        obj.loadComboBox(cboRegistrationNumber, "SELECT DISTINCT [registrationNumber] FROM [dbo].[tbl_vehicleData] WHERE [tbl_vehicleData].[allocationStatusId] = 2 ORDER BY registrationNumber", "registrationNumber", "registrationNumber")
    End Sub

    Private Sub loadVehicleData()
        Dim qry As String = "SELECT dbo.tbl_vehicleMakes.vehicleMake, dbo.tbl_vehicleModels.vehicleModel, dbo.tbl_vehicleData.registrationNumber," &
                            " dbo.tbl_vehicleData.fleetId FROM dbo.tbl_vehicleModels INNER JOIN dbo.tbl_vehicleMakes ON " &
                            " dbo.tbl_vehicleModels.vehicleMakeId = dbo.tbl_vehicleMakes.vehicleMakeId INNER JOIN dbo.tbl_vehicleData ON " &
                            " dbo.tbl_vehicleModels.vehicleModelId = dbo.tbl_vehicleData.modelId WHERE   ([tbl_vehicleData].[allocationStatusId] = 2) AND  (dbo.tbl_vehicleData.FleetId = '" & txtFleetIDSearch.Text & "')"

        Try
            obj.ConnectionString = con
            Dim ds As DataSet = obj.ExecuteDsQRY(qry)
            If ds.Tables(0).Rows.Count > 0 Then
                txtMake.Text = ds.Tables(0).Rows(0).Item("vehicleMake")
                txtModel.Text = ds.Tables(0).Rows(0).Item("vehicleModel")
                txtFleetID.Text = ds.Tables(0).Rows(0).Item("fleetId")
            Else
                obj.MessageLabel(lblMsg, "No such vehicle found under UN-ALLOCATED vehicles.", "Yellow")
            End If
        Catch ex As Exception

        End Try


    End Sub

    Protected Sub cboFleetID_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboRegistrationNumber.SelectedIndexChanged
        txtMake.Text = ""
        txtModel.Text = ""
        txtFleetID.Text = ""

        loadVehicleData()

    End Sub

    Private Sub findUserDetailsFromIDNo()
        Dim qry As String = "SELECT [firstName], [surname], [department], [position], licenseNumber FROM [dbo].[tbl_vehicleUsers] WHERE [nationalIDNo] = '" & cboNationalIDNos.Text & "'"

        Try
            obj.ConnectionString = con
            Dim ds As DataSet = obj.ExecuteDsQRY(qry)
            If ds.Tables(0).Rows.Count > 0 Then
                txtFirstName.Text = ds.Tables(0).Rows(0).Item("firstName")
                txtSurname.Text = ds.Tables(0).Rows(0).Item("surname")
                cboLicense.SelectedValue = ds.Tables(0).Rows(0).Item("licenseNumber")
                txtDept.Text = ds.Tables(0).Rows(0).Item("department")
                txtDesignation.Text = ds.Tables(0).Rows(0).Item("position")
            End If
        Catch ex As Exception

        End Try

    End Sub

    Private Sub loadVehicleUserDetails()

        Dim qry As String = "SELECT [firstName], [surname], [department], [position], [nationalIDNo] FROM [dbo].[tbl_vehicleUsers] WHERE [tbl_vehicleUsers].[allocationStatusId] = 2 AND [tbl_vehicleUsers].[licenseNumber] = '" & txtLicenceNo.Text & "'"

        Try
            obj.ConnectionString = con
            Dim ds As DataSet = obj.ExecuteDsQRY(qry)
            If ds.Tables(0).Rows.Count > 0 Then
                txtFirstName.Text = ds.Tables(0).Rows(0).Item("firstName")
                txtSurname.Text = ds.Tables(0).Rows(0).Item("surname")
                txtDept.Text = ds.Tables(0).Rows(0).Item("department")
                txtDesignation.Text = ds.Tables(0).Rows(0).Item("position")
                cboNationalIDNos.SelectedValue = ds.Tables(0).Rows(0).Item("nationalIDNo")
            Else
                obj.MessageLabel(lblMsg, "Could not find the specified Vehicle User under UnAllocated vehicle Users.", "Red")
            End If
        Catch ex As Exception

        End Try

    End Sub

    Protected Sub cboLicense_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboLicense.SelectedIndexChanged
        loadVehicleUserDetails()
    End Sub

    Private Function TemporaryLicenceNumber(ByVal licenseNum As String) As Boolean
        TemporaryLicenceNumber = False
        Dim qry As String = "SELECT  * FROM [dbo].[tblTMPTemporaryLicenceNumbers] WHERE [LicenseNo] = '" & licenseNum & "'"
        obj.ConnectionString = con

        Dim ds As DataSet = obj.ExecuteDsQRY(qry)
        If ds.Tables(0).Rows.Count > 0 Then
            TemporaryLicenceNumber = True
        End If


    End Function
    Protected Sub cmdSave_Click(sender As Object, e As EventArgs) Handles cmdSave.Click

        obj.ConnectionString = con

        If txtFleetID.Text = "" Then
            obj.MessageLabel(lblMsg, "Please specify the vehicle Fleet Number, it cannot be empty.", "Red")
            Exit Sub
        ElseIf obj.fnVehicleExists(txtFleetID.Text) = False
            obj.MessageLabel(lblMsg, "The specified Vehicle Fleet number could not be found in vehicles data.", "Red")
            Exit Sub
        ElseIf txtLicenceNo.Text = "" Then
            obj.MessageLabel(lblMsg, "Please specify the vehicle user's License Number.", "Red")
            Exit Sub
        ElseIf obj.fnVehicleUserExists(txtLicenceNo.Text) = False
            obj.MessageLabel(lblMsg, "The specified Vehicle Registration number could not be found in vehicles data.", "Red")
            Exit Sub
        End If

        If TemporaryLicenceNumber(txtLicenceNo.Text) = True Then
            obj.MessageLabel(lblMsg, "The specified License Number is a temporary License Number. Please first update the User License number before allocating this user a vehicle.", "Red")
            Exit Sub
        End If

        Dim sql As String = "UPDATE [dbo].[tbl_vehicleData] SET [allocationStatusId] = 1, [currentUserId] = '" & txtLicenceNo.Text &
            "'  WHERE [FleetId] = '" & txtFleetID.Text & "'"

        Try
            obj.ConnectionString = con
            If obj.ExecuteNonQRY(sql) = 1 Then

                sql = "UPDATE [dbo].[tbl_vehicleUsers] SET [allocationStatusId] = 1, [fleetId] = '" & txtFleetID.Text &
                    "', [regNumber] = '" & txtRegNo.Text & "', [allocationDate] = '" & Today & "' WHERE [licenseNumber] = '" & txtLicenceNo.Text & "'"

                If obj.ExecuteNonQRY(sql) = 1 Then

                    sql = "INSERT  tbl_vehicleAllocationHistory (registrationNumber,fleetID ,make,model ,allocationMode,driver," &
                            " department,nationalIDNumber,licenseNumber, dtDate)  VALUES ('" & txtRegNo.Text &
                            "','" & txtFleetID.Text & "','" & txtMake.Text & "','" & txtModel.Text & "','Allocated','" &
                             txtFirstName.Text & " " & txtSurname.Text & "','" & txtDept.Text & "','" & obj.fnVehicleUserNationalIdFromLicenceNum(txtLicenceNo.Text) &
                             "','" & txtLicenceNo.Text & "','" & Now & "')"

                    obj.ExecuteNonQRY(sql)

                    obj.MessageLabel(lblMsg, "Vehicle successfully allocated to user.", "Green")

                    clearControls()

                    loadUnAllocatedRegNumbers()
                    loadUnAllocatedVehicleUserLicences()
                    loadUnAllocatedVehicleUserNationalIDs()

                    Exit Sub
                End If
            Else
                obj.MessageLabel(lblMsg, "Error while trying to allocate vehicle to user.", "Red")
                Exit Sub
            End If

        Catch ex As Exception


        End Try

    End Sub


    Protected Sub txtFleetID_TextChanged(sender As Object, e As EventArgs) Handles txtFleetID.TextChanged

    End Sub

    Protected Sub cboNationalIDNos_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboNationalIDNos.SelectedIndexChanged
        findUserDetailsFromIDNo()
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

    Protected Sub cmdClear0_Click(sender As Object, e As EventArgs) Handles cmdClear0.Click
        txtMake.Text = ""
        txtModel.Text = ""
        txtFleetID.Text = ""

        obj.ConnectionString = con
        txtFleetIDSearch.Text = obj.fnVehicleFleetIDNumFromRegNum(txtRegNo.Text)
        loadVehicleData()

    End Sub

    Protected Sub btnFindDriver_Click(sender As Object, e As EventArgs) Handles btnFindDriver.Click
        clearUserControls()
        loadVehicleUserDetails()

    End Sub

    Protected Sub btnSearchByFleetID_Click(sender As Object, e As EventArgs) Handles btnSearchByFleetID.Click
        obj.ConnectionString = con
        txtRegNo.Text = obj.fnVehicleRegNumFromFleetID(txtFleetIDSearch.Text)
        clearControls()
        loadVehicleData()
    End Sub

    Private Sub clearUserControls()
        txtFirstName.Text = ""
        txtSurname.Text = ""

        txtDept.Text = ""
        txtDesignation.Text = ""
        obj.MessageLabel(lblMsg, "", "")
    End Sub


    Protected Sub cmdFind_Click(sender As Object, e As EventArgs) Handles cmdFind.Click

        Dim qry As String = "SELECT [nationalIDNo],[firstName], [surname], [department], [position], licenseNumber FROM [dbo].[tbl_vehicleUsers] WHERE Firstname LIKE '%" & txtSearhFirstName.Text &
            "%' AND surname LIKE '%" & txtSearchSurname.Text & "%'"

        clearControls()

        Try
            obj.ConnectionString = con
            Dim ds As DataSet = obj.ExecuteDsQRY(qry)
            If ds.Tables(0).Rows.Count > 0 Then
                If ds.Tables(0).Rows.Count = 1 Then
                    cboNationalIDNos.SelectedValue = ds.Tables(0).Rows(0).Item("nationalIDNo")
                    cboLicense.SelectedValue = ds.Tables(0).Rows(0).Item("licenseNumber")
                    txtLicenceNo.Text = ds.Tables(0).Rows(0).Item("licenseNumber")
                    txtFirstName.Text = ds.Tables(0).Rows(0).Item("firstName")
                    txtSurname.Text = ds.Tables(0).Rows(0).Item("surname")
                    txtDept.Text = ds.Tables(0).Rows(0).Item("department")
                    txtDesignation.Text = ds.Tables(0).Rows(0).Item("position")
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

        obj.MessageLabel(lblMsg, "", "")

    End Sub

End Class