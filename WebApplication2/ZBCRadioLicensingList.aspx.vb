
Imports Telerik.Web.UI
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing
Public Class ZBCRadioLicensingList
    Inherits System.Web.UI.Page
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        loadList()
    End Sub

    Protected Sub cmdAddNew_Click(sender As Object, e As EventArgs) Handles cmdAddNew.Click
        Response.Redirect("~/ZBCRadioLicesing.aspx")
    End Sub

    Private Sub loadList()

        Dim sql As String = "SELECT DISTINCT  DateDiff(MM, GETDATE(), dbo.tbl_ZBCLicensing.expiryDate) As MonthsToDueDate,   dbo.tbl_vehicleMakes.vehicleMake AS Make, dbo.tbl_vehicleModels.vehicleModel AS Model, " &
                            " dbo.tbl_ZBCLicensing.fleetId AS FleetId, dbo.tbl_ZBCLicensing.licenseNum AS LicenseNo, " &
                            "  Convert(VARCHAR(10), dbo.tbl_ZBCLicensing.dateIssued, 10) AS DateIssued, Convert(VARCHAR(10), dbo.tbl_ZBCLicensing.expiryDate, 10) AS ExpiryDate, " &
                             " dbo.tbl_ZBCLicensing.commentsNotes AS Notes, dbo.tbl_vehicleData.registrationNumber  AS RegNumber  FROM            dbo.tbl_vehicleModels INNER JOIN " &
                            " dbo.tbl_vehicleMakes ON dbo.tbl_vehicleModels.vehicleMakeId = dbo.tbl_vehicleMakes.vehicleMakeId INNER JOIN " &
                           " dbo.tbl_vehicleData ON dbo.tbl_vehicleModels.vehicleModelId = dbo.tbl_vehicleData.modelId INNER JOIN " &
                         " dbo.tbl_ZBCLicensing ON dbo.tbl_vehicleData.fleetId = dbo.tbl_ZBCLicensing.fleetId " &
                          " ORDER BY MonthsToDueDate ASC "

        '  , DateDiff(MM, GETDATE(), dbo.tbl_ZBCLicensing.expiryDate) As MonthsToDueDate

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

    Private Sub gwGrid_InsertCommand(sender As Object, e As GridCommandEventArgs) Handles gwGrid.InsertCommand
      
    End Sub

    Private Sub gwGrid_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles gwGrid.ItemCommand
        If e.CommandName = "View" Then
            Dim item As GridDataItem = e.Item
            Dim FleetId As String = item("FleetId").Text
            Response.Redirect("~/ZBCRadioLicesing.aspx?op=" + FleetId)
        End If
    End Sub

    Private Sub gwGrid_ItemDataBound(sender As Object, e As Telerik.Web.UI.GridItemEventArgs) Handles gwGrid.ItemDataBound
        If TypeOf e.Item Is GridDataItem Then

            Dim gridItem As GridDataItem = e.Item

            If Val(gridItem("MonthsToDueDate").Text) <= 0 Then
                gridItem.BackColor = Drawing.Color.Red
            ElseIf Val(gridItem("MonthsToDueDate").Text) = 1 Then
                gridItem.BackColor = Drawing.Color.Orange
            ElseIf Val(gridItem("MonthsToDueDate").Text) = 2 Then
                gridItem.BackColor = Drawing.Color.Yellow
            End If
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