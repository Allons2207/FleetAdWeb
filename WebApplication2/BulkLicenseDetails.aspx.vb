Imports Telerik.Web.UI
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data

Public Class BulkLicenseDetails
    Inherits System.Web.UI.Page
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            obj.loadComboBox(cboLicenseType, "SELECT licenseTypeId,licenseType FROM lu_LicenseTypes ORDER BY licenseType", "licenseType", "licenseTypeId")

            loadVehiclesList()

            If Not IsNothing(Request.QueryString("op")) Then
                loadExistingLicenseDetails()
            End If

        End If

    End Sub

    Protected Sub cmdSave_Click(sender As Object, e As EventArgs) Handles cmdSave.Click
        Dim qry As String = ""

        If Not IsNothing(Request.QueryString("op")) Then

            qry = "UPDATE tbl_bulkLicensing SET LicenseTypeID = " & cboLicenseType.SelectedValue & ",LicenseNo = '" & txtLicenseNo.Text &
                "',Details='" & txtDetails.Text & "',dateIssued='" & rdDateIssued.SelectedDate & "',expiryDate='" & rdExpiryDate.SelectedDate & "'"

            obj.ConnectionString = con

            If obj.ExecuteNonQRY(qry) = 1 Then
                saveVehiclesOnLicence()
                obj.MessageLabel(lblMsg, "Record successfully saved.", "Green")
            Else
                obj.MessageLabel(lblMsg, "Error while trying to save License Details.", "Red")
            End If
        Else
            qry = "SELECT * FROM tbl_bulkLicensing WHERE LicenseNo = '" & txtLicenseNo.Text & "'"

            If obj.recordExists(qry) Then
                obj.MessageLabel(lblMsg, "Error. License Number already exists.", "Red")
                Exit Sub
            End If

            qry = "INSERT tbl_bulkLicensing(LicenseTypeID,LicenseNo,Details,dateIssued,expiryDate) VALUES " &
            "(" & cboLicenseType.SelectedValue & ",'" & txtLicenseNo.Text & "','" & txtDetails.Text & "','" & rdDateIssued.SelectedDate & "','" & rdExpiryDate.SelectedDate & "')"

            obj.ConnectionString = con

            If obj.ExecuteNonQRY(qry) = 1 Then
                saveVehiclesOnLicence()
                obj.MessageLabel(lblMsg, "Record successfully saved.", "Green")
            Else
                obj.MessageLabel(lblMsg, "Error while trying to save License Details.", "Red")
            End If
        End If

    End Sub

    Private Sub saveVehiclesOnLicence()

        Dim sql As String = ""
        Try
            obj.ConnectionString = con
            sql = "DELETE FROM tbl_BulkLicenseVehicles WHERE [licenseNumber] = '" & txtLicenseNo.Text & "'"
            obj.ExecuteNonQRY(sql)

            For Each gridRow As GridDataItem In gwList.Items
                If gridRow.Selected Then
                    sql = "INSERT tbl_BulkLicenseVehicles (fleetId,licenseNumber) VALUES ('" & gridRow("FleetId").Text & "','" & txtLicenseNo.Text & "')"
                    obj.ExecuteNonQRY(sql)
                End If
            Next
        Catch ex As Exception

        End Try
    End Sub
    Private Sub loadExistingLicenseDetails()

        Dim qry As String = " SELECT  dbo.tbl_bulkLicensing.entryNumber, dbo.tbl_bulkLicensing.LicenseTypeID, dbo.tbl_bulkLicensing.LicenseNo, " &
                            " dbo.tbl_bulkLicensing.Details, dbo.tbl_bulkLicensing.dateIssued AS DateIssued, dbo.tbl_bulkLicensing.expiryDate AS ExpiryDate, " &
                            " DATEDIFF(MM, GETDATE(), dbo.tbl_bulkLicensing.expiryDate) AS MonthsToExpiryDate, dbo.lu_LicenseTypes.licenseType AS LicenseType " &
                            " FROM  dbo.tbl_bulkLicensing INNER JOIN  dbo.lu_LicenseTypes ON dbo.tbl_bulkLicensing.LicenseTypeID = dbo.lu_LicenseTypes.licenseTypeId " &
                            " WHERE(dbo.tbl_bulkLicensing.LicenseNo = '" & (Request.QueryString("op")) & "') "

        Try
            obj.ConnectionString = con
            Dim ds As DataSet = obj.ExecuteDsQRY(qry)
            If ds.Tables(0).Rows.Count > 0 Then
                cboLicenseType.SelectedValue = ds.Tables(0).Rows(0).Item("LicenseTypeID")
                txtLicenseNo.Text = ds.Tables(0).Rows(0).Item("LicenseNo")
                txtLicenseNo.Enabled = False
                txtDetails.Text = ds.Tables(0).Rows(0).Item("Details")
                rdDateIssued.SelectedDate = ds.Tables(0).Rows(0).Item("DateIssued")
                rdExpiryDate.SelectedDate = ds.Tables(0).Rows(0).Item("ExpiryDate")
            End If
            showExistingVehiclesOnLicense()
        Catch ex As Exception

        End Try

    End Sub

    Private Sub showExistingVehiclesOnLicense()
        Dim sql As String = ""
        Try
            For Each gridRow As GridDataItem In gwList.Items
                'tbl_BulkLicenseVehicles (fleetId,licenseNumber)
                sql = "SELECT * FROM tbl_BulkLicenseVehicles WHERE licenseNumber = '" & txtLicenseNo.Text &
                                     "' AND [fleetId] = '" & gridRow("FleetId").Text & "'"

                obj.ConnectionString = con
                Dim ds As DataSet = obj.ExecuteDsQRY(sql)
                If ds.Tables(0).Rows.Count > 0 Then
                    gridRow.Selected = True
                End If
            Next
        Catch ex As Exception

        End Try
    End Sub
    Private Sub loadVehiclesList()
        ViewState("VehiclesList") = Nothing
        Dim qry As String = "SELECT DISTINCT TOP (100) PERCENT dbo.tbl_vehicleTypes.vehicleType AS VehicleCategory, " &
                            " dbo.tbl_vehicleData.fleetId AS FleetId, dbo.tbl_vehicleData.registrationNumber AS RegNumber, " &
                            " dbo.tbl_vehicleMakes.vehicleMake AS Make, dbo.tbl_vehicleModels.vehicleModel AS Model " &
                            " FROM  dbo.tbl_vehicleModels INNER JOIN dbo.tbl_vehicleMakes ON dbo.tbl_vehicleModels.vehicleMakeId = " &
                            " dbo.tbl_vehicleMakes.vehicleMakeId INNER JOIN dbo.tbl_vehicleData ON dbo.tbl_vehicleModels.vehicleModelId = " &
                            " dbo.tbl_vehicleData.modelId INNER JOIN dbo.tbl_vehicleTypes ON dbo.tbl_vehicleData.vehicleTypeId = " &
                            " dbo.tbl_vehicleTypes.vehicleTypeId WHERE (dbo.tbl_vehicleData.disposalStatusId <> 1) " &
                            " ORDER BY VehicleCategory, Make, Model, RegNumber "

        obj.ConnectionString = con

        Dim ds As DataSet = obj.ExecuteDsQRY(qry)

        gwList.DataSource = ds
        gwList.DataBind()
        ViewState("VehiclesList") = ds

    End Sub

    Protected Sub gwList_NeedDataSource(sender As Object, e As GridNeedDataSourceEventArgs) Handles gwList.NeedDataSource
        'Dim qry As String = "SELECT DISTINCT TOP (100) PERCENT dbo.tbl_vehicleTypes.vehicleType AS VehicleCategory, " &
        '                    " dbo.tbl_vehicleData.fleetId AS FleetId, dbo.tbl_vehicleData.registrationNumber AS RegNumber, " &
        '                    " dbo.tbl_vehicleMakes.vehicleMake AS Make, dbo.tbl_vehicleModels.vehicleModel AS Model " &
        '                    " FROM  dbo.tbl_vehicleModels INNER JOIN dbo.tbl_vehicleMakes ON dbo.tbl_vehicleModels.vehicleMakeId = " &
        '                    " dbo.tbl_vehicleMakes.vehicleMakeId INNER JOIN dbo.tbl_vehicleData ON dbo.tbl_vehicleModels.vehicleModelId = " &
        '                    " dbo.tbl_vehicleData.modelId INNER JOIN dbo.tbl_vehicleTypes ON dbo.tbl_vehicleData.vehicleTypeId = " &
        '                    " dbo.tbl_vehicleTypes.vehicleTypeId WHERE (dbo.tbl_vehicleData.disposalStatusId <> 1) " &
        '                    " ORDER BY VehicleCategory, Make, Model, RegNumber "

        'obj.ConnectionString = con

        'Dim ds As DataSet = obj.ExecuteDsQRY(qry)

        'gwList.DataSource = ds

        gwList.DataSource = DirectCast(ViewState("VehiclesList"), DataSet)

        showExistingVehiclesOnLicense()

    End Sub
End Class