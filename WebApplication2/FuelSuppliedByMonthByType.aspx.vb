
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Telerik.Web.UI
Public Class FuelSuppliedByMonthByType
    Inherits System.Web.UI.Page
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        RadHtmlChart1.DataSource = GetVehicleRatings()
        RadHtmlChart1.DataBind()
        RadHtmlChart1.Legend.Appearance.Visible = True


        obj.ConnectionString = con

        If Not IsPostBack Then
            obj.loadComboBox(radMonth, "SELECT [mMonthId], [mMonth] FROM [dbo].[tbl_months]", "mMonth", "mMonthId")
            obj.loadComboBox(radMonthAveFuelCon, "SELECT [mMonthId], [mMonth] FROM [dbo].[tbl_months]", "mMonth", "mMonthId")
            radYear.Items.Insert(0, New RadComboBoxItem("--Select--", ""))
            radYearAveFuelCon.Items.Insert(0, New RadComboBoxItem("--Select--", ""))

            For ctr = 2010 To 2025
                cboYear.Items.Add(ctr)
            Next

            loadVehiclesList()

        End If

    End Sub
    Private Sub loadVehiclesList()
        Dim qry As String = "SELECT        TOP (100) PERCENT dbo.tbl_vehicleData.fleetId AS FleetId, " &
                            " dbo.tbl_vehicleData.registrationNumber AS RegNumber, dbo.tbl_vehicleMakes.vehicleMake AS Make, " &
                            " dbo.tbl_vehicleModels.vehicleModel AS Model FROM            dbo.tbl_vehicleModels INNER JOIN " &
                        " dbo.tbl_vehicleMakes ON dbo.tbl_vehicleModels.vehicleMakeId = dbo.tbl_vehicleMakes.vehicleMakeId INNER JOIN " &
                       "  dbo.tbl_vehicleData ON dbo.tbl_vehicleModels.vehicleModelId = dbo.tbl_vehicleData.modelId " &
                        " ORDER BY Make, Model "
        Try

            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, qry)

            If ds.Tables(0).Rows.Count > 0 Then
                radVehiclesList.DataSource = ds
                radVehiclesList.DataBind()
            Else
                radVehiclesList.DataSource = String.Empty
                radVehiclesList.DataBind()
            End If

        Catch ex As Exception

        End Try

    End Sub

    Private Sub loadLineChart()
        LineChart.PlotArea.Series.Clear()

        'Dim ds As DataSet = New DataSet
        'Dim dt As New DataTable

        'dt.Columns.Add("IndicatorId", Type.[GetType]("System.Int32"))
        'dt.Columns.Add("IndicatorName", Type.[GetType]("System.String"))

        For Each gridRow As GridDataItem In radVehiclesList.Items
            If gridRow.Selected = True Then
                loadFuelTracking(gridRow("FleetId").Text, gridRow("FleetId").Text)
            End If
        Next

        LineChart.Visible = True

    End Sub


    Private Sub loadFuelTracking(ByVal fleetId As String, ByVal testName As String)

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

        'jan.Y = Catchnull(getIndicatorMonthAchievement(indicatorId, yYear, 1), Nothing)
        'feb.Y = Catchnull(getIndicatorMonthAchievement(indicatorId, yYear, 2), Nothing)
        'mar.Y = Catchnull(getIndicatorMonthAchievement(indicatorId, yYear, 3), Nothing)
        'apr.Y = Catchnull(getIndicatorMonthAchievement(indicatorId, yYear, 4), Nothing)
        'may.Y = Catchnull(getIndicatorMonthAchievement(indicatorId, yYear, 5), Nothing)
        'jun.Y = Catchnull(getIndicatorMonthAchievement(indicatorId, yYear, 6), Nothing)
        'jul.Y = Catchnull(getIndicatorMonthAchievement(indicatorId, yYear, 7), Nothing)
        'aug.Y = Catchnull(getIndicatorMonthAchievement(indicatorId, yYear, 8), Nothing)
        'sep.Y = Catchnull(getIndicatorMonthAchievement(indicatorId, yYear, 9), Nothing)
        'oct.Y = Catchnull(getIndicatorMonthAchievement(indicatorId, yYear, 10), Nothing)
        'nov.Y = Catchnull(getIndicatorMonthAchievement(indicatorId, yYear, 11), Nothing)
        'dec.Y = Catchnull(getIndicatorMonthAchievement(indicatorId, yYear, 12), Nothing)

        jan.Y = getVehicleFuelFroMonth(fleetId, yYear, 1)
        feb.Y = getVehicleFuelFroMonth(fleetId, yYear, 2)
        mar.Y = getVehicleFuelFroMonth(fleetId, yYear, 3)
        apr.Y = getVehicleFuelFroMonth(fleetId, yYear, 4)
        may.Y = getVehicleFuelFroMonth(fleetId, yYear, 5)
        jun.Y = getVehicleFuelFroMonth(fleetId, yYear, 6)
        jul.Y = getVehicleFuelFroMonth(fleetId, yYear, 7)
        aug.Y = getVehicleFuelFroMonth(fleetId, yYear, 8)
        sep.Y = getVehicleFuelFroMonth(fleetId, yYear, 9)
        oct.Y = getVehicleFuelFroMonth(fleetId, yYear, 10)
        nov.Y = getVehicleFuelFroMonth(fleetId, yYear, 11)
        dec.Y = getVehicleFuelFroMonth(fleetId, yYear, 12)

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

        ls1.Name = testName

        LineChart.PlotArea.Series.Add(ls1)

    End Sub

    Private Function getVehicleFuelFroMonth(ByVal fleetId As String, ByVal yYear As Integer, mMonth As Integer) As Decimal

        Dim qry As String = "SELECT  fuelingYear, fuelingMonth, SUM(quantitySupplied) AS totalFuel, fleetId " &
                            "FROM            dbo.tbl_vehicleFuelingDetails GROUP BY fuelingYear, fuelingMonth, fleetId " &
                            "HAVING        (fleetId = '" & fleetId & "') AND (fuelingYear = " & yYear & ") AND (fuelingMonth = " & mMonth & ")"

        obj.ConnectionString = con

        Try
            Dim ds As New DataSet("Vehicle")
            ds = obj.ExecuteDsQRY(qry)

            If ds.Tables(0).Rows.Count > 0 Then
                Return ds.Tables(0).Rows(0).Item("totalFuel")
            Else
                Return Nothing
            End If
        Catch ex As Exception
            obj.MessageLabel(lblMsg, "Error While selecting records", "Red")
            Return Nothing
        End Try

    End Function

    Public Function GetVehicleRatings() As DataTable

        Dim qry As String = " "

        qry = "Select AA.yYear, AA.mMonth, SUM(AA.DieselQty) As Diesel, SUM(AA.PetrolQty) As Petrol FROM " &
                " (Select        DATEPART(yyyy, dbo.tbl_vehicleFuelingDetails.fuelingDate) As yYear, " &
                " DATEPART(mm, dbo.tbl_vehicleFuelingDetails.fuelingDate) As mMonth,  " &
                  "       SUM(dbo.tbl_vehicleFuelingDetails.quantitySupplied) As DieselQty, 0 As PetrolQty " &
                   " FROM  dbo.tbl_vehicleFuelingDetails INNER JOIN " &
                   " dbo.tbl_vehicleData On dbo.tbl_vehicleFuelingDetails.fleetId = dbo.tbl_vehicleData.fleetId " &
                " WHERE        (dbo.tbl_vehicleFuelingDetails.fuelType = 'Diesel') " &
            " GROUP BY DATEPART(yyyy, dbo.tbl_vehicleFuelingDetails.fuelingDate), DATEPART(mm, dbo.tbl_vehicleFuelingDetails.fuelingDate) " &
            " UNION " &
            " SELECT        DATEPART(yyyy, dbo.tbl_vehicleFuelingDetails.fuelingDate) AS yYear, " &
            " DATEPART(mm, dbo.tbl_vehicleFuelingDetails.fuelingDate) AS mMonth, 0 AS DieselQty, " &
             "            SUM(dbo.tbl_vehicleFuelingDetails.quantitySupplied) AS PetrolQty " &
            " FROM            dbo.tbl_vehicleFuelingDetails INNER JOIN " &
            " dbo.tbl_vehicleData ON dbo.tbl_vehicleFuelingDetails.fleetId = dbo.tbl_vehicleData.fleetId " &
            " WHERE        (dbo.tbl_vehicleFuelingDetails.fuelType = 'Petrol') " &
            " GROUP BY DATEPART(yyyy, dbo.tbl_vehicleFuelingDetails.fuelingDate), DATEPART(mm, dbo.tbl_vehicleFuelingDetails.fuelingDate)) " &
            " AS AA GROUP BY AA.yYear, AA.mMonth "

        obj.ConnectionString = con

        Try
            Dim ds As New DataSet("Vehicle")
            ds = obj.ExecuteDsQRY(qry)

            If ds.Tables(0).Rows.Count > 0 Then
                Return ds.Tables(0)
            Else
                Return Nothing
            End If
        Catch ex As Exception
            obj.MessageLabel(lblMsg, "Error While selecting records", "Red")
            Return Nothing
        End Try


    End Function
    Private Sub loadFuelPerVehicleForSelectedMonth()
        If radMonth.Text = "" Or radMonth.Text = "--Select--" Then
            Exit Sub
        ElseIf radYear.Text = "" Or radYear.Text = "--Select--" Then
            Exit Sub
        End If
        RadHtmlChart2.DataSource = String.Empty
        RadHtmlChart2.DataBind()

        RadHtmlChart2.DataSource = getFuelPerVehicle()
        RadHtmlChart2.DataBind()
        RadHtmlChart2.Legend.Appearance.Visible = True

    End Sub
    Private Function getFuelPerVehicle() As DataTable
        Dim qry As String = "SELECT        fleetId, SUM(quantitySupplied) AS FuelSupplied FROM            dbo.tbl_vehicleFuelingDetails " &
                            " WHERE        (fuelingYear = " & radYear.SelectedValue & ") AND (fuelingMonth = " & radMonth.SelectedValue & ") GROUP BY fleetId "

        obj.ConnectionString = con

        Try
            Dim ds As New DataSet("VehicleFuel")
            ds = obj.ExecuteDsQRY(qry)

            If ds.Tables(0).Rows.Count > 0 Then
                Return ds.Tables(0)
            Else
                Return Nothing
            End If
        Catch ex As Exception
            obj.MessageLabel(lblMsg, "Error While selecting records", "Red")
            Return Nothing
        End Try

    End Function

    Protected Sub radMonth_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles radMonth.SelectedIndexChanged
        loadFuelPerVehicleForSelectedMonth()
    End Sub

    Protected Sub radYear_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles radYear.SelectedIndexChanged
        loadFuelPerVehicleForSelectedMonth()
    End Sub
    Private Sub loadAveFuelConsumption()
        If radYearAveFuelCon.Text = "" Or radYearAveFuelCon.Text = "--Select--" Then
            Exit Sub
        ElseIf radMonthAveFuelCon.Text = "" Or radMonthAveFuelCon.Text = "--Select--" Then
            Exit Sub
        End If

        RadHtmlChart3.DataSource = String.Empty
        RadHtmlChart3.DataBind()

        RadHtmlChart3.DataSource = AveFuelConsumptions()
        RadHtmlChart3.DataBind()
        RadHtmlChart3.Legend.Appearance.Visible = True

    End Sub
    Private Function AveFuelConsumptions() As DataTable
        Dim qry As String = "SELECT TOP (100) PERCENT dbo.tbl_fuelingOdometerReadings.yYear AS Year, dbo.tbl_fuelingOdometerReadings.mMonth As " &
                            " Month, dbo.tbl_vehicleFuelingDetails.fleetId, CONVERT(Decimal(10, 2), " &
                         " (dbo.tbl_fuelingOdometerReadings.closingOdometerReading - dbo.tbl_fuelingOdometerReadings.openingOdometerReading) / " &
                         " SUM(dbo.tbl_vehicleFuelingDetails.quantitySupplied)) AS FuelConsumptionRate, " &
                         " dbo.tbl_vehicleData.fuelConsumptionRate AS StandardConsumption From dbo.tbl_vehicleModels INNER Join " &
                         " dbo.tbl_vehicleMakes ON dbo.tbl_vehicleModels.vehicleMakeId = dbo.tbl_vehicleMakes.vehicleMakeId INNER Join " &
                         " dbo.tbl_fuelingOdometerReadings INNER Join dbo.tbl_vehicleFuelingDetails ON dbo.tbl_fuelingOdometerReadings.fleetId = " &
                         " dbo.tbl_vehicleFuelingDetails.fleetId And dbo.tbl_fuelingOdometerReadings.mMonth = " &
                         " dbo.tbl_vehicleFuelingDetails.fuelingMonth And dbo.tbl_fuelingOdometerReadings.yYear = " &
                         " dbo.tbl_vehicleFuelingDetails.fuelingYear INNER JOIN  dbo.tbl_vehicleData ON dbo.tbl_vehicleFuelingDetails.fleetId = " &
                         " dbo.tbl_vehicleData.fleetId ON dbo.tbl_vehicleModels.vehicleModelId = dbo.tbl_vehicleData.modelId " &
                        " Group BY dbo.tbl_fuelingOdometerReadings.yYear, dbo.tbl_fuelingOdometerReadings.mMonth, dbo.tbl_vehicleFuelingDetails.fleetId, " &
                        " dbo.tbl_fuelingOdometerReadings.openingOdometerReading, dbo.tbl_fuelingOdometerReadings.closingOdometerReading, " &
                        " dbo.tbl_vehicleFuelingDetails.fuelType, dbo.tbl_vehicleData.fuelConsumptionRate, dbo.tbl_vehicleModels.vehicleModel, " &
                        " dbo.tbl_vehicleMakes.vehicleMake, dbo.tbl_vehicleData.registrationNumber " &
                        " HAVING (dbo.tbl_fuelingOdometerReadings.yYear = " & radYearAveFuelCon.SelectedValue & ") AND (dbo.tbl_fuelingOdometerReadings.mMonth = " & radMonthAveFuelCon.SelectedValue & ")  ORDER BY Year, Month DESC "

        obj.ConnectionString = con

        Try
            Dim ds As New DataSet("AveVehicleFuel")
            ds = obj.ExecuteDsQRY(qry)

            If ds.Tables(0).Rows.Count > 0 Then
                Return ds.Tables(0)
            Else
                Return Nothing
            End If
        Catch ex As Exception
            obj.MessageLabel(lblMsg, "Error While selecting records", "Red")
            Return Nothing
        End Try
    End Function

    Protected Sub radMonthAveFuelCon_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles radMonthAveFuelCon.SelectedIndexChanged
        loadAveFuelConsumption()
    End Sub

    Protected Sub radYearAveFuelCon_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles radYearAveFuelCon.SelectedIndexChanged
        loadAveFuelConsumption()
    End Sub

    Protected Sub btnLoadBySpecificVehicles_Click(sender As Object, e As EventArgs) Handles btnLoadBySpecificVehicles.Click
        loadLineChart()
    End Sub

    Protected Sub radVehiclesList_NeedDataSource(sender As Object, e As GridNeedDataSourceEventArgs) Handles radVehiclesList.NeedDataSource
        loadVehiclesList()
    End Sub
End Class