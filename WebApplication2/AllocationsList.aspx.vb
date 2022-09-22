
Imports Telerik.Web.UI
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing
Public Class AllocationsList
    Inherits System.Web.UI.Page
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        loadAllocationsList()
    End Sub

    Private Sub loadAllocationsList()
        Dim sql As String = "SELECT TOP (100) PERCENT dtDate AS Date, registrationNumber AS RegistrationDate, " & _
                            " fleetID AS FleetID, make AS Make, model AS Model, allocationMode AS AllocationMode, driver AS Driver, " & _
                            " department AS Department, nationalIDNumber AS NationalID, licenseNumber AS LicenseNo " & _
                            " FROM dbo.tbl_vehicleAllocationHistory ORDER BY Date DESC "
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

    Protected Sub cmdAddNew_Click(sender As Object, e As EventArgs) Handles cmdAddNew.Click

        Response.Redirect("~/AllocateVehicle.aspx")

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