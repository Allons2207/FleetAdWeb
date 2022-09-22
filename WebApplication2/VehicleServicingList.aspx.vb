Imports Telerik.Web.UI
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing

Public Class VehicleServicingList
    Inherits System.Web.UI.Page
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        loadList()
    End Sub

    Private Sub loadList()

        'Dim sql As String = "SELECT jobCardNumber AS [JobCard_#], fleetId AS [FleetID], regNum AS [RegNo], Convert(varchar(10), dateInForService,10) AS Date, " &
        '                    " typeOfService AS [TypeOfService], mileageOnService AS Mileage, Convert(varchar(10), dtDateOutOfService,10) AS DateOut, " &
        '                    " serviceFrequency AS [ServiceFreq], mechanic AS Mechanic, totalTimeTaken AS [TotalTimeTaken], " &
        '                    " otherCosts AS Costs, otherCostsValue AS Value, sundries AS Sundries, sundriesCost AS [SundriesCost], " &
        '                    " totJobCost AS [TotalCost] FROM dbo.tbl_vehicleServicingDetails ORDER BY EntryNo DESC "


        Dim sql As String = "SELECT TOP (100) PERCENT dbo.tbl_vehicleServicingDetails.jobCardNumber AS JobCard_#, dbo.tbl_vehicleServicingDetails.fleetId, " &
               " dbo.tbl_vehicleServicingDetails.regNum AS RegNo, CONVERT(varchar(10), dbo.tbl_vehicleServicingDetails.dateInForService, 10) AS Date," &
               " dbo.tbl_vehicleServicingDetails.typeOfService AS TypeOfService, dbo.tbl_vehicleServicingDetails.mileageOnService AS Mileage, " &
               " CONVERT(varchar(10), dbo.tbl_vehicleServicingDetails.dtDateOutOfService, 10) AS DateOut, " &
               " dbo.tbl_vehicleServicingDetails.serviceFrequency AS ServiceFreq, dbo.tbl_vehicleServicingDetails.mechanic AS Mechanic, " &
               " dbo.tbl_vehicleServicingDetails.totalTimeTaken AS TotalTimeTaken, dbo.tbl_vehicleServicingDetails.otherCosts AS Costs," &
               " dbo.tbl_vehicleServicingDetails.otherCostsValue AS Value, dbo.tbl_vehicleServicingDetails.sundries AS Sundries," &
               " dbo.tbl_vehicleServicingDetails.sundriesCost AS SundriesCost, dbo.tbl_vehicleServicingDetails.totJobCost AS TotalCost, " &
               " dbo.lu_vehicleServiceCategories.serviceCategory FROM     dbo.tbl_vehicleServicingDetails INNER JOIN " &
               " dbo.lu_vehicleServiceCategories ON dbo.tbl_vehicleServicingDetails.serviceCategoryId = dbo.lu_vehicleServiceCategories.serviceCategoryId " &
                " ORDER BY dbo.tbl_vehicleServicingDetails.EntryNo DESC "

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
        Response.Redirect("~/VehicleMaintenanceDetails.aspx")
    End Sub

    Private Sub gwGrid_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles gwGrid.ItemCommand

        'If e.CommandName = "View" Then

        '    Dim item As GridDataItem = e.Item
        '    Dim RegNo As String = item("RegNo").Text
        '    Response.Redirect("~\VehicleDetails.aspx?op=" + RegNo)
        'End If

        If e.CommandName = "View" Then
            Dim item As GridDataItem = e.Item
            Dim JobCardNo As String = item("JobCard_#").Text
            Response.Redirect("~/VehicleMaintenanceDetails.aspx?op=" + JobCardNo)
        ElseIf e.CommandName = "Delete" Then

            Dim item As GridDataItem = e.Item
            Dim JobCardNo As String = item("JobCard_#").Text
            obj.ConnectionString = con

            Dim qry As String = "DELETE FROM [dbo].[tbl_vehicleServicingDetails] WHERE [jobCardNumber] = '" & JobCardNo & "'"
            '"DELETE FROM [dbo].[tbl_vehicleServicingDetails] WHERE [jobCardNumber] = '" & JobCardNo & "'"

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

    Protected Sub gwGrid_NeedDataSource(sender As Object, e As GridNeedDataSourceEventArgs) Handles gwGrid.NeedDataSource
        loadList()
    End Sub


End Class