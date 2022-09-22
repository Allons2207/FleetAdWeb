Imports Telerik.Web.UI
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data

Public Class VehicleMaintenanceListing
    Inherits System.Web.UI.Page
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ' loadList()
    End Sub

    Private Sub loadList()
        Dim sql As String = "SELECT TOP (100) PERCENT dbo.tbl_vehicleServicingDetails.jobCardNumber AS JobCardNo, dbo.tbl_vehicleServicingDetails.fleetId, " &
               " dbo.tbl_vehicleServicingDetails.regNum AS RegNo, CONVERT(varchar(10), dbo.tbl_vehicleServicingDetails.dateInForService, 10) AS Date," &
               " dbo.tbl_vehicleServicingDetails.typeOfService AS TypeOfService, dbo.tbl_vehicleServicingDetails.mileageOnService AS Mileage, " &
               " CONVERT(varchar(10), dbo.tbl_vehicleServicingDetails.dtDateOutOfService, 10) AS DateOut, " &
               " dbo.tbl_vehicleServicingDetails.serviceFrequency AS ServiceFreq, dbo.tbl_vehicleServicingDetails.mechanic AS Mechanic, " &
               " dbo.tbl_vehicleServicingDetails.totalTimeTaken AS TotalTimeTaken, dbo.tbl_vehicleServicingDetails.otherCosts AS Costs," &
               " dbo.tbl_vehicleServicingDetails.otherCostsValue AS Value, dbo.tbl_vehicleServicingDetails.sundries AS Sundries," &
               " dbo.tbl_vehicleServicingDetails.sundriesCost AS SundriesCost, dbo.tbl_vehicleServicingDetails.totJobCost AS TotalCost, " &
               " dbo.lu_vehicleServiceCategories.serviceCategory FROM     dbo.tbl_vehicleServicingDetails INNER JOIN " &
               " dbo.lu_vehicleServiceCategories ON dbo.tbl_vehicleServicingDetails.serviceCategoryId = dbo.lu_vehicleServiceCategories.serviceCategoryId " &
               "   WHERE  tbl_vehicleServicingDetails.dateInForService >='" & rdFromDate.SelectedDate & "' AND tbl_vehicleServicingDetails.dateInForService <='" & rdToDate.SelectedDate & "'  " &
                " ORDER BY dbo.tbl_vehicleServicingDetails.EntryNo DESC "

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            db.ExecuteDataSet(CommandType.Text, sql)

            With radMaintenance
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
        Response.Redirect("~/VehicleMaintenanceDetails.aspx")
    End Sub

    Private Sub radMaintenance_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles radMaintenance.ItemCommand

        If e.CommandName = "View" Then
            Dim item As GridDataItem = e.Item
            Dim JobCardNo As String = item("JobCardNo").Text
            Response.Redirect("~/VehicleMaintenanceDetails.aspx?op=" + JobCardNo)
        ElseIf e.CommandName = "Delete" Then

            Dim item As GridDataItem = e.Item
            Dim JobCardNo As String = item("JobCardNo").Text
            obj.ConnectionString = con

            Dim qry As String = "DELETE FROM [dbo].[tbl_vehicleServicingDetails] WHERE [jobCardNumber] = '" & JobCardNo & "'"

            If obj.ExecuteNonQRY(qry) = 1 Then
                qry = "DELETE FROM tbl_vehicleServicingDetails WHERE (jobCardNumber = '" & JobCardNo & "') "
                If obj.ExecuteNonQRY(qry) = 1 Then
                    obj.MessageLabel(lblMsg, "Vehicle Maintenance Entry deleted.", "Green")
                    loadList()
                    Exit Sub
                End If
                loadList()
            End If
        End If

    End Sub

    Protected Sub radMaintenance_NeedDataSource(sender As Object, e As GridNeedDataSourceEventArgs) Handles radMaintenance.NeedDataSource
        loadList()
    End Sub

    Private Sub loadMaintenanceDetails()
        Dim qry As String = "Select Case jobCardNumber As JobCardNo, workDone As Workdone, descriptionOfMaterialsUsed As MaterialsUsed, " &
                            " quantityUsed As QuantityUsed, unitPrice As UnitPrice, totalPrice As Total " &
                            " From dbo.tbl_detailedVehicleServiceWorkDone "
        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, qry)
            db.ExecuteDataSet(CommandType.Text, qry)

            With radMaintenance
                Try
                    .DataSource = ds
                    .DataBind()
                    ViewState("dsDetails") = .DataSource
                Catch ex As Exception
                    '  log.Error(ex.Message)
                End Try
            End With
        Catch ex As Exception
            'log.Error(ex)
        End Try

    End Sub

    Private Function JobCardMaintenanceDetails(ByVal jobCardNum As String) As DataSet

        Dim sql As String = "SELECT jobCardNumber AS JobCardNo, workDone AS Workdone, descriptionOfMaterialsUsed AS MaterialsUsed, " &
                            " quantityUsed AS QuantityUsed, unitPrice AS UnitPrice, totalPrice AS Total " &
                            " FROM  dbo.tbl_detailedVehicleServiceWorkDone WHERE jobCardNumber = '" & jobCardNum & "'"

        obj.ConnectionString = con

        Try
            Dim ds As DataSet = obj.ExecuteDsQRY(sql)
            If ds.Tables(0).Rows.Count > 0 Then
                JobCardMaintenanceDetails = ds
            Else
                Return Nothing
            End If
        Catch ex As Exception
        End Try

    End Function

    Private Sub radMaintenance_DetailTableDataBind(sender As Object, e As Telerik.Web.UI.GridDetailTableDataBindEventArgs) Handles radMaintenance.DetailTableDataBind
        Try
            Dim dataItem As Telerik.Web.UI.GridDataItem = CType(e.DetailTableView.ParentItem, Telerik.Web.UI.GridDataItem)

            If e.DetailTableView.Name = "dsDetails" Then
                e.DetailTableView.DataSource = JobCardMaintenanceDetails(dataItem.GetDataKeyValue("JobCardNo").ToString())
            End If
        Catch ex As Exception

        End Try

    End Sub

    Protected Sub cmdExportToExcel_Click(sender As Object, e As EventArgs) Handles cmdExportToExcel.Click
        With radMaintenance
            .ExportSettings.Excel.Format = GridExcelExportFormat.ExcelML
            .ExportSettings.IgnorePaging = True
            .ExportSettings.ExportOnlyData = True
            .ExportSettings.OpenInNewWindow = True
            .MasterTableView.ExportToExcel()
        End With
    End Sub

    Protected Sub cmdShow_Click(sender As Object, e As EventArgs) Handles cmdShow.Click
        loadList()
    End Sub

End Class