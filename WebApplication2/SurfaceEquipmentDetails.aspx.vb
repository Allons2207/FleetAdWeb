Imports Telerik.Web.UI
Imports Microsoft.Practices.EnterpriseLibrary.Data

Public Class SurfaceEquipmentDetails
    Inherits System.Web.UI.Page
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then

            obj.loadComboBox(cboFuelType, "SELECT [fuelTypeId], [fuelType] FROM [dbo].[tbl_fuelTypes]", "fuelType", "fuelTypeId")
            obj.loadComboBox(cboAssetType, "SELECT SurfaceEquipmentTypeID, SurfaceEquipmentType FROM tblSurfaceEquipmentTypes", "SurfaceEquipmentType", "SurfaceEquipmentTypeID")
            obj.loadComboBox(cboTyreSize, "SELECT [tyreSizeId],[tyreSize] FROM [dbo].[tbl_tyreSizes]", "tyreSize", "tyreSizeId")
            obj.loadComboBox(cboEquipmentCategory, "SELECT SurfaceEquipmentCategory, SurfaceEquipmentCategoryID FROM luSurfaceEquipmentCategory", "SurfaceEquipmentCategory", "SurfaceEquipmentCategoryID")

            '            CREATE Table luSurfaceEquipmentCategory
            '(
            '	SurfaceEquipmentCategoryID Int identity(1, 1) Not null,
            '	SurfaceEquipmentCategory varchar(150)
            ')

            If Not IsNothing(Request.QueryString("op")) Then
                loadSurfaceEquipmentDetails(Request.QueryString("op"))
            End If

            'If grantPageWriteCommandPermission(CokkiesWrapper.UserID, 1) = True Then
            '    cmdSave.Enabled = True
            '    If Not IsNothing(Request.QueryString("op")) Then
            '        cmdDelete.Enabled = True
            '    Else
            '        cmdDelete.Enabled = False
            '    End If
            'Else
            '    cmdSave.Enabled = False
            'End If

        End If

    End Sub

    Private Sub loadSurfaceEquipmentDetails(ByVal SurfaceEquipmentID As Long)

        Dim qry As String = "SELECT TOP (100) PERCENT SurfaceEquipmentID, AssetNumber, SerialNumber, RegNumber, ChassisNumber," &
            " Description, Color, NumberOfTyres, HourMeter, GeneratorSize, TrailerSize, AssetTypeID, FuelTypeID, TyreSizeID,  " &
            " AssetCategoryID,ActiveMode, EngineModel   FROM   dbo.tblSurfaceEquipment   WHERE   SurfaceEquipmentID =  " & SurfaceEquipmentID

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, qry)

            If ds.Tables(0).Rows.Count > 0 Then
                With ds.Tables(0).Rows(0)
                    txtSurfaceEquipmentID.Text = .Item("SurfaceEquipmentID")
                    cboAssetType.SelectedValue = .Item("AssetTypeID")
                    txtAssetNumber.Text = .Item("AssetNumber")
                    txtSerialNumber.Text = .Item("SerialNumber")
                    txtRegNumber.Text = .Item("RegNumber")
                    txtChassisNumber.Text = .Item("ChassisNumber")
                    txtDescription.Text = .Item("Description")
                    txtColor.Text = .Item("Color")
                    cboFuelType.SelectedValue = .Item("FuelTypeID")
                    cboTyreSize.SelectedValue = .Item("TyreSizeID")
                    txtNumberOfTyres.Text = .Item("NumberOfTyres")
                    txtHourMeter.Text = .Item("HourMeter")
                    txtGeneratorSize.Text = .Item("GeneratorSize")
                    txtTrailerSize.Text = .Item("TrailerSize")
                    txtEngineModel.Text = .Item("EngineModel")
                    cboActiveMode.SelectedValue = .Item("ActiveMode")
                    cboEquipmentCategory.SelectedValue = .Item("AssetCategoryID")
                    cboActiveMode.SelectedValue = .Item("TrailerSize")
                End With
            Else

            End If
        Catch ex As Exception

        End Try

    End Sub

    Protected Sub btnSaveSurfaceEquipment_Click(sender As Object, e As EventArgs) Handles btnSaveSurfaceEquipment.Click

        Dim sql As String = ""

        If IsNothing(Request.QueryString("op")) Then

            If assetIDExists(txtAssetNumber.Text) = True Then
                obj.MessageLabel(lblMsg, "Cannot save because the Assetnumber already exists.", "Red")
                Exit Sub
            End If


            sql = "INSERT tblSurfaceEquipment (AssetTypeID, AssetNumber,SerialNumber, RegNumber,ChassisNumber " &
                                ",[Description],Color,FuelTypeID,TyreSizeID,NumberOfTyres, HourMeter, GeneratorSize,TrailerSize, AssetCategoryID,ActiveMode, EngineModel)" &
                                " VALUES (" & cboAssetType.SelectedValue & ",'" & txtAssetNumber.Text & "','" & txtSerialNumber.Text & "','" &
                                txtRegNumber.Text & "','" & txtChassisNumber.Text & "','" & txtDescription.Text & "','" & txtColor.Text & "'," &
                                cboFuelType.SelectedValue & "," & Val(cboTyreSize.SelectedValue) & "," & Val(txtNumberOfTyres.Text) & ",'" & txtHourMeter.Text & "','" &
                                txtGeneratorSize.Text & "','" & txtTrailerSize.Text & "', " & cboEquipmentCategory.SelectedValue & ",'" & cboActiveMode.SelectedValue & "', '" & txtEngineModel.Text & "')"
        Else
            sql = "UPDATE tblSurfaceEquipment SET  AssetTypeID = " & cboAssetType.SelectedValue & " ,  AssetNumber = '" & txtAssetNumber.Text &
                "', SerialNumber = '" & txtSerialNumber.Text & "',ChassisNumber = '" & txtChassisNumber.Text & "', [Description] = '" & txtDescription.Text &
                "' ,Color = '" & txtColor.Text & "',FuelTypeID = " & cboFuelType.SelectedValue & ",TyreSizeID = " & Val(cboTyreSize.SelectedValue) &
                ",NumberOfTyres = " & Val(txtNumberOfTyres.Text) & ", HourMeter = '" & txtHourMeter.Text & "'," &
                "GeneratorSize = '" & txtGeneratorSize.Text & "',TrailerSize = '" & txtTrailerSize.Text & "', AssetCategoryID = " & cboEquipmentCategory.SelectedValue &
                ",ActiveMode = '" & cboActiveMode.SelectedValue & "', EngineModel = '" & txtEngineModel.Text & "' WHERE SurfaceEquipmentID = " & Request.QueryString("op")
        End If

        Try
            db.ExecuteNonQuery(CommandType.Text, sql)

            'If obj.ExecuteNonQRY(sql) = 1 Then
            obj.MessageLabel(lblMsg, "Surface equipment details saved successfully.", "Green")
            'End If

        Catch ex As Exception
            obj.MessageLabel(lblMsg, "The following error occurred while saving the surface eqipment details; " & ex.Message, "Red")
        End Try


    End Sub

    Protected Sub lnkBackToList_Click(sender As Object, e As EventArgs) Handles lnkBackToList.Click
        Response.Redirect("~/SurfaceEquipmentList.aspx")
    End Sub

    Private Function assetIDExists(ByVal AssetNumber As String) As Boolean

        assetIDExists = False

        Dim qry As String = "SELECT * FROM [tblSurfaceEquipment] WHERE [AssetNumber] = '" & AssetNumber & "'"

        Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, qry)

        If ds.Tables(0).Rows.Count > 0 Then
            assetIDExists = True
        End If


    End Function

    Protected Sub btnClear_Click(sender As Object, e As EventArgs) Handles btnClear.Click

        cboAssetType.ClearSelection()
        cboEquipmentCategory.ClearSelection()
        txtAssetNumber.Text = ""
        txtRegNumber.Text = ""
        txtDescription.Text = ""
        txtColor.Text = ""
        txtEngineModel.Text = ""
        cboFuelType.ClearSelection()
        cboTyreSize.ClearSelection()
        txtNumberOfTyres.Text = ""
        txtHourMeter.Text = ""
        txtGeneratorSize.Text = ""
        txtTrailerSize.Text = ""
        cboActiveMode.ClearSelection()

        txtChassisNumber.Text = ""
        txtSerialNumber.Text = ""


    End Sub
End Class

'[ActiveMode]