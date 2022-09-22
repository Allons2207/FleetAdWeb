Imports Telerik.Web.UI
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing
Imports System.Data.SqlClient

Public Class VehicleUsersList
    Inherits System.Web.UI.Page

    Dim objCBO As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = objCBO.Database
    Dim con As String = db.ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If (CokkiesWrapper.UserID <= 0 AndAlso Not IsNumeric(CokkiesWrapper.UserID)) Then
            Response.Redirect("../Login.aspx")
            Exit Sub
        End If

        Dim sql As String = "SELECT DISTINCT dbo.tbl_vehicleUsers.surname AS Surname, dbo.tbl_vehicleUsers.firstName AS FirstName, " & _
                            " dbo.tbl_vehicleUsers.department AS Department, dbo.tbl_vehicleUsers.position AS Position, " & _
                            " dbo.tbl_vehicleUsers.nationalIDNo AS NationalIDNo, dbo.tbl_vehicleUsers.licenseNumber AS LicenseNo, " & _
                            "  Convert(VARCHAR(10), dbo.tbl_vehicleUsers.defensiveLicenseExpiryDate, 10) AS DefensiveExpDate, dbo.tbl_allocationStatus.allocationStatus " & _
                            " AS AllocationStatus, dbo.tbl_vehicleMakes.vehicleMake AS Make, dbo.tbl_vehicleModels.vehicleModel AS Model, " & _
                            " dbo.tbl_vehicleUsers.regNumber AS RegNumber FROM            dbo.tbl_allocationStatus INNER JOIN " & _
                            " dbo.tbl_vehicleUsers ON dbo.tbl_allocationStatus.allocationStatusId = dbo.tbl_vehicleUsers.allocationStatusId LEFT OUTER JOIN " & _
                            " dbo.tbl_vehicleModels INNER JOIN dbo.tbl_vehicleMakes ON dbo.tbl_vehicleModels.vehicleMakeId = " & _
                            " dbo.tbl_vehicleMakes.vehicleMakeId INNER JOIN dbo.tbl_vehicleData ON dbo.tbl_vehicleModels.vehicleModelId = " & _
                            " dbo.tbl_vehicleData.modelId ON dbo.tbl_vehicleUsers.regNumber = dbo.tbl_vehicleData.registrationNumber " & _
                            " ORDER BY Surname, FirstName "

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

    Protected Sub cmdAddNew_Click(sender As Object, e As EventArgs) Handles cmdAddNew.Click
        Response.Redirect("~/VehicleUsers.aspx")
    End Sub

    Private Sub gwGrid_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles gwGrid.ItemCommand
        If e.CommandName = "View" Then
            Dim item As GridDataItem = e.Item
            Dim LicenseNo As String = item("LicenseNo").Text
            Response.Redirect("~/VehicleUsers.aspx?op=" + LicenseNo)
        End If
    End Sub

    Protected Sub gwGrid_NeedDataSource(sender As Object, e As GridNeedDataSourceEventArgs) Handles gwGrid.NeedDataSource

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