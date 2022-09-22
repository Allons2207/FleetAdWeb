Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Telerik.Web.UI

Public Class VehiclesByMake
    Inherits System.Web.UI.Page
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        RadHtmlChart1.DataSource = GetVehicleRatings()
        RadHtmlChart1.DataBind()

        RadHtmlChart1.Legend.Appearance.Visible = True
    End Sub


    Public Function GetVehicleRatings() As DataTable
        'Dim connection As New SqlConnection(connectionString)
        'Dim command As New SqlCommand("SELECT TOP 10 [VehicleName], [AverageRating] FROM [Vehicles]", connection)
        'Dim adapter As New SqlDataAdapter(command)
        'Dim ds As New DataSet("Vehicles")
        'adapter.Fill(ds, "Vehicles")
        'Return ds.Tables("Vehicles")

        'Dim qry As String = "SELECT  District, Type, sex, SUM(Numba) AS Tot " & _
        '                    " FROM   (SELECT        dbo.lu_districts.DistrictName AS District, 'In School' AS Type, dbo.tbl_individuals.sex, COUNT(dbo.tbl_individuals.individualUniqID) AS Numba " & _
        '                  "FROM            dbo.tbl_schools INNER JOIN " & _
        '                  " dbo.tbl_individuals ON dbo.tbl_schools.schoolID = dbo.tbl_individuals.schoolID INNER JOIN " & _
        '                  " dbo.lu_districts INNER JOIN dbo.lu_wards ON dbo.lu_districts.DistrictID = dbo.lu_wards.DistrictID ON dbo.tbl_schools.wardID = dbo.lu_wards.WardID " & _
        '                  " WHERE (dbo.tbl_individuals.wardID Is NULL)  GROUP BY dbo.lu_districts.DistrictName, dbo.tbl_individuals.sex " & _
        '                  " UNION " & _
        '                  " SELECT        lu_districts_1.DistrictName AS District, 'Out of School' AS Type, tbl_individuals_1.sex, COUNT(tbl_individuals_1.individualUniqID) AS Numba " & _
        '                 " FROM            dbo.lu_districts AS lu_districts_1 INNER JOIN " & _
        '                 " dbo.lu_wards AS lu_wards_1 ON lu_districts_1.DistrictID = lu_wards_1.DistrictID INNER JOIN " & _
        '                  " dbo.tbl_individuals AS tbl_individuals_1 ON lu_wards_1.WardID = tbl_individuals_1.wardID " & _
        '                 " GROUP BY lu_districts_1.DistrictName, tbl_individuals_1.sex) AS AA GROUP BY District, Type, sex "

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

End Class