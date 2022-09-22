
Imports Telerik.Web.UI
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing
Public Class VehicleUsersRetestsList
    Inherits System.Web.UI.Page
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        loadList()
    End Sub

    Protected Sub cmdAddNew_Click(sender As Object, e As EventArgs) Handles cmdAddNew.Click
        Response.Redirect("~/RetestDetails.aspx")
    End Sub

    Private Sub loadList()

        Dim sql As String = "SELECT TOP (100) PERCENT  Convert(VARCHAR(10), dbo.tbl_vehicleUserRetests.examDate, 10) AS DateRetested, " &
                            "  Convert(VARCHAR(10), dbo.tbl_vehicleUserRetests.expiryDate, 10) AS ExpiryDate, " &
                            " dbo.tbl_vehicleUsers.firstName AS Firstname,  dbo.tbl_vehicleUsers.surname AS Surname, " &
                            " dbo.tbl_vehicleUsers.department AS Department, dbo.tbl_vehicleUsers.position AS Position, dbo.tbl_vehicleUsers.licenseNumber " &
                            " AS LicenseNo,  dbo.tbl_vehicleUserRetests.nationalIdNum AS NationalIDNo, DateDiff(MM, GETDATE(), dbo.tbl_vehicleUserRetests.expiryDate) As MonthsToExpiryDate FROM  " &
                            " dbo.tbl_vehicleUsers INNER JOIN dbo.tbl_vehicleUserRetests ON dbo.tbl_vehicleUsers.licenseNumber = " &
                            " dbo.tbl_vehicleUserRetests.licenseNumber ORDER BY MonthsToExpiryDate ASC "

        '  , DateDiff(MM, GETDATE(), dbo.tbl_vehicleUserRetests.expiryDate) As MonthsToExpiryDate
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
            Dim LicenseNo As String = item("LicenseNo").Text
            Response.Redirect("~/RetestDetails.aspx?op=" + LicenseNo)
        End If
    End Sub

    Private Sub gwGrid_ItemDataBound(sender As Object, e As Telerik.Web.UI.GridItemEventArgs) Handles gwGrid.ItemDataBound
        If TypeOf e.Item Is GridDataItem Then

            Dim gridItem As GridDataItem = e.Item

            If Val(gridItem("MonthsToExpiryDate").Text) <= 0 Then
                gridItem.BackColor = Drawing.Color.Red
            ElseIf Val(gridItem("MonthsToExpiryDate").Text) = 1 Then
                gridItem.BackColor = Drawing.Color.Orange
            ElseIf Val(gridItem("MonthsToExpiryDate").Text) = 2 Then
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