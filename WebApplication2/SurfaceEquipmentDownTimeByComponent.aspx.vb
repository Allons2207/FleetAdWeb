Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Telerik.Web.UI

Public Class SurfaceEquipmentDownTimeByComponent
    Inherits System.Web.UI.Page
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then

            obj.loadComboBox(cboAssetType, "SELECT SurfaceEquipmentTypeID, SurfaceEquipmentType FROM tblSurfaceEquipmentTypes", "SurfaceEquipmentType", "SurfaceEquipmentTypeID")
            obj.loadComboBox(cboEquipmentCategory, "SELECT [SurfaceEquipmentCategoryID], [SurfaceEquipmentCategory] FROM [dbo].[luSurfaceEquipmentCategory]", "SurfaceEquipmentCategory", "SurfaceEquipmentCategoryID")

        End If

    End Sub

    Private Sub loadSurfaceEquipment()

        Dim ds As DataSet = New DataSet
        Dim dt As New DataTable
        ds.Tables.Add(dt)

        Dim dtDate As Date = rdFromDate.SelectedDate
        Dim dtDateCol As New DataColumn("dtDate", GetType(Date))
        dt.Columns.Add(dtDateCol)
        dt.AcceptChanges()

        Do While dtDate <= rdToDate.SelectedDate
            Dim dtRow As DataRow = dt.NewRow
            dtRow("dtDate") = dtDate
            dt.Rows.Add(dtRow)

            dtDate = dtDate.AddDays(1)
        Loop

        gwGrid.DataSource = dt
        Session("SurfaceEquipment") = dt
        gwGrid.DataBind()

        btnSave.Enabled = False

    End Sub


    Private Sub SaveSurfaceEquipmentBreakdownFreq()

        Dim txtMaintenance As New TextBox
        Dim txtBreakdowns As New TextBox
        Dim txtAvailable As New TextBox
        Dim txtAvailability As New TextBox
        Dim txtEngine As New TextBox
        Dim txtBucket_Ripper_repair As New TextBox

        Dim txtPower_Train_System As New TextBox
        Dim txtSteering_Brakes As New TextBox
        Dim txtHydraulics_Hose_Burst As New TextBox
        Dim txtElectrical_Batteries As New TextBox
        Dim txtOil_analysis_results As New TextBox
        Dim txtBody_repairs_Accident_damage As New TextBox
        Dim txtTyre_puncture_replacement As New TextBox
        Dim txtCooling_System_Radiator As New TextBox
        Dim txtDrive_train_system As New TextBox
        Dim txtUndercarriage As New TextBox
        Dim txtBoom_assembly_repairs As New TextBox
        Dim txtStatus_report As New TextBox
        Dim txtMast_Assembly_Fork_Carriage_repairs As New TextBox
        Dim txtLoading_Chains As New TextBox
        Dim txtBlower_bearing_repairs_Outrigger As New TextBox
        Dim txtBackhoe_repairs_Counter_weights As New TextBox

        Dim dtDate As New Date

        For Each gridRow As GridDataItem In gwGrid.Items

            Try

                Dim qry As String = ""

                dtDate = gridRow("dtDate").Text

                txtMaintenance = gridRow.FindControl("txtMaintenance")
                txtBreakdowns = gridRow.FindControl("txtBreakdowns")
                txtAvailable = gridRow.FindControl("txtAvailable")
                txtAvailability = gridRow.FindControl("txtAvailability")
                txtEngine = gridRow.FindControl("txtEngine")
                txtBucket_Ripper_repair = gridRow.FindControl("txtBucket_Ripper_repair")

                txtPower_Train_System = gridRow.FindControl("txtPower_Train_System")
                txtSteering_Brakes = gridRow.FindControl("txtSteering_Brakes")
                txtHydraulics_Hose_Burst = gridRow.FindControl("txtHydraulics_Hose_Burst")
                txtElectrical_Batteries = gridRow.FindControl("txtElectrical_Batteries")
                txtOil_analysis_results = gridRow.FindControl("txtOil_analysis_results")
                txtBody_repairs_Accident_damage = gridRow.FindControl("txtBody_repairs_Accident_damage")
                txtTyre_puncture_replacement = gridRow.FindControl("txtTyre_puncture_replacement")
                txtCooling_System_Radiator = gridRow.FindControl("txtCooling_System_Radiator")
                txtDrive_train_system = gridRow.FindControl("txtDrive_train_system")
                txtUndercarriage = gridRow.FindControl("txtUndercarriage")
                txtBoom_assembly_repairs = gridRow.FindControl("txtBoom_assembly_repairs")
                txtStatus_report = gridRow.FindControl("txtStatus_report")
                txtMast_Assembly_Fork_Carriage_repairs = gridRow.FindControl("txtMast_Assembly_Fork_Carriage_repairs")
                txtLoading_Chains = gridRow.FindControl("txtLoading_Chains")
                txtBlower_bearing_repairs_Outrigger = gridRow.FindControl("txtBlower_bearing_repairs_Outrigger")
                txtBackhoe_repairs_Counter_weights = gridRow.FindControl("txtBackhoe_repairs_Counter_weights")


                txtBreakdowns.Text = Val(txtEngine.Text) + Val(txtBucket_Ripper_repair.Text) + Val(txtPower_Train_System.Text) +
                    Val(txtSteering_Brakes.Text) + Val(txtHydraulics_Hose_Burst.Text) + Val(txtElectrical_Batteries.Text) + Val(txtOil_analysis_results.Text) +
                    Val(txtBody_repairs_Accident_damage.Text) + Val(txtTyre_puncture_replacement.Text) + Val(txtCooling_System_Radiator.Text) +
                    Val(txtUndercarriage.Text) + Val(txtBoom_assembly_repairs.Text) + Val(txtStatus_report.Text) + Val(txtMast_Assembly_Fork_Carriage_repairs.Text) +
                    Val(txtLoading_Chains.Text) + Val(txtBlower_bearing_repairs_Outrigger.Text) + Val(txtBackhoe_repairs_Counter_weights.Text)

                txtAvailable.Text = 24 - (Val(txtMaintenance.Text) + Val(txtBreakdowns.Text))
                txtAvailability.Text = Int((Val(txtAvailable.Text) / 24) * 100)
                txtAvailability.Text = txtAvailability.Text


                qry = "DELETE FROM tblSurfaceEquipmentBreakdownFrequency WHERE EquipmentID = " & txtSurfaceEquipmentID.Text & " AND reportingYear = " & radYear.Text &
                    " AND   reportingMonth = " & radMonth.SelectedValue & " AND dtDate = '" & dtDate & "' "

                db.ExecuteNonQuery(CommandType.Text, qry)

                qry = "INSERT tblSurfaceEquipmentBreakdownFrequency ([reportingYear],[reportingMonth], EquipmentID, dtDate,Maintenance,Breakdowns,Available,[Availability],Engine,[Bucket/Ripper repair] , " &
                      " [Power Train System] ,	[Steering/Brakes] , [Hydraulics/Hose Burst] ,[Electrical/Batteries] ,	" &
                        " [Oil analysis results - Critical/urgent] ,[Body repairs/Accident damage] ,[Tyre puncture/replacement] ,	[Cooling System/Radiator] ,	" &
                        " [Drive train system] ,[Undercarriage] ,	[Boom assembly repairs] ,[Status report] ,[Mast Assembly/Fork Carriage repairs] ,	" &
                        " [Loading Chains] ,[Backhoe repairs - Counter weights/tow hitch repairs] ) " &
                        " VALUES (" & radYear.Text & "," & radMonth.SelectedValue & "," & txtSurfaceEquipmentID.Text & " ,'" & dtDate & "'," & Val(txtMaintenance.Text) & "," & txtBreakdowns.Text & "," & Val(txtAvailable.Text) &
                        "," & Val(txtAvailability.Text) & "," & Val(txtEngine.Text) & "," & Val(txtBucket_Ripper_repair.Text) & ", " &
                        Val(txtPower_Train_System.Text) & "," & Val(txtSteering_Brakes.Text) & "," & txtHydraulics_Hose_Burst.Text & "," & Val(txtElectrical_Batteries.Text) & "," &
                        Val(txtOil_analysis_results.Text) & "," & Val(txtBody_repairs_Accident_damage.Text) & "," & Val(txtTyre_puncture_replacement.Text) & "," &
                        Val(txtCooling_System_Radiator.Text) & "," & Val(txtDrive_train_system.Text) & "," & Val(txtUndercarriage.Text) & "," & Val(txtBoom_assembly_repairs.Text) & "," &
                        Val(txtStatus_report.Text) & "," & Val(txtMast_Assembly_Fork_Carriage_repairs.Text) & "," & Val(txtLoading_Chains.Text) & "," & Val(txtBackhoe_repairs_Counter_weights.Text) & ") "

                db.ExecuteNonQuery(CommandType.Text, qry)
            Catch ex As Exception
                lblMsg.Text = ex.Message
            End Try
        Next

    End Sub

    Protected Sub btnAutoFill_Click(sender As Object, e As EventArgs) Handles btnAutoFill.Click
        loadSurfaceEquipment()
    End Sub

    Protected Sub btnProcess_Click(sender As Object, e As EventArgs) Handles btnProcess.Click

        For Each gridRow As GridDataItem In gwGrid.Items

            Dim txtMaintenance As New TextBox
            Dim txtBreakdowns As New TextBox
            Dim txtAvailable As New TextBox
            Dim txtAvailability As New TextBox
            Dim txtEngine As New TextBox
            Dim txtBucket_Ripper_repair As New TextBox


            Dim txtPower_Train_System As New TextBox
            Dim txtSteering_Brakes As New TextBox
            Dim txtHydraulics_Hose_Burst As New TextBox
            Dim txtElectrical_Batteries As New TextBox
            Dim txtOil_analysis_results As New TextBox
            Dim txtBody_repairs_Accident_damage As New TextBox
            Dim txtTyre_puncture_replacement As New TextBox
            Dim txtCooling_System_Radiator As New TextBox
            Dim txtUndercarriage As New TextBox
            Dim txtBoom_assembly_repairs As New TextBox
            Dim txtStatus_report As New TextBox
            Dim txtMast_Assembly_Fork_Carriage_repairs As New TextBox
            Dim txtLoading_Chains As New TextBox
            Dim txtBlower_bearing_repairs_Outrigger As New TextBox
            Dim txtBackhoe_repairs_Counter_weights As New TextBox

            txtMaintenance = gridRow.FindControl("txtMaintenance")
            txtBreakdowns = gridRow.FindControl("txtBreakdowns")
            txtAvailable = gridRow.FindControl("txtAvailable")
            txtAvailability = gridRow.FindControl("txtAvailability")
            txtEngine = gridRow.FindControl("txtEngine")
            txtBucket_Ripper_repair = gridRow.FindControl("txtBucket_Ripper_repair")

            txtPower_Train_System = gridRow.FindControl("txtPower_Train_System")
            txtSteering_Brakes = gridRow.FindControl("txtSteering_Brakes")
            txtHydraulics_Hose_Burst = gridRow.FindControl("txtHydraulics_Hose_Burst")
            txtElectrical_Batteries = gridRow.FindControl("txtElectrical_Batteries")
            txtOil_analysis_results = gridRow.FindControl("txtOil_analysis_results")
            txtBody_repairs_Accident_damage = gridRow.FindControl("txtBody_repairs_Accident_damage")
            txtTyre_puncture_replacement = gridRow.FindControl("txtTyre_puncture_replacement")
            txtCooling_System_Radiator = gridRow.FindControl("txtCooling_System_Radiator")
            txtUndercarriage = gridRow.FindControl("txtUndercarriage")
            txtBoom_assembly_repairs = gridRow.FindControl("txtBoom_assembly_repairs")
            txtStatus_report = gridRow.FindControl("txtStatus_report")
            txtMast_Assembly_Fork_Carriage_repairs = gridRow.FindControl("txtMast_Assembly_Fork_Carriage_repairs")
            txtLoading_Chains = gridRow.FindControl("txtLoading_Chains")
            txtBlower_bearing_repairs_Outrigger = gridRow.FindControl("txtBlower_bearing_repairs_Outrigger")
            txtBackhoe_repairs_Counter_weights = gridRow.FindControl("txtBackhoe_repairs_Counter_weights")

            '  txtAvailability = gridRow.Item("Availability").FindControl("txtAvailability")
            txtBreakdowns.Text = Val(txtEngine.Text) + Val(txtBucket_Ripper_repair.Text) + Val(txtPower_Train_System.Text) +
                Val(txtSteering_Brakes.Text) + Val(txtHydraulics_Hose_Burst.Text) + Val(txtElectrical_Batteries.Text) + Val(txtOil_analysis_results.Text) +
                Val(txtBody_repairs_Accident_damage.Text) + Val(txtTyre_puncture_replacement.Text) + Val(txtCooling_System_Radiator.Text) +
                Val(txtUndercarriage.Text) + Val(txtBoom_assembly_repairs.Text) + Val(txtStatus_report.Text) + Val(txtMast_Assembly_Fork_Carriage_repairs.Text) +
                Val(txtLoading_Chains.Text) + Val(txtBlower_bearing_repairs_Outrigger.Text) + Val(txtBackhoe_repairs_Counter_weights.Text)

            txtAvailable.Text = 24 - (Val(txtMaintenance.Text) + Val(txtBreakdowns.Text))
            txtAvailability.Text = Int((Val(txtAvailable.Text) / 24) * 100)
            txtAvailability.Text = txtAvailability.Text & "%"


        Next



        btnSave.Enabled = True

    End Sub

    Private Sub loadAssets()

        Dim qry As String = "Select AssetNumber, SurfaceEquipmentID From dbo.tblSurfaceEquipment " &
                            " Where (AssetTypeID = " & cboAssetType.SelectedValue & ") And (AssetCategoryID = " & cboEquipmentCategory.SelectedValue & ") "

        obj.loadComboBox(cboAssetNumber, qry, "AssetNumber", "SurfaceEquipmentID")

    End Sub
    Protected Sub gwGrid_NeedDataSource(sender As Object, e As GridNeedDataSourceEventArgs) Handles gwGrid.NeedDataSource
        gwGrid.DataSource = Session("SurfaceEquipment")
    End Sub

    Protected Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click

        If txtSurfaceEquipmentID.Text = "" Then

            Exit Sub
        End If

        SaveSurfaceEquipmentBreakdownFreq()

    End Sub

    Protected Sub cboEquipmentCategory_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboEquipmentCategory.SelectedIndexChanged
        loadAssets()
    End Sub

    Protected Sub cboAssetType_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboAssetType.SelectedIndexChanged
        loadAssets()
    End Sub

    Protected Sub cboAssetNumber_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboAssetNumber.SelectedIndexChanged

        txtDescription.Text = ""
        txtSurfaceEquipmentID.Text = ""

        Dim qry As String = "SELECT [Description],SurfaceEquipmentID  FROM     dbo.tblSurfaceEquipment WHERE SurfaceEquipmentID = " & cboAssetNumber.SelectedValue

        Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, qry)

        If ds.Tables(0).Rows.Count > 0 Then
            txtDescription.Text = ds.Tables(0).Rows(0).Item("Description")
            txtSurfaceEquipmentID.Text = ds.Tables(0).Rows(0).Item("SurfaceEquipmentID")
        End If

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