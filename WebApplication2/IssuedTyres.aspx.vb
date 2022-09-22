Imports Telerik.Web.UI
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing
Imports System.Data.SqlClient

Public Class IssuedTyres
    Inherits System.Web.UI.Page

    Dim objCBO As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = objCBO.Database
    Dim con As String = db.ConnectionString

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If (CokkiesWrapper.UserID <= 0 AndAlso Not IsNumeric(CokkiesWrapper.UserID)) Then
            Response.Redirect("../Login.aspx")
            Exit Sub
        End If

        Dim sql As String = "SELECT DISTINCT dbo.tbl_tyreSizes.tyreSize AS TyreSize, dbo.tbl_tyreManufacturers.manufacturer AS Manufacturer, " &
                            "dbo.tbl_tyreSuppliers.supplierName AS Supplier, dbo.tbl_tyres.detFittedOnVehicle AS DateFitted, " &
                            " dbo.tbl_vehicleData.fleetId AS FleetId, dbo.tbl_vehicleData.registrationNumber AS RegNumber, dbo.tbl_vehicleCategories.category, dbo.tbl_vehicleTypes.vehicleType, " &
                            " dbo.tbl_vehicleMakes.vehicleMake, dbo.tbl_vehicleModels.vehicleModel FROM  dbo.tbl_vehicleModels INNER JOIN " &
                            " dbo.tbl_vehicleMakes ON dbo.tbl_vehicleModels.vehicleMakeId = dbo.tbl_vehicleMakes.vehicleMakeId INNER JOIN " &
                            " dbo.tbl_tyres INNER JOIN dbo.tbl_tyreManufacturers ON dbo.tbl_tyres.manufacturerId = dbo.tbl_tyreManufacturers.manufacturerId INNER JOIN " &
                            " dbo.tbl_tyreSizes ON dbo.tbl_tyres.tyreSizeId = dbo.tbl_tyreSizes.tyreSizeId INNER JOIN dbo.tbl_tyreSuppliers " &
                            " ON dbo.tbl_tyres.supplierId = dbo.tbl_tyreSuppliers.supplierId INNER JOIN dbo.tbl_vehicleData ON dbo.tbl_tyres.fleetId " &
                            " = dbo.tbl_vehicleData.fleetId INNER JOIN dbo.tbl_tyreFittingStatus ON dbo.tbl_tyres.fittingStatusId = " &
                            " dbo.tbl_tyreFittingStatus.fittingStatusId INNER JOIN dbo.tbl_vehicleCategories ON dbo.tbl_vehicleData.vehicleCategoryId = " &
                            " dbo.tbl_vehicleCategories.categoryId INNER JOIN dbo.tbl_vehicleTypes ON dbo.tbl_vehicleData.vehicleTypeId = " &
                            " dbo.tbl_vehicleTypes.vehicleTypeId ON dbo.tbl_vehicleModels.vehicleModelId = dbo.tbl_vehicleData.modelId " &
                            " WHERE(dbo.tbl_tyres.fittingStatusId = 2) ORDER BY DateFitted DESC "


        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            db.ExecuteDataSet(CommandType.Text, sql)

            With gwGrid
                Try
                    .DataSource = ds
                    .DataBind()

                    Session("IssuedTyres") = ds



                Catch ex As Exception
                    '  log.Error(ex.Message)
                End Try
            End With
        Catch ex As Exception
            'log.Error(ex)
        End Try
    End Sub

    Protected Sub gwGrid_NeedDataSource(sender As Object, e As GridNeedDataSourceEventArgs) Handles gwGrid.NeedDataSource
        gwGrid.DataSource = Session("IssuedTyres")
    End Sub
End Class