
Imports Telerik.Web.UI
Imports Microsoft.Practices.EnterpriseLibrary.Data
Public Class VehicleInsuranceDetails
    Inherits System.Web.UI.Page
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            loadAllocatedRegNumbers()
            If Not IsNothing(Request.QueryString("op")) Then
                cboRegistrationNumber.Enabled = False
                loadExistingVehicleData()
            End If
        End If
    End Sub

    Private Sub loadExistingVehicleData()

        'Dim myUser As New SecurityPolicy.UserManager(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)
        'Dim myAdmin As New AdminSettings(CookiesWrapper.thisConnectionName, 0)
        'Dim audit As New UserAudit(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)
       
        Dim sql As String = "SELECT dateIssued, expiryDate, details, fleetId FROM tbl_vehicleInsuranceDetails WHERE fleetId = '" & Request.QueryString("op") & "'"
        obj.ConnectionString = con

        Try
            Dim ds As DataSet = obj.ExecuteDsQRY(sql)

            If ds.Tables(0).Rows.Count > 0 Then

                txtFleetIDSearch.Text = ds.Tables(0).Rows(0).Item("fleetId")
                loadVehicleData()
                rdIssuedDate.SelectedDate = ds.Tables(0).Rows(0).Item("dateIssued")
                rdExpiryDate.SelectedDate = ds.Tables(0).Rows(0).Item("expiryDate")
                txtDetails.Text = ds.Tables(0).Rows(0).Item("details")

            End If
        Catch ex As Exception
            obj.MessageLabel(lblMsg, "Error. Failed to load vehicle insurance record.", "Red")
        End Try

    End Sub
    Private Sub loadAllocatedRegNumbers()
        obj.loadComboBox(cboRegistrationNumber, "SELECT DISTINCT [registrationNumber] FROM [dbo].[tbl_vehicleData] WHERE [allocationStatusId] = 1", "registrationNumber", "registrationNumber")
    End Sub

    Protected Sub btnSearchByFleetID_Click(sender As Object, e As EventArgs) Handles btnSearchByFleetID.Click
        obj.ConnectionString = con
        txtRegNo.Text = obj.fnVehicleRegNumFromFleetID(txtFleetIDSearch.Text)
        loadVehicleData()
    End Sub

    Private Sub loadVehicleData()

        txtFleetID.Text = ""
        txtDetails.Text = ""
        txtMake.Text = ""
        txtModel.Text = ""

        Dim qry As String = "SELECT dbo.tbl_vehicleMakes.vehicleMake, dbo.tbl_vehicleModels.vehicleModel, dbo.tbl_vehicleData.registrationNumber," &
                           " dbo.tbl_vehicleData.fleetId FROM dbo.tbl_vehicleModels INNER JOIN dbo.tbl_vehicleMakes ON " &
                           " dbo.tbl_vehicleModels.vehicleMakeId = dbo.tbl_vehicleMakes.vehicleMakeId INNER JOIN dbo.tbl_vehicleData ON " &
                           " dbo.tbl_vehicleModels.vehicleModelId = dbo.tbl_vehicleData.modelId WHERE  dbo.tbl_vehicleData.fleetId = '" & txtFleetIDSearch.Text & "'"

        Try
            obj.ConnectionString = con
            Dim ds As DataSet = obj.ExecuteDsQRY(qry)
            If ds.Tables(0).Rows.Count > 0 Then
                txtRegNo.Text = ds.Tables(0).Rows(0).Item("registrationNumber")
                txtMake.Text = ds.Tables(0).Rows(0).Item("vehicleMake")
                txtModel.Text = ds.Tables(0).Rows(0).Item("vehicleModel")
                txtFleetID.Text = ds.Tables(0).Rows(0).Item("fleetId")
            Else
                obj.MessageLabel(lblMsg, "No such vehicle found under ALLOCATED and POOL vehicles.", "Yellow")
            End If
        Catch ex As Exception

        End Try


    End Sub

    Protected Sub cmdFindVehicleByRegNo_Click(sender As Object, e As EventArgs) Handles cmdFindVehicleByRegNo.Click
        obj.ConnectionString = con
        txtFleetIDSearch.Text = obj.fnVehicleFleetIDNumFromRegNum(txtRegNo.Text)
        loadVehicleData()
    End Sub

    Protected Sub cmdDelete_Click(sender As Object, e As EventArgs) Handles cmdDelete.Click
        If Not IsNothing(Request.QueryString("op")) Then
            Dim qry As String = "DELETE FROM tbl_vehicleInsuranceDetails WHERE (FleetId = " & Request.QueryString("op") & ")"

            obj.ConnectionString = con

            If obj.ExecuteNonQRY(qry) = 1 Then
                obj.MessageLabel(lblMsg, "Vehicle Insurance Record successfully deleted.", "Green")
            Else
                obj.MessageLabel(lblMsg, "Error while trying to delete Vehicle Insurance entry.", "Red")
            End If
        Else
            obj.MessageLabel(lblMsg, "Error. System could not find the Vehicle Insurance Entry Record.", "Red")
        End If
    End Sub

    Protected Sub cmdSave_Click(sender As Object, e As EventArgs) Handles cmdSave.Click

        If txtFleetID.Text = "" Then
            obj.MessageLabel(lblMsg, "Error. Ivalid FleetId.", "Red")
        ElseIf rdIssuedDate.IsEmpty Then
            obj.MessageLabel(lblMsg, "Error. Ivalid Issue Date.", "Red")
        ElseIf rdExpiryDate.IsEmpty Then
            obj.MessageLabel(lblMsg, "Error. Invalid Expiry Date.", "Red")
        End If

        Dim qry As String = ""
        If IsNothing(Request.QueryString("op")) Then
            qry = "INSERT tbl_vehicleInsuranceDetails (fleetId, dateIssued, expiryDate,details) " &
                    " VALUES ('" & txtFleetID.Text & "', '" & rdIssuedDate.selectedDate & "', '" & rdExpiryDate.selectedDate &
                    "','" & txtDetails.Text & "') "
        Else
            qry = "UPDATE tbl_vehicleInsuranceDetails SET dateIssued = '" & rdIssuedDate.selectedDate & "' , expiryDate ='" & rdExpiryDate.selectedDate & "'," &
                "details = '" & txtDetails.Text & "' WHERE fleetId = '" & txtFleetID.Text & "'"
        End If

        obj.ConnectionString = con

        Try
            If obj.ExecuteNonQRY(qry) = 1 Then
                obj.MessageLabel(lblMsg, "Vehicle Insurance Record successfully saved.", "Green")
            Else
                obj.MessageLabel(lblMsg, "Error while trying to save Vehicle Insurance details.", "Red")
            End If
        Catch ex As Exception
            obj.MessageLabel(lblMsg, "Error while trying to save Vehicle Insurance details.", "Red")
        End Try

    End Sub
End Class