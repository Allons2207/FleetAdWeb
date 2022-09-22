Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Telerik.Web.UI

Public Class SurfaceEquipmentWeeklyOperations
    Inherits System.Web.UI.Page
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Public masterDataset As DataSet
    Dim saveMode As Boolean

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            loadSurfaceEquipment()
            extendDataGridFields()
            btnSave.Enabled = False
            '  radMonth.Items.Insert(0, New RadComboBoxItem("--Select--", ""))
        End If
    End Sub

    Private Sub loadSurfaceEquipment()

        Dim qry As String = " SELECT SE.SurfaceEquipmentID, dbo.tblSurfaceEquipmentTypes.SurfaceEquipmentType, SE.AssetNumber, SE.Description " &
                            " From dbo.tblSurfaceEquipment AS SE INNER Join dbo.tblSurfaceEquipmentTypes ON SE.AssetTypeID = dbo.tblSurfaceEquipmentTypes.SurfaceEquipmentTypeID "

        Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, qry)

        With gwGrid
            .DataSource = ds
            .DataBind()
            masterDataset = ds
            Session("DataList") = ds

        End With


    End Sub
    Private Sub extendDataGridFields()

        masterDataset = Session("DataList")

        Dim OpeningHrs As New DataColumn("OpeningHrs", GetType(Decimal))
        Dim ClosingHrs As New DataColumn("ClosingHrs", GetType(Decimal))
        Dim TotalHrs As New DataColumn("TotalHrs", GetType(Decimal))
        Dim MaintHrs As New DataColumn("MaintHrs", GetType(Decimal))
        Dim BrkDownHrs As New DataColumn("BrkDownHrs", GetType(Decimal))
        Dim TotalDwnTime As New DataColumn("TotalDwnTime", GetType(Decimal))
        Dim AvailableHrs As New DataColumn("AvailableHrs", GetType(Decimal))
        Dim PlannedTime As New DataColumn("PlannedTime", GetType(Decimal))
        Dim Availability As New DataColumn("Availability", GetType(Decimal))

        masterDataset.Tables(0).Columns.Add(OpeningHrs)
        masterDataset.Tables(0).Columns.Add(ClosingHrs)
        masterDataset.Tables(0).Columns.Add(TotalHrs)
        masterDataset.Tables(0).Columns.Add(MaintHrs)
        masterDataset.Tables(0).Columns.Add(BrkDownHrs)
        masterDataset.Tables(0).Columns.Add(TotalDwnTime)
        masterDataset.Tables(0).Columns.Add(AvailableHrs)
        masterDataset.Tables(0).Columns.Add(PlannedTime)
        masterDataset.Tables(0).Columns.Add(Availability)
        masterDataset.Tables(0).AcceptChanges()


        Session("DataList") = masterDataset





    End Sub
    Protected Sub btnExportToExcel_Click(sender As Object, e As EventArgs) Handles btnExportToExcel.Click
        With gwGrid
            .ExportSettings.Excel.Format = GridExcelExportFormat.ExcelML
            .ExportSettings.IgnorePaging = True
            .ExportSettings.ExportOnlyData = True
            .ExportSettings.OpenInNewWindow = True
            .MasterTableView.ExportToExcel()
        End With
    End Sub

    Private Sub rowAutoFill()

        masterDataset = Session("DataList")

        Dim rowCounter As Integer = 0

        Try
            For Each gridRow As GridDataItem In gwGrid.Items

                Dim txtOpeningHrs As New TextBox
                Dim txtClosingHrs As New TextBox
                Dim txtTotalHrs As New TextBox

                Dim txtMaintHrs As New TextBox
                Dim txtBrkDownHrs As New TextBox
                Dim txtTotalDwnTime As New TextBox
                Dim txtAvailableHrs As New TextBox
                Dim txtAvailability As New TextBox
                Dim txtPlannedTime As New TextBox

                txtOpeningHrs = gridRow.Item("OpeningHrs").FindControl("txtOpeningHrs")


                txtClosingHrs = gridRow.Item("ClosingHrs").FindControl("txtClosingHrs")
                txtTotalHrs = gridRow.FindControl("txtTotalHrs")

                txtMaintHrs = gridRow.Item("MaintHrs").FindControl("txtMaintHrs")
                txtBrkDownHrs = gridRow.Item("BrkDownHrs").FindControl("txtBrkDownHrs")
                txtTotalDwnTime = gridRow.FindControl("txtTotalDwnTime")
                txtAvailableHrs = gridRow.FindControl("txtAvailableHrs")
                txtAvailability = gridRow.FindControl("txtAvailability")

                txtAvailability = gridRow.Item("Availability").FindControl("txtAvailability")

                txtTotalHrs.Text = Val(txtClosingHrs.Text) - Val(txtOpeningHrs.Text)

                txtTotalDwnTime.Text = Val(txtMaintHrs.Text) + Val(txtBrkDownHrs.Text)

                txtPlannedTime = gridRow.FindControl("txtPlannedTime")

                '  Dim x As Long = rdFromDate.SelectedDate - rdToDate.SelectedDate


                Dim fromDate As Date = rdFromDate.SelectedDate
                Dim toDate As Date = rdToDate.SelectedDate

                txtPlannedTime.Text = (Val(DateDiff(DateInterval.Day, fromDate, toDate)) + 1) * 24

                txtAvailableHrs.Text = Val(txtPlannedTime.Text) - Val(txtTotalDwnTime.Text)

                txtAvailability.Text = (Val(txtAvailableHrs.Text) / Val(txtPlannedTime.Text)) * 100

                txtAvailability.Text = Math.Round(Val(txtAvailability.Text), 0)

                txtAvailability.Text = txtAvailability.Text & "%"

                Dim x As Long = Val(txtAvailableHrs.Text) / Val(txtPlannedTime.Text) * 100
                x = Math.Round(x)

                '  gridRow.Item("OpeningHrs").Text = txtOpeningHrs.Text
                masterDataset.Tables(0).Rows(rowCounter).Item("OpeningHrs") = Val(txtOpeningHrs.Text)
                masterDataset.Tables(0).Rows(rowCounter).Item("ClosingHrs") = Val(txtClosingHrs.Text)
                masterDataset.Tables(0).Rows(rowCounter).Item("TotalHrs") = Val(txtTotalHrs.Text)
                masterDataset.Tables(0).Rows(rowCounter).Item("MaintHrs") = Val(txtMaintHrs.Text)
                masterDataset.Tables(0).Rows(rowCounter).Item("BrkDownHrs") = Val(txtBrkDownHrs.Text)
                masterDataset.Tables(0).Rows(rowCounter).Item("TotalDwnTime") = Val(txtTotalDwnTime.Text)
                masterDataset.Tables(0).Rows(rowCounter).Item("AvailableHrs") = Val(txtAvailableHrs.Text)
                masterDataset.Tables(0).Rows(rowCounter).Item("PlannedTime") = Val(txtPlannedTime.Text)
                masterDataset.Tables(0).Rows(rowCounter).Item("Availability") = Val(txtAvailability.Text)

                masterDataset.Tables(0).AcceptChanges()

                If saveMode = True Then

                    Dim qry As String = ""

                    qry = "DELETE FROM tblSurfaceEquipmentWeeklyOperations WHERE SurfaceEquipmentID =  " & gridRow.Item("SurfaceEquipmentID").Text & "   AND  ( FromDate >= '" & rdFromDate.SelectedDate &
                        "'   And ToDate <= '" & rdToDate.SelectedDate & "' )"

                    db.ExecuteNonQuery(CommandType.Text, qry)

                    qry = " INSERT tblSurfaceEquipmentWeeklyOperations " &
                          " ( FromDate,ToDate, [SurfaceEquipmentID], OpeningHrs, ClosingHrs, TotalRunningHrs, MaintenanceHrs, BreakdownHrs, TotalDownTime, " &
                          " AvailableHrs, PlannedTime, [Availability] )    VALUES ( '" & rdFromDate.SelectedDate & "','" & rdToDate.SelectedDate & "'," & gridRow.Item("SurfaceEquipmentID").Text &
                          "," & Val(txtOpeningHrs.Text) & "," & txtClosingHrs.Text & "," & txtTotalHrs.Text & "," & Val(txtMaintHrs.Text) & "," & txtBrkDownHrs.Text & "," & txtTotalDwnTime.Text & "," & txtAvailableHrs.Text & "," &
                          txtPlannedTime.Text & "," & x & ")  "

                    db.ExecuteNonQuery(CommandType.Text, qry)

                End If

                rowCounter = rowCounter + 1

            Next
            '    LoadClassStudentsAndMarks()

            btnSave.Enabled = True

            Session("DataList") = masterDataset
            gwGrid.DataSource = masterDataset

            '   gwGrid.DataBind()


            LoadEnteredData(masterDataset)

        Catch ex As Exception

        End Try

    End Sub

    Protected Sub btnAutoFill_Click(sender As Object, e As EventArgs) Handles btnAutoFill.Click
        saveMode = False
        rowAutoFill()
    End Sub

    Protected Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click
        saveMode = True
        rowAutoFill()
    End Sub

    Protected Sub gwGrid_NeedDataSource(sender As Object, e As GridNeedDataSourceEventArgs) Handles gwGrid.NeedDataSource

        gwGrid.DataSource = Session("DataList")
        LoadEnteredData(Session("DataList"))

    End Sub


    Private Sub LoadEnteredData(dst As DataSet)

        ' masterDataset = Session("DataList")
        '  On Error Resume Next

        Dim ctrRow As Integer = dst.Tables(0).Rows.Count
        ctrRow = 0

        For Each gridRow As GridDataItem In gwGrid.Items
            Dim txtOpeningHrs As New TextBox
            Dim txtClosingHrs As New TextBox
            Dim txtTotalHrs As New TextBox
            Dim txtMaintHrs As New TextBox
            Dim txtBrkDownHrs As New TextBox
            Dim txtTotalDwnTime As New TextBox
            Dim txtAvailableHrs As New TextBox
            Dim txtPlannedTime As New TextBox
            Dim txtAvailability As New TextBox

            Dim tt As String = dst.Tables(0).Rows(ctrRow).Item("OpeningHrs")

            txtOpeningHrs = gridRow.Item("OpeningHrs").FindControl("txtOpeningHrs")
            txtClosingHrs = gridRow.Item("ClosingHrs").FindControl("txtClosingHrs")
            txtTotalHrs = gridRow.Item("TotalHrs").FindControl("txtTotalHrs")
            txtMaintHrs = gridRow.Item("MaintHrs").FindControl("txtMaintHrs")
            txtBrkDownHrs = gridRow.Item("BrkDownHrs").FindControl("txtBrkDownHrs")
            txtTotalDwnTime = gridRow.Item("TotalDwnTime").FindControl("txtTotalDwnTime")
            txtAvailableHrs = gridRow.Item("AvailableHrs").FindControl("txtAvailableHrs")
            txtPlannedTime = gridRow.Item("PlannedTime").FindControl("txtPlannedTime")
            txtAvailability = gridRow.Item("Availability").FindControl("txtAvailability")

            txtOpeningHrs.Text = dst.Tables(0).Rows(ctrRow).Item("OpeningHrs")
            txtClosingHrs.Text = dst.Tables(0).Rows(ctrRow).Item("ClosingHrs")
            txtTotalHrs.Text = dst.Tables(0).Rows(ctrRow).Item("TotalHrs")
            txtMaintHrs.Text = dst.Tables(0).Rows(ctrRow).Item("MaintHrs")
            txtBrkDownHrs.Text = dst.Tables(0).Rows(ctrRow).Item("BrkDownHrs")
            txtTotalDwnTime.Text = dst.Tables(0).Rows(ctrRow).Item("TotalDwnTime")
            txtAvailableHrs.Text = dst.Tables(0).Rows(ctrRow).Item("AvailableHrs")
            txtPlannedTime.Text = dst.Tables(0).Rows(ctrRow).Item("PlannedTime")
            txtAvailability.Text = dst.Tables(0).Rows(ctrRow).Item("Availability")

            ctrRow = ctrRow + 1

        Next

    End Sub

End Class