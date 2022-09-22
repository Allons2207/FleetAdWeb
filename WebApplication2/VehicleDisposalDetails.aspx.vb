
Imports Telerik.Web.UI
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing
Public Class VehicleDisposalDetails
    Inherits System.Web.UI.Page
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then
            loadRegNumbers()
            obj.loadComboBox(cboReason, "SELECT DISTINCT reasonId, reason FROM [tbl_vehicleDisposalReasons]", "reason", "reasonId")

            If Not IsNothing(Request.QueryString("op")) Then
              loadSelectedVehicleDetails
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

    Protected Sub cmdSave_Click(sender As Object, e As EventArgs) Handles cmdSave.Click


        If cboRegNumber.Text = "" Or cboRegNumber.Text = "--Select--" Then
            obj.MessageLabel(lblMsg, "Please specify the vehicle's registration number.", "Red")
            Exit Sub
        ElseIf cboReason.Text = "" Or cboReason.Text = "--Select--" Then
            obj.MessageLabel(lblMsg, "Please specify the reason for disposal.", "Red")
            Exit Sub
        End If


        Dim qry As String = "UPDATE tbl_vehicleData SET [disposalStatusId] = 1 WHERE ([fleetId] = '" & txtFleetID.Text & "')"

        obj.ConnectionString = con

        If obj.ExecuteNonQRY(qry) = 1 Then
            qry = "DELETE FROM tbl_vehiclesDisposalHistory WHERE ([fleetId] = '" & txtFleetID.Text & "')"

            If obj.ExecuteNonQRY(qry) = 1 Then
                qry = "INSERT [dbo].[tbl_vehiclesDisposalHistory] ([dtDate], [make],[model],[fleetId],[regNumba],[reasonForDisposal], [comments])" & _
                         "VALUES('" & rdDate.SelectedDate & "','" & txtMake.Text & "','" & txtModel.Text & "','" & txtFleetID.Text & _
                         "', '" & cboRegNumber.SelectedValue & "', '" & cboReason.Text & "','" & txtComments.Text & "')"

                If obj.ExecuteNonQRY(qry) = 1 Then

                    qry = "UPDATE [dbo].[tbl_vehicleUsers] SET [allocationStatusId] = 2, [fleetId] = '', [regNumber] = '' WHERE [licenseNumber] = '" & getVehicleUserLicenseNo() & "'"

                    obj.ExecuteNonQRY(qry)

                    obj.MessageLabel(lblMsg, "Vehicle successfully disposed off.", "Green")

                End If
            End If
        End If

    End Sub

    Private Function getVehicleUserLicenseNo() As String

        getVehicleUserLicenseNo = ""

        Dim qry As String = "SELECT licenseNumber FROM  dbo.tbl_vehicleUsers WHERE        (fleetId = '" & txtFleetID.Text & "')"

        obj.ConnectionString = con

        Dim ds As DataSet = obj.ExecuteDsQRY(qry)

        If ds.Tables(0).Rows.Count > 0 Then
            getVehicleUserLicenseNo = ds.Tables(0).Rows(0).Item("licenseNumber")
        End If


    End Function
    Private Sub loadRegNumbers()
        obj.loadComboBox(cboRegNumber, "Select DISTINCT [registrationNumber] FROM [dbo].[tbl_vehicleData] ORDER BY registrationNumber", "registrationNumber", "registrationNumber")
    End Sub

    Private Sub loadVehicleData()

        Dim qry As String = "Select dbo.tbl_vehicleMakes.vehicleMake, dbo.tbl_vehicleModels.vehicleModel, dbo.tbl_vehicleData.registrationNumber," & _
                            " dbo.tbl_vehicleData.fleetId FROM dbo.tbl_vehicleModels INNER JOIN dbo.tbl_vehicleMakes On " & _
                            " dbo.tbl_vehicleModels.vehicleMakeId = dbo.tbl_vehicleMakes.vehicleMakeId INNER JOIN dbo.tbl_vehicleData On " & _
                            " dbo.tbl_vehicleModels.vehicleModelId = dbo.tbl_vehicleData.modelId WHERE (dbo.tbl_vehicleData.registrationNumber = '" & cboRegNumber.Text & "')"

        Try
            obj.ConnectionString = con
            Dim ds As DataSet = obj.ExecuteDsQRY(qry)
            If ds.Tables(0).Rows.Count > 0 Then
                txtMake.Text = ds.Tables(0).Rows(0).Item("vehicleMake")
                txtModel.Text = ds.Tables(0).Rows(0).Item("vehicleModel")
                txtFleetID.Text = ds.Tables(0).Rows(0).Item("fleetId")
            End If
        Catch ex As Exception

        End Try

    End Sub

    Protected Sub cboRegNumber_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboRegNumber.SelectedIndexChanged
        loadVehicleData()
    End Sub


    Private Sub loadSelectedVehicleDetails()
        Dim qry As String = "SELECT DISTINCT dtDate, make, model, fleetId, regNumba, purchaseDate, mileage, reasonForDisposal, comments, " &
                            " engineNumber, chassisNumber FROM dbo.tbl_vehiclesDisposalHistory " &
                            " WHERE        (regNumba ='" & (Request.QueryString("op")) & "')"

        obj.ConnectionString = con
        Dim ds As DataSet = obj.ExecuteDsQRY(qry)

        If ds.Tables(0).Rows.Count > 0 Then
            cboRegNumber.SelectedValue = ds.Tables(0).Rows(0).Item("regNumba")
            cboReason.SelectedValue = ds.Tables(0).Rows(0).Item("reasonForDisposal")
            txtMake.Text = ds.Tables(0).Rows(0).Item("make")
            txtModel.Text = ds.Tables(0).Rows(0).Item("model")
            txtFleetID.Text = ds.Tables(0).Rows(0).Item("fleetId")
            rdDate.SelectedDate = ds.Tables(0).Rows(0).Item("dtDate")
            txtComments.Text = ds.Tables(0).Rows(0).Item("comments")
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

        If cboRegNumber.Text = "" Or cboRegNumber.Text = "--Select--" Then
            obj.MessageLabel(lblMsg, "Please specify the vehicle's registration number.", "Red")
            Exit Sub
        ElseIf cboReason.Text = "" Or cboReason.Text = "--Select--" Then
            obj.MessageLabel(lblMsg, "Please specify the reason for disposal.", "Red")
            Exit Sub
        End If


        Dim qry As String = "UPDATE tbl_vehicleData SET [disposalStatusId] = 0 WHERE ([replacedVehicleRegNum] = '" & cboRegNumber.Text & "' OR [fleetId] = '" & txtFleetID.Text & "')"

        obj.ConnectionString = con

        If obj.ExecuteNonQRY(qry) = 1 Then
            qry = "DELETE FROM tbl_vehiclesDisposalHistory WHERE (regNumba = '" & cboRegNumber.Text & "' OR [fleetId] = '" & txtFleetID.Text & "')"

            If obj.ExecuteNonQRY(qry) = 1 Then
                '    qry = "INSERT [dbo].[tbl_vehiclesDisposalHistory] ([dtDate], [make],[model],[fleetId],[regNumba],[reasonForDisposal], [comments])" &
                '             "VALUES('" & rdDate.SelectedDate & "','" & txtMake.Text & "','" & txtModel.Text & "','" & txtFleetID.Text &
                '             "', '" & cboRegNumber.SelectedValue & "', '" & cboReason.Text & "','" & txtComments.Text & "')"

                '    If obj.ExecuteNonQRY(qry) = 1 Then
                obj.MessageLabel(lblMsg, "Vehicle successfully restored from disposal records.", "Green")
                '    End If
            End If
        End If
    End Sub

End Class