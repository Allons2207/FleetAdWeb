
Imports Telerik.Web.UI
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing
Imports System.Data.SqlClient

Public Class IssuedTyreTotals
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
     
        Try
            Dim sql As String = " SELECT        dbo.tbl_tyreSizes.tyreSize AS TyreSize, dbo.tbl_tyreManufacturers.manufacturer AS Manufacturer, dbo.tbl_tyreSuppliers.supplierName AS Supplier, COUNT(DISTINCT dbo.tbl_tyres.fleetId) AS NumberOfVehicles, COUNT " & _
         " (dbo.tbl_tyres.serialNumber)  " & _
                    "  AS NumberOfTyres " & _
                     " FROM            dbo.tbl_tyres INNER JOIN " & _
                     "  dbo.tbl_tyreManufacturers ON dbo.tbl_tyres.manufacturerId = dbo.tbl_tyreManufacturers.manufacturerId INNER JOIN " & _
                    "   dbo.tbl_tyreSizes ON dbo.tbl_tyres.tyreSizeId = dbo.tbl_tyreSizes.tyreSizeId INNER JOIN " & _
                    "   dbo.tbl_tyreSuppliers ON dbo.tbl_tyres.supplierId = dbo.tbl_tyreSuppliers.supplierId " & _
                     " WHERE        (dbo.tbl_tyres.fittingStatusId = 2)  AND ((dbo.tbl_tyres.detFittedOnVehicle >= '" & CDate(rdFromDate.SelectedDate.ToString) & "') AND (dbo.tbl_tyres.detFittedOnVehicle <= '" & CDate(rdToDate.SelectedDate.ToString) & "'))" & _
                     "  GROUP BY dbo.tbl_tyreSizes.tyreSize, dbo.tbl_tyreManufacturers.manufacturer, dbo.tbl_tyreSuppliers.supplierName "

            'sql = " SELECT dbo.tbl_tyreSizes.tyreSize AS TyreSize, dbo.tbl_tyreManufacturers.manufacturer AS Manufacturer, dbo.tbl_tyreSuppliers.supplierName " &
            '       " AS Supplier, COUNT(DISTINCT dbo.tbl_tyres.fleetId)  AS NumberOfVehicles, COUNT(dbo.tbl_tyres.serialNumber) AS NumberOfTyres " &
            '       " FROM dbo.tbl_tyres INNER JOIN dbo.tbl_tyreManufacturers ON dbo.tbl_tyres.manufacturerId = dbo.tbl_tyreManufacturers.manufacturerId INNER JOIN " &
            '       " dbo.tbl_tyreSizes ON dbo.tbl_tyres.tyreSizeId = dbo.tbl_tyreSizes.tyreSizeId INNER JOIN dbo.tbl_tyreSuppliers ON dbo.tbl_tyres.supplierId = " &
            '       " dbo.tbl_tyreSuppliers.supplierId WHERE (dbo.tbl_tyres.fittingStatusId = 2)                               GROUP BY dbo.tbl_tyreSizes.tyreSize, " &
            '       " dbo.tbl_tyreManufacturers.manufacturer, dbo.tbl_tyreSuppliers.supplierName "

            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            db.ExecuteDataSet(CommandType.Text, Sql)

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

    Protected Sub btnSearchDates_Click(sender As Object, e As EventArgs) Handles btnSearchDates.Click

    End Sub
End Class