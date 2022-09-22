
Imports Telerik.Web.UI
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing
Public Class WrittenOffVehiclesList
    Inherits System.Web.UI.Page
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        loadList()
    End Sub

    Protected Sub cmdAddNew_Click(sender As Object, e As EventArgs) Handles cmdAddNew.Click
        Response.Redirect("~/VehicleWriteOff.aspx")
    End Sub

    Private Sub loadList()

        Dim sql As String = "SELECT TOP (100) PERCENT  Convert(VARCHAR(10), dbo.tbl_vehiclesWrittenOffHistory.dateWrittenOff, 10) AS DateWrittenOff, " & _
                            " dbo.tbl_vehiclesWrittenOffHistory.regNumber AS RegNumber, dbo.tbl_vehiclesWrittenOffHistory.fleetId AS " & _
                            " FleetID, dbo.tbl_vehicleMakes.vehicleMake AS Make, dbo.tbl_vehicleModels.vehicleModel AS Model, " & _
                            " dbo.tbl_vehiclesWrittenOffHistory.reason AS ReasonForWrittingOff FROM            dbo.tbl_vehicleModels INNER JOIN " & _
                            " dbo.tbl_vehicleMakes ON dbo.tbl_vehicleModels.vehicleMakeId = dbo.tbl_vehicleMakes.vehicleMakeId INNER JOIN " & _
                            " dbo.tbl_vehiclesWrittenOffHistory INNER JOIN dbo.tbl_vehicleData ON dbo.tbl_vehiclesWrittenOffHistory.regNumber = " & _
                            " dbo.tbl_vehicleData.registrationNumber ON dbo.tbl_vehicleModels.vehicleModelId = dbo.tbl_vehicleData.modelId " & _
                            " ORDER BY DateWrittenOff DESC "


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

    Private Sub gwGrid_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles gwGrid.ItemCommand
        If e.CommandName = "View" Then
            Dim item As GridDataItem = e.Item
            Dim RegNumber As String = item("RegNumber").Text
            Response.Redirect("~/VehicleWriteOff.aspx?op=" + RegNumber)
        End If
    End Sub


End Class