
Imports Telerik.Web.UI
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing
Imports System.Data.SqlClient

Public Class VehiclesWithNumberOfFittedTyresList
    Inherits System.Web.UI.Page

    Dim objCBO As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = objCBO.Database
    Dim con As String = db.ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If (CokkiesWrapper.UserID <= 0 AndAlso Not IsNumeric(CokkiesWrapper.UserID)) Then
            Response.Redirect("../Login.aspx")
            Exit Sub
        End If

        Dim sql As String = " SELECT  dbo.tbl_vehicleData.fleetId AS Fleet_Id, dbo.tbl_vehicleData.registrationNumber AS Reg_Number, dbo.tbl_vehicleData.vehicleType AS Type, dbo.tbl_vehicleData.make AS Make, " & _
                            " dbo.tbl_vehicleData.model AS Model, COUNT(dbo.tbl_tyres.serialNumber) AS NumOfTyresFitted " & _
                            " FROM  dbo.tbl_vehicleData INNER JOIN dbo.tbl_tyres ON dbo.tbl_vehicleData.fleetId = dbo.tbl_tyres.fleetId " & _
                            " WHERE  (dbo.tbl_tyres.fittingStatusId = 2) " & _
                            " GROUP BY dbo.tbl_vehicleData.fleetId, dbo.tbl_vehicleData.registrationNumber, dbo.tbl_vehicleData.vehicleType, dbo.tbl_vehicleData.make, dbo.tbl_vehicleData.model "

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            db.ExecuteDataSet(CommandType.Text, sql)

            With gwGrid
                Try
                    .DataSource = ds
                    .DataBind()

                Catch ex As Exception
                    '  log.Error(ex.Message)
                End Try
            End With
        Catch ex As Exception
            'log.Error(ex)
        End Try

    End Sub

End Class