
Imports Telerik.Web.UI
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing
Imports System.Data.SqlClient

Public Class tyrePrices
    Inherits System.Web.UI.Page

    Dim objCBO As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = objCBO.Database
    Dim con As String = db.ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If (CokkiesWrapper.UserID <= 0 AndAlso Not IsNumeric(CokkiesWrapper.UserID)) Then
            Response.Redirect("../Login.aspx")
            Exit Sub
        End If

        Dim sql As String = " SELECT        TOP (100) PERCENT dbo.tbl_tyreSizes.tyreSize AS TyreSize, dbo.tbl_tyreManufacturers.manufacturer AS Manufacturer, " &
                            " dbo.tbl_tyreSuppliers.supplierName AS Supplier, CAST(dbo.tbl_tyres.unitCost AS nvarchar) AS UnitCost, " &
                            " Convert(VARCHAR(10), dbo.tbl_tyres.detReceived, 10) As DateReceived, dbo.tbl_tyres.batchNumber AS PO_Number " &
                            "  FROM  dbo.tbl_tyres INNER JOIN " &
                            "  dbo.tbl_tyreManufacturers ON dbo.tbl_tyres.manufacturerId = dbo.tbl_tyreManufacturers.manufacturerId INNER JOIN " &
                            "  dbo.tbl_tyreSuppliers ON dbo.tbl_tyres.supplierId = dbo.tbl_tyreSuppliers.supplierId INNER JOIN " &
                            "  dbo.tbl_tyreSizes ON dbo.tbl_tyres.tyreSizeId = dbo.tbl_tyreSizes.tyreSizeId " &
                            " GROUP BY dbo.tbl_tyres.batchNumber, dbo.tbl_tyres.detReceived, dbo.tbl_tyreManufacturers.manufacturer, dbo.tbl_tyreSuppliers.supplierName, " &
                            " dbo.tbl_tyres.unitCost, dbo.tbl_tyreSizes.tyreSize ORDER BY TyreSize, Manufacturer, Supplier "

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

    Protected Sub cmdExportToExcel_Click(sender As Object, e As EventArgs) Handles cmdExportToExcel.Click
        With gwGrid
            .ExportSettings.Excel.Format = GridExcelExportFormat.ExcelML
            .ExportSettings.IgnorePaging = True
            .ExportSettings.ExportOnlyData = True
            .ExportSettings.OpenInNewWindow = True
            .MasterTableView.ExportToExcel()
        End With

    End Sub
End Class