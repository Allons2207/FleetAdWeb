Imports Telerik.Web.UI
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing

Public Class VehicleMileageUpdatesList

    Inherits System.Web.UI.Page
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        loadList()
    End Sub

    Protected Sub cmdAddNew_Click(sender As Object, e As EventArgs) Handles cmdAddNew.Click
        Response.Redirect("~/VehicleMileageUpdate.aspx")
    End Sub

    Private Sub loadList()

        Dim sql As String = "SELECT TOP 200 tbl_vehicleMileageHistory.ctr AS ID,  CONVERT(VARCHAR(10),dbo.tbl_vehicleMileageHistory.dtDate,10) AS DateUpdated, dbo.tbl_vehicleMileageHistory.registrationNumber AS " &
                            " RegNumber, dbo.tbl_vehicleMileageHistory.fleetId AS FleetID, dbo.tbl_vehicleMakes.vehicleMake AS Make, " &
                            " dbo.tbl_vehicleModels.vehicleModel AS Model, dbo.tbl_vehicleMileageHistory.newMileage AS NewMileage, " &
                            " dbo.tbl_vehicleMileageHistory.oldMileage AS OldMileage, dbo.tbl_vehicleMileageHistory.notes AS Notes " &
                            " FROM  dbo.tbl_vehicleModels INNER JOIN dbo.tbl_vehicleMakes ON dbo.tbl_vehicleModels.vehicleMakeId = " &
                            " dbo.tbl_vehicleMakes.vehicleMakeId INNER JOIN dbo.tbl_vehicleMileageHistory INNER JOIN " &
                            "  dbo.tbl_vehicleData ON dbo.tbl_vehicleMileageHistory.registrationNumber = dbo.tbl_vehicleData.registrationNumber ON " &
                            " dbo.tbl_vehicleModels.vehicleModelId = dbo.tbl_vehicleData.modelId ORDER BY DateUpdated DESC, RegNumber "
        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            db.ExecuteDataSet(CommandType.Text, sql)
            With gwGrid
                .DataSource = ds
                .DataBind()
            End With
        Catch ex As Exception
            '  log.Error(ex)
        End Try

    End Sub

    Private Sub gwGrid_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles gwGrid.ItemCommand

        Dim item As GridDataItem = e.Item
        Dim ID As String = item("ID").Text

        If e.CommandName = "View" Then
            Dim FleetId As String = item("FleetId").Text
            Response.Redirect("~/VehicleMileageUpdate.aspx?op=" + FleetId)
        ElseIf e.CommandName = "Delete" Then
            Dim qry As String = "DELETE FROM tbl_vehicleMileageHistory WHERE ctr = " & ID
            obj.ConnectionString = con

            Try
                If obj.ExecuteNonQRY(qry) = 1 Then
                    obj.MessageLabel(lblMsg, "Record successfully deleted.", "Green")
                    loadList()
                Else
                    obj.MessageLabel(lblMsg, "Error while trying to delete entry.", "Red")
                End If
            Catch ex As Exception
                obj.MessageLabel(lblMsg, "Error while trying to delete entry.", "Red")
            End Try
        End If
    End Sub

    Protected Sub gwGrid_NeedDataSource(sender As Object, e As GridNeedDataSourceEventArgs) Handles gwGrid.NeedDataSource

    End Sub
End Class