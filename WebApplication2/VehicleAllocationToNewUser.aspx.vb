
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Telerik.Web.UI

Public Class VehicleAllocationToNewUser
    Inherits System.Web.UI.Page
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsNothing(Request.QueryString("op")) Then
            loadVehicleDetails()
        End If
    End Sub

    Private Sub loadVehicleDetails()

        Dim qry As String = "SELECT  dbo.tbl_vehicleData.fleetId, dbo.tbl_vehicleData.registrationNumber, dbo.tbl_vehicleMakes.vehicleMake, " &
                            " dbo.tbl_vehicleModels.vehicleModel, dbo.tbl_vehicleTypes.vehicleType, dbo.tbl_vehicleCategories.category " &
                            " FROM  dbo.tbl_vehicleData INNER JOIN " &
                            " dbo.tbl_vehicleTypes ON dbo.tbl_vehicleData.vehicleTypeId = dbo.tbl_vehicleTypes.vehicleTypeId INNER JOIN " &
                            " dbo.tbl_vehicleCategories ON dbo.tbl_vehicleData.vehicleCategoryId = dbo.tbl_vehicleCategories.categoryId INNER JOIN " &
                            " dbo.tbl_vehicleModels ON dbo.tbl_vehicleData.modelId = dbo.tbl_vehicleModels.vehicleModelId INNER JOIN " &
                            " dbo.tbl_vehicleMakes ON dbo.tbl_vehicleModels.vehicleMakeId = dbo.tbl_vehicleMakes.vehicleMakeId " &
                            " WHERE        (dbo.tbl_vehicleData.fleetId = '" & Request.QueryString("op") & "')"

        obj.ConnectionString = con

        Dim ds As DataSet = obj.ExecuteDsQRY(qry)

        If ds.Tables(0).Rows.Count > 0 Then
            lblFleetId.Text = ds.Tables(0).Rows(0).Item("fleetId")
            lblRegNo.Text = ds.Tables(0).Rows(0).Item("registrationNumber")
            lblMake.Text = ds.Tables(0).Rows(0).Item("vehicleMake")
            lblModel.Text = ds.Tables(0).Rows(0).Item("vehicleModel")
            lblRegNo.Text = ds.Tables(0).Rows(0).Item("registrationNumber")
            lblUserCategory.Text = ds.Tables(0).Rows(0).Item("category")
            lblVehicleType.Text = ds.Tables(0).Rows(0).Item("vehicleType")
        End If

    End Sub

    Protected Sub cmdAllocate_Click(sender As Object, e As EventArgs) Handles cmdAllocate.Click

        If saveVehicleUser() = 1 Then
            If allocateUserVehicle() = 1 Then
                obj.MessageLabel(lblMsg, "Vehicle User successfully saved.", "Green")
                lockControls()
            Else
                obj.MessageLabel(lblMsg, "Saved vehicle user but failed to allocate vehicle.", "Red")
            End If
        Else
            obj.MessageLabel(lblMsg, "Failed to create and allocate vehicle user.", "Red")
        End If


    End Sub

    Private Function saveVehicleUser() As Integer
        Dim sql As String = "INSERT [dbo].[tbl_vehicleUsers] ([licenseNumber],[nationalIDNo], [firstName],[surname],[department]," &
                            " [position],[active],[comments],[defensiveLicenseExpiryDate],[allocationStatusId] ) VALUES ('" &
                            txtLicenseNumba.Text & "','" & txtNationalIDNumber.Text & "','" & txtFirstName.Text & "','" &
                            txtSurname.Text & "','" & txtDepartment.Text & "','" &
                            txtDesignation.Text & "',1,'','" & rdExpiryDate.SelectedDate & "',2)"

        obj.ConnectionString = con
        If obj.ExecuteNonQRY(sql) = 1 Then
            Return 1
        Else
            Return 0
        End If

    End Function

    Private Function allocateUserVehicle() As Integer

        allocateUserVehicle = 0

        obj.ConnectionString = con

        If lblRegNo.Text = "" Then
            obj.MessageLabel(lblMsg, "Invalid vehicle registration number.", "Red")
            Exit Function
        ElseIf obj.fnVehicleExists(lblFleetId.Text) = False
            obj.MessageLabel(lblMsg, "The specified Vehicle Fleet number could not be found in vehicles data.", "Red")
            Exit Function
        ElseIf obj.fnVehicleUserExists(txtLicenseNumba.Text) = False
            obj.MessageLabel(lblMsg, "The specified Vehicle Registration number could not be found in vehicles data.", "Red")
            Exit Function
        ElseIf txtFirstName.Text = "" Then
            obj.MessageLabel(lblMsg, "Invalid First Name.", "Red")
            Exit Function
        ElseIf txtLicenseNumba.Text = "" Then
            obj.MessageLabel(lblMsg, "Please specify the vehicle user's License Number.", "Red")
            Exit Function
        ElseIf lblModel.Text = "" Then
            obj.MessageLabel(lblMsg, "Invalid vehicle model.", "Red")
            Exit Function
        End If

        If allocatedUser() = True Then
            obj.MessageLabel(lblMsg, "User is already allocated a vehicle. First unAllocate the vehicle from the User.", "Red")
            Exit Function
        End If

        'Dim sql As String = "UPDATE [dbo].[tbl_vehicleData] SET [allocationStatusId] = 1, [currentUserId] = '" & obj.fnVehicleUserNationalIdFromLicenceNum(txtLicenceNo.Text) &
        '    "'  WHERE [registrationNumber] = '" & txtRegNumber.Text & "'"


        Dim sql As String = "UPDATE [dbo].[tbl_vehicleData] SET [allocationStatusId] = 1, [currentUserId] = '" & txtLicenseNumba.Text &
            "'  WHERE [registrationNumber] = '" & lblRegNo.Text & "'"


        Try
            obj.ConnectionString = con
            If obj.ExecuteNonQRY(sql) = 1 Then

                sql = "UPDATE [dbo].[tbl_vehicleUsers] SET [allocationStatusId] = 1, [fleetId] = '" & lblFleetId.Text &
                    "', [regNumber] = '" & lblRegNo.Text & "', [allocationDate] = '" & Today & "' WHERE [licenseNumber] = '" & txtLicenseNumba.Text & "'"

                If obj.ExecuteNonQRY(sql) = 1 Then

                    sql = "INSERT tbl_vehicleAllocationHistory (registrationNumber,fleetID ,make,model ,allocationMode,driver," &
                            " department,nationalIDNumber,licenseNumber, dtDate)  VALUES ('" & lblRegNo.Text &
                            "','" & lblFleetId.Text & "','" & lblModel.Text & "','" & lblMake.Text & "','Allocated','" &
                             txtFirstName.Text & " " & txtSurname.Text & "','" & txtDepartment.Text & "','" & obj.fnVehicleUserNationalIdFromLicenceNum(txtLicenseNumba.Text) &
                             "','" & txtLicenseNumba.Text & "','" & Now & "')"

                    obj.ExecuteNonQRY(sql)

                    lockControls()

                    allocateUserVehicle = 1

                    obj.MessageLabel(lblMsg, "Vehicle successfully allocated to user.", "Green")

                    Exit Function

                End If
            Else
                obj.MessageLabel(lblMsg, "Error while trying to allocate vehicle to user.", "Red")
                Exit Function
            End If

        Catch ex As Exception
        End Try
    End Function

    Private Sub lockControls()
        txtApplicationFormNumber.Enabled = False
        txtDepartment.Enabled = False
        txtDesignation.Enabled = False
        txtFirstName.Enabled = False
        txtLicenseNumba.Enabled = False
        txtNationalIDNumber.Enabled = False
        txtSurname.Enabled = False

        cmdAllocate.Enabled = False

    End Sub

    Private Function allocatedUser() As Boolean

        allocatedUser = False

        Dim sql As String = " SELECT [allocationStatusId] FROM [dbo].[tbl_vehicleUsers] WHERE [licenseNumber] = '" & txtLicenseNumba.Text & "'"

        obj.ConnectionString = con

        Dim ds As DataSet = obj.ExecuteDsQRY(sql)

        If ds.Tables(0).Rows.Count > 0 Then
            If ds.Tables(0).Rows(0).Item("allocationStatusId") = 1 Then
                allocatedUser = True
            End If
        End If

    End Function
End Class