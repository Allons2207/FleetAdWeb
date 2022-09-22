
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Telerik.Web.UI

Public Class SurfaceEquipmentList
    Inherits System.Web.UI.Page
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            loadSurfaceEquipment()
        End If


    End Sub


    Private Sub loadSurfaceEquipment()

        Dim qry As String = "SELECT TOP (100) PERCENT SE.SurfaceEquipmentID, ST.SurfaceEquipmentType, dbo.luSurfaceEquipmentCategory.SurfaceEquipmentCategory " &
            " AS Category, SE.AssetNumber, SE.SerialNumber, SE.RegNumber, SE.ChassisNumber, SE.Description, SE.Color, " &
            " dbo.tbl_fuelTypes.fuelType AS FuelType, dbo.tbl_tyreSizes.tyreSize AS TyreSize, SE.NumberOfTyres, SE.HourMeter, " &
            " SE.GeneratorSize, SE.TrailerSize, SE.ActiveMode, SE.EngineModel FROM     dbo.tblSurfaceEquipment AS SE INNER JOIN " &
            " dbo.tblSurfaceEquipmentTypes AS ST ON SE.AssetTypeID = ST.SurfaceEquipmentTypeID INNER JOIN dbo.tbl_fuelTypes ON " &
            " SE.FuelTypeID = dbo.tbl_fuelTypes.fuelTypeId INNER JOIN dbo.tbl_tyreSizes ON SE.TyreSizeID = dbo.tbl_tyreSizes.tyreSizeId INNER JOIN " &
            " dbo.luSurfaceEquipmentCategory ON SE.AssetCategoryID = dbo.luSurfaceEquipmentCategory.SurfaceEquipmentCategoryID " &
            " ORDER BY SE.Description, ST.SurfaceEquipmentType "

        Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, qry)

        With gwGrid
            .DataSource = ds
            .DataBind()

            Session("SurfaceEquipment") = ds
        End With

    End Sub

    Protected Sub gwGrid_NeedDataSource(sender As Object, e As Telerik.Web.UI.GridNeedDataSourceEventArgs) Handles gwGrid.NeedDataSource

        gwGrid.DataSource = Session("SurfaceEquipment")

    End Sub

    Private Sub gwGrid_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles gwGrid.ItemCommand

        If e.CommandName = "View" Then
            Dim item As GridDataItem = e.Item
            Dim SurfaceEquipmentID As String = item("SurfaceEquipmentID").Text
            Response.Redirect("~/SurfaceEquipmentDetails.aspx?op=" + SurfaceEquipmentID)
        ElseIf e.CommandName = "Delete" Then
            Dim item As GridDataItem = e.Item
            Dim SurfaceEquipmentID As String = item("SurfaceEquipmentID").Text

            Dim qry As String = "DELETE FROM tblSurfaceEquipment WHERE SurfaceEquipmentID = " & SurfaceEquipmentID

            db.ExecuteNonQuery(CommandType.Text, qry)
            loadSurfaceEquipment()

        End If

    End Sub

    Protected Sub btnAddNew_Click(sender As Object, e As EventArgs) Handles btnAddNew.Click
        Response.Redirect("~/SurfaceEquipmentDetails.aspx")
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