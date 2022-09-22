
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Telerik.Web.UI
Imports ClassLibrary1

Public Class VehicleFuelingDetails
    Inherits System.Web.UI.Page
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then
            obj.loadComboBox(cboFuelType, "SELECT DISTINCT [fuelTypeId], [fuelType] FROM [dbo].[tbl_fuelTypes]", "fuelType", "fuelTypeId")
            obj.loadComboBox(cboRegNumber, "SELECT DISTINCT [registrationNumber] FROM [dbo].[tbl_vehicleData] ORDER BY registrationNumber", "registrationNumber", "registrationNumber")
            obj.loadComboBox(radMonth, "SELECT [mMonthId], [mMonth] FROM [dbo].[tbl_months]", "mMonth", "mMonthId")
        End If

        If grantPageWriteCommandPermission(CokkiesWrapper.UserID, 17) = True Then
            cmdSave.Enabled = True
            cmdClear.Enabled = True
            If txtEntryNum.Text <> "" Then
                cmdDelete.Enabled = True
            Else
                cmdDelete.Enabled = False
            End If
        Else
            cmdSave.Enabled = False
            cmdClear.Enabled = False
        End If


    End Sub

    Public Function grantPageWriteCommandPermission(ByVal UserId As Integer, pageId As Integer) As Boolean
        grantPageWriteCommandPermission = False
        Dim qry As String = "SELECT * FROM [dbo].[tbl_userSysPermissions] WHERE [userId] = " & UserId & " AND [sysModuleSectionId] = " & pageId & " AND [sysWrite] = 1"

        Try
            obj.ConnectionString = con
            Dim ds As DataSet = obj.ExecuteDsQRY(qry)
            If ds.Tables(0).Rows.Count > 0 Then
                grantPageWriteCommandPermission = True
            End If
        Catch ex As Exception

        End Try

    End Function
    Private Sub loadVehicleData()

        txtFleetID.Text = ""
        '   txtInspectionDetails.Text = ""
        txtMake.Text = ""
        txtModel.Text = ""

        Dim qry As String = "SELECT dbo.tbl_vehicleMakes.vehicleMake, dbo.tbl_vehicleModels.vehicleModel, dbo.tbl_vehicleData.registrationNumber," &
                        "dbo.tbl_vehicleData.[currentMileage]   , dbo.tbl_vehicleData.[lastMileageDate], dbo.tbl_vehicleData.[fuelTypeId], dbo.tbl_vehicleData.[lastServiceDate]," &
                           " dbo.tbl_vehicleData.fleetId FROM dbo.tbl_vehicleModels INNER JOIN dbo.tbl_vehicleMakes ON " &
                           " dbo.tbl_vehicleModels.vehicleMakeId = dbo.tbl_vehicleMakes.vehicleMakeId INNER JOIN dbo.tbl_vehicleData ON " &
                           " dbo.tbl_vehicleModels.vehicleModelId = dbo.tbl_vehicleData.modelId WHERE (dbo.tbl_vehicleData.FleetId = '" & txtFleetIDSearch.Text & "')"

        Try
            obj.ConnectionString = con
            Dim ds As DataSet = obj.ExecuteDsQRY(qry)
            If ds.Tables(0).Rows.Count > 0 Then
                txtMake.Text = ds.Tables(0).Rows(0).Item("vehicleMake")
                txtModel.Text = ds.Tables(0).Rows(0).Item("vehicleModel")
                txtFleetID.Text = ds.Tables(0).Rows(0).Item("fleetId")
                cboFuelType.SelectedValue = ds.Tables(0).Rows(0).Item("fuelTypeId")
                'txtLastRecordedMileage.Text = ds.Tables(0).Rows(0).Item("currentMileage")
                'rdMileageDate.SelectedDate = ds.Tables(0).Rows(0).Item("lastMileageDate")
                loadVehicleFuelingDetails()
            Else
                obj.MessageLabel(lblMsg, "No such vehicle found under vehicle details.", "Yellow")
            End If
        Catch ex As Exception

        End Try

    End Sub

    Protected Sub cboRegNumber_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboRegNumber.SelectedIndexChanged
        clearControls()
        txtRegNo.Text = cboRegNumber.Text
        loadVehicleData()
    End Sub

    Protected Sub cmdSave_Click(sender As Object, e As EventArgs) Handles cmdSave.Click

        If txtOpeningOdometerReadn.Text = "" Or Val(txtOpeningOdometerReadn.Text) = 0 Then
            obj.MessageLabel(lblMsg, "Invalid Opening Odometer Reading.!", "Red")
            Exit Sub
        End If

        If txtClosingOdometerReadn.Text <> "" Or Val(txtClosingOdometerReadn.Text) <> 0 Then
            obj.MessageLabel(lblMsg, "Fueling has been closed for the specified vehicle and month.", "Red")
            Exit Sub
        End If

        If validFuelingDatesDates() = False Then
            Exit Sub
        End If

        If txtRequisitionNo.Text = "" Then
            obj.MessageLabel(lblMsg, "Please enter the requisition number.", "Red")
            Exit Sub
        End If

        If txtEntryNum.Text = "" Then
            insertNewFueling()
        Else
            updateNewFueling()
        End If
        loadVehicleFuelingDetails()

    End Sub
    Private Function validFuelingDatesDates() As Boolean
        Dim intFuelingMonth As Integer = radMonth.SelectedValue
        Dim specifiedFuelingDate As Date = rdFuelingDate.SelectedDate
        Dim impliedFuelingMonth As Integer = Month(specifiedFuelingDate)
        Dim impliedFuelingYear As Integer = Year(specifiedFuelingDate)

        validFuelingDatesDates = False

        If Day(specifiedFuelingDate) > 22 Then
            impliedFuelingMonth = impliedFuelingMonth + 1

            If impliedFuelingMonth > 12 Then
                impliedFuelingMonth = 1
                impliedFuelingYear = impliedFuelingYear + 1
            End If
        End If

        If radYear.SelectedValue <> impliedFuelingYear Then
            obj.MessageLabel(lblMsg, "Fueling date in not consitent with the selected fueling month.", "Red")
            Exit Function
        ElseIf radMonth.SelectedValue <> impliedFuelingMonth Then
            obj.MessageLabel(lblMsg, "Fueling date in not consitent with the selected fueling month.", "Red")
            Exit Function
        End If

        validFuelingDatesDates = True

    End Function

    Private Function openingMileageEntry() As Boolean
        openingMileageEntry = True

        Dim qry As String = "SELECT * FROM [dbo].[tbl_vehicleFuelingDetails] WHERE datepart(yyyy,[fuelingDate]) = " & Year(rdFuelingDate.SelectedDate) &
                            " And DatePart(MM, [fuelingDate]) = " & Month(rdFuelingDate.SelectedDate) & "And [FleetId] = '" & txtFleetID.Text & "' "

        obj.ConnectionString = con

        Try
            Dim ds As DataSet = obj.ExecuteDsQRY(qry)

            If ds.Tables(0).Rows.Count > 0 Then
                openingMileageEntry = False
            End If
        Catch

        End Try

    End Function

    Private Sub insertNewFueling()

        Dim qry As String = "INSERT tbl_vehicleFuelingDetails ( [fuelingDate], [FleetId], [fuelType], quantitySupplied, requisitionNo,OdometerReading, fuelingYear, fuelingMonth)" &
                          " VALUES ('" & rdFuelingDate.SelectedDate & "','" & txtFleetID.Text & "','" & cboFuelType.Text & "'," & Val(txtQtySupplied.Text) &
                            ",'" & txtRequisitionNo.Text & "'," & Val(txtMileageAtFueling.Text) & "," & radYear.SelectedValue & "," & radMonth.SelectedValue & ")"
        '    [fuelingYear] [Int] null,
        '[fuelingMonth] [Int] null
        Try
            obj.ConnectionString = con
            If obj.ExecuteNonQRY(qry) = 1 Then
                obj.MessageLabel(lblMsg, "Vehicle Fueling record saved successfully.", "Green")

                Dim sql As String = "UPDATE tbl_vehicleData SET currentMileage = " & Val(txtMileageAtFueling.Text) & ", lastMileageDate = '" & rdFuelingDate.SelectedDate & "' WHERE fleetId = '" & txtFleetIDSearch.Text & "'"

                obj.ExecuteNonQRY(qry)

                txtEntryNum.Text = ""

                txtRequisitionNo.Text = ""
                rdFuelingDate.Clear()
                txtQtySupplied.Text = ""
                txtMileageAtFueling.Text = ""

            Else
                obj.MessageLabel(lblMsg, "Error while trying to save Vehicle Fueling record.", "Red")
            End If
        Catch ex As Exception
            obj.MessageLabel(lblMsg, "Error while trying to save Vehicle Fueling record.", "Red")
        End Try

    End Sub

    Private Sub updateNewFueling()


        If (txtClosingOdometerReadn.Text <> "" Or Val(txtClosingOdometerReadn.Text) <> 0) And (Val(txtClosingOdometerReadn.Text) < Val(txtOpeningOdometerReadn.Text)) Then
            obj.MessageLabel(lblMsg, "Invalid Odometer readings. Closing Reading cannot be smaller than Opening Reading.", "Red")
            Exit Sub
        End If

        Dim qry As String = "UPDATE tbl_vehicleFuelingDetails SET fuelingDate = '" & rdFuelingDate.SelectedDate & "', FleetId = '" & txtFleetID.Text & "', fuelType = '" & cboFuelType.Text & "',  " &
                            " quantitySupplied = " & Val(txtQtySupplied.Text) &
                            " , Comments = '', requisitionNo = '" & txtRequisitionNo.Text & "',OdometerReading = " & Val(txtMileageAtFueling.Text) &
                            " , fuelingYear = " & radYear.SelectedValue & " ,fuelingMonth = " & radMonth.SelectedValue & "  WHERE [ctr] = " & txtEntryNum.Text
        Try
            obj.ConnectionString = con
            If obj.ExecuteNonQRY(qry) = 1 Then
                obj.MessageLabel(lblMsg, "Fueling record saved updated.", "Green")
                txtEntryNum.Text = ""

                txtRequisitionNo.Text = ""
                rdFuelingDate.Clear()
                txtQtySupplied.Text = ""
                txtMileageAtFueling.Text = ""

                loadVehicleFuelingDetails()
            Else
                obj.MessageLabel(lblMsg, "Error while trying to update record.", "Red")
            End If
        Catch ex As Exception
            obj.MessageLabel(lblMsg, "Error while trying to save record.", "Red")
        End Try

    End Sub

    Private Sub loadVehicleFuelingDetails()

        Dim qry As String = "SELECT   TOP (100) ctr AS EntryNo, fleetId AS FleetId, fuelType AS [Fuel Type], CONVERT(VARCHAR(10),fuelingDate,10) As Date, quantitySupplied AS QtySupplied, Comments, requisitionNo,   " &
                "   OdometerReading  FROM  dbo.tbl_vehicleFuelingDetails WHERE  (fleetId = '" & txtFleetID.Text & "') ORDER BY EntryNo DESC "

        Try
            obj.ConnectionString = con
            Dim ds As DataSet = obj.ExecuteDsQRY(qry)

            With gwGrid
                .DataSource = ds
                .DataBind()
            End With

        Catch ex As Exception
            obj.MessageLabel(lblMsg, "Error While trying To retrieve vehicle fueling record.", "Red")
        End Try

    End Sub

    Private Sub clearControls()

        cboFuelType.ClearSelection()
        txtEntryNum.Text = ""
        txtClosingOdometerReadn.Text = ""
        txtFleetID.Text = ""
        txtMake.Text = ""
        txtModel.Text = ""
        txtOpeningOdometerReadn.Text = ""
        txtQtySupplied.Text = ""
        txtRequisitionNo.Text = ""
        txtMileageAtFueling.Text = ""

        rdFuelingDate.Clear()

        cmdDelete.Enabled = False

        '  lblMsg.Text = ""
        obj.MessageLabel(lblMsg, "", "")

        txtClosingOdometerReadn.Enabled = False

        With gwGrid
            .DataSource = String.Empty
            .DataBind()
        End With

    End Sub

    Private Sub gwGrid_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles gwGrid.ItemCommand
        If e.CommandName = "Edita" Then
            Dim item As GridDataItem = e.Item
            Dim EntryNum As String = item("EntryNo").Text

            'txtClosingOdometerReadn.Text = ""
            'txtOpeningOdometerReadn.Text = ""
            'txtQtySupplied.Text = ""

            txtClosingOdometerReadn.Enabled = True
            '
            Dim qry As String = " Select TOP 1  [ctr], CONVERT(VARCHAR(10),fuelingDate,10) As Date ,[FleetId] ,quantitySupplied, requisitionNo, OdometerReading FROM tbl_vehicleFuelingDetails WHERE  ctr = " & EntryNum &
                "  And  FleetId = '" & txtFleetID.Text & "' ORDER BY ctr"

            obj.ConnectionString = con

            Dim ds As DataSet = obj.ExecuteDsQRY(qry)

            If ds.Tables(0).Rows.Count > 0 Then
                On Error Resume Next
                txtEntryNum.Text = EntryNum
                cmdDelete.Enabled = True

                Dim dt As Date = CDate(ds.Tables(0).Rows(0).Item("Date"))

                rdFuelingDate.SelectedDate = dt
                txtQtySupplied.Text = ds.Tables(0).Rows(0).Item("quantitySupplied")
                txtRequisitionNo.Text = ds.Tables(0).Rows(0).Item("requisitionNo")
                txtMileageAtFueling.Text = ds.Tables(0).Rows(0).Item("OdometerReading")

            Else
                obj.MessageLabel(lblMsg, "Could Not load Fueling Details.", "Red")
            End If
        End If

    End Sub

    Protected Sub gwGrid_NeedDataSource(sender As Object, e As GridNeedDataSourceEventArgs) Handles gwGrid.NeedDataSource

    End Sub

    Protected Sub cmdClear_Click(sender As Object, e As EventArgs) Handles cmdClear.Click
        txtRegNo.Text = ""
        cboRegNumber.ClearSelection()
        clearControls()
    End Sub

    Protected Sub cmdDelete_Click(sender As Object, e As EventArgs) Handles cmdDelete.Click

        obj.ConnectionString = con
        If txtEntryNum.Text = "" Then
            obj.MessageLabel(lblMsg, "Please first Select the entry you want To delete from the grid below.", "Red")
            cmdDelete.Enabled = False
            Exit Sub
        End If

        Dim qry As String = "DELETE FROM tbl_vehicleFuelingDetails WHERE  ctr = " & txtEntryNum.Text

        Try
            obj.ConnectionString = con
            If obj.ExecuteNonQRY(qry) = 1 Then
                obj.MessageLabel(lblMsg, "Fueling record successfully deleted.", "Green")
                loadVehicleFuelingDetails()
            Else
                obj.MessageLabel(lblMsg, "Failed To successfully delete fuelling record.", "Red")
            End If

            cmdDelete.Enabled = False

        Catch ex As Exception
            obj.MessageLabel(lblMsg, "Error While trying To delete fuelling record.", "Red")
        End Try


    End Sub

    Protected Sub cmdClear0_Click(sender As Object, e As EventArgs) Handles cmdClear0.Click
        clearControls()
        obj.ConnectionString = con
        txtFleetIDSearch.Text = obj.fnVehicleFleetIDNumFromRegNum(txtRegNo.Text)
        loadVehicleData()

    End Sub

    Protected Sub btnSearchByFleetID_Click(sender As Object, e As EventArgs) Handles btnSearchByFleetID.Click

        clearControls()
        obj.ConnectionString = con
        txtRegNo.Text = obj.fnVehicleRegNumFromFleetID(txtFleetIDSearch.Text)
        loadVehicleData()

    End Sub

    Protected Sub cmdSave0_Click(sender As Object, e As EventArgs) Handles cmdSave0.Click

        obj.ConnectionString = con

        If txtFleetID.Text = "" Then
            obj.MessageLabel(lblMsg, "Please specify the Vehicle Fleet Number, it cannot be empty.", "Red")
            Exit Sub
        ElseIf obj.fnVehicleExists(txtFleetID.Text) = False
            obj.MessageLabel(lblMsg, "The specified Vehicle Fleet number could Not be found In vehicles data.", "Red")
            Exit Sub
        ElseIf cboFuelType.Text = "" Then
            obj.MessageLabel(lblMsg, "Please specify the Vehicle Fuel type, it cannot be empty.", "Red")
            Exit Sub
        ElseIf cboFuelType.Text = "--Select--" Then
            obj.MessageLabel(lblMsg, "Please specify the Vehicle Fuel type, it cannot be empty.", "Red")
            Exit Sub
        ElseIf Val(txtOpeningOdometerReadn.Text) = 0 Then
            obj.MessageLabel(lblMsg, "Please specify the Vehicle Opening Odometer Reading, it cannot be empty.", "Red")
            Exit Sub
        ElseIf (txtClosingOdometerReadn.Text) <> "" And (Val(txtOpeningOdometerReadn.Text) > Val(txtClosingOdometerReadn.Text)) Then
            obj.MessageLabel(lblMsg, "Closing Odometer value cannot be less than the Opening Odometer value.", "Red")
            Exit Sub
        End If


        Dim qry As String = "Select * FROM tbl_fuelingOdometerReadings WHERE yYear = " & radYear.Text &
                            " And mMonth = " & radMonth.SelectedValue & " And [FleetId] = '" & txtFleetID.Text & "' "

        obj.ConnectionString = con

        Dim ds As DataSet = obj.ExecuteDsQRY(qry)

        If ds.Tables(0).Rows.Count > 0 Then
            If Val(txtClosingOdometerReadn.Text) > 0 Then
                qry = "UPDATE tbl_fuelingOdometerReadings SET openingOdometerReading = " & Val(txtOpeningOdometerReadn.Text) & ", closingOdometerReading = " & Val(txtClosingOdometerReadn.Text) &
                    " WHERE [FleetId] = '" & txtFleetID.Text & "' AND yYear = " & radYear.Text & " AND mMonth = " & radMonth.SelectedValue

                If obj.ExecuteNonQRY(qry) = 1 Then
                    obj.MessageLabel(lblMsg, "Fueling details successfully saved.", "Green")
                Else
                    obj.MessageLabel(lblMsg, "Error while trying to save record.", "Red")
                End If
            Else
                qry = "UPDATE tbl_fuelingOdometerReadings SET openingOdometerReading = " & Val(txtOpeningOdometerReadn.Text) &
                    " WHERE [FleetId] = '" & txtFleetID.Text & "' AND yYear = " & radYear.Text & " AND mMonth = " & radMonth.SelectedValue

                If obj.ExecuteNonQRY(qry) = 1 Then
                    obj.MessageLabel(lblMsg, "Fueling details successfully saved.", "Green")
                Else
                    obj.MessageLabel(lblMsg, "Error while trying to save record.", "Red")
                End If

            End If
        Else
            If Val(txtClosingOdometerReadn.Text) > 0 Then
                qry = "INSERT tbl_fuelingOdometerReadings (fleetId, yYear, mMonth, openingOdometerReading, closingOdometerReading) " &
                    "VALUES ('" & txtFleetID.Text & "', " & Val(radYear.Text) & ", " & radMonth.SelectedValue & "," & Val(txtOpeningOdometerReadn.Text) &
                    ", " & Val(txtClosingOdometerReadn.Text) & ")"
                If obj.ExecuteNonQRY(qry) = 1 Then
                    obj.MessageLabel(lblMsg, "Fueling details successfully saved.", "Green")
                Else
                    obj.MessageLabel(lblMsg, "Error while trying to save record.", "Red")
                End If
            Else
                qry = "INSERT tbl_fuelingOdometerReadings (fleetId, yYear, mMonth, openingOdometerReading) " &
                    "VALUES ('" & txtFleetID.Text & "', " & Val(radYear.Text) & ", " & radMonth.SelectedValue & "," & Val(txtOpeningOdometerReadn.Text) & ")"
                If obj.ExecuteNonQRY(qry) = 1 Then
                    obj.MessageLabel(lblMsg, "Fueling details successfully saved.", "Green")
                Else
                    obj.MessageLabel(lblMsg, "Error while trying to save record.", "Red")
                End If
            End If
        End If
    End Sub

    Protected Sub radMonth_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles radMonth.SelectedIndexChanged
        loadOpeningAndClosingOdometerReadings()
    End Sub

    Private Sub loadOpeningAndClosingOdometerReadings()

        If radMonth.Text = "--Select--" Or radMonth.Text = "" Then
            obj.MessageLabel(lblMsg, "Please specify the Fueling Month.", "Red")
            Exit Sub
        End If

        Dim qry As String = ""

        txtOpeningOdometerReadn.Text = ""
        txtClosingOdometerReadn.Text = ""
        txtEntryNum.Text = ""
        txtRequisitionNo.Text = ""
        rdFuelingDate.Clear()
        txtQtySupplied.Text = ""

        obj.ConnectionString = con

        qry = "SELECT openingOdometerReading, closingOdometerReading FROM tbl_fuelingOdometerReadings WHERE fleetId = '" & txtFleetID.Text & "' AND yYear = " & Val(radYear.Text) & " AND mMonth = " & radMonth.SelectedValue

        Dim ds As DataSet = obj.ExecuteDsQRY(qry)

        If ds.Tables(0).Rows.Count > 0 Then
            On Error Resume Next
            txtOpeningOdometerReadn.Text = ds.Tables(0).Rows(0).Item("openingOdometerReading")
            txtClosingOdometerReadn.Text = ds.Tables(0).Rows(0).Item("closingOdometerReading")
        End If

    End Sub



End Class