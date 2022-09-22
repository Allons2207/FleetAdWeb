
Imports Telerik.Web.UI
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing
Public Class DisposedVehiclesList
    Inherits System.Web.UI.Page
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        loadList()
    End Sub

    Protected Sub cmdAddNew_Click(sender As Object, e As EventArgs) Handles cmdAddNew.Click

        Response.Redirect("~/VehicleDisposalDetails.aspx")

    End Sub

    Private Sub gwGrid_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles gwGrid.ItemCommand
        If e.CommandName = "View" Then

            Dim item As GridDataItem = e.Item
            Dim RegNo As String = item("RegNo").Text
            Response.Redirect("~/VehicleDisposalDetails.aspx?op=" + RegNo)
        End If
    End Sub
    Private Sub loadList()

        Dim sql As String = "SELECT DISTINCT Convert(VARCHAR(10), dtDate, 10) AS DateDisposed, make AS Make, model AS Model, fleetId AS FleetID, " &
                            " regNumba AS RegNo, reasonForDisposal AS ReasonForDisposal, comments AS Comments " &
                            " FROM dbo.tbl_vehiclesDisposalHistory ORDER BY DateDisposed DESC "
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

    Protected Sub gwGrid_NeedDataSource(sender As Object, e As GridNeedDataSourceEventArgs) Handles gwGrid.NeedDataSource

    End Sub
End Class