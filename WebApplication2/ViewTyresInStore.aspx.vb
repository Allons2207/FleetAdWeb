
Imports Telerik.Web.UI
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing
Imports System.Data.SqlClient

Public Class ViewTyresInStore
    Inherits System.Web.UI.Page
    Dim objCBO As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = objCBO.Database
    Dim con As String = db.ConnectionString

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        loadDataGrid()
    End Sub


    Private Sub loadDataGrid()
        '  Dim sql As String = " SELECT * FROM tbl_tyres WHERE batchNumber = '" & txtPONumber.Text & "'"
        '  Convert(VARCHAR(10), dbo.tbl_tyres.detManufactured, 10) As detManufactured

        'CAST(dbo.tbl_tyres.unitCost AS nvarchar) AS unitCost

        Dim sql As String = "SELECT dbo.tbl_tyres.batchNumber, dbo.tbl_tyres.serialNumber, Convert(VARCHAR(10), dbo.tbl_tyres.detReceived, 10) As detReceived, " &
                     "    Convert(VARCHAR(10), dbo.tbl_tyres.detManufactured, 10) As detManufactured, dbo.tbl_tyreManufacturers.manufacturer, dbo.tbl_tyreSuppliers.supplierName, CAST(dbo.tbl_tyres.unitCost AS nvarchar) AS unitCost, " &
                      "   dbo.tbl_tyreSizes.tyreSize, dbo.tbl_tyreFittingStatus.fittingStatus, dbo.tbl_tyres.expectedTyreMileage" &
                    "  FROM            dbo.tbl_tyres INNER JOIN " &
                     "    dbo.tbl_tyreSuppliers ON dbo.tbl_tyres.supplierId = dbo.tbl_tyreSuppliers.supplierId INNER JOIN " &
                     "    dbo.tbl_tyreManufacturers ON dbo.tbl_tyres.manufacturerId = dbo.tbl_tyreManufacturers.manufacturerId INNER JOIN " &
                     "    dbo.tbl_tyreSizes ON dbo.tbl_tyres.tyreSizeId = dbo.tbl_tyreSizes.tyreSizeId INNER JOIN " &
                     "    dbo.tbl_tyreFittingStatus ON dbo.tbl_tyres.fittingStatusId = dbo.tbl_tyreFittingStatus.fittingStatusId " &
                    "  WHERE    dbo.tbl_tyres.[fittingStatusId] = 1  ORDER BY dbo.tbl_tyres.batchNumber, dbo.tbl_tyres.serialNumber"
        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            db.ExecuteDataSet(CommandType.Text, sql)

            With gwBillPayments
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


    Public Function grantPageWriteCommandPermission(ByVal UserId As Integer, pageId As Integer) As Boolean
        grantPageWriteCommandPermission = False
        Dim qry As String = "SELECT * FROM [dbo].[tbl_userSysPermissions] WHERE [userId] = " & UserId & " AND [sysModuleSectionId] = " & pageId & " AND [sysWrite] = 1"

        Try
            objCBO.ConnectionString = con
            Dim ds As DataSet = objCBO.ExecuteDsQRY(qry)
            If ds.Tables(0).Rows.Count > 0 Then
                grantPageWriteCommandPermission = True
            End If
        Catch ex As Exception
        End Try
    End Function

    Protected Sub gwBillPayments_NeedDataSource(sender As Object, e As GridNeedDataSourceEventArgs) Handles gwBillPayments.NeedDataSource

    End Sub

    Private Sub gwBillPayments_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles gwBillPayments.ItemCommand
        If e.CommandName = "Dispose" Then
            Dim item As GridDataItem = e.Item
            Dim SerialNumber As String = item("serialNumber").Text
            Response.Redirect("~/TyreDisposal.aspx?op=" + SerialNumber)
        End If
    End Sub

    Protected Sub cmdExportToExcel_Click(sender As Object, e As EventArgs) Handles cmdExportToExcel.Click
        With gwBillPayments
            .ExportSettings.Excel.Format = GridExcelExportFormat.ExcelML
            .ExportSettings.IgnorePaging = True
            .ExportSettings.ExportOnlyData = True
            .ExportSettings.OpenInNewWindow = True
            .MasterTableView.ExportToExcel()
        End With
    End Sub
End Class