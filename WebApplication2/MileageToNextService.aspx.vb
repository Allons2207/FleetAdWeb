
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Telerik.Web.UI



Public Class MileageToNextService
    Inherits System.Web.UI.Page
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            loadData()
        End If
    End Sub

    Private Sub loadData()
        'CONVERT(VARCHAR(10),dbo.tbl_vehicleData.lastServiceDate,10) As LastServiceDate
        Dim qry As String = "SELECT  TOP (100) PERCENT dbo.tbl_vehicleData.fleetId AS FleetID, dbo.tbl_vehicleData.registrationNumber AS " &
                            " RegNumber, dbo.tbl_vehicleMakes.vehicleMake AS Make, dbo.tbl_vehicleModels.vehicleModel AS Model, " &
                         " dbo.tbl_vehicleData.mileageOnLastService AS MileageOnLastService, dbo.tbl_vehicleData.currentMileage AS " &
                         " CurrentMileage, dbo.tbl_vehicleData.serviceMileage AS ServiceMileage, " &
                        " dbo.tbl_vehicleData.mileageOnLastService + dbo.tbl_vehicleData.serviceMileage - dbo.tbl_vehicleData.currentMileage " &
                        " AS MileageTowardsNextService, CONVERT(VARCHAR(10),dbo.tbl_vehicleData.lastMileageDate,10) As LastMileageDate, " &
                       "  CONVERT(VARCHAR(10),dbo.tbl_vehicleData.lastServiceDate,10) As LastServiceDate  FROM            dbo.tbl_vehicleModels INNER JOIN " &
                       "  dbo.tbl_vehicleMakes ON dbo.tbl_vehicleModels.vehicleMakeId = dbo.tbl_vehicleMakes.vehicleMakeId INNER JOIN " &
                        " dbo.tbl_vehicleData ON dbo.tbl_vehicleModels.vehicleModelId = dbo.tbl_vehicleData.modelId " &
                        " ORDER BY MileageTowardsNextService ASC, Make, Model"

        obj.ConnectionString = con
        Dim ds As DataSet = obj.ExecuteDsQRY(qry)
        gwGrid.DataSource = ds
        gwGrid.DataBind()

    End Sub

    Protected Sub gwGrid_NeedDataSource(sender As Object, e As GridNeedDataSourceEventArgs) Handles gwGrid.NeedDataSource
        Dim qry As String = "SELECT  TOP (100) PERCENT dbo.tbl_vehicleData.fleetId AS FleetID, dbo.tbl_vehicleData.registrationNumber AS " &
                            " RegNumber, dbo.tbl_vehicleMakes.vehicleMake AS Make, dbo.tbl_vehicleModels.vehicleModel AS Model, " &
                         " dbo.tbl_vehicleData.mileageOnLastService AS MileageOnLastService, dbo.tbl_vehicleData.currentMileage AS " &
                         " CurrentMileage, dbo.tbl_vehicleData.serviceMileage AS ServiceMileage, " &
                        " dbo.tbl_vehicleData.mileageOnLastService + dbo.tbl_vehicleData.serviceMileage - dbo.tbl_vehicleData.currentMileage " &
                        " AS MileageTowardsNextService, CONVERT(VARCHAR(10),dbo.tbl_vehicleData.lastMileageDate,10) As LastMileageDate, " &
                       "  CONVERT(VARCHAR(10),dbo.tbl_vehicleData.lastServiceDate,10) As LastServiceDate  FROM            dbo.tbl_vehicleModels INNER JOIN " &
                       "  dbo.tbl_vehicleMakes ON dbo.tbl_vehicleModels.vehicleMakeId = dbo.tbl_vehicleMakes.vehicleMakeId INNER JOIN " &
                        " dbo.tbl_vehicleData ON dbo.tbl_vehicleModels.vehicleModelId = dbo.tbl_vehicleData.modelId " &
                        " ORDER BY MileageTowardsNextService ASC, Make, Model"

        obj.ConnectionString = con
        Dim ds As DataSet = obj.ExecuteDsQRY(qry)
        gwGrid.DataSource = ds
    End Sub

    Private Sub gwGrid_ItemDataBound(sender As Object, e As Telerik.Web.UI.GridItemEventArgs) Handles gwGrid.ItemDataBound
        If TypeOf e.Item Is GridDataItem Then

            Dim gridItem As GridDataItem = e.Item

            If Val(gridItem("MileageTowardsNextService").Text) <= 500 Then
                gridItem.BackColor = Drawing.Color.Red
            ElseIf Val(gridItem("MileageTowardsNextService").Text) = 700 Then
                gridItem.BackColor = Drawing.Color.Orange
            ElseIf Val(gridItem("MileageTowardsNextService").Text) = 1000 Then
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