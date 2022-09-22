Imports Telerik.Web.UI
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing

Public Class RetestDetails
    Inherits System.Web.UI.Page
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            loadVehicleUserLicences()
            loadVehicleUserNationalIDs()

            If Not IsNothing(Request.QueryString("op")) Then
                loadRetestDetails()
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

    Private Sub loadRetestDetails()
        Dim qry As String = "SELECT dbo.tbl_vehicleUserRetests.nationalIdNum, dbo.tbl_vehicleUserRetests.examDate, " &
                           " dbo.tbl_vehicleUserRetests.expiryDate, dbo.tbl_vehicleUsers.firstName, dbo.tbl_vehicleUsers.surname, " &
                           " dbo.tbl_vehicleUsers.department, dbo.tbl_vehicleUsers.position, dbo.tbl_vehicleUsers.licenseNumber " &
                           " FROM dbo.tbl_vehicleUserRetests INNER JOIN dbo.tbl_vehicleUsers ON dbo.tbl_vehicleUserRetests.licenseNumber " &
                           " = dbo.tbl_vehicleUsers.licenseNumber WHERE (dbo.tbl_vehicleUsers.licenseNumber = '" & (Request.QueryString("op")) & "')"
        Try
            obj.ConnectionString = con
            Dim ds As DataSet = obj.ExecuteDsQRY(qry)
            If ds.Tables(0).Rows.Count > 0 Then
                cboLicense.SelectedValue = ds.Tables(0).Rows(0).Item("licenseNumber")

                txtDept.Text = ds.Tables(0).Rows(0).Item("department")
                txtDesignation.Text = ds.Tables(0).Rows(0).Item("position")
                txtFirstName.Text = ds.Tables(0).Rows(0).Item("firstName")
                txtSurname.Text = ds.Tables(0).Rows(0).Item("surname")
                rdDateIssued.SelectedDate = ds.Tables(0).Rows(0).Item("examDate")
                rdExpiryDate.SelectedDate = ds.Tables(0).Rows(0).Item("expiryDate")
                cboNationalIDNos.SelectedValue = ds.Tables(0).Rows(0).Item("nationalIdNum")
            End If

        Catch ex As Exception

        End Try

    End Sub


    Protected Sub cmdSave_Click(sender As Object, e As EventArgs) Handles cmdSave.Click

        'If cboNationalIDNos.Text = "" Or cboNationalIDNos.Text = "--Select--" Then
        '    obj.MessageLabel(lblMsg, "Please specify the vehicle user's National ID Number.", "Red")
        '    Exit Sub
        'Else

        If cboLicense.Text = "" Or cboLicense.Text = "--Select--" Then
            obj.MessageLabel(lblMsg, "Please specify the vehicle user's License number.", "Red")
            Exit Sub
        End If


        If Not IsNothing(Request.QueryString("op")) Then
            updateExistingEntry()
        Else
            saveNewEntry()
        End If


    End Sub

    Private Sub saveNewEntry()
        Dim sql As String = "INSERT tbl_vehicleUserRetests (licenseNumber, examDate, expiryDate)" &
                           " VALUES ('" & cboLicense.SelectedValue & "','" & rdDateIssued.SelectedDate & "','" & rdExpiryDate.SelectedDate & "')"

        obj.ConnectionString = con
        If obj.ExecuteNonQRY(sql) = 1 Then
            obj.MessageLabel(lblMsg, "Record successfully saved.", "Green")
        End If
    End Sub


    Private Sub updateExistingEntry()

        Dim sql As String = "UPDATE tbl_vehicleUserRetests SET examDate = '" & rdDateIssued.SelectedDate & "', expiryDate = '" & rdExpiryDate.SelectedDate & "' WHERE licenseNumber = '" & cboLicense.SelectedValue & "'"

        obj.ConnectionString = con

        sql = "DELETE FROM tbl_vehicleUserRetests  WHERE licenseNumber = '" & cboLicense.SelectedValue & "'"

        obj.ExecuteNonQRY(sql)

        sql = "INSERT tbl_vehicleUserRetests (licenseNumber, examDate, expiryDate)" &
                           " VALUES ('" & cboLicense.SelectedValue & "','" & rdDateIssued.SelectedDate & "','" & rdExpiryDate.SelectedDate & "')"


        If obj.ExecuteNonQRY(sql) = 1 Then
            obj.MessageLabel(lblMsg, "Record successfully updated.", "Green")
        Else
            obj.MessageLabel(lblMsg, "Error while trying to update record.", "Red")
        End If
    End Sub

    Private Sub loadVehicleUserLicences()
        obj.loadComboBox(cboLicense, "SELECT [licenseNumber] FROM [dbo].[tbl_vehicleUsers] ORDER BY licenseNumber", "licenseNumber", "licenseNumber")
    End Sub

    Private Sub loadVehicleUserNationalIDs()
        obj.loadComboBox(cboNationalIDNos, "SELECT [nationalIDNo] FROM [dbo].[tbl_vehicleUsers] ORDER BY nationalIDNo ", "nationalIDNo", "nationalIDNo")
    End Sub

    Private Sub loadUserLicenseNumFromNationalID()
        Dim sql As String = "SELECT [licenseNumber],[firstName], [surname], [department], [position] FROM [dbo].[tbl_vehicleUsers] WHERE nationalIDNo = '" & cboNationalIDNos.SelectedValue & "'"
        Try
            obj.ConnectionString = con
            Dim ds As DataSet = obj.ExecuteDsQRY(sql)
            If ds.Tables(0).Rows.Count > 0 Then
                cboLicense.SelectedValue = ds.Tables(0).Rows(0).Item("licenseNumber")
                txtFirstName.Text = ds.Tables(0).Rows(0).Item("firstName")
                txtSurname.Text = ds.Tables(0).Rows(0).Item("surname")
                txtDept.Text = ds.Tables(0).Rows(0).Item("department")
                txtDesignation.Text = ds.Tables(0).Rows(0).Item("position")
            End If
        Catch ex As Exception
        End Try
    End Sub


    Private Sub loadUserNationalIDFromLicenseNum()
        Dim sql As String = "SELECT [nationalIDNo],[firstName], [surname], [department], [position], licenseNumber FROM [dbo].[tbl_vehicleUsers] WHERE licenseNumber = '" & cboLicense.SelectedValue & "'"

        Try
            obj.ConnectionString = con
            Dim ds As DataSet = obj.ExecuteDsQRY(sql)
            If ds.Tables(0).Rows.Count > 0 Then
                cboNationalIDNos.SelectedValue = ds.Tables(0).Rows(0).Item("nationalIDNo")
                cboLicense.SelectedValue = ds.Tables(0).Rows(0).Item("licenseNumber")
                txtFirstName.Text = ds.Tables(0).Rows(0).Item("firstName")
                txtSurname.Text = ds.Tables(0).Rows(0).Item("surname")
                txtDept.Text = ds.Tables(0).Rows(0).Item("department")
                txtDesignation.Text = ds.Tables(0).Rows(0).Item("position")
            End If
        Catch ex As Exception
        End Try
    End Sub

    Protected Sub cboLicense_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboLicense.SelectedIndexChanged
        loadUserNationalIDFromLicenseNum()
    End Sub

    Protected Sub cboNationalIDNos_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboNationalIDNos.SelectedIndexChanged
        loadUserLicenseNumFromNationalID()
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
            Dim qry As String = "DELETE FROM tbl_vehicleUserRetests  WHERE  (nationalIdNum = '" & (Request.QueryString("op")) & "')"


            obj.ConnectionString = con

            If obj.ExecuteNonQRY(qry) = 1 Then
                obj.MessageLabel(lblMsg, "Retest record entry deleted.", "Green")
            Else
                obj.MessageLabel(lblMsg, "Error while trying to delete Retest record entry.", "Red")
            End If
        Else
            obj.MessageLabel(lblMsg, "Error. System could not find the associated Vehicle User License Number.", "Red")
        End If
    End Sub

    Protected Sub cmdFind_Click(sender As Object, e As EventArgs) Handles cmdFind.Click

        Dim qry As String = "SELECT [nationalIDNo],[firstName], [surname], [department], [position], licenseNumber FROM [dbo].[tbl_vehicleUsers] WHERE Firstname LIKE '%" & txtSearhFirstName.Text &
            "%' AND surname LIKE '%" & txtSearchSurname.Text & "%'"

        clearControls()

        Try
            obj.ConnectionString = con
            Dim ds As DataSet = obj.ExecuteDsQRY(qry)
            If ds.Tables(0).Rows.Count > 0 Then
                If ds.Tables(0).Rows.Count = 1 Then
                    cboNationalIDNos.SelectedValue = ds.Tables(0).Rows(0).Item("nationalIDNo")
                    cboLicense.SelectedValue = ds.Tables(0).Rows(0).Item("licenseNumber")
                    txtFirstName.Text = ds.Tables(0).Rows(0).Item("firstName")
                    txtSurname.Text = ds.Tables(0).Rows(0).Item("surname")
                    txtDept.Text = ds.Tables(0).Rows(0).Item("department")
                    txtDesignation.Text = ds.Tables(0).Rows(0).Item("position")
                Else
                    obj.MessageLabel(lblMsg, "Please refine your search criteria and/or text, more than one matching records have been found.", "Yellow")
                End If
            Else
                obj.MessageLabel(lblMsg, "No matching records have been found.", "Yellow")
            End If
        Catch ex As Exception
            obj.MessageLabel(lblMsg, "Error while searching Vehicle User details.", "Red")
        End Try
    End Sub


    Private Sub clearControls()

        obj.MessageLabel(lblMsg, "", "")
        cboNationalIDNos.ClearSelection()
        cboLicense.ClearSelection()
        txtFirstName.Text = ""
        txtSurname.Text = ""
        txtDept.Text = ""
        txtDesignation.Text = ""

    End Sub
End Class