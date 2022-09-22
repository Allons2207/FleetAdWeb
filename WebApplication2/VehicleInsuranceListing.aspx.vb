Imports Telerik.Web.UI
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing


Public Class VehicleInsuranceListing
    Inherits System.Web.UI.Page
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        loadList()
    End Sub


    Protected Sub cmdAddNew_Click(sender As Object, e As EventArgs) Handles cmdAddNew.Click
        Response.Redirect("~/VehicleInsuranceDetails.aspx")
    End Sub

    Private Sub loadList()

        Dim sql As String = "SELECT DISTINCT TOP (100) PERCENT DATEDIFF(MM, GETDATE(), dbo.tbl_vehicleInsuranceDetails.expiryDate) AS MonthsToDueDate," &
            "dbo.tbl_vehicleTypes.vehicleType AS VehicleCategory, dbo.tbl_vehicleData.fleetId AS FleetId,dbo.tbl_vehicleData.registrationNumber AS " &
            " RegNumber, dbo.tbl_vehicleMakes.vehicleMake AS Make, dbo.tbl_vehicleModels.vehicleModel AS Model, dbo.tbl_vehicleInsuranceDetails.dateIssued," &
             " dbo.tbl_vehicleInsuranceDetails.expiryDate, dbo.tbl_vehicleInsuranceDetails.details AS Notes FROM dbo.tbl_vehicleModels INNER JOIN " &
             " dbo.tbl_vehicleMakes ON dbo.tbl_vehicleModels.vehicleMakeId = dbo.tbl_vehicleMakes.vehicleMakeId INNER JOIN " &
             " dbo.tbl_vehicleData ON dbo.tbl_vehicleModels.vehicleModelId = dbo.tbl_vehicleData.modelId INNER JOIN " &
             "  dbo.tbl_vehicleTypes ON dbo.tbl_vehicleData.vehicleTypeId = dbo.tbl_vehicleTypes.vehicleTypeId INNER JOIN " &
             "  dbo.tbl_vehicleInsuranceDetails ON dbo.tbl_vehicleData.fleetId = dbo.tbl_vehicleInsuranceDetails.fleetId " &
             " WHERE        (dbo.tbl_vehicleData.disposalStatusId <> 1) ORDER BY VehicleCategory, Make, Model, RegNumber "

        '  , DateDiff(MM, GETDATE(), dbo.tbl_ZBCLicensing.expiryDate) As MonthsToDueDate

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

    Private Sub gwGrid_InsertCommand(sender As Object, e As GridCommandEventArgs) Handles gwGrid.InsertCommand

    End Sub

    Private Sub gwGrid_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles gwGrid.ItemCommand
        If e.CommandName = "View" Then
            Dim item As GridDataItem = e.Item
            Dim FleetId As String = item("FleetId").Text
            Response.Redirect("~/VehicleInsuranceDetails.aspx?op=" + FleetId)
        End If
    End Sub

    Private Sub gwGrid_ItemDataBound(sender As Object, e As Telerik.Web.UI.GridItemEventArgs) Handles gwGrid.ItemDataBound
        If TypeOf e.Item Is GridDataItem Then

            Dim gridItem As GridDataItem = e.Item

            If Val(gridItem("MonthsToDueDate").Text) <= 0 Then
                gridItem.BackColor = Drawing.Color.Red
            ElseIf Val(gridItem("MonthsToDueDate").Text) = 1 Then
                gridItem.BackColor = Drawing.Color.Orange
            ElseIf Val(gridItem("MonthsToDueDate").Text) = 2 Then
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