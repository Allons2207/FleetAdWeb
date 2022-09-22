
Imports Telerik.Web.UI
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing
Public Class VehicleInspectionDetails
    Inherits System.Web.UI.Page
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString



    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            loadAllocatedRegNumbers()
            loadInspectionAreas()

            If Not IsNothing(Request.QueryString("op")) Then
                cboRegistrationNumber.Enabled = False
                loadExistingVehicleData()
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

    Private Sub loadAllocatedRegNumbers()
        obj.loadComboBox(cboRegistrationNumber, "SELECT DISTINCT [registrationNumber] FROM [dbo].[tbl_vehicleData] WHERE [allocationStatusId] = 1", "registrationNumber", "registrationNumber")
    End Sub

    Private Sub loadInspectionAreas()
        Dim sql As String = "SELECT DISTINCT [inspectionAreaId], [inspectionArea] AS Inspected FROM [dbo].[tbl_inspectionAreas]"
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


    Private Sub saveInspectionDetails()
        Dim sql As String = "INSERT [dbo].[tbl_inspectionDetails] ([dtDate], [fleetId],[regNum], [keyFinding], [keyDetails])" &
                            "VALUES ('" & rdInspectionDate.SelectedDate & "','" & txtFleetID.Text & "','" & cboRegistrationNumber.SelectedValue & "', " &
                            "'" & cboOverallFinding.Text & "', '" & txtInspectionDetails.Text & "')"


        Try

            obj.ConnectionString = con
            If obj.ExecuteNonQRY(sql) = 1 Then

                insertInspectionAreas()
                obj.MessageLabel(lblMsg, "Vehicle inspection details successfully saved.", "Green")
                Exit Sub
            Else
                obj.MessageLabel(lblMsg, "Error while trying to save Inspection Details.", "Red")
                Exit Sub
            End If

        Catch ex As Exception
        End Try


    End Sub


    Private Sub insertInspectionAreas()
        Dim sql As String = ""
        Try
            obj.ConnectionString = con
            sql = "DELETE FROM [dbo].[tbl_inspectionAreaDetails] WHERE [fleetId] = '" & txtFleetID.Text & "' AND [dtDate] = '" & rdInspectionDate.SelectedDate & "'"
            obj.ExecuteNonQRY(sql)

            For Each gridRow As GridDataItem In gwList.Items
                If gridRow.Selected Then
                    sql = "INSERT [dbo].[tbl_inspectionAreaDetails]   ([dtDate],[fleetId],[inspectionArea] ) " &
                          " VALUES('" & rdInspectionDate.SelectedDate & "', '" & txtFleetID.Text & "', '" & gridRow("Inspected").Text & "')"
                    obj.ExecuteNonQRY(sql)
                End If
            Next
        Catch ex As Exception

        End Try


    End Sub

    Private Sub loadVehicleData()

        txtFleetID.Text = ""
        txtInspectionDetails.Text = ""
        txtMake.Text = ""
        txtModel.Text = ""

        Dim qry As String = "SELECT dbo.tbl_vehicleMakes.vehicleMake, dbo.tbl_vehicleModels.vehicleModel, dbo.tbl_vehicleData.registrationNumber," &
                           " dbo.tbl_vehicleData.fleetId FROM dbo.tbl_vehicleModels INNER JOIN dbo.tbl_vehicleMakes ON " &
                           " dbo.tbl_vehicleModels.vehicleMakeId = dbo.tbl_vehicleMakes.vehicleMakeId INNER JOIN dbo.tbl_vehicleData ON " &
                           " dbo.tbl_vehicleModels.vehicleModelId = dbo.tbl_vehicleData.modelId WHERE  dbo.tbl_vehicleData.fleetId = '" & txtFleetIDSearch.Text & "'"

        Try
            obj.ConnectionString = con
            Dim ds As DataSet = obj.ExecuteDsQRY(qry)
            If ds.Tables(0).Rows.Count > 0 Then
                txtRegNo.Text = ds.Tables(0).Rows(0).Item("registrationNumber")
                txtMake.Text = ds.Tables(0).Rows(0).Item("vehicleMake")
                txtModel.Text = ds.Tables(0).Rows(0).Item("vehicleModel")
                txtFleetID.Text = ds.Tables(0).Rows(0).Item("fleetId")
            Else
                obj.MessageLabel(lblMsg, "No such vehicle found under ALLOCATED and POOL vehicles.", "Yellow")
            End If
        Catch ex As Exception

        End Try


    End Sub

    Protected Sub cboFleetID_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboRegistrationNumber.SelectedIndexChanged
        loadVehicleData()
    End Sub

    Protected Sub cmdSave_Click(sender As Object, e As EventArgs) Handles cmdSave.Click

        If txtFleetID.Text = "" Then
            obj.MessageLabel(lblMsg, "Please specify the Vehicle's Fleet number.", "Red")
            Exit Sub
        ElseIf cboOverallFinding.Text = "" Or cboOverallFinding.Text = "--Select--" Then
            obj.MessageLabel(lblMsg, "Please specify the overall finding.", "Red")
            Exit Sub
        End If


        Dim qry As String = "SELECT dbo.tbl_vehicleMakes.vehicleMake, dbo.tbl_vehicleModels.vehicleModel, dbo.tbl_vehicleData.registrationNumber," &
                           " dbo.tbl_vehicleData.fleetId FROM dbo.tbl_vehicleModels INNER JOIN dbo.tbl_vehicleMakes ON " &
                           " dbo.tbl_vehicleModels.vehicleMakeId = dbo.tbl_vehicleMakes.vehicleMakeId INNER JOIN dbo.tbl_vehicleData ON " &
                           " dbo.tbl_vehicleModels.vehicleModelId = dbo.tbl_vehicleData.modelId WHERE    (dbo.tbl_vehicleData.FleetId = '" & txtFleetID.Text & "')"

        Try
            obj.ConnectionString = con
            Dim ds As DataSet = obj.ExecuteDsQRY(qry)
            If ds.Tables(0).Rows.Count > 0 Then

            Else
                obj.MessageLabel(lblMsg, "No such vehicle found under ALLOCATED and POOL vehicles.", "Red")
                Exit Sub
            End If
        Catch ex As Exception

        End Try



        If Not IsNothing(Request.QueryString("op")) Then
            updateInspectionDetails()
        Else
            saveInspectionDetails()
        End If



    End Sub

    Private Sub updateInspectionDetails()
        Dim sql As String = "UPDATE tbl_inspectionDetails SET dtDate = '" & rdInspectionDate.SelectedDate & "',fleetId = '" & txtFleetID.Text &
            "' ,regNum = '" & txtRegNo.Text & "' , keyFinding = '" & cboOverallFinding.Text & "', keyDetails = '" & txtInspectionDetails.Text & "' " &
           " WHERE (ctr = " & Request.QueryString("op") & ")"

        Try
            obj.ConnectionString = con
            If obj.ExecuteNonQRY(sql) = 1 Then
                insertInspectionAreas()
                obj.MessageLabel(lblMsg, "Vehicle inspection details successfully Updated.", "Green")
                Exit Sub
            Else
                obj.MessageLabel(lblMsg, "Error while trying to Update Inspection Details.", "Red")
                Exit Sub
            End If

        Catch ex As Exception
        End Try

    End Sub
    Private Sub loadExistingVehicleData()
        Dim sql As String = "SELECT ctr, dtDate, fleetId, regNum, keyFinding, keyDetails FROM dbo.tbl_inspectionDetails WHERE (ctr = " & Request.QueryString("op") & ")"
        obj.ConnectionString = con
        Dim ds As DataSet = obj.ExecuteDsQRY(sql)

        If ds.Tables(0).Rows.Count > 0 Then

            txtFleetIDSearch.Text = ds.Tables(0).Rows(0).Item("fleetId")
            loadVehicleData()
            txtRegNo.Text = ds.Tables(0).Rows(0).Item("regNum")
            rdInspectionDate.SelectedDate = ds.Tables(0).Rows(0).Item("dtDate")
            cboOverallFinding.SelectedValue = ds.Tables(0).Rows(0).Item("keyFinding")
            txtInspectionDetails.Text = ds.Tables(0).Rows(0).Item("keyDetails")
            showOnCheckGrid()
        End If
    End Sub

    Private Sub showOnCheckGrid()
        Dim sql As String = ""
        Try
            For Each gridRow As GridDataItem In gwList.Items
                sql = "SELECT * FROM [dbo].[tbl_inspectionAreaDetails] WHERE [dtDate] = '" & rdInspectionDate.SelectedDate &
                                     "' AND [fleetId] = '" & txtFleetID.Text & "' AND [inspectionArea] = '" & gridRow("Inspected").Text & "'"

                obj.ConnectionString = con
                Dim ds As DataSet = obj.ExecuteDsQRY(sql)
                If ds.Tables(0).Rows.Count > 0 Then
                    gridRow.Selected = True
                End If
            Next
        Catch ex As Exception

        End Try
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
            Dim qry As String = "DELETE FROM dbo.tbl_inspectionDetails WHERE (ctr = " & Request.QueryString("op") & ")"

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

    Protected Sub cmdClear0_Click(sender As Object, e As EventArgs) Handles cmdClear0.Click

        obj.ConnectionString = con
        txtFleetIDSearch.Text = obj.fnVehicleFleetIDNumFromRegNum(txtRegNo.Text)
        loadVehicleData()

    End Sub

    Protected Sub btnSearchByFleetID_Click(sender As Object, e As EventArgs) Handles btnSearchByFleetID.Click
        obj.ConnectionString = con
        txtRegNo.Text = obj.fnVehicleRegNumFromFleetID(txtFleetIDSearch.Text)
        loadVehicleData()
    End Sub

End Class