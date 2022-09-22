Imports Telerik.Web.UI
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing

Public Class BulkLicensingList
    Inherits System.Web.UI.Page
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        loadList()
    End Sub

    Protected Sub cmdAddNew_Click(sender As Object, e As EventArgs) Handles cmdAddNew.Click
        Response.Redirect("~/BulkLicenseDetails.aspx")
    End Sub

    Private Sub loadList()
        '   Convert(VARCHAR(10), dbo.tbl_bulkLicensing.dateIssued, 10) AS DateIssued
        Dim sql As String = "SELECT dbo.tbl_bulkLicensing.entryNumber, dbo.tbl_bulkLicensing.LicenseTypeID, dbo.tbl_bulkLicensing.LicenseNo, dbo.tbl_bulkLicensing.Details, " &
              " Convert(VARCHAR(10), dbo.tbl_bulkLicensing.dateIssued, 10) AS DateIssued, Convert(VARCHAR(10), dbo.tbl_bulkLicensing.expiryDate, 10) AS ExpiryDate, DATEDIFF(MM, GETDATE(), dbo.tbl_bulkLicensing.expiryDate) " &
              " AS MonthsToExpiryDate, dbo.lu_LicenseTypes.licenseType AS LicenseType FROM   dbo.tbl_bulkLicensing INNER JOIN " &
              " dbo.lu_LicenseTypes ON dbo.tbl_bulkLicensing.LicenseTypeID = dbo.lu_LicenseTypes.licenseTypeId  ORDER BY  ExpiryDate "
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

    Private Sub gwGrid_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles gwGrid.ItemCommand
        If e.CommandName = "View" Then
            Dim item As GridDataItem = e.Item
            Dim LicenseNo As String = item("LicenseNo").Text
            Response.Redirect("~/BulkLicenseDetails.aspx?op=" + LicenseNo)
        End If
    End Sub

    Private Sub gwGrid_ItemDataBound(sender As Object, e As Telerik.Web.UI.GridItemEventArgs) Handles gwGrid.ItemDataBound
        If TypeOf e.Item Is GridDataItem Then

            Dim gridItem As GridDataItem = e.Item

            If Val(gridItem("MonthsToExpiryDate").Text) <= 0 Then
                gridItem.BackColor = Drawing.Color.Red
            ElseIf Val(gridItem("MonthsToExpiryDate").Text) = 1 Then
                gridItem.BackColor = Drawing.Color.Orange
            ElseIf Val(gridItem("MonthsToExpiryDate").Text) = 2 Then
                gridItem.BackColor = Drawing.Color.Yellow
            End If
        End If

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