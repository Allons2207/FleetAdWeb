Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Telerik.Web.UI

Public Class VehicleMileageUpdate
    Inherits System.Web.UI.Page

    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        '  obj.loadComboBox(cboLicense, "SELECT [licenseNumber] FROM [dbo].[tbl_vehicleUsers] WHERE [allocationStatusId] = 2", "licenseNumber", "licenseNumber")
        If Not IsPostBack Then
            loadRegNumbers()
            loadFleetIDs()

            If Not IsNothing(Request.QueryString("op")) Then
                txtFleetIDSearch.Text = Request.QueryString("op")
                loadSelectedVehicleDetails()
                txtRegNo.Enabled = False
            Else
                txtRegNo.Enabled = True
            End If


            If grantPageWriteCommandPermission(CokkiesWrapper.UserID, 1) = True Then
                cmdSave.Enabled = True

            Else
                cmdSave.Enabled = False

            End If
        End If
    End Sub

    Private Sub loadRegNumbers()
        obj.loadComboBox(cboRegNumber, "SELECT DISTINCT [registrationNumber] FROM [dbo].[tbl_vehicleData] ORDER BY registrationNumber", "registrationNumber", "registrationNumber")
    End Sub

    Private Sub loadFleetIDs()
        obj.loadComboBox(cboFleetID, "SELECT DISTINCT [fleetId] FROM [dbo].[tbl_vehicleData] ORDER BY fleetId", "fleetId", "fleetId")
    End Sub

    Private Sub showFleetIDForSelectedRegNumber()

    End Sub


    Private Sub loadVehicleDetails()

        Dim sql As String = "SELECT DISTINCT dbo.tbl_vehicleData.fleetId,    dbo.tbl_vehicleData.registrationNumber, dbo.tbl_vehicleData.currentMileage, dbo.tbl_vehicleData.lastMileageDate, " &
            " dbo.tbl_vehicleMakes.vehicleMake, dbo.tbl_vehicleModels.vehicleModel FROM dbo.tbl_vehicleData INNER JOIN " &
              " dbo.tbl_vehicleModels ON dbo.tbl_vehicleData.modelId = dbo.tbl_vehicleModels.vehicleModelId INNER JOIN " &
              "  dbo.tbl_vehicleMakes ON dbo.tbl_vehicleModels.vehicleMakeId = dbo.tbl_vehicleMakes.vehicleMakeId  WHERE tbl_vehicleData.fleetId = '" & txtFleetIDSearch.Text & "'"

        Try
            obj.ConnectionString = con
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)

            If ds.Tables(0).Rows.Count > 0 Then
                cboFleetID.SelectedValue = ds.Tables(0).Rows(0).Item("fleetId")
                txtRegNo.Text = ds.Tables(0).Rows(0).Item("registrationNumber")
                txtMake.Text = ds.Tables(0).Rows(0).Item("vehicleMake").ToString
                txtModel.Text = ds.Tables(0).Rows(0).Item("vehicleModel").ToString
                txtLastRecordedMileage.Text = ds.Tables(0).Rows(0).Item("currentMileage").ToString
                txtLastMileageDate.Text = ds.Tables(0).Rows(0).Item("lastMileageDate").ToString
                '    txtCommentsNotes.Text = ds.Tables(0).Rows(0).Item("notes").ToString
                vehicleMileageHistory()
            Else

                obj.MessageLabel(lblMsg, "No such vehicle found under vehicle details.", "Yellow")
            End If
        Catch ex As Exception
        End Try
    End Sub
    Protected Sub cboRegNumber_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboRegNumber.SelectedIndexChanged
        showFleetIDForSelectedRegNumber()
        vehicleMileageHistory()
    End Sub

    Private Sub showRegNumberForSelectedFleetID()

        Dim sql As String = "SELECT DISTINCT dbo.tbl_vehicleData.fleetId,  dbo.tbl_vehicleData.registrationNumber, dbo.tbl_vehicleData.currentMileage, dbo.tbl_vehicleData.lastMileageDate, " &
              " dbo.tbl_vehicleMakes.vehicleMake, dbo.tbl_vehicleModels.vehicleModel FROM dbo.tbl_vehicleData INNER JOIN " &
                " dbo.tbl_vehicleModels ON dbo.tbl_vehicleData.modelId = dbo.tbl_vehicleModels.vehicleModelId INNER JOIN " &
                "  dbo.tbl_vehicleMakes ON dbo.tbl_vehicleModels.vehicleMakeId = dbo.tbl_vehicleMakes.vehicleMakeId WHERE dbo.tbl_vehicleData.[fleetId] = '" & cboFleetID.Text & "'"

        Try
            obj.ConnectionString = con
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)

            If ds.Tables(0).Rows.Count > 0 Then
                cboRegNumber.SelectedValue = ds.Tables(0).Rows(0).Item("registrationNumber").ToString
                txtMake.Text = ds.Tables(0).Rows(0).Item("vehicleMake").ToString
                txtModel.Text = ds.Tables(0).Rows(0).Item("vehicleModel").ToString
                txtLastRecordedMileage.Text = ds.Tables(0).Rows(0).Item("currentMileage").ToString
                txtLastMileageDate.Text = ds.Tables(0).Rows(0).Item("lastMileageDate").ToString
            End If
        Catch ex As Exception

        End Try

    End Sub

    Private Sub clearControls()

        txtMake.Text = ""
        txtModel.Text = ""
        txtLastRecordedMileage.Text = ""
        txtLastMileageDate.Text = ""
        txtCommentsNotes.Text = ""
        txtCurrentMileage.Text = ""
        rdCurrentDate.Clear()
        cboFleetID.ClearSelection()
        cboRegNumber.ClearSelection()

        obj.MessageLabel(lblMsg, "", "")

        With gwList
            .DataSource = String.Empty
            .DataBind()
        End With

    End Sub

    Protected Sub cboFleetID_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboFleetID.SelectedIndexChanged
        showRegNumberForSelectedFleetID()
        vehicleMileageHistory()
    End Sub

    Protected Sub cmdSave_Click(sender As Object, e As EventArgs) Handles cmdSave.Click

        If validSave() = False Then Exit Sub

        Dim sql As String = "UPDATE tbl_vehicleData SET currentMileage = " & txtCurrentMileage.Text & ", lastMileageDate = '" & rdCurrentDate.SelectedDate & "' WHERE fleetId = '" & txtFleetIDSearch.Text & "'"
        Try
            obj.ConnectionString = con

            If obj.ExecuteNonQRY(sql) = 1 Then
                'insert mileage history

                sql = " INSERT [tbl_vehicleMileageHistory] ([registrationNumber], [dtDate], [oldMileage], [newMileage],[fleetId], [notes] )  " &
                        " VALUES ('" & txtRegNo.Text & "','" & rdCurrentDate.SelectedDate & "'," & Val(txtLastRecordedMileage.Text) & "," & Val(txtCurrentMileage.Text) &
                        ",'" & txtFleetIDSearch.Text & "','" & txtCommentsNotes.Text & "')"
                If obj.ExecuteNonQRY(sql) = 1 Then
                    obj.MessageLabel(lblMsg, "Vehicle mileage successfully updated.", "Green")
                    vehicleMileageHistory()
                    clearControls()
                    Exit Sub
                Else
                    obj.MessageLabel(lblMsg, "Error while trying to update vehicle mileage.", "Red")
                    Exit Sub
                End If
            Else

            End If

        Catch ex As Exception
            obj.MessageLabel(lblMsg, "Error while trying to update vehicle mileage.", "Red")
        End Try

    End Sub

    Private Sub vehicleMileageHistory()

        Dim sql As String = "SELECT DISTINCT CONVERT(VARCHAR(10),dbo.tbl_vehicleMileageHistory.dtDate,10) AS DateUpdated, dbo.tbl_vehicleMileageHistory.registrationNumber AS " &
                            " RegNumber, dbo.tbl_vehicleMileageHistory.fleetId AS FleetID, dbo.tbl_vehicleMakes.vehicleMake AS Make, " &
                            " dbo.tbl_vehicleModels.vehicleModel AS Model, dbo.tbl_vehicleMileageHistory.newMileage AS NewMileage, " &
                            " dbo.tbl_vehicleMileageHistory.oldMileage AS OldMileage, dbo.tbl_vehicleMileageHistory.notes AS Notes " &
                            " FROM  dbo.tbl_vehicleModels INNER JOIN dbo.tbl_vehicleMakes ON dbo.tbl_vehicleModels.vehicleMakeId = " &
                            " dbo.tbl_vehicleMakes.vehicleMakeId INNER JOIN dbo.tbl_vehicleMileageHistory INNER JOIN " &
                            "  dbo.tbl_vehicleData ON dbo.tbl_vehicleMileageHistory.fleetId = dbo.tbl_vehicleData.fleetId ON " &
                            " dbo.tbl_vehicleModels.vehicleModelId = dbo.tbl_vehicleData.modelId WHERE " &
                            "(dbo.tbl_vehicleMileageHistory.fleetId = '" & txtFleetIDSearch.Text & "') ORDER BY DateUpdated DESC, fleetId "

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            db.ExecuteDataSet(CommandType.Text, sql)
            With gwList
                .DataSource = ds
                .DataBind()
            End With
        Catch ex As Exception
            '  log.Error(ex)
        End Try

    End Sub

    Protected Sub cmdClear_Click(sender As Object, e As EventArgs) Handles cmdClear.Click
        clearControls()




    End Sub

    Private Function validSave() As Boolean
        validSave = False

        obj.ConnectionString = con

        If txtFleetIDSearch.Text = "" Then
            obj.MessageLabel(lblMsg, "Please specify the vehicle fleet number.", "Red")
            Exit Function
        ElseIf obj.fnVehicleExists(txtFleetIDSearch.Text) = False
            obj.MessageLabel(lblMsg, "The specified Vehicle Fleet number could not be found in vehicles data.", "Red")
            Exit Function
        ElseIf IsNothing(rdCurrentDate.SelectedDate) Then
            obj.MessageLabel(lblMsg, "Invalid Mileage Date.", "Red")
            Exit Function
        ElseIf Val(txtCurrentMileage.Text) = 0 Then
            obj.MessageLabel(lblMsg, "Invalid current mileage.", "Red")
            Exit Function
        ElseIf Val(txtCurrentMileage.Text) < Val(txtLastRecordedMileage.Text)
            obj.MessageLabel(lblMsg, "Current mileage cannot be greater than than the previous/last-recorded mileage.", "Red")
            Exit Function
        End If

        validSave = True

    End Function


    Private Sub loadSelectedVehicleDetails()

        Dim qry As String = "SELECT DISTINCT dbo.tbl_vehicleData.registrationNumber, dbo.tbl_vehicleData.fleetId, dbo.tbl_vehicleMakes.vehicleMake," &
                            " dbo.tbl_vehicleModels.vehicleModel, dbo.tbl_vehicleData.lastMileageDate, dbo.tbl_vehicleData.currentMileage " &
                            " FROM  dbo.tbl_vehicleModels INNER JOIN dbo.tbl_vehicleMakes ON dbo.tbl_vehicleModels.vehicleMakeId = " &
                            " dbo.tbl_vehicleMakes.vehicleMakeId INNER JOIN dbo.tbl_vehicleData ON dbo.tbl_vehicleModels.vehicleModelId " &
                            " = dbo.tbl_vehicleData.modelId WHERE (dbo.tbl_vehicleData.fleetId = '" & (Request.QueryString("op")) & "')"

        obj.ConnectionString = con
        Dim ds As DataSet = obj.ExecuteDsQRY(qry)
        If ds.Tables(0).Rows.Count > 0 Then
            cboRegNumber.SelectedValue = ds.Tables(0).Rows(0).Item("registrationNumber")
            txtRegNo.Text = ds.Tables(0).Rows(0).Item("registrationNumber")

            cboFleetID.SelectedValue = ds.Tables(0).Rows(0).Item("fleetId")
            txtMake.Text = ds.Tables(0).Rows(0).Item("vehicleMake").ToString
            txtModel.Text = ds.Tables(0).Rows(0).Item("vehicleModel").ToString
            txtLastRecordedMileage.Text = ds.Tables(0).Rows(0).Item("currentMileage").ToString
            txtLastMileageDate.Text = ds.Tables(0).Rows(0).Item("lastMileageDate").ToString

            vehicleMileageHistory()

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

    Protected Sub cmdDelete_Click(sender As Object, e As EventArgs) Handles cmdDelete.Click
        If Not IsNothing(Request.QueryString("op")) Then
            Dim qry As String = "DELETE FROM tbl_vehicleMileageHistory WHERE (ctr = " & Request.QueryString("op") & ")"

            obj.ConnectionString = con

            If obj.ExecuteNonQRY(qry) = 1 Then
                obj.MessageLabel(lblMsg, "Vehicle Inspection Record successfully deleted.", "Green")
            Else
                obj.MessageLabel(lblMsg, "Error while trying to delete Vehicle Inspection entry.", "Red")
            End If
        Else
            obj.MessageLabel(lblMsg, "Error. System could not find the Vehicle Inpsection Entry Record Number.", "Red")
        End If
    End Sub

    Protected Sub gwList_NeedDataSource(sender As Object, e As GridNeedDataSourceEventArgs) Handles gwList.NeedDataSource

    End Sub

    Protected Sub cmdClear0_Click(sender As Object, e As EventArgs) Handles cmdClear0.Click

        clearControls()

        obj.ConnectionString = con
        txtFleetIDSearch.Text = obj.fnVehicleFleetIDNumFromRegNum(txtRegNo.Text)

        loadVehicleDetails()

    End Sub

    Protected Sub btnSearchByFleetID_Click(sender As Object, e As EventArgs) Handles btnSearchByFleetID.Click

        clearControls()

        obj.ConnectionString = con
        txtRegNo.Text = obj.fnVehicleRegNumFromFleetID(txtFleetIDSearch.Text)

        loadVehicleDetails()

    End Sub


End Class