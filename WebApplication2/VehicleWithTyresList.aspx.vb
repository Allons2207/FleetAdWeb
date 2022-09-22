
Imports Telerik.Web.UI
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing
Imports System.Data.SqlClient

Public Class VehicleWithTyresList
    Inherits System.Web.UI.Page

    Dim objCBO As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = objCBO.Database
    Dim con As String = db.ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If (CokkiesWrapper.UserID <= 0 AndAlso Not IsNumeric(CokkiesWrapper.UserID)) Then
            Response.Redirect("../Login.aspx")
            Exit Sub
        End If

        Dim sql As String = " SELECT        dbo.tbl_vehicleData.fleetId AS Fleet_Id, dbo.tbl_vehicleData.registrationNumber AS Reg_Number, dbo.tbl_vehicleData.vehicleType AS Type, dbo.tbl_vehicleData.make AS Make, " & _
                        " dbo.tbl_vehicleData.model AS Model, dbo.tbl_tyres.serialNumber AS Tyre_Serial_Number, dbo.tbl_tyres.batchNumber AS PO_Number, dbo.tbl_tyreSuppliers.supplierName AS " & _
                        " Supplier, dbo.tbl_tyreManufacturers.manufacturer AS Manufacturer, dbo.tbl_tyreSizes.tyreSize AS Tyre_Size, dbo.tbl_tyres.detFittedOnVehicle AS Date_Fitted, " & _
                "         dbo.tbl_tyres.vehicleMileageAtTyreFitting AS Mileage_At_Fitting, dbo.tbl_tyres.currentVehicleMileage AS Last_Known_Mileage, " & _
                  "       dbo.tbl_tyres.currentVehicleMileage - dbo.tbl_tyres.vehicleMileageAtTyreFitting AS Tyre_Mileage, dbo.tbl_tyres.expectedTyreMileage, " & _
                    "     dbo.tbl_tyres.expectedTyreMileage - (dbo.tbl_tyres.currentVehicleMileage - dbo.tbl_tyres.vehicleMileageAtTyreFitting) AS Remaining_Tyre_Mileage " & _
                   "   FROM  dbo.tbl_vehicleData INNER JOIN " & _
                       "  dbo.tbl_tyres ON dbo.tbl_vehicleData.fleetId = dbo.tbl_tyres.fleetId INNER JOIN " & _
                       "  dbo.tbl_tyreSuppliers ON dbo.tbl_tyres.supplierId = dbo.tbl_tyreSuppliers.supplierId INNER JOIN " & _
                       "  dbo.tbl_tyreManufacturers ON dbo.tbl_tyres.manufacturerId = dbo.tbl_tyreManufacturers.manufacturerId INNER JOIN " & _
                       "  dbo.tbl_tyreSizes ON dbo.tbl_tyres.tyreSizeId = dbo.tbl_tyreSizes.tyreSizeId WHERE        (dbo.tbl_tyres.fittingStatusId = 2) "


        sql = "SELECT   dbo.tbl_tyres.detFittedOnVehicle AS Date_Fitted, dbo.tbl_vehicleData.fleetId AS FleetId, dbo.tbl_vehicleData.registrationNumber AS RegNumber, " &
              " dbo.tbl_tyres.serialNumber AS Tyre_Serial_Number, dbo.tbl_tyres.batchNumber AS PO_Number, dbo.tbl_tyreSuppliers.supplierName AS Supplier, " &
              " dbo.tbl_tyreManufacturers.manufacturer AS Manufacturer, dbo.tbl_tyreSizes.tyreSize AS Tyre_Size, " &
              " dbo.tbl_tyres.vehicleMileageAtTyreFitting AS Mileage_At_Fitting, dbo.tbl_tyres.currentVehicleMileage AS Last_Known_Mileage, " &
              " dbo.tbl_tyres.currentVehicleMileage - dbo.tbl_tyres.vehicleMileageAtTyreFitting AS Tyre_Mileage, dbo.tbl_tyres.expectedTyreMileage, " &
              " dbo.tbl_tyres.expectedTyreMileage - (dbo.tbl_tyres.currentVehicleMileage - dbo.tbl_tyres.vehicleMileageAtTyreFitting) AS Remaining_Tyre_Mileage, " &
              " dbo.tbl_vehicleModels.vehicleModel AS VehicleModel, dbo.tbl_vehicleMakes.vehicleMake AS VehicleMake, dbo.tbl_vehicleTypes.vehicleType AS VehicleType " &
              " FROM  dbo.tbl_vehicleTypes INNER JOIN  dbo.tbl_vehicleData INNER JOIN  dbo.tbl_tyres ON dbo.tbl_vehicleData.fleetId = dbo.tbl_tyres.fleetId INNER JOIN " &
              " dbo.tbl_tyreSuppliers ON dbo.tbl_tyres.supplierId = dbo.tbl_tyreSuppliers.supplierId INNER JOIN " &
              " dbo.tbl_tyreManufacturers ON dbo.tbl_tyres.manufacturerId = dbo.tbl_tyreManufacturers.manufacturerId INNER JOIN " &
              " dbo.tbl_tyreSizes ON dbo.tbl_tyres.tyreSizeId = dbo.tbl_tyreSizes.tyreSizeId INNER JOIN  dbo.tbl_vehicleModels INNER JOIN " &
              " dbo.tbl_vehicleMakes ON dbo.tbl_vehicleModels.vehicleMakeId = dbo.tbl_vehicleMakes.vehicleMakeId ON dbo.tbl_vehicleData.modelId = " &
              " dbo.tbl_vehicleModels.vehicleModelId ON dbo.tbl_vehicleTypes.vehicleTypeId = dbo.tbl_vehicleData.vehicleTypeId " &
              " WHERE        (dbo.tbl_tyres.fittingStatusId = 2)  ORDER BY Date_Fitted DESC  "

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            db.ExecuteDataSet(CommandType.Text, sql)

            With gwGrid
                Try
                    .DataSource = ds
                    .DataBind()

                    Session("VehiclesWithoutTyres") = ds

                Catch ex As Exception
                    '  log.Error(ex.Message)
                End Try
            End With
        Catch ex As Exception
            'log.Error(ex)
        End Try
    End Sub

    Protected Sub gwGrid_NeedDataSource(sender As Object, e As GridNeedDataSourceEventArgs) Handles gwGrid.NeedDataSource
        gwGrid.DataSource = Session("VehiclesWithoutTyres")
    End Sub


End Class