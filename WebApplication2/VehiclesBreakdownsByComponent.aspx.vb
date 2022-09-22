Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Telerik.Web.UI

Public Class VehiclesBreakdownsByComponent
    Inherits System.Web.UI.Page
    Dim saveMode As Boolean
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        'If Not IsPostBack Then
        '    obj.loadComboBox(cboFleetID, "SELECT SurfaceEquipmentTypeID, SurfaceEquipmentType FROM tblSurfaceEquipmentTypes", "SurfaceEquipmentType", "SurfaceEquipmentTypeID")
        '    obj.loadComboBox(cboRegNumber, "SELECT SurfaceEquipmentTypeID, SurfaceEquipmentType FROM tblSurfaceEquipmentTypes", "SurfaceEquipmentType", "SurfaceEquipmentTypeID")
        'End If

    End Sub

    Protected Sub btnSearchByFleetID_Click(sender As Object, e As EventArgs) Handles btnSearchByFleetID.Click
        obj.ConnectionString = con
        txtRegNo.Text = obj.fnVehicleRegNumFromFleetID(txtFleetIDSearch.Text)
        obj.MessageLabel(lblMsg, "", "")
        txtFleetID.Text = ""
        '   txtInspectionDetails.Text = ""
        txtMake.Text = ""
        txtModel.Text = ""

        loadVehicleData()

    End Sub

    Private Sub loadVehicleData()

        txtFleetID.Text = ""
        '   txtInspectionDetails.Text = ""
        txtMake.Text = ""
        txtModel.Text = ""

        Dim qry As String = ""

        qry = "SELECT dbo.tbl_vehicleMakes.vehicleMake, dbo.tbl_vehicleModels.vehicleModel, dbo.tbl_vehicleData.registrationNumber," &
                        " dbo.tbl_vehicleData.fleetId FROM dbo.tbl_vehicleModels INNER JOIN dbo.tbl_vehicleMakes ON " &
                           " dbo.tbl_vehicleModels.vehicleMakeId = dbo.tbl_vehicleMakes.vehicleMakeId INNER JOIN dbo.tbl_vehicleData ON " &
                           " dbo.tbl_vehicleModels.vehicleModelId = dbo.tbl_vehicleData.modelId WHERE (dbo.tbl_vehicleData.fleetId = '" & txtFleetIDSearch.Text & "' )"
        Try
            obj.ConnectionString = con
            Dim ds As DataSet = obj.ExecuteDsQRY(qry)
            If ds.Tables(0).Rows.Count > 0 Then
                txtMake.Text = ds.Tables(0).Rows(0).Item("vehicleMake")
                txtModel.Text = ds.Tables(0).Rows(0).Item("vehicleModel")
                txtFleetID.Text = ds.Tables(0).Rows(0).Item("fleetId")
            Else
                obj.MessageLabel(lblMsg, "No such vehicle found under vehicle details.", "Yellow")
            End If
        Catch ex As Exception

        End Try

    End Sub

    Private Sub loadDates()

        Dim ds As DataSet = New DataSet
        Dim dt As New DataTable
        ds.Tables.Add(dt)

        Dim dtDate As Date = rdFromDate.SelectedDate
        Dim dtDateCol As New DataColumn("dtDate", GetType(Date))
        dt.Columns.Add(dtDateCol)
        dt.AcceptChanges()

        Do While dtDate <= rdToDate.SelectedDate
            Dim dtRow As DataRow = dt.NewRow
            dtRow("dtDate") = CDate(dtDate.Day & "/" & dtDate.Month & "/" & dtDate.Year)
            '  dtRow("dtDate") = CDate(dtDate.Day & "/" & dtDate.Month & "/" & dtDate.Year)
            dt.Rows.Add(dtRow)

            dtDate = dtDate.AddDays(1)
        Loop

        gwGrid.DataSource = dt
        Session("SurfaceEquipment") = dt
        gwGrid.DataBind()

    End Sub

    Protected Sub btnAutoFill_Click(sender As Object, e As EventArgs) Handles btnAutoFill.Click
        loadDates()
    End Sub
    Protected Sub btnProcess_Click(sender As Object, e As EventArgs) Handles btnProcess.Click

        saveMode = False
        setGridValues()

    End Sub

    Private Sub setGridValues()

        For Each gridRow As GridDataItem In gwGrid.Items

            Dim txtMaintenance As New TextBox
            Dim txtBreakdowns As New TextBox
            Dim txtAvailable As New TextBox
            Dim txtAvailability As New TextBox
            Dim txtEngine As New TextBox

            Dim txtWindscreen_Replacement As New TextBox
            Dim txtSteering_Brakes As New TextBox
            Dim txtPneumatics_Hose_Burst As New TextBox
            Dim txtElectrical_Batteries As New TextBox
            Dim txtOil_analysis_results As New TextBox
            Dim txtBody_repairs_Accident_damage As New TextBox
            Dim txtTyre_puncture_replacement As New TextBox
            Dim txtCooling_System_Radiator As New TextBox
            Dim txtDrive_train_system As New TextBox
            Dim txtRear_Suspension As New TextBox
            Dim txtFront_Suspension As New TextBox
            Dim txtStatus_report As New TextBox
            Dim txtMounted_Crane As New TextBox
            Dim txtTrailers_FifthWheel_Repais As New TextBox

            Dim dtDate As New Date

            dtDate = CDate(gridRow("dtDate").Text)
            txtMaintenance = gridRow.FindControl("txtMaintenance")
            txtBreakdowns = gridRow.FindControl("txtBreakdowns")
            txtAvailable = gridRow.FindControl("txtAvailable")
            txtAvailability = gridRow.FindControl("txtAvailability")
            txtEngine = gridRow.FindControl("txtEngine")
            txtWindscreen_Replacement = gridRow.FindControl("txtWindscreen_Replacement")
            txtSteering_Brakes = gridRow.FindControl("txtSteering_Brakes")
            txtPneumatics_Hose_Burst = gridRow.FindControl("txtPneumatics_Hose_Burst")
            txtElectrical_Batteries = gridRow.FindControl("txtElectrical_Batteries")
            txtOil_analysis_results = gridRow.FindControl("txtOil_analysis_results")
            txtBody_repairs_Accident_damage = gridRow.FindControl("txtBody_repairs_Accident_damage")
            txtTyre_puncture_replacement = gridRow.FindControl("txtTyre_puncture_replacement")
            txtCooling_System_Radiator = gridRow.FindControl("txtCooling_System_Radiator")
            txtDrive_train_system = gridRow.FindControl("txtDrive_train_system")
            txtRear_Suspension = gridRow.FindControl("txtRear_Suspension")
            txtFront_Suspension = gridRow.FindControl("txtFront_Suspension")
            txtStatus_report = gridRow.FindControl("txtStatus_report")
            txtMounted_Crane = gridRow.FindControl("txtMounted_Crane")
            txtTrailers_FifthWheel_Repais = gridRow.FindControl("txtTrailers_FifthWheel_Repais")

            txtBreakdowns.Text = Val(txtEngine.Text) + Val(txtWindscreen_Replacement.Text) + Val(txtSteering_Brakes.Text) +
              Val(txtPneumatics_Hose_Burst.Text) + Val(txtElectrical_Batteries.Text) + Val(txtOil_analysis_results.Text) + Val(txtBody_repairs_Accident_damage.Text) +
              Val(txtTyre_puncture_replacement.Text) + Val(txtCooling_System_Radiator.Text) + Val(txtDrive_train_system.Text) +
              Val(txtRear_Suspension.Text) + Val(txtFront_Suspension.Text) + Val(txtStatus_report.Text) + Val(txtMounted_Crane.Text) +
              Val(txtTrailers_FifthWheel_Repais.Text)

            txtAvailable.Text = 24 - (Val(txtMaintenance.Text) + Val(txtBreakdowns.Text))
            txtAvailability.Text = Int((Val(txtAvailable.Text) / 24) * 100)
            txtAvailability.Text = txtAvailability.Text & "%"

            If saveMode = True Then
                Dim qry As String = "INSERT [tblVehiclesBreakdownFrequency]  " &
                    " ( [reportingYear],[reportingMonth], FleetID, RegNumber, dtDate, Maintenance, Breakdowns, [Available],[Availability],Engine,	" &
                    " [Windscreen replacement/repairs],[Steering/Brakes], [Pneumatics/Hose Burst], [Electrical/Batteries], " &
                    " [Oil analysis results - Critical/urgent], [Body repairs/Accident damage], [Tyre puncture/ replacement],	" &
                    " [Cooling System/Radiator], [Drive train system - gearbox - clutch], [Rear Suspension/Spring  repairs]," &
                    " [Front suspension/bearing/k- pin  repair] , [Status report], [Mounted crane], [Trailers/Fifth Wheel repairs])  " &
                    " VALUES " &
                    " (" & radYear.SelectedValue & "," & radMonth.SelectedValue & ",'" & txtFleetID.Text & "','" & txtRegNo.Text &
                    "'," & dtDate & "," & Val(txtMaintenance.Text) & "," & Val(txtBreakdowns.Text) & "," & Val(txtAvailable.Text) & "," & Val(txtAvailability.Text) & "," &
                    Val(txtEngine.Text) & "," & Val(txtWindscreen_Replacement.Text) & "," & Val(txtSteering_Brakes.Text) & "," & Val(txtPneumatics_Hose_Burst.Text) & "," &
                    Val(txtElectrical_Batteries.Text) & "," & Val(txtOil_analysis_results.Text) & "," & Val(txtBody_repairs_Accident_damage.Text) & "," &
                    Val(txtTyre_puncture_replacement.Text) & "," & Val(txtCooling_System_Radiator.Text) & "," & Val(txtDrive_train_system.Text) & "," &
                    Val(txtRear_Suspension.Text) & "," & Val(txtFront_Suspension.Text) & "," & Val(txtStatus_report.Text) & "," & Val(txtMounted_Crane.Text) & "," &
                    Val(txtTrailers_FifthWheel_Repais.Text) & ")"

                db.ExecuteNonQuery(CommandType.Text, qry)

            End If
        Next

    End Sub

    Protected Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click

        If validSave() = False Then Exit Sub

        saveMode = True
        setGridValues()

    End Sub


    Private Function validSave() As Boolean

        validSave = False

        If txtFleetID.Text = "" Then
            obj.MessageLabel(lblMsg, "Invalid Fleet ID.", "Red")
            Exit Function
        End If

        validSave = True

    End Function
    Protected Sub cmdFindVehicleDetsByRegNum_Click(sender As Object, e As EventArgs) Handles cmdFindVehicleDetsByRegNum.Click

        obj.MessageLabel(lblMsg, "", "")
        txtFleetID.Text = ""
        txtMake.Text = ""
        txtModel.Text = ""

        obj.ConnectionString = con

        txtFleetIDSearch.Text = obj.fnVehicleFleetIDNumFromRegNum(txtRegNo.Text)
        loadVehicleData()

    End Sub

    Protected Sub gwGrid_NeedDataSource(sender As Object, e As GridNeedDataSourceEventArgs) Handles gwGrid.NeedDataSource
        gwGrid.DataSource = Session("SurfaceEquipment")
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


End Class