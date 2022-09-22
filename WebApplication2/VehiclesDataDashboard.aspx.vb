Imports Telerik.Web.UI
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing


Public Class VehiclesDataDashboard
    Inherits System.Web.UI.Page
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        RadHtmlChart1.DataSource = loadAllocation()
        RadHtmlChart1.DataBind()

        RadHtmlChart2.DataSource = GetVehiclesByMake()
        RadHtmlChart2.DataBind()

        RadHtmlChart3.DataSource = vehiclesByAge()
        RadHtmlChart3.DataBind()

        RadHtmlChart4.DataSource = vehiclesByCategory()
        RadHtmlChart4.DataBind()

    End Sub

    Private Function loadAllocation() As DataTable
        Dim qry As String = "SELECT    dbo.tbl_allocationStatus.allocationStatus,     COUNT(dbo.tbl_vehicleData.fleetId) AS NumOfVehicles " &
                        " FROM   dbo.tbl_vehicleData INNER JOIN dbo.tbl_allocationStatus ON dbo.tbl_vehicleData.allocationStatusId " &
                        " = dbo.tbl_allocationStatus.allocationStatusId WHERE        (dbo.tbl_vehicleData.disposalStatusId = 0) " &
                        " Group BY dbo.tbl_allocationStatus.allocationStatus "

        obj.ConnectionString = con

        Dim ds As New DataSet("Allocation")
        ds = obj.ExecuteDsQRY(qry)

        If ds.Tables(0).Rows.Count > 0 Then
            Return ds.Tables(0)
        Else
            Return Nothing
        End If

    End Function


    Public Function GetVehiclesByMake() As DataTable
        Dim qry As String = " SELECT DATEPART(yyyy, dbo.tbl_vehicleServicingDetails.dtDateOutOfService) AS yYear, DATEPART(mm, dbo.tbl_vehicleServicingDetails.dtDateOutOfService) " &
                            " AS mMonth, dbo.tbl_detailedVehicleServiceWorkDone.descriptionOfMaterialsUsed, SUM(dbo.tbl_detailedVehicleServiceWorkDone.quantityUsed) " &
                            " AS qtyUsed, SUM(dbo.tbl_detailedVehicleServiceWorkDone.totalPrice) AS TotCost " &
                            " FROM            dbo.tbl_vehicleServicingDetails INNER JOIN dbo.tbl_detailedVehicleServiceWorkDone ON " &
                         " dbo.tbl_vehicleServicingDetails.jobCardNumber = dbo.tbl_detailedVehicleServiceWorkDone.jobCardNumber " &
                            " GROUP BY DATEPART(yyyy, dbo.tbl_vehicleServicingDetails.dtDateOutOfService), " &
        " DATEPART(mm, dbo.tbl_vehicleServicingDetails.dtDateOutOfService), dbo.tbl_detailedVehicleServiceWorkDone.descriptionOfMaterialsUsed "


        qry = "SELECT DISTINCT TOP (100) PERCENT dbo.tbl_vehicleMakes.vehicleMake AS Make, COUNT(dbo.tbl_vehicleData.registrationNumber) " &
                " AS MakeCount FROM  dbo.tbl_vehicleModels INNER JOIN dbo.tbl_vehicleMakes ON dbo.tbl_vehicleModels.vehicleMakeId = " &
                " dbo.tbl_vehicleMakes.vehicleMakeId INNER JOIN dbo.tbl_vehicleData ON dbo.tbl_vehicleModels.vehicleModelId =" &
                " dbo.tbl_vehicleData.modelId GROUP BY dbo.tbl_vehicleMakes.vehicleMake"

        obj.ConnectionString = con
        Dim ds As New DataSet("Vehicle")
        ds = obj.ExecuteDsQRY(qry)

        If ds.Tables(0).Rows.Count > 0 Then
            Return ds.Tables(0)
        Else
            Return Nothing
        End If
    End Function


    Private Function vehiclesByAge() As DataTable
        Dim qry As String = "SELECT        DATEDIFF(YYYY, purchaseDate, GETDATE()) AS AgeFromPurchase, COUNT(fleetId) AS NoOfVehicles " &
                            " FROM  dbo.tbl_vehicleData GROUP BY DATEDIFF(YYYY, purchaseDate, GETDATE()) "

        obj.ConnectionString = con
        Dim ds As New DataSet("Vehicle")
        ds = obj.ExecuteDsQRY(qry)

        If ds.Tables(0).Rows.Count > 0 Then
            Return ds.Tables(0)
        Else
            Return Nothing
        End If

    End Function

    Private Function vehiclesByCategory() As DataTable
        Dim qry As String = "SELECT  dbo.tbl_vehicleCategories.category AS Category, COUNT(dbo.tbl_vehicleData.fleetId) AS NoOfVehicles " &
                            " FROM   dbo.tbl_vehicleData INNER JOIN  dbo.tbl_vehicleCategories ON dbo.tbl_vehicleData.vehicleCategoryId = " &
                            " dbo.tbl_vehicleCategories.categoryId GROUP BY dbo.tbl_vehicleCategories.category "

        obj.ConnectionString = con
        Dim ds As New DataSet("VehiclesByCategory")
        ds = obj.ExecuteDsQRY(qry)

        If ds.Tables(0).Rows.Count > 0 Then
            Return ds.Tables(0)
        Else
            Return Nothing
        End If

    End Function

    Public Function GetVehicleRatings() As DataTable

        Dim qry As String = " SELECT  DistrictName AS District, SUM(Male) AS M, SUM(Female) AS F " &
                            " FROM  (SELECT  dbo.lu_districts.DistrictName, COUNT(dbo.tbl_individuals.individualUniqID) AS Male, 0 AS Female " &
                            " FROM  dbo.lu_wards INNER JOIN dbo.lu_districts ON dbo.lu_wards.DistrictID = dbo.lu_districts.DistrictID INNER JOIN " &
                            " dbo.tbl_individuals ON dbo.lu_wards.WardID = dbo.tbl_individuals.wardID GROUP BY dbo.lu_districts.DistrictName, dbo.tbl_individuals.sex " &
                            " HAVING (dbo.tbl_individuals.sex = N'Male') " &
                            " UNION " &
                            " SELECT lu_districts_1.DistrictName, 0 AS Male, COUNT(tbl_individuals_1.individualUniqID) AS Female " &
                            " FROM            dbo.lu_wards AS lu_wards_1 INNER JOIN dbo.lu_districts AS lu_districts_1 ON lu_wards_1.DistrictID = lu_districts_1.DistrictID INNER JOIN " &
                            " dbo.tbl_individuals AS tbl_individuals_1 ON lu_wards_1.WardID = tbl_individuals_1.wardID  GROUP BY lu_districts_1.DistrictName, tbl_individuals_1.sex " &
                            " HAVING (tbl_individuals_1.sex = N'Female')) AS AA  GROUP BY DistrictName "

        obj.ConnectionString = con
        Dim ds As New DataSet("Vehicle")
        ds = obj.ExecuteDsQRY(qry)

        If ds.Tables(0).Rows.Count > 0 Then
            Return ds.Tables(0)
        Else
            Return Nothing
        End If
    End Function
End Class