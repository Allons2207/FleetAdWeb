
Imports Telerik.Web.UI
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing
Public Class VehicleWriteOff
    Inherits System.Web.UI.Page
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then
            loadRegNumbers()
            obj.loadComboBox(cboReason, "SELECT reasonId, reason FROM tbl_reasonsForWrittingVehicleOff", "reason", "reasonId")
            loadExistingWrittenOffVehicle()

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

    Private Sub loadExistingWrittenOffVehicle()

        Dim qry As String = "SELECT dbo.tbl_vehiclesWrittenOffHistory.fleetId, dbo.tbl_vehiclesWrittenOffHistory.regNumber, " & _
                            " dbo.tbl_vehiclesWrittenOffHistory.dateWrittenOff, dbo.tbl_vehiclesWrittenOffHistory.reason, " & _
                            " dbo.tbl_vehicleMakes.vehicleMake, dbo.tbl_vehicleModels.vehicleModel FROM dbo.tbl_vehicleModels INNER JOIN " & _
                            " dbo.tbl_vehicleMakes ON dbo.tbl_vehicleModels.vehicleMakeId = dbo.tbl_vehicleMakes.vehicleMakeId INNER JOIN " & _
                            " dbo.tbl_vehiclesWrittenOffHistory INNER JOIN dbo.tbl_vehicleData ON dbo.tbl_vehiclesWrittenOffHistory.regNumber " & _
                            "= dbo.tbl_vehicleData.registrationNumber ON dbo.tbl_vehicleModels.vehicleModelId = dbo.tbl_vehicleData.modelId " & _
                            " WHERE dbo.tbl_vehiclesWrittenOffHistory.regNumber = '" & (Request.QueryString("op")) & "'"

        obj.ConnectionString = con
        Dim ds As DataSet = obj.ExecuteDsQRY(qry)

        If ds.Tables(0).Rows.Count > 0 Then
            obj.loadComboBox(cboRegNumber, "SELECT [registrationNumber] FROM [dbo].[tbl_vehicleData] ORDER BY registrationNumber", "registrationNumber", "registrationNumber")
            cboRegNumber.SelectedValue = ds.Tables(0).Rows(0).Item("regNumber")
            cboReason.Text = ds.Tables(0).Rows(0).Item("reason")
            txtFleetID.Text = ds.Tables(0).Rows(0).Item("fleetId")
            txtMake.Text = ds.Tables(0).Rows(0).Item("vehicleMake")
            txtModel.Text = ds.Tables(0).Rows(0).Item("vehicleModel")
            rdDate.SelectedDate = ds.Tables(0).Rows(0).Item("dateWrittenOff")


        End If


    End Sub

    Protected Sub cmdSave_Click(sender As Object, e As EventArgs) Handles cmdSave.Click

        If cboRegNumber.Text = "" Or cboRegNumber.Text = "--Select--" Then
            obj.MessageLabel(lblMsg, "Please specify the Vehicle's registration number.", "Red")
            Exit Sub
        ElseIf cboReason.Text = "" Or cboReason.Text = "--Select--" Then
            obj.MessageLabel(lblMsg, "Please specify the overall finding.", "Red")
            Exit Sub
        End If


        Dim qry As String = "UPDATE tbl_vehicleData SET writternOff = 1 WHERE [replacedVehicleRegNum] = '" & cboRegNumber.SelectedValue & "' OR [fleetId] = '" & txtFleetID.Text & "'"

        obj.ConnectionString = con

        If obj.ExecuteNonQRY(qry) = 1 Then

            qry = "INSERT [dbo].[tbl_vehiclesWrittenOffHistory]([regNumber], [fleetId], [dateWrittenOff], [reason]) " & _
               "VALUES('" & cboRegNumber.SelectedValue & "','" & txtFleetID.Text & "','" & rdDate.SelectedDate & "','" & cboReason.Text & "')"

            If obj.ExecuteNonQRY(qry) = 1 Then
                lblMsg.Text = "Vehicle successfully written off."
            End If

        End If

    End Sub


    Private Sub loadRegNumbers()
        obj.loadComboBox(cboRegNumber, "SELECT [registrationNumber] FROM [dbo].[tbl_vehicleData] WHERE [writternOff] IS NULL ORDER BY registrationNumber", "registrationNumber", "registrationNumber")
    End Sub

    Private Sub loadVehicleData()

        Dim qry As String = "SELECT dbo.tbl_vehicleMakes.vehicleMake, dbo.tbl_vehicleModels.vehicleModel, dbo.tbl_vehicleData.registrationNumber," & _
                            " dbo.tbl_vehicleData.fleetId FROM dbo.tbl_vehicleModels INNER JOIN dbo.tbl_vehicleMakes ON " & _
                            " dbo.tbl_vehicleModels.vehicleMakeId = dbo.tbl_vehicleMakes.vehicleMakeId INNER JOIN dbo.tbl_vehicleData ON " & _
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

    Protected Sub btnSearchByFleetID_Click(sender As Object, e As EventArgs) Handles btnSearchByFleetID.Click

    End Sub
End Class