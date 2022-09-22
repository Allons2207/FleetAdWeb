Imports Telerik.Web.UI
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing

Public Class ZBCRadioLicesing
    Inherits System.Web.UI.Page
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            loadRegNumbers()
            If Not IsNothing(Request.QueryString("op")) Then
                loadExistingLicenseDetails()
            End If

            If grantPageWriteCommandPermission(CokkiesWrapper.UserID, 1) = True Then
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

    Protected Sub cmdSave_Click(sender As Object, e As EventArgs) Handles cmdSave.Click

        obj.ConnectionString = con

        If txtFleetIDSearch.Text = "" Then
            obj.MessageLabel(lblMsg, "Please specify the vehicle's fleet number.", "Red")
            Exit Sub
        ElseIf obj.fnVehicleExists(txtFleetIDSearch.Text) = False
            obj.MessageLabel(lblMsg, "The specified Vehicle fleet number could not be found in vehicles data.", "Red")
            Exit Sub
        End If

        Dim qry As String = "DELETE FROM tbl_ZBCLicensing WHERE fleetId = '" & txtFleetIDSearch.Text & "' "

        obj.ConnectionString = con

        If obj.ExecuteNonQRY(qry) = 1 Then
            qry = "INSERT tbl_ZBCLicensing (fleetId,licenseNum,dateIssued,expiryDate,commentsNotes) VALUES ('" &
                     txtFleetIDSearch.Text & "','" & txtLicenseNumber.Text & "','" & rdDateIssued.SelectedDate & "','" & rdExpiryDate.SelectedDate & "','" & txtCommentsNotes.Text & "')"
            If obj.ExecuteNonQRY(qry) = 1 Then
                obj.MessageLabel(lblMsg, "Entry successfully captured!", "Green")
            End If
        Else
            obj.MessageLabel(lblMsg, "Error while trying to capture record!", "Red")
        End If

    End Sub


    Private Sub loadExistingLicenseDetails()
        Dim qry As String = "SELECT dbo.tbl_ZBCLicensing.fleetId, dbo.tbl_ZBCLicensing.licenseNum, dbo.tbl_ZBCLicensing.dateIssued," &
                            " dbo.tbl_ZBCLicensing.expiryDate, dbo.tbl_ZBCLicensing.commentsNotes, dbo.tbl_vehicleMakes.vehicleMake, " &
                            " dbo.tbl_vehicleModels.vehicleModel, tbl_vehicleData.registrationNumber AS RegNumber FROM   dbo.tbl_ZBCLicensing INNER JOIN dbo.tbl_vehicleModels INNER JOIN " &
                            " dbo.tbl_vehicleMakes ON dbo.tbl_vehicleModels.vehicleMakeId = dbo.tbl_vehicleMakes.vehicleMakeId INNER JOIN " &
                            " dbo.tbl_vehicleData ON dbo.tbl_vehicleModels.vehicleModelId = dbo.tbl_vehicleData.modelId ON " &
                            " dbo.tbl_ZBCLicensing.fleetId = dbo.tbl_vehicleData.fleetId WHERE " &
                            " (dbo.tbl_ZBCLicensing.fleetId = '" & (Request.QueryString("op")) & "')"

        obj.ConnectionString = con
        Dim ds As DataSet = obj.ExecuteDsQRY(qry)

        If ds.Tables(0).Rows.Count > 0 Then
            '  cboRegNumber.SelectedValue = ds.Tables(0).Rows(0).Item("regNumber")
            txtFleetIDSearch.Text = Request.QueryString("op")
            txtRegNo.Text = ds.Tables(0).Rows(0).Item("regNumber")

            txtFleetIDSearch.Enabled = False
            txtRegNo.Enabled = False

            txtFleetId.Text = ds.Tables(0).Rows(0).Item("fleetId")
            txtLicenseNumber.Text = ds.Tables(0).Rows(0).Item("licenseNum")
            txtMake.Text = ds.Tables(0).Rows(0).Item("vehicleMake")
            txtModel.Text = ds.Tables(0).Rows(0).Item("vehicleModel")
            txtCommentsNotes.Text = ds.Tables(0).Rows(0).Item("commentsNotes")

            rdDateIssued.SelectedDate = ds.Tables(0).Rows(0).Item("dateIssued")
            rdExpiryDate.SelectedDate = ds.Tables(0).Rows(0).Item("expiryDate")
        Else

        End If
    End Sub
    Private Sub loadRegNumbers()
        obj.loadComboBox(cboRegNumber, "SELECT DISTINCT [registrationNumber] FROM [dbo].[tbl_vehicleData] ORDER BY registrationNumber", "registrationNumber", "registrationNumber")
    End Sub


    Private Sub loadVehicleData()

        txtMake.Text = ""
        txtModel.Text = ""
        txtFleetId.Text = ""

        Dim qry As String = "SELECT DISTINCT dbo.tbl_vehicleMakes.vehicleMake, dbo.tbl_vehicleModels.vehicleModel, dbo.tbl_vehicleData.registrationNumber," &
                            " dbo.tbl_vehicleData.fleetId FROM dbo.tbl_vehicleModels INNER JOIN dbo.tbl_vehicleMakes ON " &
                            " dbo.tbl_vehicleModels.vehicleMakeId = dbo.tbl_vehicleMakes.vehicleMakeId INNER JOIN dbo.tbl_vehicleData ON " &
                            " dbo.tbl_vehicleModels.vehicleModelId = dbo.tbl_vehicleData.modelId WHERE (dbo.tbl_vehicleData.registrationNumber = '" & txtRegNo.Text & "')"

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

    Protected Sub cboRegNumber_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboRegNumber.SelectedIndexChanged
        loadVehicleData()
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
            Dim qry As String = "DELETE FROM tbl_ZBCLicensing WHERE (dbo.tbl_ZBCLicensing.fleetId = '" & (Request.QueryString("op")) & "')"
            obj.ConnectionString = con

            If obj.ExecuteNonQRY(qry) = 1 Then
                obj.MessageLabel(lblMsg, "ZBC Radio License Record successfully deleted.", "Green")
            Else
                obj.MessageLabel(lblMsg, "Error while trying to delete ZBC License entry.", "Red")
            End If
        Else
            obj.MessageLabel(lblMsg, "Error. System could not find the Vehicle Registration Number.", "Red")
        End If
    End Sub

    Protected Sub cmdClear0_Click(sender As Object, e As EventArgs) Handles cmdClear0.Click

        obj.ConnectionString = con
        txtFleetIDSearch.Text = obj.fnVehicleFleetIDNumFromRegNum(txtRegNo.Text)
        loadVehicleData()

    End Sub

    Protected Sub btnSearchByFleetID_Click(sender As Object, e As EventArgs) Handles btnSearchByFleetID.Click
        obj.ConnectionString = con
        txtRegNo.Text = obj.fnVehicleRegNumFromFleetID(txtFleetIDSearch.Text)
        loadVehicleData()

    End Sub



End Class