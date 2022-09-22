
Imports Telerik.Web.UI
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing

Public Class LoggedTripsList
    Inherits System.Web.UI.Page
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        loadLoggedTrips()
    End Sub

    Private Sub loadLoggedTrips()
        Dim qry As String = "SELECT DISTINCT tbl_tripLogging.ctr AS ID,  dbo.tbl_vehicleMakes.vehicleMake AS Make, dbo.tbl_vehicleModels.vehicleModel AS Model, " &
                            " dbo.tbl_vehicleData.registrationNumber AS RegNumber, dbo.tbl_vehicleData.fleetId AS FleetID, " &
                            " dbo.tbl_tripLogging.destination AS Destination, CONVERT(VARCHAR(10),dbo.tbl_tripLogging.departureDate,10) AS DepartureDate, " &
                            " dbo.tbl_tripLogging.departureTime AS DepartureTime,  CONVERT(VARCHAR(10),dbo.tbl_tripLogging.expectedReturnDate,10) AS ExpectedReturnDate," &
                            " dbo.tbl_tripLogging.expectedReturnTime AS ExpectedReturnTime, dbo.tbl_tripLogging.returnStatus AS ReturnStatus, " &
                            " CONVERT(VARCHAR(10),dbo.tbl_tripLogging.actualReturnDate,10) AS ActualReturnDate, dbo.tbl_tripLogging.actualReturnTime AS ActualReturnTime " &
                            " FROM dbo.tbl_vehicleModels INNER JOIN dbo.tbl_vehicleMakes ON dbo.tbl_vehicleModels.vehicleMakeId = " &
                            " dbo.tbl_vehicleMakes.vehicleMakeId INNER JOIN dbo.tbl_tripLogging INNER JOIN dbo.tbl_vehicleData ON " &
                            " dbo.tbl_tripLogging.fleetId = dbo.tbl_vehicleData.fleetId ON dbo.tbl_vehicleModels.vehicleModelId = " &
                            " dbo.tbl_vehicleData.modelId ORDER BY ReturnStatus DESC, ExpectedReturnDate "

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, qry)
            db.ExecuteDataSet(CommandType.Text, qry)

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

    Protected Sub cmdAddNew_Click(sender As Object, e As EventArgs) Handles cmdAddNew.Click
        Response.Redirect("~/TripLoggingDetails.aspx")
    End Sub

    Private Sub gwGrid_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles gwGrid.ItemCommand
        If e.CommandName = "View" Then
            Dim item As GridDataItem = e.Item
            Dim ID As String = item("ID").Text
            Response.Redirect("~/TripLoggingDetails.aspx?op=" + ID)
        End If
    End Sub

End Class