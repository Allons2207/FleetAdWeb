
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Telerik.Web.UI

Public Class UnAllocateVehicleFromUsers
    Inherits System.Web.UI.Page
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            loadAllocatedRegNumberss()
            loadAllocatedVehicleUserLicences()
            loadAllocatedVehicleUserNationalIDs()
            loadAllocatedVehicleUserNames()

            If grantPageWriteCommandPermission(CokkiesWrapper.UserID, 1) = True Then
                cmdSave.Enabled = True
            Else
                cmdSave.Enabled = False
            End If
        End If

    End Sub

    Private Sub loadAllocatedVehicleUserNames()

        Dim qry As String = "SELECT TOP (100) PERCENT nationalIDNo, RTRIM(firstName) + ' ' + RTRIM(surname) AS driver " &
                            "FROM  dbo.tbl_vehicleUsers WHERE        (allocationStatusId = 1) ORDER BY firstName, surname "
        obj.loadComboBox(cboName, qry, "driver", "nationalIDNo")

    End Sub

    Private Sub loadAllocatedVehicleUserNationalIDs()
        obj.loadComboBox(cboNationalIDNos, "Select DISTINCT [nationalIDNo] FROM [dbo].[tbl_vehicleUsers] WHERE [allocationStatusId] = 1", "nationalIDNo", "nationalIDNo")
    End Sub
    Private Sub loadAllocatedVehicleUserLicences()
        obj.loadComboBox(cboLicense, "Select DISTINCT [licenseNumber] FROM [dbo].[tbl_vehicleUsers] WHERE [allocationStatusId] = 1", "licenseNumber", "licenseNumber")
    End Sub

    Private Sub loadAllocatedRegNumberss()
        obj.loadComboBox(cboRegistrationNumber, "Select DISTINCT [registrationNumber] FROM [dbo].[tbl_vehicleData] WHERE [allocationStatusId] = 1 ", "registrationNumber", "registrationNumber")
    End Sub

    Private Sub loadVehicleAndUserData()

        clearcontrols()
        'loadVehicleAndUserData

        Dim qry As String = "Select dbo.tbl_vehicleData.fleetId, dbo.tbl_vehicleData.registrationNumber, dbo.tbl_vehicleMakes.vehicleMake," &
                            " dbo.tbl_vehicleModels.vehicleModel, dbo.tbl_vehicleUsers.firstName, dbo.tbl_vehicleUsers.surname, " &
                            " dbo.tbl_vehicleUsers.department, dbo.tbl_vehicleUsers.position, dbo.tbl_vehicleUsers.licenseNumber, " &
                            " dbo.tbl_vehicleUsers.nationalIDNo FROM dbo.tbl_vehicleModels INNER JOIN " &
                            " dbo.tbl_vehicleMakes On dbo.tbl_vehicleModels.vehicleMakeId = dbo.tbl_vehicleMakes.vehicleMakeId INNER JOIN " &
                            " dbo.tbl_vehicleData On dbo.tbl_vehicleModels.vehicleModelId = dbo.tbl_vehicleData.modelId INNER JOIN " &
                            " dbo.tbl_vehicleUsers On dbo.tbl_vehicleData.FleetId = dbo.tbl_vehicleUsers.FleetId " &
                            " WHERE        (dbo.tbl_vehicleData.FleetId = '" & txtFleetIDSearch.Text & "')"

        Try
            obj.ConnectionString = con
            Dim ds As DataSet = obj.ExecuteDsQRY(qry)
            If ds.Tables(0).Rows.Count > 0 Then
                txtFleetID.Text = ds.Tables(0).Rows(0).Item("fleetId")
                txtMake.Text = ds.Tables(0).Rows(0).Item("vehicleMake")
                txtModel.Text = ds.Tables(0).Rows(0).Item("vehicleModel")
                cboNationalIDNos.SelectedValue = ds.Tables(0).Rows(0).Item("nationalIDNo")
                txtFirstName.Text = ds.Tables(0).Rows(0).Item("firstName")
                txtSurname.Text = ds.Tables(0).Rows(0).Item("surname")
                txtDept.Text = ds.Tables(0).Rows(0).Item("department")
                txtDesignation.Text = ds.Tables(0).Rows(0).Item("position")
                cboLicense.SelectedValue = ds.Tables(0).Rows(0).Item("licenseNumber")
            Else
                obj.MessageLabel(lblMsg, "Vehicle and Allocated User details not found under Allocations.!", "Red")
                Exit Sub
            End If
        Catch ex As Exception

        End Try

    End Sub

    Private Sub clearcontrols()

        txtDept.Text = ""
        txtDesignation.Text = ""
        txtFleetID.Text = ""
        txtMake.Text = ""
        txtModel.Text = ""
        cboNationalIDNos.ClearSelection()
        txtFirstName.Text = ""
        txtSurname.Text = ""
        txtDept.Text = ""
        txtDesignation.Text = ""
        cboLicense.SelectedValue = ""

        obj.MessageLabel(lblMsg, "", "")

    End Sub

    Protected Sub cmdSave_Click(sender As Object, e As EventArgs) Handles cmdSave.Click

        obj.ConnectionString = con

        If txtFleetID.Text = "" Then
            obj.MessageLabel(lblMsg, "Please specify the vehicle fleet number.", "Red")
            Exit Sub
        ElseIf obj.fnVehicleExists(txtFleetID.Text) = False
            obj.MessageLabel(lblMsg, "The specified Vehicle Fleet number could not be found in vehicles data.", "Red")
            Exit Sub
        ElseIf cboLicense.Text = "" Then
            obj.MessageLabel(lblMsg, "The User's licence number is invalid..", "Red")
            Exit Sub
        ElseIf obj.fnVehicleUserExists(cboLicense.SelectedValue) = False
            obj.MessageLabel(lblMsg, "The User's details could not be found.", "Red")
            Exit Sub
        End If


        Dim sql As String = "UPDATE [dbo].[tbl_vehicleData] SET [allocationStatusId] = 2, [currentUserId] = ''  WHERE [FleetId] = '" & txtFleetID.Text & "'"
        Try
            obj.ConnectionString = con
            If obj.ExecuteNonQRY(sql) = 1 Then

                sql = "UPDATE [dbo].[tbl_vehicleUsers] SET [allocationStatusId] = 2, [fleetId] = '', [regNumber] = '' WHERE [licenseNumber] = '" & cboLicense.Text & "'"

                If obj.ExecuteNonQRY(sql) = 1 Then

                    sql = "INSERT  tbl_vehicleAllocationHistory (registrationNumber,fleetID ,make,model ,allocationMode,driver," &
                           " department,nationalIDNumber,licenseNumber, dtDate)  VALUES ('" & txtRegNo.Text &
                           "','" & txtFleetID.Text & "','" & txtMake.Text & "','" & txtModel.Text & "','UnAllocated','" &
                            txtFirstName.Text & " " & txtSurname.Text & "','" & txtDept.Text & "','" & cboNationalIDNos.Text &
                            "','" & cboLicense.Text & "','" & Now & "')"

                    obj.ExecuteNonQRY(sql)

                    obj.MessageLabel(lblMsg, "Vehicle successfully un-allocated from user.", "Green")

                    loadAllocatedRegNumberss()
                    loadAllocatedVehicleUserLicences()
                    loadAllocatedVehicleUserNationalIDs()

                    Exit Sub
                End If
            Else
                obj.MessageLabel(lblMsg, "Error while trying to un-allocate vehicle to user.", "Red")
                Exit Sub
            End If

        Catch ex As Exception
        End Try

    End Sub

    Protected Sub cboRegistrationNumber_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboRegistrationNumber.SelectedIndexChanged

        cboLicense.ClearSelection()
        cboNationalIDNos.ClearSelection()

        loadVehicleAndUserData()

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

        cboLicense.ClearSelection()
        cboNationalIDNos.ClearSelection()
        obj.ConnectionString = con
        txtFleetIDSearch.Text = obj.fnVehicleFleetIDNumFromRegNum(txtRegNo.Text)
        loadVehicleAndUserData()

    End Sub

    Protected Sub cboNationalIDNos_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboNationalIDNos.SelectedIndexChanged

    End Sub

    Protected Sub cboName_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboName.SelectedIndexChanged
        cboNationalIDNos.SelectedValue = cboName.SelectedValue
    End Sub

    Protected Sub btnSearchByFleetID_Click(sender As Object, e As EventArgs) Handles btnSearchByFleetID.Click
        obj.ConnectionString = con
        txtRegNo.Text = obj.fnVehicleRegNumFromFleetID(txtFleetIDSearch.Text)
        cboLicense.ClearSelection()
        cboNationalIDNos.ClearSelection()

        loadVehicleAndUserData()

    End Sub

End Class