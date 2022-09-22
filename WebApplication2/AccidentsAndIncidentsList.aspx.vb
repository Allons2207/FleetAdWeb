
Imports Telerik.Web.UI
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing

Public Class AccidentsAndIncidentsList
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
        Dim sql As String = "SELECT DISTINCT dbo.tbl_accidentsIncidents.[accidentIncidentId]  AS ID,Convert(VARCHAR(10), dbo.tbl_accidentsIncidents.dtAccidentDate, 10) AS AccidentDate, dbo.tbl_accidentsIncidents.tTime AS AccidentTime, " &
                            " dbo.tbl_accidentsIncidents.location AS Location, dbo.tbl_accidentsIncidents.FleetId, " &
                            "  dbo.tbl_vehicleUsers.firstName + ' ' + dbo.tbl_vehicleUsers.surname AS Driver, " &
                            " dbo.tbl_vehicleUsers.department AS Department, dbo.tbl_vehicleUsers.position AS Position, " &
                            " dbo.tbl_vehicleUsers.licenseNumber AS LicenseNo, dbo.tbl_vehicleUsers.nationalIDNo AS NationalIDNo, " &
                            " dbo.tbl_accidentsIncidents.accidentDetails AS Details FROM dbo.tbl_accidentsIncidents INNER JOIN dbo.tbl_vehicleUsers ON dbo.tbl_accidentsIncidents.driverID = dbo.tbl_vehicleUsers.[licenseNumber] "

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

    Protected Sub cmdExportToExcel_Click(sender As Object, e As EventArgs) Handles cmdExportToExcel.Click
        With gwGrid
            .ExportSettings.Excel.Format = GridExcelExportFormat.ExcelML
            .ExportSettings.IgnorePaging = True
            .ExportSettings.ExportOnlyData = True
            .ExportSettings.OpenInNewWindow = True
            .MasterTableView.ExportToExcel()
        End With
    End Sub
End Class