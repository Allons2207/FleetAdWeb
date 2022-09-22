
Imports Telerik.Web.UI
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing
Imports System.Data.SqlClient

Public Class VehiclesWithoutTyresList
    Inherits System.Web.UI.Page


    Dim objCBO As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = objCBO.Database
    Dim con As String = db.ConnectionString

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If (CokkiesWrapper.UserID <= 0 AndAlso Not IsNumeric(CokkiesWrapper.UserID)) Then
            Response.Redirect("../Login.aspx")
            Exit Sub
        End If

        If Not IsPostBack Then

            Dim sql As String = " SELECT  TOP (100) PERCENT dbo.tbl_vehicleTypes.vehicleType AS Type, dbo.tbl_vehicleMakes.vehicleMake AS Make, " &
                                " dbo.tbl_vehicleModels.vehicleModel AS Model, dbo.tbl_vehicleData.fleetId AS FleetId, dbo.tbl_vehicleData.registrationNumber " &
                                " AS RegNumber FROM  dbo.tbl_vehicleModels INNER JOIN dbo.tbl_vehicleMakes ON dbo.tbl_vehicleModels.vehicleMakeId = " &
                                " dbo.tbl_vehicleMakes.vehicleMakeId INNER JOIN  dbo.tbl_vehicleData INNER JOIN " &
                                " dbo.tbl_vehicleTypes ON dbo.tbl_vehicleData.vehicleTypeId = dbo.tbl_vehicleTypes.vehicleTypeId ON " &
                                " dbo.tbl_vehicleModels.vehicleModelId = dbo.tbl_vehicleData.modelId  WHERE  (dbo.tbl_vehicleData.fleetId NOT IN " &
                                " (SELECT  fleetId FROM  dbo.tbl_tyres  WHERE  (fittingStatusId = 2))) ORDER BY Type, Make, Model, FleetId, RegNumber "

            Try
                Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
                db.ExecuteDataSet(CommandType.Text, sql)

                With gwGrid
                    Try
                        .DataSource = ds
                        .DataBind()

                        Session("VehiclesWithoutTyres") = ds

                    Catch ex As Exception
                        '  log.Error(ex.Message)
                    End Try
                End With
            Catch ex As Exception
                'log.Error(ex)
            End Try
        End If
    End Sub

    Protected Sub gwGrid_NeedDataSource(sender As Object, e As GridNeedDataSourceEventArgs) Handles gwGrid.NeedDataSource
        gwGrid.DataSource = Session("VehiclesWithoutTyres")
    End Sub
End Class