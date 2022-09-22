
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Telerik.Web.UI

Public Class VehicleMaintenanceDetails
    Inherits System.Web.UI.Page

    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            obj.loadComboBox(cboWorkDone, "SELECT [detailedServicingWorkDoneId], [detailedServicingWorkDone] FROM [dbo].[tbl_detailedServicingWorkDone] ORDER BY detailedServicingWorkDone", "detailedServicingWorkDone", "detailedServicingWorkDone")
            obj.loadComboBox(cboMaterialsUsed, "SELECT [serviceMaterialId], [serviceMaterial] FROM [dbo].[tbl_serviceMaterials] ORDER BY serviceMaterial", "serviceMaterial", "serviceMaterialId")
            obj.loadComboBox(cboServiceFrequency, "SELECT [ServiceFrequencyId], [ServiceFrequency] FROM [dbo].[lu_ServiceFrequencies]", "ServiceFrequency", "ServiceFrequency")
            obj.loadComboBox(cboServiceCategory, "SELECT  serviceCategoryId, serviceCategory FROM lu_vehicleServiceCategories ORDER BY serviceCategory", "serviceCategory", "serviceCategoryId")
            loadRegNumbers()

            '   txtRegNo.Text = 

            If Not IsNothing(Request.QueryString("op")) Then
                cmdSaveHeader.Enabled = False
                loadExistingServiceData()
            Else
                gwGrid.DataSource = String.Empty
                gwGrid.DataBind()
            End If

            If grantPageWriteCommandPermission(CokkiesWrapper.UserID, 1) = True Then
                cmdSave.Enabled = True
                cmdSaveHeader.Enabled = True
            Else
                cmdSave.Enabled = False
                cmdSaveHeader.Enabled = False
            End If

        End If

    End Sub
    Private Sub loadExistingServiceData()

        Dim qry As String = "Select jobCardNumber, dateInForService, typeOfService, mileageOnService, serviceFrequency, totalTimeTaken, otherCosts, " &
                            " otherCostsValue, sundries, sundriesCost, totJobCost, mechanic, fleetId, regNum, dtDateOutOfService, serviceCategoryId FROM dbo.tbl_vehicleServicingDetails " &
                            "WHERE   (jobCardNumber = '" & Request.QueryString("op") & "') "

        obj.ConnectionString = con

        Try
            Dim ds As DataSet = obj.ExecuteDsQRY(qry)

            If ds.Tables(0).Rows.Count > 0 Then
                With ds.Tables(0).Rows(0)

                    '  cboRegNumber.SelectedValue = .Item("regNum")

                    txtRegNo.Text = .Item("regNum")
                    txtFleetIDSearch.Text = .Item("fleetId")

                    loadVehicleData()

                    txtJobCardNumber.Text = Request.QueryString("op")
                    rdServiceDate.SelectedDate = .Item("dateInForService")
                    txtCurrentMileage.Text = .Item("mileageOnService")
                    cboTypeOfService.SelectedValue = .Item("typeOfService")
                    Dim t As String = .Item("serviceFrequency")
                    cboServiceFrequency.SelectedValue = .Item("serviceFrequency")
                    txtTotalTimeTaken.Text = .Item("totalTimeTaken")
                    txtMechanic.Text = .Item("mechanic")
                    txtFleetID.Text = .Item("fleetId")
                    'dtDateOutOfService
                    rdDateOutOfService.SelectedDate = .Item("dtDateOutOfService")
                    cboServiceCategory.SelectedValue = .Item("serviceCategoryId")
                    loadWorkDetails()

                End With
            End If

        Catch ex As Exception
            'log.Error(ex)
        End Try

    End Sub
    Private Sub loadRegNumbers()
        obj.loadComboBox(cboRegNumber, "SELECT DISTINCT [registrationNumber] FROM [dbo].[tbl_vehicleData] ORDER BY registrationNumber", "registrationNumber", "registrationNumber")
    End Sub
    Private Sub loadFailedComponents()
        Dim sql As String = "SELECT TOP (100) PERCENT dbo.tbl_failureOrRepairTypes.failtureOrRepairType AS Type, dbo.tbl_failureOrRepairsList.failureOrRepair AS Failure" & _
                            " FROM dbo.tbl_failureOrRepairsList INNER JOIN  dbo.tbl_failureOrRepairTypes ON dbo.tbl_failureOrRepairsList.failureOrRepairTypeId = " & _
                            " dbo.tbl_failureOrRepairTypes.failtureOrRepairTypeId ORDER BY dbo.tbl_failureOrRepairTypes.failtureOrRepairType "

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            db.ExecuteDataSet(CommandType.Text, sql)

            With gwGrid0
                Try
                    .DataSource = ds
                    .DataBind()
                Catch ex As Exception
                    '  log.Error(ex.Message)
                End Try
            End With
        Catch ex As Exception
            'log.Error(ex)
        End Try

    End Sub

    Protected Sub cboRegNumber_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboRegNumber.SelectedIndexChanged
        loadVehicleData()
    End Sub

    Protected Sub cmdSaveHeader_Click(sender As Object, e As EventArgs) Handles cmdSaveHeader.Click
        Dim sql As String = ""

        If IsNothing(Request.QueryString("op")) Then

            sql = "SELECT * FROM tbl_vehicleServicingDetails WHERE jobCardNumber = '" & txtJobCardNumber.Text & "'"
            If obj.recordExists(sql) = True Then
                obj.MessageLabel(lblMsg, "Job Card Number already exists.", "Red")
                Exit Sub
            End If

            sql = "INSERT [dbo].[tbl_vehicleServicingDetails] ([jobCardNumber], [dateInForService],[mileageOnService], [regNum], [typeOfService], " &
                "  [serviceFrequency], [totalTimeTaken],[mechanic], [fleetId] , [dtDateOutOfService], serviceCategoryId) VALUES ('" & txtJobCardNumber.Text & "','" & rdServiceDate.SelectedDate & "','" & txtCurrentMileage.Text & "','" & txtRegNo.Text &
                "','" & cboTypeOfService.SelectedValue & "', '" & cboServiceFrequency.Text & "', " & Val(txtTotalTimeTaken.Text) & ",'" & txtMechanic.Text & "','" & txtFleetID.Text & "','" & rdDateOutOfService.SelectedDate & "', " & cboServiceCategory.SelectedValue & ")"
        Else
            sql = "UPDATE tbl_vehicleServicingDetails SET dateInForService ='" & rdServiceDate.SelectedDate & "', mileageOnService ='" & txtCurrentMileage.Text & "', regNum = '" & txtRegNo.Text & "'," &
                "typeOfService ='" & cboTypeOfService.SelectedValue & "' ,serviceFrequency ='" & cboServiceFrequency.Text & "',  totalTimeTaken = " & Val(txtTotalTimeTaken.Text) & ", mechanic ='" & txtMechanic.Text & "' ,fleetId ='" & txtFleetID.Text & "', " &
                "dtDateOutOfService='" & rdDateOutOfService.SelectedDate & "',serviceCategoryId= " & cboServiceCategory.SelectedValue & "  WHERE jobCardNumber  ='" & txtJobCardNumber.Text & "'"
        End If

        saveMaintenanceDetails(sql)

    End Sub

    Private Sub saveMaintenanceDetails(ByVal qry As String)

        obj.ConnectionString = con

        If txtFleetIDSearch.Text = "" Then
            obj.MessageLabel(lblMsg, "Please specify the Vehicle Fleet Number. It cannt be empty.", "Red")
            Exit Sub
        ElseIf obj.fnVehicleExists(txtFleetIDSearch.Text) = False
            obj.MessageLabel(lblMsg, "The specified Vehicle Fleet number could Not be found In vehicles data.", "Red")
            Exit Sub
        ElseIf txtJobCardNumber.Text = "" Then
            obj.MessageLabel(lblMsg, "Please specify the JobCardNumber, it cannot be empty.", "Red")
            Exit Sub
        ElseIf cboTypeOfService.Text = "--Select" Or cboTypeOfService.Text = "" Then
            obj.MessageLabel(lblMsg, "Please specify the Type Of service.", "Red")
            Exit Sub
        ElseIf cboServiceCategory.Text = "--Select--" Or cboServiceCategory.Text = "" Then
            obj.MessageLabel(lblMsg, "Please specify the service category", "Red")
            Exit Sub
        ElseIf cboServiceFrequency.Text = "--Select" Or cboServiceFrequency.Text = "" Then
            obj.MessageLabel(lblMsg, "Please specify the service frequency", "Red")
            Exit Sub
        ElseIf txtMechanic.Text = "" Then
            obj.MessageLabel(lblMsg, "Please specify the Mechanic.", "Red")
            Exit Sub
        End If



        Try
            obj.ConnectionString = con

            If obj.ExecuteNonQRY(qry) = 1 Then
                obj.MessageLabel(lblMsg, "Record saved successfully.", "Green")

                cmdSave.Enabled = True
                cmdSaveHeader.Enabled = False

                qry = "UPDATE [dbo].[tbl_vehicleData] SET [mileageOnLastService] = " & txtCurrentMileage.Text & ", [lastServiceDate] = '" &
                    rdServiceDate.SelectedDate & "', [lastMileageDate] = '" & rdServiceDate.SelectedDate & "' WHERE [fleetId] = '" & txtFleetIDSearch.Text & "'"

                obj.ExecuteNonQRY(qry)

            Else
                obj.MessageLabel(lblMsg, "Error while trying to save record.", "Red")
            End If
        Catch ex As Exception

        End Try

    End Sub


    Private Sub loadVehicleData()

        txtFleetID.Text = ""
        '   txtInspectionDetails.Text = ""
        txtMake.Text = ""
        txtModel.Text = ""

        Dim qry As String = ""

        If Not IsNothing(Request.QueryString("op")) Then
            qry = "SELECT dbo.tbl_vehicleMakes.vehicleMake, dbo.tbl_vehicleModels.vehicleModel, dbo.tbl_vehicleData.registrationNumber," &
                        "dbo.tbl_vehicleData.[currentMileage]   , dbo.tbl_vehicleData.[lastMileageDate], dbo.tbl_vehicleData.[lastServiceDate]," &
                           " dbo.tbl_vehicleData.fleetId FROM dbo.tbl_vehicleModels INNER JOIN dbo.tbl_vehicleMakes ON " &
                           " dbo.tbl_vehicleModels.vehicleMakeId = dbo.tbl_vehicleMakes.vehicleMakeId INNER JOIN dbo.tbl_vehicleData ON " &
                           " dbo.tbl_vehicleModels.vehicleModelId = dbo.tbl_vehicleData.modelId WHERE (dbo.tbl_vehicleData.fleetId = " &
                           " (SELECT [fleetId] FROM [dbo].[tbl_vehicleServicingDetails] WHERE [jobCardNumber] ='" & Request.QueryString("op") & "'))"
        Else
            qry = "SELECT dbo.tbl_vehicleMakes.vehicleMake, dbo.tbl_vehicleModels.vehicleModel, dbo.tbl_vehicleData.registrationNumber," &
                        "dbo.tbl_vehicleData.[currentMileage]   , dbo.tbl_vehicleData.[lastMileageDate], dbo.tbl_vehicleData.[lastServiceDate]," &
                           " dbo.tbl_vehicleData.fleetId FROM dbo.tbl_vehicleModels INNER JOIN dbo.tbl_vehicleMakes ON " &
                           " dbo.tbl_vehicleModels.vehicleMakeId = dbo.tbl_vehicleMakes.vehicleMakeId INNER JOIN dbo.tbl_vehicleData ON " &
                           " dbo.tbl_vehicleModels.vehicleModelId = dbo.tbl_vehicleData.modelId WHERE (dbo.tbl_vehicleData.fleetId = '" & txtFleetIDSearch.Text & "' )"
        End If

        Try
            obj.ConnectionString = con
            Dim ds As DataSet = obj.ExecuteDsQRY(qry)
            If ds.Tables(0).Rows.Count > 0 Then
                txtMake.Text = ds.Tables(0).Rows(0).Item("vehicleMake")
                txtModel.Text = ds.Tables(0).Rows(0).Item("vehicleModel")
                txtFleetID.Text = ds.Tables(0).Rows(0).Item("fleetId")
                'txtLastRecordedMileage.Text = ds.Tables(0).Rows(0).Item("currentMileage")
                txtLastRecordedMileage.Text = lastVehicleMaintenanceMileage()
                rdMileageDate.SelectedDate = ds.Tables(0).Rows(0).Item("lastMileageDate")
            Else
                obj.MessageLabel(lblMsg, "No such vehicle found under vehicle details.", "Yellow")
            End If
        Catch ex As Exception

        End Try

    End Sub

    Private Function lastVehicleMaintenanceMileage() As Long

        lastVehicleMaintenanceMileage = 0

        obj.ConnectionString = con

        Try
            Dim qry As String = "SELECT TOP 1  mileageOnService FROM  tbl_vehicleServicingDetails  WHERE  (fleetId = '" & txtFleetID.Text & "') ORDER BY dateInForService DESC"

            Dim ds As DataSet = obj.ExecuteDsQRY(qry)

            If ds.Tables(0).Rows.Count > 0 Then
                lastVehicleMaintenanceMileage = ds.Tables(0).Rows(0).Item("mileageOnService")
            End If

        Catch ex As Exception

        End Try

    End Function

    Protected Sub cmdSave_Click(sender As Object, e As EventArgs) Handles cmdSave.Click
        If txtJobCardNumber.Text = "" Then
            obj.MessageLabel(lblMsg2, "Invalid Jobcard...!", "Red")
            Exit Sub
        ElseIf obj.recordExists("SELECT * FROM tbl_vehicleServicingDetails WHERE [jobCardNumber] = '" & txtJobCardNumber.Text & "'") = False Then
            obj.MessageLabel(lblMsg2, "The specified Job Card Number could not be found. Please first save the Header above.", "Red")
            Exit Sub
        ElseIf (cboWorkDone.Text = "--Select--" Or cboWorkDone.Text = "") And txtWorkDone.Text = "" Then
            obj.MessageLabel(lblMsg2, "Please specify the Work Done, it cannot be empty.", "Red")
            Exit Sub
        ElseIf (cboMaterialsUsed.Text = "--Select--" Or cboMaterialsUsed.Text = "") And txtMaterialsUsed.Text = "" Then
            obj.MessageLabel(lblMsg2, "Please specify the material used, it cannot be empty.", "Red")
            Exit Sub
        ElseIf Val(txtUnitPrice.Text) = 0 Then
            obj.MessageLabel(lblMsg2, "Please enter valid Unit Price.", "Red")
            Exit Sub
        ElseIf Val(txtQty.Text) = 0 Then
            obj.MessageLabel(lblMsg2, "Please enter valid Quantity.", "Red")
            Exit Sub
        End If


        Dim workDone As String = ""
        Dim materialsUsed As String = ""
        Dim qq As String = ""

        If cboWorkDone.Text = "--Select--" Or cboWorkDone.Text = "" Then
            workDone = txtWorkDone.Text
            If workDone <> "" Then
                If obj.recordExists("SELECT * FROM tbl_detailedServicingWorkDone WHERE detailedServicingWorkDone = '" & workDone & "'") = True Then
                    cboWorkDone.Text = workDone
                Else
                    qq = "INSERT tbl_detailedServicingWorkDone (detailedServicingWorkDone) VALUES ('" & workDone & "')"
                    obj.ConnectionString = con
                    obj.ExecuteNonQRY(qq)
                End If
            Else
                obj.MessageLabel(lblMsg2, "The Work Done has not been specified.", "Red")
            End If
        Else
            workDone = cboWorkDone.Text
        End If

        If cboMaterialsUsed.Text = "--Select--" Or cboMaterialsUsed.Text = "" Then
            materialsUsed = txtMaterialsUsed.Text
            If materialsUsed <> "" Then
                If obj.recordExists("SELECT * FROM tbl_serviceMaterials WHERE serviceMaterial =''") Then
                    cboMaterialsUsed.Text = materialsUsed
                Else
                    qq = "INSERT tbl_serviceMaterials (serviceMaterial) VALUES ('" & materialsUsed & "')"
                    obj.ConnectionString = con
                    obj.ExecuteNonQRY(qq)
                End If
            Else
                obj.MessageLabel(lblMsg2, "The material used has not been specified.", "Red")
            End If
            Else
                materialsUsed = cboMaterialsUsed.Text
        End If

        '  obj.loadComboBox(cboMaterialsUsed, "SELECT [serviceMaterialId], [serviceMaterial] FROM [dbo].[tbl_serviceMaterials]", "serviceMaterial", "serviceMaterialId")

        txtTotalPrice.Text = Val(txtQty.Text) * Val(txtUnitPrice.Text)

        If txtEntryId.Text = "" Then
            Dim sql As String = "INSERT [dbo].[tbl_detailedVehicleServiceWorkDone] ([jobCardNumber],[workDone],[descriptionOfMaterialsUsed], " &
            "[quantityUsed], [unitPrice],[totalPrice] ) VALUES ('" & txtJobCardNumber.Text & "','" & workDone &
            "','" & materialsUsed & "'," & Val(txtQty.Text) & "," & Val(txtUnitPrice.Text) & "," & Val(txtTotalPrice.Text) & ")"

            obj.ConnectionString = con

            If obj.ExecuteNonQRY(sql) = 1 Then
                obj.MessageLabel(lblMsg2, "Record successfully saved.", "Green")
                loadWorkDetails()
                txtEntryId.Text = ""

                txtQty.Text = ""
                txtUnitPrice.Text = ""
                txtTotalPrice.Text = ""

            Else
                obj.MessageLabel(lblMsg2, "Error! Could not save record.", "Red")
            End If
        Else
            Dim sql As String = "UPDATE tbl_detailedVehicleServiceWorkDone SET [workDone] = '" & cboWorkDone.Text &
                "',[descriptionOfMaterialsUsed] = '" & cboMaterialsUsed.Text & "',[quantityUsed] = " & Val(txtQty.Text) & ", [unitPrice] =" & Val(txtUnitPrice.Text) &
                ",[totalPrice] =" & Val(txtTotalPrice.Text) & "  WHERE [jobCardNumber] = '" & txtJobCardNumber.Text & "' AND EntryId = " & txtEntryId.Text

            obj.ConnectionString = con

            If obj.ExecuteNonQRY(sql) = 1 Then
                obj.MessageLabel(lblMsg2, "Record successfully Updated.", "Green")
                loadWorkDetails()
                txtEntryId.Text = ""

                txtQty.Text = ""
                txtUnitPrice.Text = ""
                txtTotalPrice.Text = ""

                txtWorkDone.Text = ""
                txtMaterialsUsed.Text = ""

            Else
                obj.MessageLabel(lblMsg2, "Error! Could Not Update record.", "Red")
            End If
        End If


        lblMsg3.Text = "$ " & grandTotal(txtJobCardNumber.Text) & "  "


    End Sub

    Private Function getMaterialCost() As Double
        Dim sql As String = "select CAST(ROUND(materialCost,2,1) AS DECIMAL (9,2)) AS materialCost FROM tbl_serviceMaterials WHERE serviceMaterial ='" & cboMaterialsUsed.Text & "' AND serviceMaterialId = " & Val(cboMaterialsUsed.SelectedValue)

        obj.ConnectionString = con

        Try
            Dim ds As DataSet = obj.ExecuteDsQRY(sql)

            If ds.Tables(0).Rows.Count > 0 Then
                getMaterialCost = ds.Tables(0).Rows(0).Item("materialCost")
            Else
                getMaterialCost = Nothing
            End If

        Catch ex As Exception
            getMaterialCost = Nothing
        End Try
    End Function
    Private Sub loadWorkDetails()

        'cast(convert(Decimal(10,2),[unitPrice]) As money) As UnitPrice

        Dim SQL = "Select EntryID, [jobCardNumber] As JobCardNo , [workDone], [descriptionOfMaterialsUsed] As [Desc], [quantityUsed] As [QtyUsed] , convert(Decimal(10,2),[unitPrice]) As UnitPrice, convert(Decimal(10,2),[totalPrice])  As TotalPrice FROM " &
            " [dbo].[tbl_detailedVehicleServiceWorkDone] WHERE [jobCardNumber] = '" & txtJobCardNumber.Text & "'"

        'cast(convert(decimal(10,2),[totalPrice]) AS money)
        'cast(convert(decimal(10,2),[unitPrice]) AS money)
        'cast(convert(decimal(10,2),[unitPrice]) AS money)
        'cast(convert(decimal(10,2),[unitPrice]) AS money)

        ' ' cast(Convert(Decimal(10, 2), [totalPrice]))
        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, SQL)
            db.ExecuteDataSet(CommandType.Text, SQL)

            With gwGrid
                Try
                    .DataSource = ds
                    .DataBind()

                    lblMsg3.Text = "$ " & grandTotal(txtJobCardNumber.Text) & "  "

                Catch ex As Exception
                    '  log.Error(ex.Message)
                End Try
            End With
        Catch ex As Exception
            'log.Error(ex)
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

    Protected Sub cboTypeOfService_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboTypeOfService.SelectedIndexChanged

    End Sub

    Protected Sub cmdClear0_Click(sender As Object, e As EventArgs) Handles cmdClear0.Click
        obj.MessageLabel(lblMsg, "", "")
        txtFleetID.Text = ""
        '   txtInspectionDetails.Text = ""
        txtMake.Text = ""
        txtModel.Text = ""

        obj.ConnectionString = con

        txtFleetIDSearch.Text = obj.fnVehicleFleetIDNumFromRegNum(txtRegNo.Text)
        loadVehicleData()


    End Sub

    Protected Sub txtUnitPrice_TextChanged(sender As Object, e As EventArgs) Handles txtUnitPrice.TextChanged
        totalCostOfMaterials()
    End Sub


    Private Sub totalCostOfMaterials()

        txtTotalPrice.Text = Val(txtQty.Text) * Val(txtUnitPrice.Text)

    End Sub

    Protected Sub txtQty_TextChanged(sender As Object, e As EventArgs) Handles txtQty.TextChanged
        totalCostOfMaterials()
    End Sub

    Private Sub gwGrid_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles gwGrid.ItemCommand

        Dim item As GridDataItem = e.Item

        If TypeOf e.Item Is GridDataItem Then
            item.Cells(7).HorizontalAlign = HorizontalAlign.Right
        End If

        Dim ID As String = item("EntryId").Text

        If e.CommandName = "Editta" Then
            Dim EntryId As String = item("EntryId").Text
            Dim totalPrice As Decimal = item("TotalPrice").Text
            Dim unitPrice As Decimal = item("UnitPrice").Text


            txtEntryId.Text = EntryId
            txtQty.Text = item("QtyUsed").Text
            txtUnitPrice.Text = unitPrice.ToString("#,###.##")
            txtTotalPrice.Text = totalPrice.ToString("#,###.##")

            Dim qry As String = "SELECT [detailedServicingWorkDoneId], [detailedServicingWorkDone] FROM [dbo].[tbl_detailedServicingWorkDone] WHERE detailedServicingWorkDone = '" & item("Workdone").Text & "'"

            obj.ConnectionString = con

            Try
                Dim ds As DataSet = obj.ExecuteDsQRY(qry)

                If ds.Tables(0).Rows.Count > 0 Then
                    cboWorkDone.SelectedValue = ds.Tables(0).Rows(0).Item("detailedServicingWorkDoneId")
                End If
            Catch ex As Exception

            End Try

            qry = "Select [serviceMaterialId], [serviceMaterial] FROM [dbo].[tbl_serviceMaterials] WHERE serviceMaterial = '" & item("Desc").Text & "'"

            obj.ConnectionString = con

            Try
                Dim ds As DataSet = obj.ExecuteDsQRY(qry)

                If ds.Tables(0).Rows.Count > 0 Then
                    cboMaterialsUsed.SelectedValue = ds.Tables(0).Rows(0).Item("serviceMaterialId")
                End If
            Catch ex As Exception

            End Try

        ElseIf e.CommandName = "Delete" Then
            Dim qry As String = "DELETE FROM tbl_detailedVehicleServiceWorkDone WHERE EntryId = " & item("EntryId").Text

            'tbl_detailedVehicleServiceWorkDone
            obj.ConnectionString = con

            Try
                If obj.ExecuteNonQRY(qry) = 1 Then
                    obj.MessageLabel(lblMsg2, "Record successfully deleted.", "Green")
                    loadWorkDetails()

                    '     loadList()
                Else
                    obj.MessageLabel(lblMsg2, "Error While trying To delete entry.", "Red")
                End If
            Catch ex As Exception
                obj.MessageLabel(lblMsg2, "Error While trying To delete entry.", "Red")
            End Try
        End If



    End Sub


    Private Sub findWorkDoneIdFromTheText()

    End Sub

    Protected Sub gwGrid_NeedDataSource(sender As Object, e As GridNeedDataSourceEventArgs) Handles gwGrid.NeedDataSource

    End Sub

    'Protected Sub cmdDelete_Click(sender As Object, e As EventArgs) Handles cmdDelete.Click
    '    Dim qry As String = "DELETE FROM tbl_detailedServicingWorkDone WHERE EntryId = 0"
    '    obj.ConnectionString = con

    '    Try
    '        If obj.ExecuteNonQRY(qry) = 1 Then
    '            obj.MessageLabel(lblMsg2, "Record successfully deleted.", "Green")
    '            '     loadList()
    '        Else
    '            obj.MessageLabel(lblMsg2, "Error While trying To delete entry.", "Red")
    '        End If
    '    Catch ex As Exception
    '        obj.MessageLabel(lblMsg2, "Error While trying To delete entry.", "Red")
    '    End Try
    'End Sub

    Protected Sub btnClear_Click(sender As Object, e As EventArgs) Handles btnClear.Click
        cboWorkDone.ClearSelection()
        cboMaterialsUsed.ClearSelection()

        txtQty.Text = ""
        txtUnitPrice.Text = ""
        txtTotalPrice.Text = ""
        txtEntryId.Text = ""

        obj.MessageLabel(lblMsg2, "", "")

    End Sub

    Private Function vehicleRegNumFromJobCard(ByVal jobCardNum As String) As String
        'Dim qry As String = "SELECT jobCardNumber, dateInForService, typeOfService, mileageOnService, serviceFrequency, totalTimeTaken, otherCosts, " &
        '                  " otherCostsValue, sundries, sundriesCost, totJobCost, mechanic, fleetId, regNum, dtDateOutOfService FROM dbo.tbl_vehicleServicingDetails " &
        '                  "WHERE   (jobCardNumber = '" & Request.QueryString("op") & "') "

        'obj.ConnectionString = con

        'Try
        '    Dim ds As DataSet = obj.ExecuteDsQRY(qry)

        '    If ds.Tables(0).Rows.Count > 0 Then
        '        With ds.Tables(0).Rows(0)

        '            '  cboRegNumber.SelectedValue = .Item("regNum")


        '            loadVehicleData()

        '            txtJobCardNumber.Text = Request.QueryString("op")
        '            rdServiceDate.SelectedDate = .Item("dateInForService")
        '        End With
        '        End dif
        'Catch ex As Exception



        'End Try

    End Function


    Private Function grandTotal(ByVal jobcardNum As String) As Single

        Dim qry As String = "SELECT SUM(totalPrice) AS jobCardTotal, jobCardNumber FROM dbo.tbl_detailedVehicleServiceWorkDone GROUP BY jobCardNumber " &
                            " HAVING  (jobCardNumber ='" & jobcardNum & "')"

        obj.ConnectionString = con

        lblMsg3.Text = ""

        Try
            Dim ds As DataSet = obj.ExecuteDsQRY(qry)

            If ds.Tables(0).Rows.Count > 0 Then
                Return ds.Tables(0).Rows(0).Item("jobCardTotal")
            End If
        Catch ex As Exception

        End Try

    End Function

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

    Protected Sub cboWorkDone_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboWorkDone.SelectedIndexChanged

    End Sub

    Protected Sub cboMaterialsUsed_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboMaterialsUsed.SelectedIndexChanged
        If Not IsNothing(getMaterialCost) Then
            txtUnitPrice.Text = getMaterialCost()
            If txtUnitPrice.Text = 0 Then
                txtUnitPrice.Text = ""
            End If
        End If
    End Sub
End Class