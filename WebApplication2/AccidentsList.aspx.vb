Imports Telerik.Web.UI
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing
Public Class AccidentsList
    Inherits System.Web.UI.Page
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        loadList()
    End Sub

    Protected Sub cmdAddNew_Click(sender As Object, e As EventArgs) Handles cmdAddNew.Click
        Response.Redirect("~/AccidentDetails.aspx")
    End Sub

    Private Sub loadList()

        Dim sql As String = " SELECT        TOP (100) PERCENT dbo.tbl_accidentsIncidents.dtAccidentDate AS AccidentDate, " & _
                            " dbo.tbl_accidentsIncidents.tTime AS Time, dbo.tbl_accidentsIncidents.location AS Location, " & _
                            " dbo.tbl_vehicleUsers.surname + ' ' + dbo.tbl_vehicleUsers.firstName AS Driver, dbo.tbl_vehicleUsers.department " & _
                            " AS Department, dbo.tbl_vehicleUsers.position AS Position, dbo.tbl_vehicleMakes.vehicleMake AS VehicleMake, " & _
                            " dbo.tbl_vehicleModels.vehicleModel AS Model, dbo.tbl_vehicleData.registrationNumber AS RegNumber " & _
                            " FROM            dbo.tbl_vehicleUsers INNER JOIN  dbo.tbl_accidentsIncidents ON dbo.tbl_vehicleUsers.nationalIDNo =" & _
                            " dbo.tbl_accidentsIncidents.driverID INNER JOIN dbo.tbl_vehicleModels INNER JOIN " & _
                            " dbo.tbl_vehicleMakes ON dbo.tbl_vehicleModels.vehicleMakeId = dbo.tbl_vehicleMakes.vehicleMakeId INNER JOIN " & _
                            " dbo.tbl_vehicleData ON dbo.tbl_vehicleModels.vehicleModelId = dbo.tbl_vehicleData.modelId ON " & _
                            " dbo.tbl_accidentsIncidents.regNumber = dbo.tbl_vehicleData.registrationNumber " & _
                            " ORDER BY dbo.tbl_vehicleUsers.surname, dbo.tbl_vehicleUsers.firstName "
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
            Dim ID As String = item("ID").Text
            Response.Redirect("~/AccidentDetails.aspx?op=" + ID)
        End If
    End Sub


End Class