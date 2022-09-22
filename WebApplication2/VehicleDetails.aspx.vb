


Imports Telerik.Web.UI
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing
Public Class VehicleDetails
    Inherits System.Web.UI.Page

    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'CokkiesWrapper.thisConnectionName
        If Not IsPostBack Then
            obj.loadComboBox(cboColor, "SELECT [vehicleColorId], [vehicleColor] from [dbo].[tbl_vehicleColors]", "vehicleColor", "vehicleColorId")
            obj.loadComboBox(cboFuelType, "SELECT [fuelTypeId], [fuelType] FROM [dbo].[tbl_fuelTypes]", "fuelType", "fuelTypeId")
            obj.loadComboBox(cboMake, "SELECT  [vehicleMakeId]  ,[vehicleMake] FROM    [dbo].[tbl_vehicleMakes] order by [vehicleMake]", "vehicleMake", "vehicleMakeId")
            obj.loadComboBox(cboPurchaseCurrency, "SELECT [currencyId], [curCurrency] FROM [dbo].[tbl_currencies]", "curCurrency", "currencyId")
            obj.loadComboBox(cboUserCategory, "SELECT [categoryId], [category] FROM [dbo].[tbl_vehicleCategories]", "category", "categoryId")
            obj.loadComboBox(cboVehicleType, "SELECT [vehicleTypeId], [vehicleType] FROM [dbo].[tbl_vehicleTypes] ORDER BY [vehicleType]", "vehicleType", "vehicleTypeId")
            obj.loadComboBox(cboTyreSizeId, "SELECT [tyreSizeId],[tyreSize] FROM [dbo].[tbl_tyreSizes]", "tyreSize", "tyreSizeId")

            Dim ctr As Long

            For ctr = 2000 To Val(Year(Now))
                cboYearOfManufacture.Items.Add(ctr)
            Next


            'Dim ctr As Long
            'For ctr = 2000 To Year(Now)
            '    cboYearOfManufacture.Items.Add(ctr)
            'Next


            If grantPageWriteCommandPermission(CokkiesWrapper.UserID, 1) = True Then
                cmdSave.Enabled = True
                btnClear.Enabled = True
                If Not IsNothing(Request.QueryString("op")) Then
                    cmdDelete.Enabled = True
                Else
                    cmdDelete.Enabled = False
                End If
            Else
                cmdSave.Enabled = False
                btnClear.Enabled = False
            End If

            loadAccessories()
            'showOnCheckGrid

            If Not IsNothing(Request.QueryString("op")) Then
                loadVehicleDetails()
                loadVehicleUserDetails()
            Else
                hideVehicleAllocationControls()
            End If



        End If

    End Sub

    Private Sub loadVehicleDetails()

        txtRegNumber.Text = Request.QueryString("op")

        Dim qry As String = "SELECT  dbo.tbl_vehicleData.fleetId, dbo.tbl_vehicleData.registrationNumber, dbo.tbl_vehicleData.satelliteTrackingNumber, " &
                            " dbo.tbl_vehicleData.satelliteCellNum, dbo.tbl_vehicleData.yearOfManufacture, dbo.tbl_vehicleData.engineNumber, " &
                            " dbo.tbl_vehicleData.capacity, dbo.tbl_vehicleData.chassisNumber, dbo.tbl_vehicleData.purchaseDate, " &
                            " dbo.tbl_vehicleData.purchaseAmount, dbo.tbl_vehicleData.purchaseCurrencyId, dbo.tbl_vehicleData.purchaseRateToUSD, " &
                            " dbo.tbl_vehicleData.currentMileage, dbo.tbl_vehicleData.serviceMileage, dbo.tbl_vehicleData.fuelTypeId, " &
                            " dbo.tbl_vehicleData.vehicleColorId, dbo.tbl_vehicleData.lastMileageDate, dbo.tbl_vehicleData.GrossVehicleMass, " &
                            " dbo.tbl_vehicleData.NetVehicleMass,dbo.tbl_vehicleData.passengerCarryingCapacity, dbo.tbl_vehicleData.tyreSizeId, " &
                            " dbo.tbl_vehicleData.numberOfTyres, dbo.tbl_vehicleData.vehicleCategoryId, dbo.tbl_vehicleData.vehicleTypeId, " &
                            " dbo.tbl_vehicleData.modelId, dbo.tbl_vehicleModels.vehicleMakeId, dbo.tbl_vehicleData.currentUserId, dbo.tbl_vehicleData.fuelConsumptionRate  FROM dbo.tbl_vehicleModels INNER JOIN " &
                            " dbo.tbl_vehicleData ON dbo.tbl_vehicleModels.vehicleModelId = dbo.tbl_vehicleData.modelId " &
                            " WHERE        (dbo.tbl_vehicleData.registrationNumber = '" & txtRegNumber.Text & "')"

        obj.ConnectionString = con
        Dim ds As DataSet = obj.ExecuteDsQRY(qry)

        If ds.Tables(0).Rows.Count > 0 Then
            With ds.Tables(0).Rows(0)
                '.Rows(0)("firstName")
                On Error Resume Next


                btnClear.Enabled = False

                txtFleetID.Enabled = False
                txtFleetID.Text = .Item("fleetId")
                txtRegNumber.Text = .Item("registrationNumber")
                txtZTrackNumba.Text = .Item("satelliteTrackingNumber")
                txtCellNumba.Text = .Item("satelliteCellNum")
                cboYearOfManufacture.SelectedValue = .Item("yearOfManufacture")
                txtEngineNumba.Text = .Item("engineNumber")
                txtEngineCapacity.Text = .Item("capacity")
                txtChassisNumba.Text = .Item("chassisNumber")
                rdPurchaseDate.SelectedDate = .Item("purchaseDate")
                txtPurchaseAmt.Text = .Item("purchaseAmount")
                cboPurchaseCurrency.SelectedValue = .Item("purchaseCurrencyId")
                txtPurchaseRateToUSD.Text = .Item("purchaseRateToUSD")
                txtCurrentMileage.Text = .Item("currentMileage")
                txtServiceMileage.Text = .Item("serviceMileage")
                cboFuelType.SelectedValue = .Item("fuelTypeId")
                cboColor.SelectedValue = .Item("vehicleColorId")
                txtGVM.Text = .Item("GrossVehicleMass")
                txtNVM.Text = .Item("NetVehicleMass")
                txtCarryingCapacity.Text = .Item("passengerCarryingCapacity")
                cboTyreSizeId.SelectedValue = .Item("tyreSizeId")
                txtNumOfTyres.Text = .Item("numberOfTyres")
                cboUserCategory.SelectedValue = .Item("vehicleCategoryId")
                cboVehicleType.SelectedValue = .Item("vehicleTypeId")
                cboMake.SelectedValue = .Item("vehicleMakeId")
                obj.loadComboBox(cboModel, "SELECT [vehicleModelId], [vehicleModel] FROM [dbo].[tbl_vehicleModels] WHERE [vehicleMakeId] = '" & cboMake.SelectedValue & "'", "vehicleModel", "vehicleModelId")
                cboModel.SelectedValue = .Item("modelId")
                txtLicenceNo.Text = .Item("currentUserId")
                txtFuelConsumptionRate.Text = .Item("fuelConsumptionRate")

                showOnCheckGrid()

                btnAllocateVehicle.Enabled = True

            End With
        End If


    End Sub

    Private Sub clearControls()
        txtFleetID.Text = ""
        txtRegNumber.Text = ""
        txtZTrackNumba.Text = ""
        txtCellNumba.Text = ""
        cboYearOfManufacture.ClearSelection()
        txtEngineNumba.Text = ""
        txtEngineCapacity.Text = ""
        txtChassisNumba.Text = ""
        rdPurchaseDate.Clear()
        txtPurchaseAmt.Text = ""
        cboPurchaseCurrency.ClearSelection()
        txtPurchaseRateToUSD.Text = ""
        txtCurrentMileage.Text = ""
        txtServiceMileage.Text = ""
        cboFuelType.ClearSelection()
        cboColor.ClearSelection()
        txtGVM.Text = ""
        txtNVM.Text = ""
        txtCarryingCapacity.Text = ""
        cboTyreSizeId.ClearSelection()
        txtNumOfTyres.Text = ""
        cboUserCategory.SelectedValue = ""
        cboVehicleType.ClearSelection()
        cboMake.ClearSelection()
        cboModel.ClearSelection()
        txtRegNumber.Enabled = True

        clearCheckGrid(gwList)

    End Sub


    Private Sub loadAccessories()
        Dim sql As String = "SELECT [accessoryId], [accessory] FROM [dbo].[tbl_accessories]"
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

    Protected Sub cmdSave_Click(sender As Object, e As EventArgs) Handles cmdSave.Click

        If validSave() = False Then Exit Sub

        Dim qry As String = "SELECT * FROM tbl_vehicleData WHERE fleetId = '" & txtFleetID.Text & "'"

        Try
            obj.ConnectionString = con
            Dim ds As DataSet = obj.ExecuteDsQRY(qry)
            If ds.Tables(0).Rows.Count > 0 Then
                UpdateExistingVehicleDetails()
            Else
                insertNewEntry()
            End If

        Catch ex As Exception

            obj.MessageLabel(lblMsg, "The following error occurred while saving the vehicle details; " & ex.Message, "Red")

        End Try

    End Sub

    Public Function validSave() As Boolean

        validSave = False

        If txtFleetID.Text = "" Then
            obj.MessageLabel(lblMsg, "Please enter a valid FleetID, it cannot be empty.", "Red")
            Exit Function
            'ElseIf txtRegNumber.Text = "" Then
            '    obj.MessageLabel(lblMsg, "Please enter a valid Registration Number, it cannot be empty.", "Red")
            '    Exit Function
        ElseIf cboUserCategory.Text = "" Or cboUserCategory.Text = "Select" Then
            obj.MessageLabel(lblMsg, "Please enter a valid User Category. It cannot be empty.", "Red")
            Exit Function
        ElseIf cboVehicleType.Text = "" Or cboUserCategory.Text = "Select" Then
            obj.MessageLabel(lblMsg, "Please enter a valid Vehicle Type. It cannot be empty.", "Red")
            Exit Function
        ElseIf cboMake.Text = "" Or cboUserCategory.Text = "Select" Then
            obj.MessageLabel(lblMsg, "Please enter a valid Vehicle Make. It cannot be empty.", "Red")
            Exit Function
        ElseIf cboModel.Text = "" Or cboUserCategory.Text = "Select" Then
            obj.MessageLabel(lblMsg, "Please enter a valid vehicle Vehicle Model. It cannot be empty.", "Red")
            Exit Function
        ElseIf cboYearOfManufacture.Text = "" Or cboUserCategory.Text = "Select" Then
            obj.MessageLabel(lblMsg, "Please enter a valid Year of Manufacture. It cannot be empty.", "Red")
            Exit Function
        ElseIf txtEngineNumba.Text = "" Then
            obj.MessageLabel(lblMsg, "Please enter a valid Engine Number. It cannot be empty.", "Red")
            Exit Function
        ElseIf txtChassisNumba.Text = "" Then
            obj.MessageLabel(lblMsg, "Please enter a valid Chassis Number. It cannot be empty.", "Red")
            Exit Function
        ElseIf txtGVM.Text = "" Then
            obj.MessageLabel(lblMsg, "Invalid GVM. Please enter a valid GVM.", "Red")
            Exit Function
            'ElseIf txtNVM.Text = "" Then
            '    obj.MessageLabel(lblMsg, "Invalid NVM. Please enter a valid NVM.", "Red")
            '    Exit Function
        ElseIf rdPurchaseDate.IsEmpty Then
            obj.MessageLabel(lblMsg, "Purchase date is empty. Please enter a valid purchase date.", "Red")
            Exit Function
        ElseIf cboPurchaseCurrency.Text = "" Or cboUserCategory.Text = "Select" Then
            obj.MessageLabel(lblMsg, "Please enter a valid Purchase Currency. It cannot be empty.", "Red")
            Exit Function
        ElseIf txtServiceMileage.Text = "" Then
            obj.MessageLabel(lblMsg, "Please enter valid Service Mileage. It cannot be empty.", "Red")
            Exit Function
            'ElseIf txtCurrentMileage.Text = "" Then
            '    obj.MessageLabel(lblMsg, "Error while trying to save vehicle details.", "Red")
            '    Exit Function
            'ElseIf txtNumOfTyres.Text = "" Then
            '    obj.MessageLabel(lblMsg, "Error while trying to save vehicle details.", "Red")
            '    Exit Function
            'ElseIf cboTyreSizeId.Text = "" Then
            '    obj.MessageLabel(lblMsg, "Error while trying to save vehicle details.", "Red")
            '    Exit Function
            'ElseIf cboColor.Text = "" Then
            '    obj.MessageLabel(lblMsg, "Error while trying to save vehicle details.", "Red")
            '    Exit Function
            'ElseIf cboFuelType.Text = "" Then
            '    obj.MessageLabel(lblMsg, "Error while trying to save vehicle details.", "Red")
            '    Exit Function
            'ElseIf txtFuelConsumptionRate.Text = "" Then
        End If

        validSave = True

    End Function


    Private Sub insertNewEntry()

        Dim allocationStatusId As Long = 2

        If cboUserCategory.SelectedValue = 4 Then
            allocationStatusId = 4
        End If

        Dim qry As String = "INSERT [tbl_vehicleData] ([fleetId],[registrationNumber],[satelliteTrackingNumber],[satelliteCellNum],[yearOfManufacture],[engineNumber],[capacity]," &
              " [chassisNumber],[purchaseDate],[purchaseAmount],[purchaseCurrencyId],[purchaseRateToUSD],[currentMileage],[serviceMileage]," &
               " [fuelTypeId],[vehicleColorId],[GrossVehicleMass],[NetVehicleMass],[passengerCarryingCapacity],[tyreSizeId],[numberOfTyres]," &
                " [vehicleCategoryId],[vehicleTypeId],[modelId], [allocationStatusId], [disposalStatusId], [fuelConsumptionRate]) VALUES ('" & txtFleetID.Text & "','" & txtRegNumber.Text & "','" & txtZTrackNumba.Text &
                "','" & txtCellNumba.Text & "'," & cboYearOfManufacture.SelectedValue & ",'" & txtEngineNumba.Text & "','" & txtEngineCapacity.Text &
                "','" & txtChassisNumba.Text & "','" & rdPurchaseDate.SelectedDate & "'," & Val(txtPurchaseAmt.Text) & "," & cboPurchaseCurrency.SelectedValue &
                ",'" & txtPurchaseRateToUSD.Text & "'," & Val(txtCurrentMileage.Text) & "," & Val(txtServiceMileage.Text) & "," & cboFuelType.SelectedValue &
                "," & cboColor.SelectedValue & "," & Val(txtGVM.Text) & "," & Val(txtNVM.Text) & "," & Val(txtCarryingCapacity.Text) & "," & cboTyreSizeId.SelectedValue &
                "," & Val(txtNumOfTyres.Text) & "," & cboUserCategory.SelectedValue & "," & cboVehicleType.SelectedValue & "," & cboModel.SelectedValue & "," & allocationStatusId & ",0," & Val(CInt(txtFuelConsumptionRate.Text)) & ")"
        Try
            obj.ConnectionString = con
            If obj.ExecuteNonQRY(qry) = 1 Then
                saveFromCheckGrid()
                btnAllocateVehicle.Enabled = True
                obj.MessageLabel(lblMsg, "Vehicle details successfully saved.", "Green")
                showVehicleAllocationControls()
                Exit Sub
            Else
                obj.MessageLabel(lblMsg, "Error while trying to save vehicle details.", "Red")
                Exit Sub
            End If
        Catch ex As Exception
            obj.MessageLabel(lblMsg, "Error while trying to save vehicle details.", "Red")
        End Try

    End Sub

    Private Sub UpdateExistingVehicleDetails()

        Dim qry As String = "UPDATE tbl_vehicleData SET   registrationNumber = '" & txtRegNumber.Text & " ',   [fleetId] = '" & txtFleetID.Text & "',[satelliteTrackingNumber]='" & txtZTrackNumba.Text & "',[satelliteCellNum] = '" & txtCellNumba.Text &
            "',[yearOfManufacture] = " & cboYearOfManufacture.SelectedValue & ",[engineNumber]='" & txtEngineNumba.Text & "',[capacity]='" & txtEngineCapacity.Text &
            "', [chassisNumber] = '" & txtChassisNumba.Text & "',[purchaseDate] = '" & rdPurchaseDate.SelectedDate & "',[purchaseAmount] = " & Val(txtPurchaseAmt.Text) &
            ",[purchaseCurrencyId]=" & cboPurchaseCurrency.SelectedValue & ",[purchaseRateToUSD]='" & txtPurchaseRateToUSD.Text & "',[currentMileage] = " & Val(txtCurrentMileage.Text) &
            ",[serviceMileage]=" & Val(txtServiceMileage.Text) & ", [fuelTypeId] = " & cboFuelType.SelectedValue & ",[vehicleColorId]=" & cboColor.SelectedValue &
            ",[GrossVehicleMass]=" & Val(txtGVM.Text) & ",[NetVehicleMass]=" & Val(txtNVM.Text) & ",[passengerCarryingCapacity]=" & Val(txtCarryingCapacity.Text) &
            ",[tyreSizeId]=" & cboTyreSizeId.SelectedValue & ",[numberOfTyres] = " & Val(txtNumOfTyres.Text) & ",[vehicleCategoryId] = " & cboUserCategory.SelectedValue &
            ",[vehicleTypeId] = " & cboVehicleType.SelectedValue & ",[modelId] = " & cboModel.SelectedValue & ", [fuelConsumptionRate] = " & Val(CInt(txtFuelConsumptionRate.Text)) & " WHERE [fleetId] = '" & txtFleetID.Text & "'"

        Try
            obj.ConnectionString = con
            If obj.ExecuteNonQRY(qry) = 1 Then
                saveFromCheckGrid()
                obj.MessageLabel(lblMsg, "Vehicle details successfully updated.", "Green")
                Exit Sub
            Else
                obj.MessageLabel(lblMsg, "Error while trying to update vehicle details.", "Red")
                Exit Sub
            End If
        Catch ex As Exception
            obj.MessageLabel(lblMsg, "Error while trying to update vehicle details.", "Red")
        End Try


    End Sub
    Protected Sub cboMake_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboMake.SelectedIndexChanged
        obj.loadComboBox(cboModel, "SELECT [vehicleModelId], [vehicleModel] FROM [dbo].[tbl_vehicleModels] WHERE [vehicleMakeId] = '" & cboMake.SelectedValue & "'", "vehicleModel", "vehicleModelId")
    End Sub

    Private Sub showOnCheckGrid()
        Dim sql As String = ""
        Try
            For Each gridRow As GridDataItem In gwList.Items
                sql = "SELECT * FROM [tbl_vehicle_accessories] WHERE  registrationNumber = '" & txtRegNumber.Text & "' AND [accessory] = '" & gridRow("accessory").Text & "'"
                obj.ConnectionString = con
                Dim ds As DataSet = obj.ExecuteDsQRY(sql)
                If ds.Tables(0).Rows.Count > 0 Then
                    gridRow.Selected = True
                End If
            Next
        Catch ex As Exception

        End Try
    End Sub

    Private Sub clearCheckGrid(gwList As RadGrid)
        For Each gridRow As GridDataItem In gwList.Items
            gridRow.Selected = False
        Next
    End Sub

    Private Sub saveFromCheckGrid()

        Dim sql As String = ""
        Try
            obj.ConnectionString = con
            sql = "DELETE FROM tbl_vehicle_accessories WHERE registrationNumber = '" & txtRegNumber.Text & "'"
            obj.ExecuteNonQRY(sql)

            For Each gridRow As GridDataItem In gwList.Items
                If gridRow.Selected Then
                    sql = "INSERT [dbo].[tbl_vehicle_accessories]   ([fleetId],[registrationNumber],[accessory] ) " & _
                          " VALUES('" & txtFleetID.Text & "', '" & txtRegNumber.Text & "', '" & gridRow("accessory").Text & "')"
                    obj.ExecuteNonQRY(sql)
                End If
            Next
        Catch ex As Exception

        End Try

    End Sub

    Protected Sub btnClear_Click(sender As Object, e As EventArgs) Handles btnClear.Click
        clearControls()
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
            Dim qry As String = "DELETE FROM tbl_vehicleData WHERE  (dbo.tbl_vehicleData.registrationNumber = '" & txtRegNumber.Text & "')"

            obj.ConnectionString = con

            If obj.ExecuteNonQRY(qry) = 1 Then
                clearControls()
                obj.MessageLabel(lblMsg, "Vehicle record entry deleted.", "Green")
            Else
                obj.MessageLabel(lblMsg, "Error while trying to delete Vehicle record entry.", "Red")
            End If
        Else
            obj.MessageLabel(lblMsg, "Error. System could not find the Vehicle Registration Number.", "Red")
        End If
    End Sub

    Protected Sub cmdFind_Click(sender As Object, e As EventArgs) Handles cmdFind.Click

        Dim qry As String = "SELECT [nationalIDNo],[firstName], [surname], [department], [position], licenseNumber FROM [dbo].[tbl_vehicleUsers] WHERE Firstname LIKE '%" & txtSearhFirstName.Text &
            "%' AND surname LIKE '%" & txtSearchSurname.Text & "%'"

        clearUserControls()

        Try
            obj.ConnectionString = con
            Dim ds As DataSet = obj.ExecuteDsQRY(qry)
            If ds.Tables(0).Rows.Count > 0 Then
                If ds.Tables(0).Rows.Count = 1 Then
                    txtFirstName.Text = ds.Tables(0).Rows(0).Item("firstName")
                    txtSurname.Text = ds.Tables(0).Rows(0).Item("surname")
                    txtDept.Text = ds.Tables(0).Rows(0).Item("department")
                    txtDesignation.Text = ds.Tables(0).Rows(0).Item("position")
                    txtLicenceNo.Text = ds.Tables(0).Rows(0).Item("licenseNumber")
                Else
                    obj.MessageLabel(lblSecndMsg, "Please refine your search criteria and/or text, more than one matching records have been found.", "Yellow")
                End If
            Else
                obj.MessageLabel(lblSecndMsg, "No matching records have been found.", "Yellow")
            End If
        Catch ex As Exception
            obj.MessageLabel(lblSecndMsg, "Error while searching Vehicle User details.", "Red")
        End Try

    End Sub

    Private Function validSearchText() As Boolean
        validSearchText = False

        If txtSearhFirstName.Text = "" And txtSearchSurname.Text = "" Then
            obj.MessageLabel(lblSecndMsg, "Invalid search text. It cannot both be empty.", "Red")
            Exit Function
        End If

        validSearchText = True

    End Function
    Private Sub clearUserControls()

        txtLicenceNo.Text = ""
        txtFirstName.Text = ""
        txtSurname.Text = ""
        txtDept.Text = ""
        txtDesignation.Text = ""
        txtLicenceNo.Text = ""
        obj.MessageLabel(lblMsg, "", "")
        obj.MessageLabel(lblSecndMsg, "", "")

    End Sub

    Protected Sub btnAllocateVehicle_Click(sender As Object, e As EventArgs) Handles btnAllocateVehicle.Click

        If btnAllocateVehicle.Text = "Allocate" Then
            allocateVehicleToUser()
        ElseIf btnAllocateVehicle.Text = "UnAllocate" Then
            UnAllocateVehicleFromUser()
        Else

        End If

    End Sub


    Private Sub allocateVehicleToUser()
        obj.ConnectionString = con

        If txtRegNumber.Text = "" Then
            obj.MessageLabel(lblSecndMsg, "Please specify the vehicle registration number.", "Red")
            Exit Sub
        ElseIf obj.fnVehicleExists(txtFleetID.Text) = False
            obj.MessageLabel(lblSecndMsg, "The specified Vehicle Fleet number could not be found in vehicles data.", "Red")
            Exit Sub
        ElseIf obj.fnVehicleUserExists(txtLicenceNo.Text) = False
            obj.MessageLabel(lblSecndMsg, "The specified Vehicle Registration number could not be found in vehicles data.", "Red")
            Exit Sub
        ElseIf txtFirstName.Text = "" Then
            obj.MessageLabel(lblSecndMsg, "Please search and first find the Vehicle User.", "Red")
            Exit Sub
        ElseIf txtLicenceNo.Text = "" Then
            obj.MessageLabel(lblSecndMsg, "Please specify the vehicle user's License Number.", "Red")
            Exit Sub
        ElseIf cboModel.Text = "" Then
            obj.MessageLabel(lblSecndMsg, "Please specify the vehicle Model.", "Red")
            Exit Sub
        End If

        If allocatedUser() = True Then
            obj.MessageLabel(lblSecndMsg, "User is already allocated a vehicle. First unAllocate the vehicle from the User.", "Red")
            Exit Sub
        End If

        'Dim sql As String = "UPDATE [dbo].[tbl_vehicleData] SET [allocationStatusId] = 1, [currentUserId] = '" & obj.fnVehicleUserNationalIdFromLicenceNum(txtLicenceNo.Text) &
        '    "'  WHERE [registrationNumber] = '" & txtRegNumber.Text & "'"


        Dim sql As String = "UPDATE [dbo].[tbl_vehicleData] SET [allocationStatusId] = 1, [currentUserId] = '" & txtLicenceNo.Text &
            "'  WHERE [registrationNumber] = '" & txtRegNumber.Text & "'"


        Try
            obj.ConnectionString = con
            If obj.ExecuteNonQRY(sql) = 1 Then

                sql = "UPDATE [dbo].[tbl_vehicleUsers] SET [allocationStatusId] = 1, [fleetId] = '" & txtFleetID.Text &
                    "', [regNumber] = '" & txtRegNumber.Text & "', [allocationDate] = '" & Today & "' WHERE [licenseNumber] = '" & txtLicenceNo.Text & "'"

                If obj.ExecuteNonQRY(sql) = 1 Then

                    sql = "INSERT tbl_vehicleAllocationHistory (registrationNumber,fleetID ,make,model ,allocationMode,driver," &
                            " department,nationalIDNumber,licenseNumber, dtDate)  VALUES ('" & txtRegNumber.Text &
                            "','" & txtFleetID.Text & "','" & cboMake.Text & "','" & cboMake.Text & "','Allocated','" &
                             txtFirstName.Text & " " & txtSurname.Text & "','" & txtDept.Text & "','" & obj.fnVehicleUserNationalIdFromLicenceNum(txtLicenceNo.Text) &
                             "','" & txtLicenceNo.Text & "','" & Now & "')"

                    obj.ExecuteNonQRY(sql)

                    clearUserControls()

                    obj.MessageLabel(lblSecndMsg, "Vehicle successfully allocated to user.", "Green")

                    Exit Sub

                End If
            Else
                obj.MessageLabel(lblSecndMsg, "Error while trying to allocate vehicle to user.", "Red")
                Exit Sub
            End If

        Catch ex As Exception
        End Try
    End Sub

    Private Sub UnAllocateVehicleFromUser()
        obj.ConnectionString = con

        If txtRegNumber.Text = "" Then
            obj.MessageLabel(lblSecndMsg, "Please specify the vehicle registration number.", "Red")
            Exit Sub
        ElseIf obj.fnVehicleExists(txtFleetID.Text) = False
            obj.MessageLabel(lblSecndMsg, "The specified Vehicle Fleet number could not be found in vehicles data.", "Red")
            Exit Sub
        ElseIf obj.fnVehicleUserExists(txtLicenceNo.Text) = False
            obj.MessageLabel(lblSecndMsg, "The specified Vehicle Registration number could not be found in vehicles data.", "Red")
            Exit Sub
        ElseIf txtFirstName.Text = "" Then
            obj.MessageLabel(lblSecndMsg, "Please search and first find the Vehicle User.", "Red")
            Exit Sub
        ElseIf txtLicenceNo.Text = "" Then
            obj.MessageLabel(lblSecndMsg, "Please specify the vehicle user's License Number.", "Red")
            Exit Sub
        ElseIf cboModel.Text = "" Then
            obj.MessageLabel(lblSecndMsg, "Please specify the vehicle Model.", "Red")
            Exit Sub
        End If

        If allocatedUser() = True Then

            Dim sql As String = "UPDATE [dbo].[tbl_vehicleData] SET [allocationStatusId] = 2, [currentUserId] = ''  WHERE [registrationNumber] = '" & txtRegNumber.Text & "'"


            Try
                obj.ConnectionString = con
                If obj.ExecuteNonQRY(sql) = 1 Then

                    sql = "UPDATE [dbo].[tbl_vehicleUsers] SET [allocationStatusId] = 2, [fleetId] = ''" &
                    ", [regNumber] = '', [allocationDate] = '" & Today & "' WHERE [licenseNumber] = '" & txtLicenceNo.Text & "'"

                    If obj.ExecuteNonQRY(sql) = 1 Then

                        sql = "INSERT tbl_vehicleAllocationHistory (registrationNumber,fleetID ,make,model ,allocationMode,driver," &
                            " department,nationalIDNumber,licenseNumber, dtDate)  VALUES ('" & txtRegNumber.Text &
                            "','" & txtFleetID.Text & "','" & cboMake.Text & "','" & cboMake.Text & "','UnAllocated','" &
                             txtFirstName.Text & " " & txtSurname.Text & "','" & txtDept.Text & "','" & obj.fnVehicleUserNationalIdFromLicenceNum(txtLicenceNo.Text) &
                             "','" & txtLicenceNo.Text & "','" & Now & "')"

                        obj.ExecuteNonQRY(sql)

                        clearUserControls()

                        obj.MessageLabel(lblSecndMsg, "Vehicle successfully UnAllocated from User.", "Green")

                        Exit Sub

                    End If
                Else
                    obj.MessageLabel(lblSecndMsg, "Error while trying to UnAllocate vehicle from user.", "Red")
                    Exit Sub
                End If

            Catch ex As Exception
            End Try
        Else

        End If

        'Dim sql As String = "UPDATE [dbo].[tbl_vehicleData] SET [allocationStatusId] = 1, [currentUserId] = '" & obj.fnVehicleUserNationalIdFromLicenceNum(txtLicenceNo.Text) &
        '    "'  WHERE [registrationNumber] = '" & txtRegNumber.Text & "'"



    End Sub

    Private Function allocatedUser() As Boolean

        allocatedUser = False

        Dim sql As String = " SELECT [allocationStatusId] FROM [dbo].[tbl_vehicleUsers] WHERE [licenseNumber] = '" & txtLicenceNo.Text & "'"

        obj.ConnectionString = con

        Dim ds As DataSet = obj.ExecuteDsQRY(sql)

        If ds.Tables(0).Rows.Count > 0 Then
            If ds.Tables(0).Rows(0).Item("allocationStatusId") = 1 Then
                allocatedUser = True
            End If
        End If

    End Function

    Private Sub loadVehicleUserDetails()

        Dim sql As String = " Select  [licenseNumber], [firstName], [surname], [department], [position] FROM [dbo].[tbl_vehicleUsers] WHERE [licenseNumber] = '" & txtLicenceNo.Text & "'"

        obj.ConnectionString = con
        Try
            Dim ds As DataSet = obj.ExecuteDsQRY(sql)

            If ds.Tables(0).Rows.Count > 0 Then
                txtFirstName.Text = ds.Tables(0).Rows(0).Item("firstName")
                txtSurname.Text = ds.Tables(0).Rows(0).Item("surname")
                txtLicenceNo.Text = ds.Tables(0).Rows(0).Item("licenseNumber")
                txtDept.Text = ds.Tables(0).Rows(0).Item("department")
                txtDesignation.Text = ds.Tables(0).Rows(0).Item("position")

                btnAllocateVehicle.Text = "UnAllocate"
            Else
                btnAllocateToNewUser.Visible = True
            End If
        Catch

        End Try

    End Sub
    Private Sub hideVehicleAllocationControls()

        lblAllocateTo.Visible = False
        lblDepartment.Visible = False
        lblFirstname.Visible = False
        lblFirstNameSearch.Visible = False
        lblLicenseNo.Visible = False
        lblSecndMsg.Visible = False
        lblSurname.Visible = False
        lblSurnameSearch.Visible = False
        lblVehicleAllocation.Visible = False
        lblVehicleAllocation.Visible = False
        lblDesignation.Visible = False

        cmdFind.Visible = False

        txtFirstName.Visible = False
        txtSurname.Visible = False
        txtLicenceNo.Visible = False
        txtDept.Visible = False
        txtDesignation.Visible = False

        txtSearchSurname.Visible = False
        txtSearhFirstName.Visible = False

        btnAllocateVehicle.Visible = False
        btnAllocateToNewUser.Visible = False

        lblHR.Visible = False

    End Sub

    Private Sub showVehicleAllocationControls()

        lblAllocateTo.Visible = True
        lblDepartment.Visible = True
        lblFirstname.Visible = True
        lblFirstNameSearch.Visible = True
        lblLicenseNo.Visible = True
        lblSecndMsg.Visible = True
        lblSurname.Visible = True
        lblSurnameSearch.Visible = True
        lblVehicleAllocation.Visible = True
        lblVehicleAllocation.Visible = True
        lblDesignation.Visible = True

        cmdFind.Visible = True

        txtFirstName.Visible = True
        txtSurname.Visible = True
        txtLicenceNo.Visible = True
        txtDept.Visible = True
        txtDesignation.Visible = True

        txtSearchSurname.Visible = True
        txtSearhFirstName.Visible = True

        btnAllocateVehicle.Visible = True
        btnAllocateToNewUser.Visible = True

        lblHR.Visible = True
    End Sub

    Protected Sub btnAllocateToNewUser_Click(sender As Object, e As EventArgs) Handles btnAllocateToNewUser.Click
        If txtFleetID.Text = "" Then
            obj.MessageLabel(lblMsg, "Invalid Fleet ID.", "Red")
            Exit Sub
        ElseIf txtFleetID.Enabled = False Then
            obj.MessageLabel(lblMsg, "It appears the vehicle has not been saved or does not exit in records.", "Red")
        End If

        Response.Redirect("~\VehicleAllocationToNewUser.aspx?op=" + txtFleetID.Text)

    End Sub

End Class