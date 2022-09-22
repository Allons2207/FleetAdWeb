
Imports Telerik.Web.UI
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing
Imports System.Data.SqlClient

Public Class EditFittedTyreDetails
    Inherits System.Web.UI.Page

    Dim objCBO As New commonFunction("FleetAd")
    Dim db As Database = objCBO.Database
    Dim con As String = db.ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


        If Not IsPostBack Then
            objCBO.ConnectionString = con

            objCBO.loadComboBox(cboFittingStatus, "SELECT [fittingStatusId], [fittingStatus] FROM [dbo].[tbl_tyreFittingStatus]", "fittingStatus", "fittingStatusId")

            loadTyreDetails()

        End If

    End Sub

    Private Sub loadTyreDetails()

        Dim qrySTR As String = "SELECT [vehicleMileageAtTyreFitting], [fittingStatusId], [detFittedOnVehicle], [fleetId], [serialNumber] FROM [dbo].[tbl_tyres] " &
                                      " WHERE [serialNumber] = '" & Request.QueryString("op") & "'"

        objCBO.ConnectionString = con

        If Not IsNothing(Request.QueryString("op")) Then

            Dim ds As DataSet = objCBO.ExecuteDsQRY(qrySTR)
            If ds.Tables(0).Rows.Count > 0 Then
                With ds.Tables(0).Rows(0)
                    txtSerialNumber.Text = .Item("serialNumber")
                    cboFittingStatus.SelectedValue = .Item("fittingStatusId")
                    rdDateFittedOnVehicle.SelectedDate = .Item("detFittedOnVehicle")
                    txtVehicleFleetID.Text = .Item("fleetId")
                End With
            End If
        Else

        End If

    End Sub

    Protected Sub cmdSave_Click(sender As Object, e As EventArgs) Handles cmdSave.Click

        Dim qry As String = "UPDATE [tbl_tyres] set [vehicleMileageAtTyreFitting] = " & txtMileageAtFitting.Text & ", [fittingStatusId] = " & cboFittingStatus.SelectedValue &
            ", [detFittedOnVehicle] = '" & rdDateFittedOnVehicle.SelectedDate & "', [fleetId] = '" & txtVehicleFleetID.Text & "', WHERE [serialNumber] = '" & txtSerialNumber.Text & "'"

        objCBO.ConnectionString = con

        Try
            objCBO.ExecuteDsQRY(qry)

            objCBO.MessageLabel(lblMsg, "Record saved successfully.", "Green")

        Catch ex As Exception
            objCBO.MessageLabel(lblMsg, "Error while saving record.", "Green")
        End Try


    End Sub



End Class