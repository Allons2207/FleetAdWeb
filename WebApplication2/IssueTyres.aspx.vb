
Imports Telerik.Web.UI
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing
Imports System.Data.SqlClient

Public Class IssueTyres
    Inherits System.Web.UI.Page

    Dim objCBO As New commonFunction("FleetAd")
    Dim db As Database = objCBO.Database
    Dim con As String = db.ConnectionString

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If (CokkiesWrapper.UserID <= 0 AndAlso Not IsNumeric(CokkiesWrapper.UserID)) Then
            Response.Redirect("../Login.aspx")
            Exit Sub
        End If

        If Not IsPostBack Then
            objCBO.loadComboBox(cboManufacturer, "SELECT [manufacturer],[manufacturerId] FROM [dbo].[tbl_tyreManufacturers]", "manufacturer", "manufacturerId")
            objCBO.loadComboBox(cboReasonForReplacingTyres, "SELECT [reasonForReplacement], [reasonForReplacementId] FROM [dbo].[tbl_tyreReasonForReplacement]", "reasonForReplacement", "reasonForReplacementId")
            objCBO.loadComboBox(cboTyreSize, "SELECT [tyreSize] , [tyreSizeId]   FROM [dbo].[tbl_tyreSizes]", "tyreSize", "tyreSizeId")

            cmdFitTyres.Visible = False
            ' cmdShowReplacementTyres.Visible = False

            If grantPageWriteCommandPermission(CokkiesWrapper.UserID, 1) = True Then
                cmdFitTyres.Enabled = True
                cmdSearch.Enabled = True
                cmdShowReplacementTyres.Enabled = True
            Else
                cmdFitTyres.Enabled = False
                cmdSearch.Enabled = False
                cmdShowReplacementTyres.Enabled = False

            End If

        End If

    End Sub

    Private Sub loadVehicleDetails()
        Dim qry As String = ""
        Dim serialNumber As String = ""
        Dim insRec As New commonFunction(CokkiesWrapper.thisConnectionName)
        insRec.ConnectionString = con

        Dim qrySTR As String = "SELECT dbo.tbl_vehicleData.fleetId, dbo.tbl_vehicleData.registrationNumber, dbo.tbl_vehicleMakes.vehicleMake, " &
                " dbo.tbl_vehicleModels.vehicleModel, dbo.tbl_vehicleData.currentMileage " &
                " FROM dbo.tbl_vehicleData INNER JOIN dbo.tbl_vehicleModels ON dbo.tbl_vehicleData.modelId = " &
                " dbo.tbl_vehicleModels.vehicleModelId INNER JOIN dbo.tbl_vehicleMakes ON dbo.tbl_vehicleModels.vehicleMakeId " &
                " = dbo.tbl_vehicleMakes.vehicleMakeId WHERE (dbo.tbl_vehicleData.fleetId ='" & txtFleetID.Text & "')"
        Try
            Dim ds As DataSet = insRec.ExecuteDsQRY(qrySTR)

            cmdFitTyres.Visible = False
            cmdShowReplacementTyres.Visible = False

            If ds.Tables(0).Rows.Count > 0 Then
                txtRegNumber.Text = ds.Tables(0).Rows(0).Item("registrationNumber")
                txtMake.Text = ds.Tables(0).Rows(0).Item("vehicleMake")
                txtModel.Text = ds.Tables(0).Rows(0).Item("vehicleModel")
                txtVehicleMileage.Text = ds.Tables(0).Rows(0).Item("currentMileage")

                loadTyresOnVehicle()

                cmdShowReplacementTyres.Visible = True
            Else
                objCBO.MessageLabel(lblMsg, "Record not found in the vehicle data records.", "Red")
            End If

        Catch ex As Exception

        End Try


    End Sub

    Private Sub searchByFleetID()
        Dim qry As String = ""
        Dim serialNumber As String = ""
        Dim insRec As New commonFunction(CokkiesWrapper.thisConnectionName)
        insRec.ConnectionString = con

        Dim qrySTR As String = "SELECT dbo.tbl_vehicleData.fleetId, dbo.tbl_vehicleData.registrationNumber, dbo.tbl_vehicleMakes.vehicleMake, " &
                " dbo.tbl_vehicleModels.vehicleModel, dbo.tbl_vehicleData.currentMileage " &
                " FROM dbo.tbl_vehicleData INNER JOIN dbo.tbl_vehicleModels ON dbo.tbl_vehicleData.modelId = " &
                " dbo.tbl_vehicleModels.vehicleModelId INNER JOIN dbo.tbl_vehicleMakes ON dbo.tbl_vehicleModels.vehicleMakeId " &
                " = dbo.tbl_vehicleMakes.vehicleMakeId WHERE (dbo.tbl_vehicleData.fleetId ='" & txtFleetID.Text & "')"
        Try
            Dim ds As DataSet = insRec.ExecuteDsQRY(qrySTR)

            cmdFitTyres.Visible = False
            cmdShowReplacementTyres.Visible = False

            If ds.Tables(0).Rows.Count > 0 Then
                txtRegNumber.Text = ds.Tables(0).Rows(0).Item("registrationNumber")
                txtMake.Text = ds.Tables(0).Rows(0).Item("vehicleMake")
                txtModel.Text = ds.Tables(0).Rows(0).Item("vehicleModel")

                loadTyresOnVehicle()

                cmdShowReplacementTyres.Visible = True

                txtVehicleMileage.Text = ds.Tables(0).Rows(0).Item("currentMileage")
            Else
                objCBO.MessageLabel(lblMsg, "Could not found a vehicle with this Fleet ID in the vehicle data records.", "Red")

                gwFittedTyres.DataSource = String.Empty
                gwFittedTyres.DataBind()
            End If

        Catch ex As Exception

        End Try
    End Sub


    Private Sub loadTyresOnVehicle()

        Dim sql As String = " SELECT dbo.tbl_tyres.serialNumber AS [Serial_Number], dbo.tbl_tyreSizes.tyreSize AS [Tyre Size], dbo.tbl_tyreManufacturers.manufacturer " &
     " 	AS Manufacturer, dbo.tbl_tyres.detManufactured AS [Date Manufactured], dbo.tbl_tyreSuppliers.supplierName AS Supplier,  " &
           "   dbo.tbl_tyres.detFittedOnVehicle AS [Date Fitted], dbo.tbl_tyres.vehicleMileageAtTyreFitting AS [Vehicle Milage At Fitting],  " &
                      "     dbo.tbl_tyres.currentVehicleMileage AS [Current Vehicle Mileage], dbo.tbl_tyres.currentTyreMilage AS [Tyre Mileage] " &
         " FROM            dbo.tbl_tyres INNER JOIN dbo.tbl_tyreManufacturers ON dbo.tbl_tyres.manufacturerId = dbo.tbl_tyreManufacturers.manufacturerId INNER JOIN " &
                      "     dbo.tbl_tyreSizes ON dbo.tbl_tyres.tyreSizeId = dbo.tbl_tyreSizes.tyreSizeId INNER JOIN " &
                        "   dbo.tbl_tyreSuppliers ON dbo.tbl_tyres.supplierId = dbo.tbl_tyreSuppliers.supplierId " &
               "   WHERE        (dbo.tbl_tyres.fittingStatusId = 2) AND (dbo.tbl_tyres.[fleetId] ='" & txtFleetID.Text & "')"

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            If ds.Tables(0).Rows.Count > 0 Then
                With gwFittedTyres
                    Try
                        .DataSource = ds
                        .DataBind()

                    Catch ex As Exception
                        '  log.Error(ex.Message)
                    End Try
                End With
            Else
                gwFittedTyres.DataSource = String.Empty
                gwFittedTyres.DataBind()
            End If

        Catch ex As Exception
            'log.Error(ex)
        End Try

    End Sub

    Protected Sub cmdSearch_Click(sender As Object, e As EventArgs) Handles cmdSearch.Click

        If txtRegNumber.Text = "" Then
            objCBO.MessageLabel(lblMsg, "Please enter a valid Registration Number.", "")
            Exit Sub
        End If

        clearSearchControls()

        objCBO.ConnectionString = con
        txtFleetID.Text = objCBO.fnVehicleFleetIDNumFromRegNum(txtRegNumber.Text)

        loadVehicleDetails()

    End Sub

    Private Sub loadAvailableTyres()
        ' gwAvailableTyres






        Dim NumberOfTyresRequired As Integer
        Dim qry As String = ""

        NumberOfTyresRequired = Val(txtNumberOfTyresReqd.Text)

        If NumberOfTyresRequired > 0 Then

            If chkSpecifyManufacturer.Checked = True Then
                qry = "SELECT TOP " & NumberOfTyresRequired & "  dbo.tbl_tyres.serialNumber AS [Serial_Number], dbo.tbl_tyreManufacturers.manufacturer AS Manufacturer, " &
                            "   dbo.tbl_tyres.detManufactured AS [Date Manufactured], dbo.tbl_tyreSuppliers.supplierName AS Supplier, " &
                         "  dbo.tbl_tyres.detReceived AS [Date Supplied], dbo.tbl_tyreSizes.tyreSize AS [Tyre Size], dbo.tbl_tyres.batchNumber AS [P.O Number], " &
                        "   dbo.tbl_tyres.entryNumber FROM  dbo.tbl_tyres INNER JOIN " &
                         "  dbo.tbl_tyreManufacturers ON dbo.tbl_tyres.manufacturerId = dbo.tbl_tyreManufacturers.manufacturerId INNER JOIN " &
                         "  dbo.tbl_tyreSuppliers ON dbo.tbl_tyres.supplierId = dbo.tbl_tyreSuppliers.supplierId INNER JOIN " &
                         "  dbo.tbl_tyreSizes ON dbo.tbl_tyres.tyreSizeId = dbo.tbl_tyreSizes.tyreSizeId " &
                         " WHERE (dbo.tbl_tyreSizes.tyreSize = '" & cboTyreSize.Text & "')  AND dbo.tbl_tyres.fittingStatusId = 1 " &
                         " AND tbl_tyreManufacturers.manufacturerId  = " & cboManufacturer.SelectedValue & " ORDER BY dbo.tbl_tyres.entryNumber "
            Else
                qry = "SELECT TOP " & NumberOfTyresRequired & "  dbo.tbl_tyres.serialNumber AS [Serial_Number], dbo.tbl_tyreManufacturers.manufacturer AS Manufacturer, " &
                            "   dbo.tbl_tyres.detManufactured AS [Date Manufactured], dbo.tbl_tyreSuppliers.supplierName AS Supplier, " &
                         "  dbo.tbl_tyres.detReceived AS [Date Supplied], dbo.tbl_tyreSizes.tyreSize AS [Tyre Size], dbo.tbl_tyres.batchNumber AS [P.O Number], " &
                        "   dbo.tbl_tyres.entryNumber FROM  dbo.tbl_tyres INNER JOIN " &
                         "  dbo.tbl_tyreManufacturers ON dbo.tbl_tyres.manufacturerId = dbo.tbl_tyreManufacturers.manufacturerId INNER JOIN " &
                         "  dbo.tbl_tyreSuppliers ON dbo.tbl_tyres.supplierId = dbo.tbl_tyreSuppliers.supplierId INNER JOIN " &
                         "  dbo.tbl_tyreSizes ON dbo.tbl_tyres.tyreSizeId = dbo.tbl_tyreSizes.tyreSizeId " &
                         " WHERE (dbo.tbl_tyreSizes.tyreSize = '" & cboTyreSize.Text & "')  AND dbo.tbl_tyres.fittingStatusId = 1  ORDER BY dbo.tbl_tyres.entryNumber "

            End If

            Try
                Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, qry)
                If ds.Tables(0).Rows.Count > 0 Then
                    With gwAvailableTyres
                        Try
                            .DataSource = ds
                            .DataBind()

                            cmdFitTyres.Visible = True


                        Catch ex As Exception
                            '  log.Error(ex.Message)
                        End Try
                    End With
                Else
                    objCBO.MessageLabel(lblMsg, "No Such Tyres Found in Store.", "Red")
                    gwAvailableTyres.DataSource = String.Empty
                    gwAvailableTyres.DataBind()
                End If
            Catch ex As Exception
                'log.Error(ex)
                objCBO.MessageLabel(lblMsg, "An ERROR occurred.", "Red")
            End Try

        End If


    End Sub

    Protected Sub cmdShowReplacementTyres_Click(sender As Object, e As EventArgs) Handles cmdShowReplacementTyres.Click
        If txtNumberOfTyresReqd.Text = "" Then
            objCBO.MessageLabel(lblMsg, "Please specify the number of tyres required.", "Red")
            Exit Sub
        ElseIf Val(txtNumberOfTyresReqd.Text) < 1 Then
            objCBO.MessageLabel(lblMsg, "Invalid number of tyres required.", "Red")
            Exit Sub
        End If

        loadAvailableTyres()

    End Sub

    Protected Sub cmdFitTyres_Click(sender As Object, e As EventArgs) Handles cmdFitTyres.Click

        Dim qry As String = ""
        Dim insRec As New commonFunction(CokkiesWrapper.thisConnectionName)

        insRec.ConnectionString = con
        Try
            For Each gridRow As GridDataItem In gwAvailableTyres.Items
                qry = "UPDATE [dbo].[tbl_tyres] SET [vehicleMileageAtTyreFitting] = " &
                    Val(txtVehicleMileage.Text) & ", [fittingStatusId] = 2, [detFittedOnVehicle] = '" & rdDtDate.SelectedDate.ToString & "', [fleetId] = '" &
                    txtFleetID.Text & "' WHERE [serialNumber] = '" & gridRow("Serial_Number").Text & "'"
                ' End If
                If insRec.ExecuteNonQRY(qry) = 1 Then
                Else
                    'log error
                End If
            Next

            For Each gridRow As GridDataItem In gwFittedTyres.Items
                If gridRow.Selected Then
                    qry = "UPDATE [dbo].[tbl_tyres] SET [vehicleMileageAtTyreRemoval] = " &
                        Val(txtVehicleMileage.Text) & ", [fittingStatusId] = 3, [detRemovedFromVehicle] = '" & rdDtDate.SelectedDate.ToString & "', [reasonForRemovalId] = " &
                        cboReasonForReplacingTyres.SelectedValue & " WHERE [serialNumber] = '" & gridRow("Serial_Number").Text & "' AND [fleetId] = '" & txtFleetID.Text & "'"
                    ' End If
                    If insRec.ExecuteNonQRY(qry) = 1 Then
                    Else
                        'log error
                        ' Exit Sub
                    End If
                End If
            Next

            objCBO.MessageLabel(lblMsg, "Tyres have been fitted successfully.", "Green")

        Catch ex As Exception
            'log error
        End Try

        With gwAvailableTyres
            .DataSource = Nothing
            .DataBind()
        End With

        loadTyresOnVehicle()

    End Sub

    Public Function grantPageWriteCommandPermission(ByVal UserId As Integer, pageId As Integer) As Boolean

        grantPageWriteCommandPermission = False
        Dim qry As String = "SELECT * FROM [dbo].[tbl_userSysPermissions] WHERE [userId] = " & UserId & " AND [sysModuleSectionId] = " & pageId & " AND [sysWrite] = 1"

        Try
            objCBO.ConnectionString = con
            Dim ds As DataSet = objCBO.ExecuteDsQRY(qry)
            If ds.Tables(0).Rows.Count > 0 Then
                grantPageWriteCommandPermission = True
            End If
        Catch ex As Exception
        End Try

    End Function

    Protected Sub btnSearchByFleetId_Click(sender As Object, e As EventArgs) Handles btnSearchByFleetId.Click

        If txtFleetID.Text = "" Then
            objCBO.MessageLabel(lblMsg, "Please enter a Valid Fleet Id.", "")
            Exit Sub
        End If

        clearSearchControls()
        searchByFleetID()

    End Sub

    Private Sub clearSearchControls()

        txtMake.Text = ""
        txtModel.Text = ""
        txtVehicleMileage.Text = ""

        objCBO.MessageLabel(lblMsg, "", "")

        With gwFittedTyres
            .DataSource = Nothing
            .DataBind()
        End With

        With gwAvailableTyres
            .DataSource = Nothing
            .DataBind()
        End With

    End Sub


End Class