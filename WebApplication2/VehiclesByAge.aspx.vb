
Imports Telerik.Web.UI
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing
Imports System.Data.SqlClient


Public Class VehiclesByAge
    Inherits System.Web.UI.Page

    Dim objCBO As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = objCBO.Database
    Dim con As String = db.ConnectionString

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (CokkiesWrapper.UserID <= 0 AndAlso Not IsNumeric(CokkiesWrapper.UserID)) Then
            Response.Redirect("../Login.aspx")
            Exit Sub
        End If

        If Not IsPostBack Then
            loadAllVehicles()
        End If
    End Sub

    Protected Sub cmdAddNew_Click(sender As Object, e As EventArgs) Handles cmdAddNew.Click
        Response.Redirect("~/vehicleDetails.aspx")
    End Sub

    Private Sub gwGrid_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles gwGrid.ItemCommand
        If e.CommandName = "View" Then

            Dim item As GridDataItem = e.Item
            Dim RegNo As String = item("RegNo").Text
            Response.Redirect("~\VehicleDetails.aspx?op=" + RegNo)
        End If
    End Sub

    Protected Sub gwGrid_NeedDataSource(sender As Object, e As GridNeedDataSourceEventArgs) Handles gwGrid.NeedDataSource
        loadAllVehicles()
    End Sub

    Private Sub loadAllVehicles()
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
                           " WHERE dbo.tbl_vehicleData.disposalStatusId <> 1  ORDER BY VehicleCategory, Make, Model, RegNo "
        ' WHERE dbo.tbl_vehicleData.disposalStatusId <> 3
        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            db.ExecuteDataSet(CommandType.Text, sql)

            With gwGrid
                Try
                    .DataSource = ds
                    .DataBind()
                Catch ex As Exception
                    '  log.Error(ex.Message)
                End Try
            End With
        Catch ex As Exception
            'log.Error(ex)
        End Try
    End Sub





End Class