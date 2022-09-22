
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Telerik.Web.UI
Public Class InspectionsDashboard
    Inherits System.Web.UI.Page
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        RadHtmlChart1.DataSource = inspections()
        RadHtmlChart1.DataBind()
        RadHtmlChart1.Legend.Appearance.Visible = True

        pieChart.DataSource = loadPieChart("SELECT keyFinding, COUNT(fleetId) AS NoOfVehicles FROM dbo.tbl_inspectionDetails GROUP BY keyFinding ")
        pieChart.DataBind()

        pieChart.Legend.Appearance.Visible = True

    End Sub

    Private Function inspections() As DataTable
        '~/FuelSuppliedByMonthByType.aspx
        Dim qry As String = "SELECT keyFinding, COUNT(fleetId) AS NoOfVehicles FROM dbo.tbl_inspectionDetails GROUP BY keyFinding "
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
            obj.MessageLabel(lblMsg, "Error while selecting records", "Red")
            Return Nothing
        End Try

    End Function


    Private Function inspectionsByDateRange() As DataTable
        '~/FuelSuppliedByMonthByType.aspx
        Dim qry As String = "SELECT keyFinding, COUNT(fleetId) AS NoOfVehicles FROM dbo.tbl_inspectionDetails " &
                            " WHERE (dtDate >= '" & rdFromDate.SelectedDate & "') AND (dtDate <= '" & rdToDate.SelectedDate & "' )" &
                            " GROUP BY keyFinding "
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
            obj.MessageLabel(lblMsg, "Error while selecting records", "Red")
            Return Nothing
        End Try

    End Function

    Protected Sub cmdShow_Click(sender As Object, e As EventArgs) Handles cmdShow.Click

        obj.MessageLabel(lblMsg, "", "")

        RadHtmlChart1.DataSource = inspectionsByDateRange()
        RadHtmlChart1.DataBind()
        RadHtmlChart1.Legend.Appearance.Visible = True

        Dim qry As String = "SELECT keyFinding, COUNT(fleetId) AS NoOfVehicles FROM dbo.tbl_inspectionDetails " &
                            " WHERE (dtDate >= '" & rdFromDate.SelectedDate & "') AND (dtDate <= '" & rdToDate.SelectedDate & "' )" &
                            " GROUP BY keyFinding "

        pieChart.DataSource = loadPieChart(qry)
        pieChart.DataBind()
        pieChart.Legend.Appearance.Visible = True

    End Sub

    Private Function loadPieChart(qry As String) As DataSet
        'Dim qry As String = "SELECT keyFinding, COUNT(fleetId) AS NoOfVehicles FROM dbo.tbl_inspectionDetails " &
        '                    " WHERE (dtDate >= '" & rdFromDate.SelectedDate & "') AND (dtDate <= '" & rdToDate.SelectedDate & "' )" &
        '                    " GROUP BY keyFinding "

        obj.ConnectionString = con

        Dim ds As DataSet = obj.ExecuteDsQRY(qry)

        If ds.Tables(0).Rows.Count > 0 Then
            Return ds
        Else
            Return Nothing
        End If

    End Function
End Class