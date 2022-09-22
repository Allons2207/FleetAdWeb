Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Telerik.Web.UI

Public Class AccidentsDashBoard
    Inherits System.Web.UI.Page
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    End Sub

    Private Sub loadYearAccidentsTracking(ByVal yYear As String)
        LineChart.PlotArea.Series.Clear()

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

        jan.Y = getVehicleAccidentsForYearMonth(yYear, 1)
        feb.Y = getVehicleAccidentsForYearMonth(yYear, 2)
        mar.Y = getVehicleAccidentsForYearMonth(yYear, 3)
        apr.Y = getVehicleAccidentsForYearMonth(yYear, 4)
        may.Y = getVehicleAccidentsForYearMonth(yYear, 5)
        jun.Y = getVehicleAccidentsForYearMonth(yYear, 6)
        jul.Y = getVehicleAccidentsForYearMonth(yYear, 7)
        aug.Y = getVehicleAccidentsForYearMonth(yYear, 8)
        sep.Y = getVehicleAccidentsForYearMonth(yYear, 9)
        oct.Y = getVehicleAccidentsForYearMonth(yYear, 10)
        nov.Y = getVehicleAccidentsForYearMonth(yYear, 11)
        dec.Y = getVehicleAccidentsForYearMonth(yYear, 12)

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

        ls1.Name = yYear

        LineChart.PlotArea.Series.Add(ls1)
        LineChart.Visible = True

    End Sub


    Private Function getVehicleAccidentsForYearMonth(ByVal yYear As Integer, mMonth As Integer) As Decimal

        Dim qry As String = "SELECT COUNT(fleetId) AS NumOfAccidents FROM  dbo.tbl_accidentsIncidents " &
                            " WHERE   (DATEPART(mm, dtAccidentDate) = " & mMonth & ") AND (DATEPART(YYYY, dtAccidentDate) = " & yYear & ") "

        obj.ConnectionString = con

        Try
            Dim ds As New DataSet("Accidents")
            ds = obj.ExecuteDsQRY(qry)

            If ds.Tables(0).Rows.Count > 0 Then
                Return ds.Tables(0).Rows(0).Item("NumOfAccidents")
            Else
                Return Nothing
            End If
        Catch ex As Exception
            Return Nothing
        End Try

    End Function

    Protected Sub cboYear_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboYear.SelectedIndexChanged
        Dim yYear As Long = Val(cboYear.Text)

        loadYearAccidentsTracking(yYear)
    End Sub

End Class