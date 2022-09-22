
Imports Telerik.Web.UI
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing
Imports System.Data.SqlClient

Public Class VehicleAvailability
    Inherits System.Web.UI.Page
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        loadPoolVehicles()
    End Sub

    Private Sub loadPoolVehicles()
        Dim sql As String = "SELECT DISTINCT dbo.tbl_vehicleTypes.vehicleType AS VehicleCategory, dbo.tbl_vehicleData.fleetId AS FleetId, " &
                           " dbo.tbl_vehicleData.registrationNumber AS RegNo, dbo.tbl_vehicleMakes.vehicleMake AS Make," &
                           " dbo.tbl_vehicleModels.vehicleModel AS Model, dbo.tbl_vehicleData.engineNumber AS EngineNo, " &
                           " dbo.tbl_vehicleData.chassisNumber AS ChassisNo, dbo.tbl_vehicleData.currentMileage AS Mileage, " &
                           " Convert(VARCHAR(10), dbo.tbl_vehicleData.lastMileageDate, 10) AS MileageDate, dbo.tbl_vehicleCategories.category AS UserCategory, " &
                           " dbo.tbl_vehicleUsers.firstName + ' ' + dbo.tbl_vehicleUsers.surname AS VehicleUser, " &
                           " dbo.tbl_vehicleUsers.position AS Position, dbo.tbl_vehicleUsers.department AS Department " &
                           " FROM dbo.tbl_vehicleModels INNER JOIN " &
                           " dbo.tbl_vehicleMakes ON dbo.tbl_vehicleModels.vehicleMakeId = dbo.tbl_vehicleMakes.vehicleMakeId INNER JOIN " &
                           " dbo.tbl_vehicleData ON dbo.tbl_vehicleModels.vehicleModelId = dbo.tbl_vehicleData.modelId INNER JOIN " &
                           " dbo.tbl_vehicleTypes ON dbo.tbl_vehicleData.vehicleTypeId = dbo.tbl_vehicleTypes.vehicleTypeId INNER JOIN " &
                           " dbo.tbl_vehicleCategories ON dbo.tbl_vehicleData.vehicleCategoryId = dbo.tbl_vehicleCategories.categoryId LEFT OUTER JOIN " &
                           " dbo.tbl_vehicleUsers ON dbo.tbl_vehicleData.currentUserId = dbo.tbl_vehicleUsers.licenseNumber " &
                           " WHERE dbo.tbl_vehicleData.disposalStatusId <> 1 AND dbo.tbl_vehicleData.vehicleCategoryId = 1  ORDER BY VehicleCategory, Make, Model, RegNo "
        ' WHERE dbo.tbl_vehicleData.disposalStatusId <> 3
        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            db.ExecuteDataSet(CommandType.Text, sql)

            With gwGrid
                Try
                    .DataSource = ds
                    .DataBind()

                    obj.MessageLabel(lblMsg, ds.Tables(0).Rows.Count & "   vehicle(s) found.", "Green")
                Catch ex As Exception
                    '  log.Error(ex.Message)
                End Try
            End With
        Catch ex As Exception
            'log.Error(ex)
        End Try
    End Sub

    Private Sub availableVehicles()
        Dim sql As String = "SELECT DISTINCT dbo.tbl_vehicleTypes.vehicleType AS VehicleCategory, dbo.tbl_vehicleData.fleetId AS FleetId, " &
                           " dbo.tbl_vehicleData.registrationNumber AS RegNo, dbo.tbl_vehicleMakes.vehicleMake AS Make," &
                           " dbo.tbl_vehicleModels.vehicleModel AS Model, dbo.tbl_vehicleData.engineNumber AS EngineNo, " &
                           " dbo.tbl_vehicleData.chassisNumber AS ChassisNo, dbo.tbl_vehicleData.currentMileage AS Mileage, " &
                           " Convert(VARCHAR(10), dbo.tbl_vehicleData.lastMileageDate, 10) AS MileageDate, dbo.tbl_vehicleCategories.category AS UserCategory, " &
                           " dbo.tbl_vehicleUsers.firstName + ' ' + dbo.tbl_vehicleUsers.surname AS VehicleUser, " &
                           " dbo.tbl_vehicleUsers.position AS Position, dbo.tbl_vehicleUsers.department AS Department " &
                           " FROM dbo.tbl_vehicleModels INNER JOIN " &
                           " dbo.tbl_vehicleMakes ON dbo.tbl_vehicleModels.vehicleMakeId = dbo.tbl_vehicleMakes.vehicleMakeId INNER JOIN " &
                           " dbo.tbl_vehicleData ON dbo.tbl_vehicleModels.vehicleModelId = dbo.tbl_vehicleData.modelId INNER JOIN " &
                           " dbo.tbl_vehicleTypes ON dbo.tbl_vehicleData.vehicleTypeId = dbo.tbl_vehicleTypes.vehicleTypeId INNER JOIN " &
                           " dbo.tbl_vehicleCategories ON dbo.tbl_vehicleData.vehicleCategoryId = dbo.tbl_vehicleCategories.categoryId LEFT OUTER JOIN " &
                           " dbo.tbl_vehicleUsers ON dbo.tbl_vehicleData.currentUserId = dbo.tbl_vehicleUsers.licenseNumber " &
                           " WHERE dbo.tbl_vehicleData.disposalStatusId <> 1 AND dbo.tbl_vehicleData.vehicleCategoryId = 1 " &
                           "  AND  dbo.tbl_vehicleData.FleetId NOT IN (SELECT [fleetId] FROM [dbo].[tbl_tripLogging] WHERE [returnStatus] = 'Still Out') ORDER BY VehicleCategory, Make, Model, RegNo "

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            db.ExecuteDataSet(CommandType.Text, sql)

            With gwGrid
                Try
                    .DataSource = ds
                    .DataBind()

                    obj.MessageLabel(lblMsg, ds.Tables(0).Rows.Count & "   vehicle(s) found.", "Green")

                Catch ex As Exception
                    '  log.Error(ex.Message)
                End Try
            End With
        Catch ex As Exception
            'log.Error(ex)
        End Try

    End Sub

    Private Sub UnAvailableVehicles()
        Dim sql As String = "SELECT DISTINCT dbo.tbl_vehicleTypes.vehicleType AS VehicleCategory, dbo.tbl_vehicleData.fleetId AS FleetId, " &
                           " dbo.tbl_vehicleData.registrationNumber AS RegNo, dbo.tbl_vehicleMakes.vehicleMake AS Make," &
                           " dbo.tbl_vehicleModels.vehicleModel AS Model, dbo.tbl_vehicleData.engineNumber AS EngineNo, " &
                           " dbo.tbl_vehicleData.chassisNumber AS ChassisNo, dbo.tbl_vehicleData.currentMileage AS Mileage, " &
                           " Convert(VARCHAR(10), dbo.tbl_vehicleData.lastMileageDate, 10) AS MileageDate, dbo.tbl_vehicleCategories.category AS UserCategory, " &
                           " dbo.tbl_vehicleUsers.firstName + ' ' + dbo.tbl_vehicleUsers.surname AS VehicleUser, " &
                           " dbo.tbl_vehicleUsers.position AS Position, dbo.tbl_vehicleUsers.department AS Department " &
                           " FROM dbo.tbl_vehicleModels INNER JOIN " &
                           " dbo.tbl_vehicleMakes ON dbo.tbl_vehicleModels.vehicleMakeId = dbo.tbl_vehicleMakes.vehicleMakeId INNER JOIN " &
                           " dbo.tbl_vehicleData ON dbo.tbl_vehicleModels.vehicleModelId = dbo.tbl_vehicleData.modelId INNER JOIN " &
                           " dbo.tbl_vehicleTypes ON dbo.tbl_vehicleData.vehicleTypeId = dbo.tbl_vehicleTypes.vehicleTypeId INNER JOIN " &
                           " dbo.tbl_vehicleCategories ON dbo.tbl_vehicleData.vehicleCategoryId = dbo.tbl_vehicleCategories.categoryId LEFT OUTER JOIN " &
                           " dbo.tbl_vehicleUsers ON dbo.tbl_vehicleData.currentUserId = dbo.tbl_vehicleUsers.licenseNumber " &
                           " WHERE dbo.tbl_vehicleData.disposalStatusId <> 1 AND dbo.tbl_vehicleData.vehicleCategoryId = 1 " &
                           "  AND  dbo.tbl_vehicleData.FleetId IN (SELECT [fleetId] FROM [dbo].[tbl_tripLogging] WHERE [returnStatus] = 'Still Out') ORDER BY VehicleCategory, Make, Model, RegNo "

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            db.ExecuteDataSet(CommandType.Text, sql)

            With gwGrid
                Try
                    .DataSource = ds
                    .DataBind()

                    obj.MessageLabel(lblMsg, ds.Tables(0).Rows.Count & "   vehicle(s) found.", "Green")

                Catch ex As Exception
                    '  log.Error(ex.Message)
                End Try
            End With
        Catch ex As Exception
            'log.Error(ex)
        End Try

    End Sub

    Protected Sub cboSelect_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboSelect.SelectedIndexChanged

        obj.MessageLabel(lblMsg, "", "")

        Select Case cboSelect.Text
            Case "Available Vehicle"
                availableVehicles()
            Case "UnAvailable Vehicles"
                UnAvailableVehicles()
            Case Else
                loadPoolVehicles()
        End Select
    End Sub
End Class