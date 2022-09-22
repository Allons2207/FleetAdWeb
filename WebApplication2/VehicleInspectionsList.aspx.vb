Imports Telerik.Web.UI
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing

Public Class VehicleInspectionsList
    Inherits System.Web.UI.Page
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        loadList()
    End Sub

    Protected Sub cmdAddNew_Click(sender As Object, e As EventArgs) Handles cmdAddNew.Click
        Response.Redirect("~/VehicleInspectionDetails.aspx")
    End Sub

    Private Sub loadList()

        Dim sql As String = "SELECT  DISTINCT dbo.tbl_inspectionDetails.ctr AS EntryNo,  CONVERT(VARCHAR(10),dbo.tbl_inspectionDetails.dtDate,10) AS Date, dbo.tbl_vehicleData.registrationNumber AS RegNumber, " &
                            " dbo.tbl_inspectionDetails.fleetId AS FleetID, dbo.tbl_vehicleMakes.vehicleMake AS Make, " &
                            " dbo.tbl_vehicleModels.vehicleModel AS Model, dbo.tbl_inspectionDetails.keyFinding AS KeyFinding, " &
                            " dbo.tbl_inspectionDetails.keyDetails AS Details, dbo.tbl_vehicleUsers.firstName + ' ' + dbo.tbl_vehicleUsers.surname " &
                            " AS VehicleUser, dbo.tbl_vehicleUsers.department AS Department, dbo.tbl_vehicleUsers.position AS Position " &
                            " FROM dbo.tbl_inspectionDetails INNER JOIN dbo.tbl_vehicleModels INNER JOIN " &
                            " dbo.tbl_vehicleMakes ON dbo.tbl_vehicleModels.vehicleMakeId = dbo.tbl_vehicleMakes.vehicleMakeId INNER JOIN " &
                            " dbo.tbl_vehicleData ON dbo.tbl_vehicleModels.vehicleModelId = dbo.tbl_vehicleData.modelId ON " &
                            " dbo.tbl_inspectionDetails.fleetId = dbo.tbl_vehicleData.fleetId LEFT OUTER JOIN " &
                            " dbo.tbl_vehicleUsers ON dbo.tbl_vehicleData.fleetId = dbo.tbl_vehicleUsers.fleetId " &
                            " ORDER BY Date DESC "
        'CONVERT(VARCHAR(10),GETDATE(),10)
        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            db.ExecuteDataSet(CommandType.Text, sql)

            With gwGrid
                Try
                    .DataSource = ds
                    .DataBind()
                    '.MasterTableView.GetColumn("ctr").Display = False

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
            Dim EntryNo As String = item("EntryNo").Text
            Response.Redirect("~/VehicleInspectionDetails.aspx?op=" + EntryNo)

        End If
    End Sub

    Protected Sub gwGrid_NeedDataSource(sender As Object, e As GridNeedDataSourceEventArgs) Handles gwGrid.NeedDataSource

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