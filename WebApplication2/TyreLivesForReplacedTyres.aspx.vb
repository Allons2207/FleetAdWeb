
Imports Telerik.Web.UI
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing
Imports System.Data.SqlClient

Public Class TyreLivesForReplacedTyres
    Inherits System.Web.UI.Page

    Dim objCBO As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = objCBO.Database
    Dim con As String = db.ConnectionString

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (CokkiesWrapper.UserID <= 0 AndAlso Not IsNumeric(CokkiesWrapper.UserID)) Then
            Response.Redirect("../Login.aspx")
            Exit Sub
        End If

        lblMsg.Text = ""

    End Sub

    Protected Sub btnSearchDates_Click(sender As Object, e As EventArgs) Handles btnSearchDates.Click
        Try
            Dim sql As String = "SELECT TOP (100) PERCENT dbo.tbl_tyres.detRemovedFromVehicle AS DateRemoved, dbo.tbl_vehicleMakes.vehicleMake " &
                                " AS Make, dbo.tbl_vehicleModels.vehicleModel AS Model, dbo.tbl_tyres.serialNumber AS SerialNumber, " &
                                " dbo.tbl_tyreSizes.tyreSize AS TyreSize, dbo.tbl_tyreManufacturers.manufacturer AS Manufacturer, " &
                                " dbo.tbl_tyreSuppliers.supplierName AS Supplier, dbo.tbl_tyres.fleetId AS FleetId, " &
                                " dbo.tbl_tyres.detFittedOnVehicle AS DateFitted, DATEDIFF(MM, dbo.tbl_tyres.detFittedOnVehicle, " &
                                " dbo.tbl_tyres.detRemovedFromVehicle) AS DurationInMonths, dbo.tbl_vehicleData.registrationNumber, " &
                                " dbo.tbl_tyres.expectedTyreMileage AS ExpectedMileage, dbo.tbl_tyres.vehicleMileageAtTyreRemoval - dbo.tbl_tyres.vehicleMileageAtTyreFitting AS TravelledMileage, " &
                                " dbo.tbl_tyreReasonForReplacement.reasonForReplacement AS ReasonForReplacement FROM dbo.tbl_vehicleModels INNER JOIN " &
                                " dbo.tbl_vehicleMakes ON dbo.tbl_vehicleModels.vehicleMakeId = dbo.tbl_vehicleMakes.vehicleMakeId INNER JOIN " &
                                " dbo.tbl_tyres INNER JOIN dbo.tbl_tyreManufacturers ON dbo.tbl_tyres.manufacturerId = dbo.tbl_tyreManufacturers.manufacturerId INNER JOIN " &
                                " dbo.tbl_tyreSizes ON dbo.tbl_tyres.tyreSizeId = dbo.tbl_tyreSizes.tyreSizeId INNER JOIN " &
                                " dbo.tbl_tyreSuppliers ON dbo.tbl_tyres.supplierId = dbo.tbl_tyreSuppliers.supplierId INNER JOIN " &
                                " dbo.tbl_vehicleData ON dbo.tbl_tyres.fleetId = dbo.tbl_vehicleData.fleetId INNER JOIN " &
                                " dbo.tbl_tyreReasonForReplacement ON dbo.tbl_tyres.reasonForRemovalId = dbo.tbl_tyreReasonForReplacement.reasonForReplacementId ON " &
                                " dbo.tbl_vehicleModels.vehicleModelId = dbo.tbl_vehicleData.modelId WHERE(dbo.tbl_tyres.fittingStatusId = 3) ORDER BY DateRemoved DESC "

            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            db.ExecuteDataSet(CommandType.Text, sql)

            With gwGrid
                Try
                    .DataSource = ds
                    .DataBind()

                Catch ex As Exception
                    ' log.Error(ex.Message)
                    lblMsg.Text = "An Error has occurred."
                End Try
            End With
        Catch ex As Exception
            'log.Error(ex)
        End Try
    End Sub

End Class