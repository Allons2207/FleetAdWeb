
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Telerik.Web.UI
Public Class CostOfMaterialsDashboard
    Inherits System.Web.UI.Page
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            For ctr = 2017 To 2025
                cboYear.Items.Add(ctr)
            Next

            loadMaterialsList()
        End If

    End Sub

    Private Sub loadMaterialsList()
        Dim qry As String = "SELECT TOP (100) PERCENT serviceMaterialId, serviceMaterial From dbo.tbl_serviceMaterials Order By serviceMaterial"

        obj.ConnectionString = con

        Dim ds As DataSet = obj.ExecuteDsQRY(qry)
        With gwList
            .DataSource = ds
            .DataBind()
        End With
    End Sub
    Private Sub loadMaterialCostTracking(ByVal materialId As String, ByVal materialName As String)

        Dim yYear As Long = Val(cboYear.Text)
        Dim ls1 As LineSeries = New LineSeries

        Dim jan As CategorySeriesItem = New CategorySeriesItem
        Dim feb As CategorySeriesItem = New CategorySeriesItem
        Dim mar As CategorySeriesItem = New CategorySeriesItem
        Dim apr As CategorySeriesItem = New CategorySeriesItem
        Dim may As CategorySeriesItem = New CategorySeriesItem
        Dim jun As CategorySeriesItem = New CategorySeriesItem
        Dim jul As CategorySeriesItem = New CategorySeriesItem
        Dim aug As CategorySeriesItem = New CategorySeriesItem
        Dim sep As CategorySeriesItem = New CategorySeriesItem
        Dim oct As CategorySeriesItem = New CategorySeriesItem
        Dim nov As CategorySeriesItem = New CategorySeriesItem
        Dim dec As CategorySeriesItem = New CategorySeriesItem

        jan.Y = getMaterialCostForYearMonth(materialId, yYear, 1)
        feb.Y = getMaterialCostForYearMonth(materialId, yYear, 2)
        mar.Y = getMaterialCostForYearMonth(materialId, yYear, 3)
        apr.Y = getMaterialCostForYearMonth(materialId, yYear, 4)
        may.Y = getMaterialCostForYearMonth(materialId, yYear, 5)
        jun.Y = getMaterialCostForYearMonth(materialId, yYear, 6)
        jul.Y = getMaterialCostForYearMonth(materialId, yYear, 7)
        aug.Y = getMaterialCostForYearMonth(materialId, yYear, 8)
        sep.Y = getMaterialCostForYearMonth(materialId, yYear, 9)
        oct.Y = getMaterialCostForYearMonth(materialId, yYear, 10)
        nov.Y = getMaterialCostForYearMonth(materialId, yYear, 11)
        dec.Y = getMaterialCostForYearMonth(materialId, yYear, 12)

        ls1.SeriesItems.Add(jan)
        ls1.SeriesItems.Add(feb)
        ls1.SeriesItems.Add(mar)
        ls1.SeriesItems.Add(apr)
        ls1.SeriesItems.Add(may)
        ls1.SeriesItems.Add(jun)
        ls1.SeriesItems.Add(jul)
        ls1.SeriesItems.Add(aug)
        ls1.SeriesItems.Add(sep)
        ls1.SeriesItems.Add(oct)
        ls1.SeriesItems.Add(nov)
        ls1.SeriesItems.Add(dec)

        ls1.Name = materialName

        LineChart.PlotArea.Series.Add(ls1)

    End Sub


    Private Function getMaterialCostForYearMonth(ByVal materialId As String, ByVal yYear As Integer, mMonth As Integer) As Decimal

        Dim qry As String = "SELECT TOP (100) PERCENT SUM(dbo.tbl_detailedVehicleServiceWorkDone.totalPrice) AS totalCost " &
                            " FROM  dbo.tbl_vehicleServicingDetails INNER JOIN dbo.tbl_detailedVehicleServiceWorkDone ON " &
                            " dbo.tbl_vehicleServicingDetails.jobCardNumber = dbo.tbl_detailedVehicleServiceWorkDone.jobCardNumber INNER JOIN " &
                            " dbo.tbl_serviceMaterials ON dbo.tbl_detailedVehicleServiceWorkDone.descriptionOfMaterialsUsed = " &
                            " dbo.tbl_serviceMaterials.serviceMaterial WHERE (DATEPART(mm, dbo.tbl_vehicleServicingDetails.dateInForService) = " & mMonth & ") " &
                            " AND (DATEPART(yyyy, dbo.tbl_vehicleServicingDetails.dateInForService) = " & yYear & ") AND " &
                            " (dbo.tbl_serviceMaterials.serviceMaterialId = " & materialId & ") GROUP BY dbo.tbl_serviceMaterials.serviceMaterial " &
                            " ORDER BY dbo.tbl_serviceMaterials.serviceMaterial"

        obj.ConnectionString = con

        Try
            Dim ds As New DataSet("MaterialCost")
            ds = obj.ExecuteDsQRY(qry)

            If ds.Tables(0).Rows.Count > 0 Then
                Return ds.Tables(0).Rows(0).Item("totalCost")
            Else
                Return Nothing
            End If
        Catch ex As Exception

            Return Nothing
        End Try

    End Function

    Protected Sub btnLoadSelectedCosts_Click(sender As Object, e As EventArgs) Handles btnLoadSelectedCosts.Click
        loadLineChart()
    End Sub

    Private Sub loadLineChart()
        LineChart.PlotArea.Series.Clear()

        'Dim ds As DataSet = New DataSet
        'Dim dt As New DataTable

        'dt.Columns.Add("IndicatorId", Type.[GetType]("System.Int32"))
        'dt.Columns.Add("IndicatorName", Type.[GetType]("System.String"))

        For Each gridRow As GridDataItem In gwList.Items
            If gridRow.Selected = True Then
                loadMaterialCostTracking(gridRow("serviceMaterialId").Text, gridRow("serviceMaterial").Text)
            End If
        Next

        LineChart.Visible = True

    End Sub

    Protected Sub gwList_NeedDataSource(sender As Object, e As GridNeedDataSourceEventArgs) Handles gwList.NeedDataSource
        Dim qry As String = "SELECT TOP (100) PERCENT serviceMaterialId, serviceMaterial From dbo.tbl_serviceMaterials Order By serviceMaterial"

        obj.ConnectionString = con

        Dim ds As DataSet = obj.ExecuteDsQRY(qry)
        With gwList
            .DataSource = ds

        End With
    End Sub
End Class