Imports Telerik.Web.UI
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing

Public Class ZinaraLicensesList
    Inherits System.Web.UI.Page
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        loadList()
    End Sub

    Protected Sub cmdAddNew_Click(sender As Object, e As EventArgs) Handles cmdAddNew.Click
        Response.Redirect("~/ZinaraLicensing.aspx")
    End Sub

    Private Sub loadList()

        Dim sql As String = "SELECT DISTINCT dbo.tbl_vehicleMakes.vehicleMake AS Make, dbo.tbl_vehicleModels.vehicleModel AS Model, " &
                            " dbo.tbl_ZinaraLicensing.fleetId AS FleetId,   tbl_vehicleData.registrationNumber as RegNumber, dbo.tbl_ZinaraLicensing.licenseNum AS LicenseNo, " &
                            " Convert(VARCHAR(10), dbo.tbl_ZinaraLicensing.dateIssued, 10) AS DateIssued, Convert(VARCHAR(10), dbo.tbl_ZinaraLicensing.expiryDate, 10) AS ExpiryDate, " &
                            " DateDiff(MM, GETDATE(), dbo.tbl_ZinaraLicensing.expiryDate) As MonthsToDueDate, dbo.tbl_ZinaraLicensing.commentsNotes AS Notes FROM            dbo.tbl_vehicleModels INNER JOIN " &
                            " dbo.tbl_vehicleMakes ON dbo.tbl_vehicleModels.vehicleMakeId = dbo.tbl_vehicleMakes.vehicleMakeId INNER JOIN " &
                            " dbo.tbl_ZinaraLicensing INNER JOIN dbo.tbl_vehicleData ON dbo.tbl_ZinaraLicensing.fleetId = " &
                            " dbo.tbl_vehicleData.fleetId ON dbo.tbl_vehicleModels.vehicleModelId = dbo.tbl_vehicleData.modelId " &
                            " ORDER BY MonthsToDueDate ASC "
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
            Dim fleetId As String = item("fleetId").Text
            Response.Redirect("~/ZinaraLicensing.aspx?op=" + fleetId)
        End If
    End Sub

    Protected Sub gwGrid_NeedDataSource(sender As Object, e As GridNeedDataSourceEventArgs) Handles gwGrid.NeedDataSource

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

    '    Protected void grid_ItemDataBound(Object sender, GridItemEventArgs e)
    '{
    ' If (e.Item Is GridDataItem)
    ' {
    '  GridDataItem item = (GridDataItem)e.Item;
    '  TableCell cell = (TableCell)item["UniqueName"];
    '  cell.BackColor = System.Drawing.Color.Red;
    ' }
    '}

    'Protected void gridSearchResults_OnItemDataBound(sender as Object , as GridItemEventArgs )  Handles gwGrid.ItemDataBound
    '{  
    '    If (e.Item Is GridDataItem)
    '    {  
    '        GridDataItem dataItem = (GridDataItem)e.Item;  
    '        TableCell myCell = dataItem["90DaysLate"];  
    '        If ((myCell.Text == "1"))
    '        {  
    '            //dataItem.BackColor = System.Drawing.Color.Red;  
    '            dataItem.ForeColor = System.Drawing.Color.Red;  
    '            dataItem.Font.Bold = true;  
    '        }  
    '     }
    '}


End Class