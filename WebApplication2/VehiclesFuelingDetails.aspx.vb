Imports Telerik.Web.UI
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing

Public Class VehiclesFuelingDetails
    Inherits System.Web.UI.Page
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        loadFuelingDetailsList()
    End Sub

    Private Sub loadFuelingDetailsList()

        Dim qry As String = "SELECT TOP (100) PERCENT dbo.tbl_fuelingOdometerReadings.yYear AS Year, dbo.tbl_fuelingOdometerReadings.mMonth AS Month, " &
             " dbo.tbl_vehicleFuelingDetails.fleetId AS FleetId, dbo.tbl_fuelingOdometerReadings.openingOdometerReading AS OpeningOdometerReading, " &
             " dbo.tbl_fuelingOdometerReadings.closingOdometerReading AS ClosingOdometerReading, " &
             " dbo.tbl_fuelingOdometerReadings.closingOdometerReading - dbo.tbl_fuelingOdometerReadings.openingOdometerReading AS MileageTravelled, " &
             " dbo.tbl_vehicleFuelingDetails.fuelType AS FuelType, SUM(dbo.tbl_vehicleFuelingDetails.quantitySupplied) AS Quantity, " &
             "  Convert(Decimal(10, 2), (dbo.tbl_fuelingOdometerReadings.closingOdometerReading - dbo.tbl_fuelingOdometerReadings.openingOdometerReading) " &
                        " / SUM(dbo.tbl_vehicleFuelingDetails.quantitySupplied))  As [FuelConsumptionRate (kms/l)]  FROM  dbo.tbl_fuelingOdometerReadings INNER JOIN " &
             " dbo.tbl_vehicleFuelingDetails ON dbo.tbl_fuelingOdometerReadings.fleetId = dbo.tbl_vehicleFuelingDetails.fleetId AND " &
             " dbo.tbl_fuelingOdometerReadings.mMonth = dbo.tbl_vehicleFuelingDetails.fuelingMonth AND dbo.tbl_fuelingOdometerReadings.yYear = " &
             " dbo.tbl_vehicleFuelingDetails.fuelingYear GROUP BY dbo.tbl_fuelingOdometerReadings.yYear, dbo.tbl_fuelingOdometerReadings.mMonth, " &
             " dbo.tbl_vehicleFuelingDetails.fleetId, dbo.tbl_fuelingOdometerReadings.openingOdometerReading, " &
            " dbo.tbl_fuelingOdometerReadings.closingOdometerReading, dbo.tbl_vehicleFuelingDetails.fuelType ORDER BY Year, Month DESC "

        Try
            obj.ConnectionString = con
            Dim ds As DataSet = obj.ExecuteDsQRY(qry)

            With gwGrid
                .DataSource = ds
                .DataBind()
            End With

            'If obj.ExecuteNonQRY(qry) = 1 Then
            '    obj.MessageLabel(lblMsg, "Fueling record saved successfully.", "Green")
            'Else
            '    obj.MessageLabel(lblMsg, "Error While trying To save record.", "Red")
            'End If

        Catch ex As Exception
            obj.MessageLabel(lblMsg, "Error While trying To retrieve vehicle fueling record.", "Red")
        End Try
    End Sub

    Protected Sub cmdAddNew_Click(sender As Object, e As EventArgs) Handles cmdAddNew.Click
        Response.Redirect("~/VehicleFuelingDetails.aspx")
    End Sub

    Protected Sub cmdExport_Click(sender As Object, e As EventArgs) Handles cmdExport.Click
        With gwGrid
            .ExportSettings.Excel.Format = GridExcelExportFormat.ExcelML
            .ExportSettings.IgnorePaging = True
            .ExportSettings.ExportOnlyData = True
            .ExportSettings.OpenInNewWindow = True
            .MasterTableView.ExportToExcel()
        End With
    End Sub
End Class