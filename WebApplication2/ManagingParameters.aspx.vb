Imports Telerik.Web.UI
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing
Public Class ManagingParameters
    Inherits System.Web.UI.Page
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then
            obj.loadComboBox(cboParameters, "SELECT [ParameterId], [Parameter] FROM [dbo].[lu_ParametersList] ORDER BY [Parameter]", "Parameter", "ParameterId")

            If grantPageWriteCommandPermission(CokkiesWrapper.UserID, 1) = True Then
                cmdSave.Enabled = True
                btnClear.Enabled = True
            Else
                cmdSave.Enabled = False
                btnClear.Enabled = False
            End If

        End If

    End Sub

    Protected Sub cboParameters_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboParameters.SelectedIndexChanged
        lblMsg.Text = ""

        lblParentParameter.Text = ""

        txtParameterValue.Text = ""
        txtParameterID.Text = ""

        lblParentParameter.Visible = False
        cboParameterParent.Visible = False
        txtSecondValue.Visible = False
        gwList.MasterTableView.RenderColumns(1).Display = False

        loadParametersList()

    End Sub

    Private Sub loadParentComboBox(ByVal sql As String, ByVal textField As String, ByVal valField As String, ByVal parentName As String)

        obj.ConnectionString = con

        lblParentParameter.Text = parentName
        lblParentParameter.Visible = True

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            With cboParameterParent
                .DataSource = ds
                .DataValueField = valField
                .DataTextField = textField
                .DataBind()
                .Items.Insert(0, New RadComboBoxItem("--Select--", ""))
                .Visible = True
            End With
        Catch

        End Try

    End Sub

    Private Sub loadParametersList()
        Dim qry As String = ""
        Select Case cboParameters.Text

            Case "Vehicle User Category"
                qry = "SELECT [categoryId] AS ParameterId, [category] AS Parameter FROM [dbo].[tbl_vehicleCategories] ORDER BY category"
            Case "Vehicle Type"
                qry = "SELECT [vehicleTypeId] AS ParameterId, [vehicleType] AS Parameter FROM [dbo].[tbl_vehicleTypes] ORDER BY vehicleType"
            Case "Vehicle Model"
                qry = "SELECT vehicleModelId AS ParameterId, vehicleModel AS Parameter FROM  dbo.tbl_vehicleModels ORDER BY vehicleModel"

                loadParentComboBox("SELECT vehicleMakeId, vehicleMake  FROM     dbo.tbl_vehicleMakes", "vehicleMake", "vehicleMakeId", "Make")

            Case "Vehicle Makes"
                qry = "Select  vehicleMakeId As ParameterId, vehicleMake  As Parameter FROM   dbo.tbl_vehicleMakes "
            Case "Color"
                qry = "Select [vehicleColorId] As ParameterId, [vehicleColor] As Parameter FROM [dbo].[tbl_vehicleColors] ORDER BY [vehicleColor]"
            Case "Fuel Type"
                qry = "Select [fuelTypeId] As ParameterId, [fuelType] As Parameter FROM [dbo].[tbl_fuelTypes] ORDER BY [fuelType]"
            Case "Currency"
                qry = "Select [currencyId] As ParameterId, [curCurrency] As Parameter FROM [dbo].[tbl_currencies]"
            Case "Tyre Sizes"
                qry = "Select [tyreSizeId] As ParameterId, [tyreSize] As Parameter FROM [dbo].[tbl_tyreSizes]"
            Case "Vehicle Accessories"
                qry = "Select [accessoryId] As ParameterId, [accessory] As Parameter FROM [dbo].[tbl_accessories] ORDER BY [accessory]"
            Case "Reasons for Replacing Tyres"
                '"Reasons for Replacing Tyres"
                qry = "Select [reasonForReplacementId] As ParameterId, [reasonForReplacement] As Parameter FROM [dbo].[tbl_tyreReasonForReplacement] ORDER BY [reasonForReplacement]"
            Case "Inspection Items"
                qry = "Select [inspectionAreaId] As ParameterId, [inspectionArea] As Parameter FROM [dbo].[tbl_inspectionAreas] ORDER BY [inspectionArea]"
            Case "Inspection Overall Findings"
                qry = "Select [overallFindingId] As ParameterId, [overallDetails] As Parameter FROM [dbo].[tbl_overallInspectionFindings] ORDER BY [overallDetails]"
            Case "Vehicle Service Work Done"
                qry = "Select [detailedServicingWorkDoneId] As ParameterId, [detailedServicingWorkDone] As Parameter  FROM [dbo].[tbl_detailedServicingWorkDone] ORDER BY [detailedServicingWorkDone]"
            Case "Vehicle Service Materials"
                qry = "Select [serviceMaterialId] As ParameterId, serviceMaterial   As Parameter, CAST(ROUND(materialCost,2,1) AS DECIMAL (9,2)) AS Cost FROM [dbo].[tbl_serviceMaterials] ORDER BY [serviceMaterial]"
                '+ CAST('   ($' AS nvarchar)   +  CAST([materialCost] AS nvarchar)  + CAST(')' AS nvarchar)

                ''CAST(ROUND(materialCost,2,1) AS DECIMAL (9,2)) AS Cost
                txtSecondValue.Visible = True
                lblParentParameter.Text = "Cost"
                lblParentParameter.Visible = True
            'gwList.Columns
            'Cost

            Case "Vehicle Service Frequencies"
                qry = "Select [ServiceFrequencyId] As ParameterId, [ServiceFrequency]  As Parameter FROM [dbo].[lu_ServiceFrequencies]"
            Case "Tyre Suppliers"
                qry = "SELECT [supplierId] As ParameterId, [supplierName] As Parameter FROM [dbo].[tbl_tyreSuppliers]"
            Case "Tyre Manufactures"
                qry = "SELECT [manufacturer] As Parameter, [manufacturerId] As ParameterId FROM [dbo].[tbl_tyreManufacturers]"
            Case "Vehicle Service Category"
                qry = "SELECT  serviceCategoryId As ParameterId, serviceCategory As Parameter FROM lu_vehicleServiceCategories ORDER BY serviceCategory"
            Case "File Types"
                qry = "SELECT [FileTypeId] As ParameterId, [FileType] As Parameter FROM [dbo].[lu_FileTypes]  ORDER BY  Parameter"

        End Select

        If qry <> "" Then
            obj.ConnectionString = con
            Try
                Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, qry)
                db.ExecuteDataSet(CommandType.Text, qry)

                With gwList
                    Try
                        .DataSource = ds
                        .DataBind()
                        '.MasterTableView.GetColumn("ctr").Display = False

                    Catch ex As Exception
                        '  log.Error(ex.Message)
                    End Try
                End With
            Catch ex As Exception
                'log.Error(ex)
            End Try

        End If
    End Sub
    Private Sub updateParameters()
        Dim qry As String = ""
        Select Case cboParameters.Text
            Case "Vehicle User Category"
                qry = "UPDATE tbl_vehicleCategories Set category ='" & txtParameterValue.Text & "' WHERE categoryId = " & Val(txtParameterID.Text)
            Case "Vehicle Type"
                qry = "UPDATE tbl_vehicleTypes SET vehicleType ='" & txtParameterValue.Text & "' WHERE vehicleTypeId = " & Val(txtParameterID.Text)
            Case "Vehicle Model"
                qry = " UPDATE tbl_vehicleModels SET vehicleModel = '" & txtParameterValue.Text & "' WHERE vehicleModelId = " & Val(txtParameterID.Text)
            Case "Vehicle Makes"
                qry = "UPDATE tbl_vehicleMakes SET vehicleMake = '" & txtParameterValue.Text & "' WHERE vehicleMakeId = " & Val(txtParameterID.Text)
            Case "Color"
                qry = "UPDATE tbl_vehicleColors SET vehicleColor ='" & txtParameterValue.Text & "' WHERE vehicleColorId = " & Val(txtParameterID.Text)
            Case "Fuel Type"
                qry = "UPDATE tbl_fuelTypes SET fuelType ='" & txtParameterValue.Text & "' WHERE fuelTypeId = " & Val(txtParameterID.Text)
            Case "Currency"
                qry = "UPDATE tbl_currencies SET curCurrency ='" & txtParameterValue.Text & "' WHERE currencyId = " & Val(txtParameterID.Text)
            Case "Tyre Sizes"
                qry = "UPDATE tbl_tyreSizes SET tyreSize ='" & txtParameterValue.Text & "' WHERE tyreSizeId = " & Val(txtParameterID.Text)
            Case "Vehicle Accessories"
                qry = "UPDATE tbl_accessories SET accessory ='" & txtParameterValue.Text & "' WHERE accessoryId = " & Val(txtParameterID.Text)
            Case "Reasons for Replacing Tyres"
                qry = "UPDATE tbl_tyreReasonForReplacement SET reasonForReplacement ='" & txtParameterValue.Text & "' WHERE reasonForReplacementId = " & Val(txtParameterID.Text)
            Case "Inspection Items"
                qry = "UPDATE tbl_inspectionAreas SET inspectionArea ='" & txtParameterValue.Text & "' WHERE inspectionAreaId = " & Val(txtParameterID.Text)
            Case "Inspection Overall Findings"
                qry = "UPDATE tbl_overallInspectionFindings SET overallDetails ='" & txtParameterValue.Text & "' WHERE overallFindingId = " & Val(txtParameterID.Text)
            Case "Vehicle Service Work Done"
                qry = "UPDATE tbl_detailedServicingWorkDone SET detailedServicingWorkDone ='" & txtParameterValue.Text & "' WHERE detailedServicingWorkDoneId = " & Val(txtParameterID.Text)
            Case "Vehicle Service Materials"
                qry = "UPDATE tbl_serviceMaterials SET serviceMaterial ='" & txtParameterValue.Text & "', [materialCost] = '" & txtSecondValue.Text & "' WHERE serviceMaterialId = " & Val(txtParameterID.Text)
            Case "Vehicle Service Frequencies"
                qry = "UPDATE lu_ServiceFrequencies SET ServiceFrequency = '" & txtParameterValue.Text & "' WHERE ServiceFrequencyId = " & Val(txtParameterID.Text)
            Case "Tyre Suppliers"
                qry = "UPDATE tbl_tyreSuppliers SET supplierName = '" & txtParameterValue.Text & "' WHERE supplierId = " & Val(txtParameterID.Text)
            Case "Tyre Manufactures"
                qry = "UPDATE [tbl_tyreManufacturers] SET [manufacturer] = '" & txtParameterValue.Text & "'    WHERE [manufacturerId] = " & Val(txtParameterID.Text)
            Case "Vehicle Service Category"
                qry = "UPDATE lu_vehicleServiceCategories SET serviceCategory = '" & txtParameterValue.Text & "',serviceCategoryId = " & Val(txtParameterID.Text)
            Case "File Types"
                qry = "UPDATE lu_FileTypes SET FileType = '" & txtParameterValue.Text & "' WHERE FileTypeId = " & Val(txtParameterID.Text)
        End Select

        If qry <> "" Then
            obj.ConnectionString = con
            Try
                Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, qry)
                db.ExecuteDataSet(CommandType.Text, qry)
                loadParametersList()

                txtParameterID.Text = ""
                txtParameterValue.Text = ""

                txtSecondValue.Text = ""

            Catch ex As Exception
            End Try
        End If
    End Sub

    Private Sub insertNewParameters()
        Dim qry As String = ""

        Select Case cboParameters.Text
            Case "Vehicle User Category"
                qry = "INSERT tbl_vehicleCategories (category) VALUES ('" & txtParameterValue.Text & "')"
            Case "Vehicle Type"
                qry = "INSERT tbl_vehicleTypes (vehicleType) VALUES ('" & txtParameterValue.Text & "')"
            Case "Vehicle Model"
                If cboParameterParent.Text = "" Or cboParameterParent.Text = "--Select--" Then
                    obj.MessageLabel(lblMsg, "Please specify the Vehicle Model. " & cboParameters.Text, "Red")
                    Exit Sub
                End If
                qry = " INSERT tbl_vehicleModels (vehicleModel, vehicleMakeId)  VALUES ('" & txtParameterValue.Text & "', " & Val(cboParameterParent.SelectedValue) & " )"
            Case "Vehicle Makes"
                qry = "INSERT tbl_vehicleMakes (vehicleMake)  VALUES ('" & txtParameterValue.Text & "')"
            Case "Color"
                qry = "INSERT tbl_vehicleColors (vehicleColor) VALUES ('" & txtParameterValue.Text & "')"
            Case "Fuel Type"
                qry = "INSERT tbl_fuelTypes (fuelType) VALUES ('" & txtParameterValue.Text & "')"
            Case "Currency"
                qry = "INSERT tbl_currencies (curCurrency) VALUES ('" & txtParameterValue.Text & "')"
            Case "Tyre Sizes"
                qry = "INSERT tbl_tyreSizes (tyreSize) VALUES ('" & txtParameterValue.Text & "')"
            Case "Vehicle Accessories"
                qry = "INSERT tbl_accessories (accessory) VALUES ('" & txtParameterValue.Text & "')"
            Case "Reasons for Replacing Tyres"
                qry = "INSERT tbl_tyreReasonForReplacement (reasonForReplacement) VALUES ('" & txtParameterValue.Text & "')"
            Case "Inspection Items"
                qry = "INSERT tbl_inspectionAreas (inspectionArea) VALUES ('" & txtParameterValue.Text & "')"
            Case "Inspection Overall Findings"
                qry = "INSERT tbl_overallInspectionFindings (overallDetails) VALUES ('" & txtParameterValue.Text & "')"
            Case "Vehicle Service Work Done"
                qry = "INSERT tbl_detailedServicingWorkDone (detailedServicingWorkDone) VALUES ('" & txtParameterValue.Text & "')"
            Case "Vehicle Service Materials"
                qry = "INSERT tbl_serviceMaterials (serviceMaterial, materialCost) VALUES ('" & txtParameterValue.Text & "','" & Val(txtSecondValue.Text) & "')"
            Case "Vehicle Service Frequencies"
                qry = "INSERT lu_ServiceFrequencies (ServiceFrequency) VALUES ('" & txtParameterValue.Text & "')"
            Case "Tyre Suppliers"
                qry = "INSERT tbl_tyreSuppliers (supplierName) VALUES ('" & txtParameterValue.Text & "')"
            Case "Tyre Manufactures"
                qry = "INSERT tbl_tyreManufacturers (manufacturer) VALUES ('" & txtParameterValue.Text & "')"
            Case "Vehicle Service Category"
                qry = "INSERT lu_vehicleServiceCategories (serviceCategory)  VALUES ('" & txtParameterValue.Text & "')"
            Case "File Types"
                qry = "INSERT lu_FileTypes (FileType) VALUES ('" & txtParameterValue.Text & "') "
        End Select

        If qry <> "" Then
            obj.ConnectionString = con
            Try
                obj.ConnectionString = con
                If obj.ExecuteNonQRY(qry) = 1 Then
                    obj.MessageLabel(lblMsg, cboParameters.Text & " Details successfully saved.", "Green")
                    txtParameterID.Text = ""
                    txtParameterValue.Text = ""
                    loadParametersList()
                    Exit Sub
                Else
                    obj.MessageLabel(lblMsg, "Error while trying to save " & cboParameters.Text, "Red")
                    Exit Sub
                End If
            Catch ex As Exception
            End Try
        End If
    End Sub

    Private Sub gwList_Prerender(sender As Object, e As EventArgs) Handles gwList.PreRender

        Select Case cboParameters.Text
            Case "Vehicle Service Materials"
                gwList.MasterTableView.GetColumn("Cost").Display = True
            Case Else
                gwList.MasterTableView.GetColumn("Cost").Display = False
        End Select

        'gwList.Columns.FindByUniqueName("Cost").Visible = False
        ''RadGrid1.MasterTableView.GetColumn("ProductName").Display = false
        'gwList.MasterTableView.GetColumn("Cost").Display = False

    End Sub


    Private Sub gwList_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles gwList.ItemCommand
        If e.CommandName = "Edita" Then
            Dim item As GridDataItem = e.Item
            txtParameterID.Text = item("ParameterId").Text
            txtParameterValue.Text = item("Parameter").Text

            'cboParameterParent
            Select Case cboParameters.Text
                Case "Vehicle User Category"

                Case "Vehicle Type"

                Case "Vehicle Model"
                    Dim sql As String = "Select vehicleMakeId FROM  tbl_vehicleModels WHERE (vehicleModelId = " & txtParameterID.Text & ") And (vehicleModel = '" & txtParameterValue.Text & "') "

                    obj.ConnectionString = con

                    Dim ds As DataSet = obj.ExecuteDsQRY(sql)
                    If ds.Tables(0).Rows.Count > 0 Then
                        cboParameterParent.SelectedValue = ds.Tables(0).Rows(0).Item("vehicleMakeId")
                    End If
                Case ""
                    'txtSecondValue
                    Dim sql As String = "SELECT vehicleMakeId FROM  tbl_vehicleModels WHERE (vehicleModelId = " & txtParameterID.Text & ") AND (vehicleModel = '" & txtParameterValue.Text & "') "

                    obj.ConnectionString = con

                    Dim ds As DataSet = obj.ExecuteDsQRY(sql)
                    If ds.Tables(0).Rows.Count > 0 Then
                        cboParameterParent.SelectedValue = ds.Tables(0).Rows(0).Item("vehicleMakeId")
                    End If
            End Select
        End If
    End Sub

    Protected Sub gwList_NeedDataSource(sender As Object, e As GridNeedDataSourceEventArgs) Handles gwList.NeedDataSource
        loadParametersList()
    End Sub

    Protected Sub cmdSave_Click(sender As Object, e As EventArgs) Handles cmdSave.Click
        If txtParameterID.Text = "" Then
            If similarNameExistence() = True Then
                obj.MessageLabel(lblMsg, "Parameter already exits..!", "Red")
                Exit Sub
            End If
            insertNewParameters()
        Else
            updateParameters()
        End If

    End Sub
    Private Function similarNameExistence() As Boolean
        Dim qry As String = ""

        Select Case cboParameters.Text
            Case "Vehicle User Category"
                qry = "SELECT * FROM tbl_vehicleCategories WHERE category = '" & txtParameterValue.Text & "'"
            Case "Vehicle Type"
                qry = "SELECT * FROM tbl_vehicleTypes WHERE vehicleType = '" & txtParameterValue.Text & "'"
            Case "Vehicle Model"
                qry = " SELECT * FROM tbl_vehicleModels WHERE vehicleModel = '" & txtParameterValue.Text & "' AND vehicleMakeId = " & Val(cboParameterParent.SelectedValue)
            Case "Vehicle Makes"
                qry = "SELECT * FROM tbl_vehicleMakes WHERE vehicleMake = '" & txtParameterValue.Text & "'"
            Case "Color"
                qry = "SELECT * FROM tbl_vehicleColors  WHERE vehicleColor = '" & txtParameterValue.Text & "'"
            Case "Fuel Type"
                qry = "SELECT * FROM  tbl_fuelTypes WHERE fuelType = '" & txtParameterValue.Text & "'"
            Case "Currency"
                qry = "SELECT * FROM tbl_currencies WHERE curCurrency = '" & txtParameterValue.Text & "'"
            Case "Tyre Sizes"
                qry = "SELECT * FROM tbl_tyreSizes WHERE tyreSize = '" & txtParameterValue.Text & "'"
            Case "Vehicle Accessories"
                qry = "SELECT * FROM tbl_accessories WHERE accessory = '" & txtParameterValue.Text & "'"
            Case "Reasons for Replacing Tyres"
                qry = "SELECT * FROM tbl_tyreReasonForReplacement WHERE reasonForReplacement = '" & txtParameterValue.Text & "'"
            Case "Inspection Items"
                qry = "SELECT * FROM tbl_inspectionAreas WHERE inspectionArea = '" & txtParameterValue.Text & "'"
            Case "Inspection Overall Findings"
                qry = "SELECT * FROM tbl_overallInspectionFindings WHERE overallDetails = '" & txtParameterValue.Text & "'"
            Case "Vehicle Service Work Done"
                qry = "SELECT * FROM tbl_detailedServicingWorkDone WHERE detailedServicingWorkDone = '" & txtParameterValue.Text & "'"
            Case "Vehicle Service Materials"
                qry = "SELECT * FROM tbl_serviceMaterials WHERE serviceMaterial = '" & txtParameterValue.Text & "'"
            Case "Vehicle Service Frequencies"
                qry = "SELECT * FROM lu_ServiceFrequencies WHERE ServiceFrequency = '" & txtParameterValue.Text & "'"
            Case "Tyre Suppliers"
                qry = "SELECT * FROM tbl_tyreSuppliers WHERE supplierName = '" & txtParameterValue.Text & "'"
            Case "Tyre Manufactures"
                qry = "SELECT * FROM tbl_tyreManufacturers WHERE manufacturer = '" & txtParameterValue.Text & "'"
            Case "Vehicle Service Category"
                qry = "SELECT * FROM lu_vehicleServiceCategories WHERE serviceCategory = '" & txtParameterValue.Text & "'"
            Case "File Types"
                qry = "SELECT * FROM  lu_FileTypes WHERE FileType = '" & txtParameterValue.Text & "'"
        End Select

        If qry <> "" Then
            obj.ConnectionString = con
            Try
                obj.ConnectionString = con
                similarNameExistence = obj.recordExists(qry)
            Catch ex As Exception
            End Try
        End If
    End Function
    Protected Sub btnClear_Click(sender As Object, e As EventArgs) Handles btnClear.Click
        txtParameterID.Text = ""
        txtParameterValue.Text = ""
        lblMsg.Text = ""

    End Sub


    Public Function grantPageWriteCommandPermission(ByVal UserId As Integer, pageId As Integer) As Boolean

        grantPageWriteCommandPermission = False
        Dim qry As String = "Select * FROM [dbo].[tbl_userSysPermissions] WHERE [userId] = " & UserId & " And [sysModuleSectionId] = " & pageId & " And [sysWrite] = 1"

        Try
            obj.ConnectionString = con
            Dim ds As DataSet = obj.ExecuteDsQRY(qry)
            If ds.Tables(0).Rows.Count > 0 Then
                grantPageWriteCommandPermission = True
            End If
        Catch ex As Exception
        End Try

    End Function


End Class