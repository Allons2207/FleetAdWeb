Imports Telerik.Web.UI
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing

Public Class TripLoggingDetails
    Inherits System.Web.UI.Page
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then

            loadUnAllocatedVehicleUserNationalIDs()
            loadUnAllocatedRegNumbers()

            rdActualReturnDate.Enabled = False
            rdActualReturnTime.Enabled = False
            txtCommentsNotes.Enabled = False

            If Not IsNothing(Request.QueryString("op")) Then
                loadTripLogDetails()
                txtRegNo.Enabled = False
            End If

            If grantPageWriteCommandPermission(CokkiesWrapper.UserID, 1) = True Then
                cmdSave.Enabled = True
                If Not IsNothing(Request.QueryString("op")) Then
                    cmdDelete.Enabled = True
                Else
                    cmdDelete.Enabled = False
                End If
            Else
                cmdSave.Enabled = False
            End If

        End If

    End Sub

    Private Sub loadTripLogDetails()

        Dim qry As String = "SELECT dbo.tbl_vehicleData.registrationNumber, dbo.tbl_vehicleData.fleetId, dbo.tbl_vehicleMakes.vehicleMake," &
                            " dbo.tbl_vehicleModels.vehicleModel, dbo.tbl_tripLogging.userId, dbo.tbl_tripLogging.destination, " &
                            " dbo.tbl_tripLogging.departureDate, dbo.tbl_tripLogging.departureTime, dbo.tbl_tripLogging.expectedReturnDate, " &
                            " dbo.tbl_tripLogging.expectedReturnTime, dbo.tbl_tripLogging.actualReturnDate,dbo.tbl_tripLogging.actualReturnTime, " &
                            " dbo.tbl_tripLogging.Comments, dbo.tbl_tripLogging.returnStatus FROM  dbo.tbl_vehicleModels INNER JOIN " &
                            " dbo.tbl_vehicleMakes ON dbo.tbl_vehicleModels.vehicleMakeId = dbo.tbl_vehicleMakes.vehicleMakeId INNER JOIN " &
                            " dbo.tbl_tripLogging INNER JOIN dbo.tbl_vehicleData ON dbo.tbl_tripLogging.fleetId = dbo.tbl_vehicleData.fleetId " &
                            " ON dbo.tbl_vehicleModels.vehicleModelId = dbo.tbl_vehicleData.modelId WHERE dbo.tbl_tripLogging.ctr = " & (Request.QueryString("op"))

        obj.ConnectionString = con

        Dim ds As DataSet = obj.ExecuteDsQRY(qry)

        If ds.Tables(0).Rows.Count > 0 Then
            With ds.Tables(0).Rows(0)
                '.Rows(0)("firstName")
                txtFleetIDSearch.Text = .Item("fleetId")
                txtFleetId.Text = .Item("fleetId")
                txtMake.Text = .Item("vehicleMake")
                txtModel.Text = .Item("vehicleModel")

                txtRegNo.Text = .Item("registrationNumber")
                cboDriver.SelectedValue = .Item("userId")
                txtDestination.Text = .Item("destination")
                rdDepartureDate.SelectedDate = .Item("departureDate")

                Dim departureTime As String = .Item("departureTime")

                rdDepartureTime.SelectedTime = New TimeSpan(CInt(departureTime.Substring(0, 2)), CInt(departureTime.Substring(3, 2)), CInt(departureTime.Substring(6, 2)))

                rdExpectedReturnDate.SelectedDate = .Item("expectedReturnDate")

                Dim expectedReturnTime As String = .Item("expectedReturnTime")

                rdExpectedReturnTime.SelectedTime = New TimeSpan(CInt(expectedReturnTime.Substring(0, 2)), CInt(expectedReturnTime.Substring(3, 2)), CInt(expectedReturnTime.Substring(6, 2)))

                If .Item("returnStatus") = "Still Out" Then

                Else
                    chkDriverHasReturned.Checked = True
                    If Not IsDBNull(.Item("Comments")) Then
                        txtCommentsNotes.Text = .Item("Comments")
                    End If

                    If Not IsDBNull(.Item("actualReturnDate")) Then
                        rdActualReturnDate.SelectedDate = .Item("actualReturnDate")
                    End If

                    If Not IsDBNull(.Item("actualReturnTime")) Then
                        If .Item("actualReturnTime") <> "" Then
                            Dim actualReturnTime As String = .Item("actualReturnTime")
                            rdActualReturnTime.SelectedTime = New TimeSpan(CInt(actualReturnTime.Substring(0, 2)), CInt(actualReturnTime.Substring(3, 2)), CInt(actualReturnTime.Substring(6, 2)))
                        End If
                    End If
                    End If

                    DriverHasReturnedControls()

            End With

        End If

    End Sub

    Protected Sub cmdSave_Click(sender As Object, e As EventArgs) Handles cmdSave.Click

        obj.ConnectionString = con

        If txtFleetIDSearch.Text = "" Then
            obj.MessageLabel(lblMsg, "Please sepcify the vehicle fleet number, it cannot be empty.", "Red")
            Exit Sub
        ElseIf obj.fnVehicleExists(txtFleetIDSearch.Text) = False
            obj.MessageLabel(lblMsg, "The specified Vehicle Fleet number could not be found in vehicles data.", "Red")
            Exit Sub
        ElseIf cboDriver.Text = "" Or cboDriver.Text = "--Select" Then
            obj.MessageLabel(lblMsg, "Please specify the driver making the trip..", "Red")
            Exit Sub
        ElseIf txtDestination.Text = "" Then
            obj.MessageLabel(lblMsg, "Please specify the destination, it cannot be empty.", "Red")
            Exit Sub
        End If

        If Not IsNothing(Request.QueryString("op")) Then
            updateTripLog()
        Else
            insertNewTripLog()
        End If

    End Sub

    Private Sub updateTripLog()
        Dim ds As New DataSet

        ds.Tables.Add(New DataTable)

        ds.Tables(0).Columns.Add(New DataColumn("fleetId"))
        ds.Tables(0).Columns.Add(New DataColumn("userId"))
        ds.Tables(0).Columns.Add(New DataColumn("destination"))
        ds.Tables(0).Columns.Add(New DataColumn("departureDate"))
        ds.Tables(0).Columns.Add(New DataColumn("departureTime"))
        ds.Tables(0).Columns.Add(New DataColumn("expectedReturnDate"))
        ds.Tables(0).Columns.Add(New DataColumn("expectedReturnTime"))
        ds.Tables(0).Columns.Add(New DataColumn("returnStatus"))
        ds.Tables(0).Columns.Add(New DataColumn("actualReturnDate"))
        ds.Tables(0).Columns.Add(New DataColumn("actualReturnTime"))
        ds.Tables(0).Columns.Add(New DataColumn("Comments"))

        Dim dr As DataRow = ds.Tables(0).NewRow

        dr("fleetId") = txtFleetIDSearch.Text
        dr("userId") = cboDriver.SelectedValue
        dr("destination") = txtDestination.Text
        dr("departureDate") = rdDepartureDate.SelectedDate
        dr("departureTime") = rdDepartureTime.SelectedTime
        dr("expectedReturnDate") = rdExpectedReturnDate.SelectedDate
        dr("expectedReturnTime") = rdExpectedReturnTime.SelectedTime

        If chkDriverHasReturned.Checked = True Then
            dr("returnStatus") = "Returned"
            dr("actualReturnDate") = rdActualReturnDate.SelectedDate
            dr("actualReturnTime") = rdActualReturnTime.SelectedTime
            dr("Comments") = txtCommentsNotes.Text
        Else
            dr("returnStatus") = "Still Out"
            dr("actualReturnDate") = rdActualReturnDate.SelectedDate
            dr("actualReturnTime") = rdActualReturnTime.SelectedTime
            dr("Comments") = txtCommentsNotes.Text
        End If

        ds.Tables(0).Rows.Add(dr)

        Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
        Dim db As Database = obj.Database
        Dim con As String = db.ConnectionString
        Dim qry As String = ""

        qry = "UPDATE tbl_tripLogging SET fleetId = '" & dr("fleetId") & "',userId = '" & dr("userId") &
                                        "',destination = '" & dr("destination") & "',departureDate = '" & dr("departureDate") &
                                        "' ,departureTime = '" & dr("departureTime") & "',expectedReturnDate = '" & dr("expectedReturnDate") &
                                        "', expectedReturnTime = '" & dr("expectedReturnTime") & "', returnStatus = '" & dr("returnStatus") & "', " &
                                        "actualReturnDate = '" & dr("actualReturnDate") & "',actualReturnTime = '" & dr("actualReturnTime") &
                                        "', Comments = '" & dr("Comments") & "' WHERE ctr = " & (Request.QueryString("op"))
        obj.ConnectionString = con

        If obj.ExecuteNonQRY(qry) = 1 Then
            obj.MessageLabel(lblMsg, "Trip log successfully updated..", "Green")
        Else
            obj.MessageLabel(lblMsg, "Error while trying to update trip log details..", "Red")
        End If


    End Sub
    Private Sub insertNewTripLog()

        Dim ds As New DataSet

        ds.Tables.Add(New DataTable)

        ds.Tables(0).Columns.Add(New DataColumn("fleetId"))
        ds.Tables(0).Columns.Add(New DataColumn("userId"))
        ds.Tables(0).Columns.Add(New DataColumn("destination"))
        ds.Tables(0).Columns.Add(New DataColumn("departureDate"))
        ds.Tables(0).Columns.Add(New DataColumn("departureTime"))
        ds.Tables(0).Columns.Add(New DataColumn("expectedReturnDate"))
        ds.Tables(0).Columns.Add(New DataColumn("expectedReturnTime"))
        ds.Tables(0).Columns.Add(New DataColumn("returnStatus"))

        Dim dr As DataRow = ds.Tables(0).NewRow

        dr("fleetId") = txtFleetIDSearch.Text
        dr("userId") = cboDriver.SelectedValue
        dr("destination") = txtDestination.Text
        dr("departureDate") = rdDepartureDate.SelectedDate
        dr("departureTime") = rdDepartureTime.SelectedTime
        dr("expectedReturnDate") = rdExpectedReturnDate.SelectedDate
        dr("expectedReturnTime") = rdExpectedReturnTime.SelectedTime
        dr("returnStatus") = "Still Out"

        ds.Tables(0).Rows.Add(dr)

        Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
        Dim db As Database = obj.Database
        Dim con As String = db.ConnectionString
        Dim qry As String = ""

        qry = "INSERT tbl_tripLogging (fleetId ,userId ,destination ,departureDate ,departureTime ,expectedReturnDate ," &
                            "expectedReturnTime, returnStatus) VALUES ('" & dr("fleetId") &
                            "','" & dr("userId") & "','" & dr("destination") &
                            "','" & dr("departureDate") & "','" & dr("departureTime") &
                             "','" & dr("expectedReturnDate") & "','" & dr("expectedReturnTime") &
                             "','" & dr("returnStatus") & "')"

        obj.ConnectionString = con

        If obj.ExecuteNonQRY(qry) = 1 Then
            obj.MessageLabel(lblMsg, "Trip log successfully saved..", "Green")
        Else
            obj.MessageLabel(lblMsg, "Error while trying to save trip log details..", "Red")
        End If

    End Sub
    Private Sub loadUnAllocatedVehicleUserNationalIDs()
        obj.loadComboBox(cboDriver, "SELECT DISTINCT [nationalIDNo], [firstName] + ' ' +  [surname]  AS Driver  FROM [dbo].[tbl_vehicleUsers]  ORDER BY Driver ", "Driver", "nationalIDNo")
    End Sub

    Private Sub loadUnAllocatedRegNumbers()
        obj.loadComboBox(cboRegNumber, "SELECT DISTINCT [registrationNumber] FROM [dbo].[tbl_vehicleData] WHERE [tbl_vehicleData].[allocationStatusId] = 2 ORDER BY registrationNumber", "registrationNumber", "registrationNumber")
    End Sub

    Protected Sub cboRegNumber_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboRegNumber.SelectedIndexChanged
        loadVehicleData()
    End Sub

    Private Sub loadVehicleData()

        txtMake.Text = ""
        txtModel.Text = ""
        txtFleetId.Text = ""
        obj.MessageLabel(lblMsg, "", "")

        Dim qry As String = "SELECT DISTINCT dbo.tbl_vehicleMakes.vehicleMake, dbo.tbl_vehicleModels.vehicleModel, dbo.tbl_vehicleData.registrationNumber," &
                            " dbo.tbl_vehicleData.fleetId FROM dbo.tbl_vehicleModels INNER JOIN dbo.tbl_vehicleMakes ON " &
                            " dbo.tbl_vehicleModels.vehicleMakeId = dbo.tbl_vehicleMakes.vehicleMakeId INNER JOIN dbo.tbl_vehicleData ON " &
                            " dbo.tbl_vehicleModels.vehicleModelId = dbo.tbl_vehicleData.modelId WHERE    (dbo.tbl_vehicleData.fleetId = '" & txtFleetIDSearch.Text & "')"

        '([tbl_vehicleData].[allocationStatusId] = 4) AND

        Try
            obj.ConnectionString = con
            Dim ds As DataSet = obj.ExecuteDsQRY(qry)
            If ds.Tables(0).Rows.Count > 0 Then
                txtMake.Text = ds.Tables(0).Rows(0).Item("vehicleMake")
                txtModel.Text = ds.Tables(0).Rows(0).Item("vehicleModel")
                txtFleetId.Text = ds.Tables(0).Rows(0).Item("fleetId")
            Else
                obj.MessageLabel(lblMsg, "Vehicle details not found.", "Yellow")
            End If
        Catch ex As Exception

        End Try

    End Sub


    Protected Sub chkDriverHasReturned_CheckedChanged(sender As Object, e As EventArgs) Handles chkDriverHasReturned.CheckedChanged
        DriverHasReturnedControls()
    End Sub


    Private Sub DriverHasReturnedControls()
        If chkDriverHasReturned.Checked = True Then
            rdActualReturnDate.Enabled = True
            rdActualReturnTime.Enabled = True
            txtCommentsNotes.Enabled = True
        Else
            rdActualReturnDate.Clear()
            rdActualReturnTime.Clear()
            txtCommentsNotes.Text = ""
            rdActualReturnDate.Enabled = False
            rdActualReturnTime.Enabled = False
            txtCommentsNotes.Enabled = False
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
            Dim qry As String = "DELETE FROM tbl_tripLogging  WHERE dbo.tbl_tripLogging.ctr = " & (Request.QueryString("op"))


            obj.ConnectionString = con

            If obj.ExecuteNonQRY(qry) = 1 Then
                obj.MessageLabel(lblMsg, "Trip-Logging record entry deleted.", "Green")
            Else
                obj.MessageLabel(lblMsg, "Error while trying to delete Trip-Logging record entry.", "Red")
            End If
        Else
            obj.MessageLabel(lblMsg, "Error. System could not find the associated Trip-Logging entry Number.", "Red")
        End If

    End Sub

    Protected Sub cmdClear0_Click(sender As Object, e As EventArgs) Handles cmdClear0.Click

        loadVehicleData()

    End Sub

    Protected Sub btnSearchByFleetID_Click(sender As Object, e As EventArgs) Handles btnSearchByFleetID.Click

        obj.ConnectionString = con
        txtRegNo.Text = obj.fnVehicleRegNumFromFleetID(txtFleetIDSearch.Text)
        loadVehicleData()

    End Sub

End Class