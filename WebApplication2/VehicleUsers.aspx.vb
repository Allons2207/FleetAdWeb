
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Telerik.Web.UI

Public Class VehicleUsers
    Inherits System.Web.UI.Page
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            obj.loadComboBox(cboAllocationStatus, "SELECT [allocationStatus], [allocationStatusId] FROM [dbo].[tbl_allocationStatus]", "allocationStatus", "allocationStatusId")

            If Not IsNothing(Request.QueryString("op")) Then
                loadExistingVehicleUserDetails()
            End If

            If grantPageWriteCommandPermission(CokkiesWrapper.UserID, 1) = True Then
                cmdAddNew.Enabled = True
                If Not IsNothing(Request.QueryString("op")) Then
                    cmdDelete.Enabled = True
                Else
                    cmdDelete.Enabled = False
                End If
            Else
                cmdAddNew.Enabled = False
            End If
        End If

    End Sub

    Private Sub loadExistingVehicleUserDetails()

        Dim qry As String = "SELECT licenseNumber,[nationalIDNo], firstName, surname, department, position, allocationStatusId, applicationDate, formNumber," & _
                            " employmentNumber , [defensiveLicenseExpiryDate] FROM dbo.tbl_vehicleUsers WHERE  (licenseNumber = '" & (Request.QueryString("op")) & "')"

        '   Try
        obj.ConnectionString = con
        Dim ds As DataSet = obj.ExecuteDsQRY(qry)

        On Error Resume Next

        If ds.Tables(0).Rows.Count > 0 Then

            txtLicenseNumba.Text = ds.Tables(0).Rows(0).Item("licenseNumber")
            txtFirstName.Text = ds.Tables(0).Rows(0).Item("firstName")
            txtSurname.Text = ds.Tables(0).Rows(0).Item("surname")
            txtDepartment.Text = ds.Tables(0).Rows(0).Item("department")
            txtDesignation.Text = ds.Tables(0).Rows(0).Item("position")
            txtNationalIDNumber.Text = ds.Tables(0).Rows(0).Item("nationalIDNo")
            cboAllocationStatus.SelectedValue = ds.Tables(0).Rows(0).Item("allocationStatusId")

            rdExpiryDate.SelectedDate = ds.Tables(0).Rows(0).Item("defensiveLicenseExpiryDate")

            If Not IsDBNull(ds.Tables(0).Rows(0).Item("applicationDate")) Then
                rdApplicationDate.SelectedDate = ds.Tables(0).Rows(0).Item("applicationDate")
            End If

            If Not IsDBNull(ds.Tables(0).Rows(0).Item("formNumber")) Then
                txtApplicationFormNumber.Text = ds.Tables(0).Rows(0).Item("formNumber")
            End If

            loadAllocationHistory()
            loadMedicalTestDetails(txtLicenseNumba.Text)
            loadDDCDetails(txtLicenseNumba.Text)
            loadReTestDetails(txtLicenseNumba.Text)

        End If
        '  obj.MessageLabel(lblMsg, "Selected vehicle user's details successfully loaded.", "Green")
        '   Catch ex As Exception
        'obj.MessageLabel(lblMsg, "Error while trying to load selected vehicle user's details.", "Red")
        '  End Try

    End Sub

    Private Sub loadAllocationHistory()

        Dim sql As String = "SELECT [allocationMode], [dtDate], [make], [model], [registrationNumber], [fleetID] FROM " &
                            " [dbo].[tbl_vehicleAllocationHistory] WHERE [licenseNumber] = '" & txtLicenseNumba.Text & "' ORDER BY dtDate Desc "

        obj.ConnectionString = con

        Dim ds As DataSet = obj.ExecuteDsQRY(sql)
        gwList.DataSource = ds
        gwList.DataBind()

    End Sub

    Private Sub saveVehicleUser()

        Dim sql As String = "INSERT [dbo].[tbl_vehicleUsers] ([licenseNumber],[nationalIDNo], [firstName],[surname],[department]," &
                            " [position],[active],[comments],[defensiveLicenseExpiryDate],[allocationStatusId] ) VALUES ('" &
                            txtLicenseNumba.Text & "','" & txtNationalIDNumber.Text & "','" & txtFirstName.Text & "','" &
                            txtSurname.Text & "','" & txtDepartment.Text & "','" &
                            txtDesignation.Text & "',1,'','" & rdExpiryDate.SelectedDate & "'," & cboAllocationStatus.SelectedValue & ")"

        obj.ConnectionString = con
        If obj.ExecuteNonQRY(sql) = 1 Then
            obj.MessageLabel(lblMsg, "Vehicle User successfully saved.", "Green")
            Exit Sub
        Else
            obj.MessageLabel(lblMsg, "Error while trying to save vehicle user.", "Red")
            Exit Sub
        End If

    End Sub
    Protected Sub cmdAddNew_Click(sender As Object, e As EventArgs) Handles cmdAddNew.Click
        If Not IsNothing(Request.QueryString("op")) Then
            updateVehicleUser()
        Else
            saveVehicleUser()
        End If

    End Sub


    Private Sub updateVehicleUser()

        Dim sql As String = ""

        sql = "UPDATE tbl_vehicleUsers SET licenseNumber = '" & txtLicenseNumba.Text & "',[nationalIDNo] ='" & txtNationalIDNumber.Text &
                    "', [firstName] = '" & txtFirstName.Text & "', [surname] = '" & txtSurname.Text & "', [department] = '" & txtDepartment.Text &
                    "', [position] = '" & txtDesignation.Text & "', [defensiveLicenseExpiryDate] = '" & rdExpiryDate.SelectedDate &
                    "',[allocationStatusId] = " & cboAllocationStatus.SelectedValue &
                    ", [applicationDate] = '" & rdApplicationDate.SelectedDate & "', [formNumber] = '" & txtApplicationFormNumber.Text & "' WHERE licenseNumber = '" & (Request.QueryString("op")) & "'"

        'If optBasedOnLicenseNumber.Checked = True Then
        '    sql = "UPDATE tbl_vehicleUsers SET licenseNumber = '" & txtLicenseNumba.Text & "',[nationalIDNo] ='" & txtNationalIDNumber.Text &
        '            "', [firstName] = '" & txtFirstName.Text & "', [surname] = '" & txtSurname.Text & "', [department] = '" & txtDepartment.Text &
        '            "', [position] = '" & txtDesignation.Text & "', [defensiveLicenseExpiryDate] = '" & rdExpiryDate.SelectedDate &
        '            "',[allocationStatusId] = " & cboAllocationStatus.SelectedValue &
        '            ", [applicationDate] = '" & rdApplicationDate.SelectedDate & "', [formNumber] = '" & txtApplicationFormNumber.Text & "' WHERE licenseNumber = '" & (Request.QueryString("op")) & "'"

        'ElseIf optBasedOnNationalIDNumber.Checked = True Then
        '    sql = "UPDATE tbl_vehicleUsers SET licenseNumber = '" & txtLicenseNumba.Text & "',[nationalIDNo] ='" & txtNationalIDNumber.Text &
        '            "', [firstName] = '" & txtFirstName.Text & "', [surname] = '" & txtSurname.Text & "', [department] = '" & txtDepartment.Text &
        '            "', [position] = '" & txtDesignation.Text & "', [defensiveLicenseExpiryDate] = '" & rdExpiryDate.SelectedDate &
        '            "',[allocationStatusId] = " & cboAllocationStatus.SelectedValue &
        '            ", [applicationDate] = '" & rdApplicationDate.SelectedDate & "', [formNumber] = '" & txtApplicationFormNumber.Text & "' WHERE nationalIDNo = '" & (Request.QueryString("op")) & "'"

        'End If

        obj.ConnectionString = con
        If obj.ExecuteNonQRY(sql) = 1 Then
            obj.MessageLabel(lblMsg, "Vehicle User successfully updated.", "Green")
            Exit Sub
        Else
            obj.MessageLabel(lblMsg, "Error while trying to update vehicle user.", "Red")
            Exit Sub
        End If

    End Sub

    Private Sub clearControls()
        txtLicenseNumba.Text = ""
        txtFirstName.Text = ""
        txtSurname.Text = ""
        txtDepartment.Text = ""
        txtDesignation.Text = ""
        txtNationalIDNumber.Text = ""
        rdApplicationDate.Clear()
        rdExpiryDate.Clear()
        cboAllocationStatus.ClearSelection()
    End Sub

    Protected Sub cmdClear_Click(sender As Object, e As EventArgs) Handles cmdClear.Click
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
            Dim qry As String = "DELETE FROM dbo.tbl_vehicleUsers WHERE  (licenseNumber = '" & (Request.QueryString("op")) & "')"

            obj.ConnectionString = con

            If obj.ExecuteNonQRY(qry) = 1 Then
                obj.MessageLabel(lblMsg, "Vehicle User Record successfully deleted.", "Green")
            Else
                obj.MessageLabel(lblMsg, "Error while trying to delete Vehicle User entry.", "Red")
            End If
        Else
            obj.MessageLabel(lblMsg, "Error. System could not find the Vehicle User License Number.", "Red")
        End If
    End Sub

    Protected Sub PageLevelTabs_TabClick(sender As Object, e As RadTabStripEventArgs) Handles PageLevelTabs.TabClick
        lblMultipageLabels.Text = PageLevelTabs.SelectedTab.Text
    End Sub

    Protected Sub cmdSaveMedical_Click(sender As Object, e As EventArgs) Handles cmdSaveMedical.Click

        Dim sql As String = "SELECT * FROM tbl_vehicleUserMedicals WHERE licenseNumber = '" & txtLicenseNumba.Text & "'"

        If RecordExists(sql) = True Then
            sql = "UPDATE tbl_vehicleUserMedicals SET examDate = '" & rdMedicalsDateIssued.SelectedDate & "', expiryDate = '" & rdMedicalsExpiryDate.SelectedDate & "' WHERE licenseNumber = '" & txtLicenseNumba.Text & "'"
        Else
            sql = "INSERT tbl_vehicleUserMedicals (licenseNumber, examDate, expiryDate)" &
                          " VALUES ('" & txtLicenseNumba.Text & "','" & rdMedicalsDateIssued.SelectedDate & "','" & rdMedicalsExpiryDate.SelectedDate & "')"
        End If

        executeQuery(sql)

    End Sub

    Private Sub executeQuery(ByVal sql As String)
        If sql <> "" Then
            obj.ConnectionString = con
            If obj.ExecuteNonQRY(sql) = 1 Then
                obj.MessageLabel(lblMsg, "Record successfully saved.", "Green")
            End If
        End If
    End Sub
    Private Function RecordExists(ByVal qry As String) As Boolean

        obj.ConnectionString = con

        Try
            Dim ds As DataSet = obj.ExecuteDsQRY(qry)
            If ds.Tables(0).Rows.Count > 0 Then
                RecordExists = True
            Else
                RecordExists = False
            End If
        Catch ex As Exception
            RecordExists = False
        End Try

    End Function

    Protected Sub cmdSaveRetest_Click(sender As Object, e As EventArgs) Handles cmdSaveRetest.Click

        Dim sql As String = "SELECT * FROM tbl_vehicleUserRetests WHERE licenseNumber = '" & txtLicenseNumba.Text & "'"

        If RecordExists(sql) = True Then
            sql = "UPDATE tbl_vehicleUserRetests SET examDate = '" & radRetestedDate.SelectedDate & "', expiryDate = '" & radRetestedExpiryDate.SelectedDate & "' WHERE licenseNumber = '" & txtLicenseNumba.Text & "'"
        Else
            sql = "INSERT tbl_vehicleUserRetests (licenseNumber, examDate, expiryDate)" &
                          " VALUES ('" & txtLicenseNumba.Text & "','" & radRetestedDate.SelectedDate & "','" & radRetestedExpiryDate.SelectedDate & "')"
        End If

        executeQuery(sql)

    End Sub

    Protected Sub cmdSaveDDC_Click(sender As Object, e As EventArgs) Handles cmdSaveDDC.Click

        Dim sql As String = "SELECT * FROM tbl_vehicleUserDDCs WHERE licenseNumber = '" & txtLicenseNumba.Text & "'"

        If RecordExists(sql) = True Then
            sql = "UPDATE tbl_vehicleUserDDCs SET examDate = '" & radDateDDCTested.SelectedDate & "', expiryDate = '" & radDateDDCExpiry.SelectedDate & "' WHERE licenseNumber = '" & txtLicenseNumba.Text & "'"
        Else
            sql = "INSERT tbl_vehicleUserDDCs (licenseNumber, examDate, expiryDate)" &
                          " VALUES ('" & txtLicenseNumba.Text & "','" & radDateDDCTested.SelectedDate & "','" & radDateDDCExpiry.SelectedDate & "')"
        End If

        executeQuery(sql)

    End Sub


    Private Sub loadMedicalTestDetails(ByVal licenseNumba As String)
        Dim sql As String = "SELECT  licenseNumber, nationalIdNum, examDate, expiryDate FROM  dbo.tbl_vehicleUserMedicals " &
                            " WHERE  (licenseNumber = '" & licenseNumba & "')"

        obj.ConnectionString = con

        Try
            Dim ds As DataSet = obj.ExecuteDsQRY(sql)
            If ds.Tables(0).Rows.Count > 0 Then
                rdMedicalsDateIssued.SelectedDate = ds.Tables(0).Rows(0).Item("examDate")
                rdMedicalsExpiryDate.SelectedDate = ds.Tables(0).Rows(0).Item("expiryDate")
            Else

            End If
        Catch ex As Exception

        End Try

    End Sub

    Private Sub loadReTestDetails(ByVal licenseNumba As String)
        Dim sql As String = "SELECT  licenseNumber, nationalIdNum, examDate, expiryDate FROM  dbo.tbl_vehicleUserRetests " &
                            " WHERE  (licenseNumber = '" & licenseNumba & "')"

        obj.ConnectionString = con

        Try
            Dim ds As DataSet = obj.ExecuteDsQRY(sql)
            If ds.Tables(0).Rows.Count > 0 Then
                radRetestedDate.SelectedDate = ds.Tables(0).Rows(0).Item("examDate")
                radRetestedExpiryDate.SelectedDate = ds.Tables(0).Rows(0).Item("expiryDate")
            Else

            End If
        Catch ex As Exception

        End Try

    End Sub

    Private Sub loadDDCDetails(ByVal licenseNumba As String)
        Dim sql As String = "SELECT  licenseNumber, nationalIdNum, examDate, expiryDate FROM  dbo.[tbl_vehicleUserDDCs] " &
                            " WHERE  (licenseNumber = '" & licenseNumba & "')"

        obj.ConnectionString = con

        Try
            Dim ds As DataSet = obj.ExecuteDsQRY(sql)
            If ds.Tables(0).Rows.Count > 0 Then
                radDateDDCTested.SelectedDate = ds.Tables(0).Rows(0).Item("examDate")
                radDateDDCExpiry.SelectedDate = ds.Tables(0).Rows(0).Item("expiryDate")
            Else

            End If
        Catch ex As Exception

        End Try

    End Sub

End Class