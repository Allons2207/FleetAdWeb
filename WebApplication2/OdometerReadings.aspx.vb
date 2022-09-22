Imports Telerik.Web.UI
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing
Imports System.Data.SqlClient

Public Class OdometerReadings
    Inherits System.Web.UI.Page
    Dim objCBO As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = objCBO.Database
    Dim con As String = db.ConnectionString

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If (CokkiesWrapper.UserID <= 0 AndAlso Not IsNumeric(CokkiesWrapper.UserID)) Then
            Response.Redirect("../Login.aspx")
            Exit Sub
        End If


        objCBO.ConnectionString = con

        If Not IsPostBack Then
            objCBO.loadComboBox(radMonth, "SELECT [mMonthId], [mMonth] FROM [dbo].[tbl_months]", "mMonth", "mMonthId")
            radYear.Items.Insert(0, New RadComboBoxItem("--Select--", ""))
            cboTask.Items.Insert(0, New RadComboBoxItem("--Select--", ""))

            gwGrid.Visible = False

        End If

        'loadAllVehicles()
    End Sub

    Private Sub loadParameters()

        gwGrid.DataSource = String.Empty
        gwGrid.DataBind()

        gwGrid.Visible = False
        btnSave.Visible = False

        If radYear.Text = "" Or radYear.Text = "--Select--" Then
            ' objCBO.MessageLabel(lblMsg, "Please specify the Year. It cannot be empty.", "Red")
            Exit Sub
        ElseIf radMonth.Text = "" Or radMonth.Text = "--Select--" Then
            ' objCBO.MessageLabel(lblMsg, "Please specify the Month. It cannot be empty.", "Red")
            Exit Sub
        ElseIf cboTask.Text = "" Or cboTask.Text = "--Select--" Then
            '  objCBO.MessageLabel(lblMsg, "Please specify the Task. It cannot be empty.", "Red")
            Exit Sub
        Else
            loadAllVehicles()
        End If

    End Sub
    Private Sub gwGrid_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles gwGrid.ItemCommand
        If e.CommandName = "View" Then

            Dim item As GridDataItem = e.Item
            Dim RegNo As String = item("RegNo").Text
            Response.Redirect("~\VehicleDetails.aspx?op=" + RegNo)
        End If
    End Sub

    Private Sub gwGrid_ItemDataBound(sender As Object, e As Telerik.Web.UI.GridItemEventArgs) Handles gwGrid.ItemDataBound
        If cboTask.Text = "View Odometer Readings" Then
            lockTextBoxes()
            loadOdometerReadings()
            gwGrid.Visible = True
        ElseIf cboTask.Text = "Capture Opening Odometer Readings" Then
            gwGrid.MasterTableView.GetColumn("ClosingReading").Display = False
            loadOpeningOdometerReadingValues()
            gwGrid.Visible = True
            btnSave.Visible = True
        ElseIf cboTask.Text = "Capture Closing Odometer Readings" Then
            gwGrid.MasterTableView.GetColumn("OpeningReading").Display = False
            loadClosingOdometerReadingValues()
            gwGrid.Visible = True
            btnSave.Visible = True
        End If
    End Sub



    Protected Sub gwGrid_NeedDataSource(sender As Object, e As GridNeedDataSourceEventArgs) Handles gwGrid.NeedDataSource

        gwGrid.DataSource = Session("Vehicles")

        ''  loadAllVehicles()
        'objCBO.MessageLabel(lblMsg, "", "")
        'loadParameters()

        'If cboTask.Text = "View Odometer Readings" Then
        '    lockTextBoxes()
        '    loadOdometerReadings()
        '    gwGrid.Visible = True
        'ElseIf cboTask.Text = "Capture Opening Odometer Readings" Then
        '    gwGrid.MasterTableView.GetColumn("ClosingReading").Display = False
        '    loadOpeningOdometerReadingValues()
        '    gwGrid.Visible = True
        '    btnSave.Visible = True
        'ElseIf cboTask.Text = "Capture Closing Odometer Readings" Then
        '    gwGrid.MasterTableView.GetColumn("OpeningReading").Display = False
        '    loadClosingOdometerReadingValues()
        '    gwGrid.Visible = True
        '    btnSave.Visible = True
        'End If

        'gwGrid.Visible = True

    End Sub

    Private Sub loadAllVehicles()

        Dim sql As String = "SELECT DISTINCT dbo.tbl_vehicleTypes.vehicleType AS VehicleCategory, dbo.tbl_vehicleData.fleetId AS FleetId, " &
                           " dbo.tbl_vehicleData.registrationNumber AS RegNo, dbo.tbl_vehicleMakes.vehicleMake AS Make," &
                           " dbo.tbl_vehicleModels.vehicleModel AS Model, dbo.tbl_vehicleData.engineNumber AS EngineNo, " &
                           " dbo.tbl_vehicleData.chassisNumber AS ChassisNo, dbo.tbl_vehicleData.currentMileage AS Mileage, " &
                           " Convert(VARCHAR(10), dbo.tbl_vehicleData.lastMileageDate, 10) AS MileageDate, dbo.tbl_vehicleCategories.category AS UserCategory, " &
                           " dbo.tbl_vehicleUsers.firstName + ' ' + dbo.tbl_vehicleUsers.surname AS VehicleUser, " &
                           " dbo.tbl_vehicleUsers.position AS Position, dbo.tbl_vehicleUsers.department AS Department " &
                           " , '' AS OpeningReading FROM dbo.tbl_vehicleModels INNER JOIN " &
                           " dbo.tbl_vehicleMakes ON dbo.tbl_vehicleModels.vehicleMakeId = dbo.tbl_vehicleMakes.vehicleMakeId INNER JOIN " &
                           " dbo.tbl_vehicleData ON dbo.tbl_vehicleModels.vehicleModelId = dbo.tbl_vehicleData.modelId INNER JOIN " &
                           " dbo.tbl_vehicleTypes ON dbo.tbl_vehicleData.vehicleTypeId = dbo.tbl_vehicleTypes.vehicleTypeId INNER JOIN " &
                           " dbo.tbl_vehicleCategories ON dbo.tbl_vehicleData.vehicleCategoryId = dbo.tbl_vehicleCategories.categoryId LEFT OUTER JOIN " &
                           " dbo.tbl_vehicleUsers ON dbo.tbl_vehicleData.currentUserId = dbo.tbl_vehicleUsers.licenseNumber " &
                           " WHERE dbo.tbl_vehicleData.disposalStatusId <> 1  ORDER BY VehicleCategory, Make, Model, RegNo "
        ' WHERE dbo.tbl_vehicleData.disposalStatusId <> 3
        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            db.ExecuteDataSet(CommandType.Text, sql)

            Session("Vehicles") = ds

            With gwGrid
                Try
                    .DataSource = ds
                    .DataBind()

                    gwGrid.MasterTableView.GetColumn("OpeningReading").Display = True
                    gwGrid.MasterTableView.GetColumn("ClosingReading").Display = True

                    If cboTask.Text = "View Odometer Readings" Then
                        lockTextBoxes()
                        loadOdometerReadings()
                        gwGrid.Visible = True
                    ElseIf cboTask.Text = "Capture Opening Odometer Readings" Then
                        gwGrid.MasterTableView.GetColumn("ClosingReading").Display = False
                        loadOpeningOdometerReadingValues()
                        gwGrid.Visible = True
                        btnSave.Visible = True
                    ElseIf cboTask.Text = "Capture Closing Odometer Readings" Then
                        gwGrid.MasterTableView.GetColumn("OpeningReading").Display = False
                        loadClosingOdometerReadingValues()
                        gwGrid.Visible = True
                        btnSave.Visible = True
                    End If

                Catch ex As Exception
                    '  log.Error(ex.Message)
                End Try
            End With
        Catch ex As Exception
            'log.Error(ex)
        End Try
    End Sub

    Private Sub loadOdometerReadings()

        Dim qry As String = ""
        Dim txtBox As TextBox

        For Each gridRow As GridDataItem In gwGrid.Items

            qry = "SELECT openingOdometerReading, closingOdometerReading FROM tbl_fuelingOdometerReadings WHERE fleetId = '" & gridRow("FleetId").Text & "' AND yYear = " & Val(radYear.Text) & " AND mMonth = " & radMonth.SelectedValue

            Dim ds As DataSet = objCBO.ExecuteDsQRY(qry)

            If ds.Tables(0).Rows.Count > 0 Then
                txtBox = gridRow.Item("OpeningReading").FindControl("txtOpeningReading")
                txtBox.Text = ds.Tables(0).Rows(0).Item("openingOdometerReading")

                txtBox = gridRow.FindControl("txtClosingReading")
                '  txtBox.Text = ds.Tables(0).Rows(0).Item("closingOdometerReading")

                On Error Resume Next
                txtBox.Text = objCBO.Catchnull(ds.Tables(0).Rows(0).Item("closingOdometerReading"), "")

            End If
        Next

    End Sub

    Private Sub loadClosingOdometerReadingValues()

        Dim qry As String = ""
        Dim txtBox As TextBox

        For Each gridRow As GridDataItem In gwGrid.Items

            qry = "SELECT openingOdometerReading, closingOdometerReading FROM tbl_fuelingOdometerReadings WHERE fleetId = '" & gridRow("FleetId").Text & "' AND yYear = " & Val(radYear.Text) & " AND mMonth = " & radMonth.SelectedValue

            Dim ds As DataSet = objCBO.ExecuteDsQRY(qry)

            If ds.Tables(0).Rows.Count > 0 Then
                On Error Resume Next
                txtBox = gridRow.FindControl("txtClosingReading")
                txtBox.Text = ds.Tables(0).Rows(0).Item("closingOdometerReading")
            End If
        Next

    End Sub

    Private Sub loadOpeningOdometerReadingValues()

        Dim qry As String = ""
        Dim txtBox As TextBox


        On Error Resume Next
        For Each gridRow As GridDataItem In gwGrid.Items

            qry = "SELECT openingOdometerReading, closingOdometerReading FROM tbl_fuelingOdometerReadings WHERE fleetId = '" & gridRow("FleetId").Text & "' AND yYear = " & Val(radYear.Text) & " AND mMonth = " & radMonth.SelectedValue

            Dim ds As DataSet = objCBO.ExecuteDsQRY(qry)

            If ds.Tables(0).Rows.Count > 0 Then
                txtBox = gridRow.Item("OpeningReading").FindControl("txtOpeningReading")
                txtBox.Text = ds.Tables(0).Rows(0).Item("openingOdometerReading")
            Else
                qry = "SELECT TOP 1 closingOdometerReading FROM tbl_fuelingOdometerReadings WHERE fleetId = '" & gridRow("FleetId").Text & "' ORDER BY [ctr] DESC "

                ds = objCBO.ExecuteDsQRY(qry)
                If ds.Tables(0).Rows.Count > 0 Then
                    txtBox = gridRow.Item("OpeningReading").FindControl("txtOpeningReading")
                    txtBox.Text = ds.Tables(0).Rows(0).Item("closingOdometerReading")
                End If
            End If
        Next

    End Sub

    Private Sub lockTextBoxes()
        Dim txtBox As New TextBox

        Try
            For Each gridRow As GridDataItem In gwGrid.Items
                txtBox = gridRow.FindControl("txtOpeningReading")
                txtBox.Enabled = False

                txtBox = gridRow.FindControl("txtClosingReading")
                txtBox.Enabled = False
            Next
            '    LoadClassStudentsAndMarks()
        Catch ex As Exception

        End Try

    End Sub

    Private Function thereAreOpenOdometerReadingMonths() As Boolean
        thereAreOpenOdometerReadingMonths = False
        Dim qry As String = "Select  DISTINCT yYear, mMonth From dbo.tbl_fuelingOdometerReadings " &
                " Where (openingOdometerReading Is Not NULL) And (closingOdometerReading Is NULL) And (mMonth < " & radMonth.SelectedValue & ")"


        objCBO.ConnectionString = con

        Dim ds As DataSet = objCBO.ExecuteDsQRY(qry)
        If ds.Tables(0).Rows.Count > 0 Then
            thereAreOpenOdometerReadingMonths = True
        End If

    End Function



    Protected Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click

        If thereAreOpenOdometerReadingMonths() = True Then
            objCBO.MessageLabel(lblMsg, "You have Not clossed mileages for other months", "Red")
            Exit Sub
        End If

        Dim qry As String = ""
        Dim txtBox As New TextBox

        Try
            For Each gridRow As GridDataItem In gwGrid.Items

                If cboTask.Text = "Capture Opening Odometer Readings" Then

                    qry = "DELETE FROM tbl_fuelingOdometerReadings WHERE fleetId = '" & gridRow("FleetId").Text & "' AND yYear = " & Val(radYear.Text) & " AND mMonth = " & radMonth.SelectedValue
                    objCBO.ExecuteNonQRY(qry)

                    txtBox = gridRow.Item("OpeningReading").FindControl("txtOpeningReading")

                    '  txtBox = gridRow.FindControl("txtOpeningReading")

                    If txtBox.Text <> "" And Val(txtBox.Text) <> 0 Then
                        qry = "INSERT tbl_fuelingOdometerReadings (fleetId, yYear, mMonth, openingOdometerReading)" &
                     " VALUES ('" & gridRow("FleetId").Text & "', " & Val(radYear.Text) & ", " & radMonth.SelectedValue & "," & Val(txtBox.Text) & ")"

                        objCBO.ExecuteNonQRY(qry)
                        updateVehicleMileageReading(Val(txtBox.Text), gridRow("FleetId").Text)

                    End If
                ElseIf cboTask.Text = "Capture Closing Odometer Readings" Then

                    txtBox = gridRow.FindControl("txtClosingReading")

                    If txtBox.Text <> "" And Val(txtBox.Text) <> 0 Then

                        qry = "UPDATE tbl_fuelingOdometerReadings SET closingOdometerReading = " & Val(txtBox.Text) & "   WHERE fleetId = '" & gridRow("FleetId").Text & "' AND yYear = " & Val(radYear.Text) & " AND mMonth = " & radMonth.SelectedValue

                        objCBO.ExecuteNonQRY(qry)

                        ' Insert the following month's opening readings as this month's closing readings
                        Dim nextMonth As Integer = Val(radMonth.SelectedValue) + 1
                        Dim yyYear As Integer = Val(radYear.Text)

                        If nextMonth = 13 Then
                            'December to January
                            nextMonth = 1
                            yyYear = yyYear + 1
                        End If

                        qry = "INSERT tbl_fuelingOdometerReadings (fleetId, yYear, mMonth, openingOdometerReading)" &
                     " VALUES ('" & gridRow("FleetId").Text & "', " & yyYear & ", " & nextMonth & "," & Val(txtBox.Text) & ")"

                        objCBO.ExecuteNonQRY(qry)

                        updateVehicleMileageReading(Val(txtBox.Text), gridRow("FleetId").Text)

                    End If
                End If
            Next

            objCBO.MessageLabel(lblMsg, "Done", "Green")

        Catch ex As Exception
            objCBO.MessageLabel(lblMsg, "An Error Occured..!", "Red")
        End Try

    End Sub

    Protected Sub gwGrid_NeedDataSource1(sender As Object, e As GridNeedDataSourceEventArgs) Handles gwGrid.NeedDataSource
        loadAllVehicles()
    End Sub

    Protected Sub cboTask_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboTask.SelectedIndexChanged
        objCBO.MessageLabel(lblMsg, "", "")
        loadParameters()
    End Sub

    Protected Sub radMonth_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles radMonth.SelectedIndexChanged
        objCBO.MessageLabel(lblMsg, "", "")

        loadParameters()
    End Sub

    Private Sub updateVehicleMileageReading(ByVal mileage As Integer, fleetId As String)

        Dim dt As String = ""

        On Error Resume Next
        If cboTask.Text = "Capture Opening Odometer Readings" Then
            dt = "01/" & radMonth.SelectedValue & "/" & radYear.Text
        ElseIf cboTask.Text = "Capture Closing Odometer Readings" Then
            dt = "22/" & radMonth.SelectedValue & "/" & radYear.Text
        End If

        If Not IsDate(dt) Then
            If cboTask.Text = "Capture Opening Odometer Readings" Then
                dt = radMonth.SelectedValue & "/" & "01/" & radYear.Text
            ElseIf cboTask.Text = "Capture Closing Odometer Readings" Then
                dt = radMonth.SelectedValue & "/22/" & radYear.Text
            End If
        End If

        Dim qry As String = ""
        qry = "UPDATE [dbo].[tbl_vehicleData] SET [currentMileage] = " & mileage & ", [lastMileageDate] = '" & dt & "' WHERE [fleetId] = '" & fleetId & "'"

        objCBO.ConnectionString = con

        objCBO.ExecuteNonQRY(qry)

    End Sub

    Protected Sub radYear_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles radYear.SelectedIndexChanged
        objCBO.MessageLabel(lblMsg, "", "")
        loadParameters()
    End Sub
End Class