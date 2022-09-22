Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Telerik.Web.UI


Public Class TyresDashboard
    Inherits System.Web.UI.Page
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        RadHtmlChart1.DataSource = TyresInStoreByManufacturer()
        RadHtmlChart1.DataBind()
        RadHtmlChart1.Legend.Appearance.Visible = True

        RadHtmlChart2.DataSource = CostOfTyresByMonth()
        RadHtmlChart2.DataBind()
        RadHtmlChart2.Legend.Appearance.Visible = True

        RadHtmlChart3.DataSource = tyreReplacementsDisposal()
        RadHtmlChart3.DataBind()
        RadHtmlChart3.Legend.Appearance.Visible = True

        RadHtmlChart4.DataSource = requiredVSAvailableTyres()
        RadHtmlChart4.DataBind()
        RadHtmlChart4.Legend.Appearance.Visible = True

    End Sub

    Private Function TyresInStoreByManufacturer() As DataTable
        Dim qry As String = "SELECT  dbo.tbl_tyreManufacturers.manufacturer, COUNT(dbo.tbl_tyres.serialNumber) AS NoOfTyres " &
                            " FROM dbo.tbl_tyres INNER JOIN dbo.tbl_tyreManufacturers ON dbo.tbl_tyres.manufacturerId = " &
                            " dbo.tbl_tyreManufacturers.manufacturerId WHERE        (dbo.tbl_tyres.fittingStatusId = 1) " &
                            " GROUP BY dbo.tbl_tyreManufacturers.manufacturer "


        obj.ConnectionString = con
        Dim ds As New DataSet("Vehicle")
        ds = obj.ExecuteDsQRY(qry)

        If ds.Tables(0).Rows.Count > 0 Then
            Return ds.Tables(0)
        Else
            Return Nothing
        End If


    End Function

    Private Function CostOfTyresByMonth() As DataTable
        Dim qry As String = "SELECT DATEPART(YYYY, detReceived) AS yYear, DATEPART(MM, detReceived) AS mMonth, SUM(unitCost) AS TotalCost " &
                            " FROM   dbo.tbl_tyres GROUP BY DATEPART(YYYY, detReceived), DATEPART(MM, detReceived) "


        obj.ConnectionString = con
        Dim ds As New DataSet("CostOfTyres")
        ds = obj.ExecuteDsQRY(qry)

        If ds.Tables(0).Rows.Count > 0 Then
            Return ds.Tables(0)
        Else
            Return Nothing
        End If


    End Function

    Private Function tyreReplacementsDisposal() As DataTable

        Dim qry As String = "SELECT        dbo.tbl_tyreReasonForReplacement.reasonForReplacement, COUNT(dbo.tbl_tyres.serialNumber) AS NoOfTyres " &
                            " FROM            dbo.tbl_tyres INNER JOIN " &
                            " dbo.tbl_tyreReasonForReplacement ON dbo.tbl_tyres.reasonForRemovalId = dbo.tbl_tyreReasonForReplacement.reasonForReplacementId " &
                            " WHERE        (NOT (dbo.tbl_tyres.detDisposed IS NULL)) AND (dbo.tbl_tyres.fittingStatusId = 4) " &
                            " Group BY dbo.tbl_tyreReasonForReplacement.reasonForReplacement "


        obj.ConnectionString = con
        Dim ds As New DataSet("CostOfTyres")
        ds = obj.ExecuteDsQRY(qry)

        If ds.Tables(0).Rows.Count > 0 Then
            Return ds.Tables(0)
        Else
            Return Nothing
        End If

    End Function

    Private Function requiredVSAvailableTyres() As DataTable

        Dim qry As String = "SELECT tyreSize, SUM(TyresRequired) AS Required, SUM(TyresInStock) AS Available " &
                            " FROM  (SELECT        dbo.tbl_tyreSizes.tyreSize, SUM(dbo.tbl_vehicleData.numberOfTyres) AS TyresRequired, 0 AS TyresInStock " &
                            " FROM            dbo.tbl_vehicleData INNER JOIN " &
                            " dbo.tbl_tyreSizes ON dbo.tbl_vehicleData.tyreSizeId = dbo.tbl_tyreSizes.tyreSizeId " &
                            " WHERE        (dbo.tbl_vehicleData.disposalStatusId = 0) " &
                            " GROUP BY dbo.tbl_tyreSizes.tyreSize " &
                            " UNION " &
                            " SELECT tbl_tyreSizes_1.tyreSize, 0 AS TyresRequired, COUNT(dbo.tbl_tyres.serialNumber) AS TyresInStock " &
                            " FROM   dbo.tbl_tyres INNER JOIN " &
                            " dbo.tbl_tyreSizes AS tbl_tyreSizes_1 ON dbo.tbl_tyres.tyreSizeId = tbl_tyreSizes_1.tyreSizeId " &
                            " WHERE        (dbo.tbl_tyres.fittingStatusId = 1) GROUP BY tbl_tyreSizes_1.tyreSize) AS AA " &
                            " GROUP BY tyreSize "

        obj.ConnectionString = con
        Dim ds As New DataSet("CostOfTyres")
        ds = obj.ExecuteDsQRY(qry)

        If ds.Tables(0).Rows.Count > 0 Then
            Return ds.Tables(0)
        Else
            Return Nothing
        End If

    End Function

End Class