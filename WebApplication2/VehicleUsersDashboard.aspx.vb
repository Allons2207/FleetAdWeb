Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Telerik.Web.UI

Public Class VehicleUsersDashboard
    Inherits System.Web.UI.Page
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        RadHtmlChart1.DataSource = UsersByAllocationStatus()
        RadHtmlChart1.DataBind()
        RadHtmlChart1.Legend.Appearance.Visible = True
    End Sub

    Private Function UsersByAllocationStatus() As DataTable

        Dim qry As String = "SELECT        dbo.tbl_allocationStatus.allocationStatus, COUNT(dbo.tbl_vehicleUsers.licenseNumber) AS NoOfVehicleUsers " &
                            " FROM  dbo.tbl_vehicleUsers INNER JOIN dbo.tbl_allocationStatus ON dbo.tbl_vehicleUsers.allocationStatusId = " &
                            " dbo.tbl_allocationStatus.allocationStatusId WHERE        (dbo.tbl_vehicleUsers.active = 1) " &
                            " GROUP BY dbo.tbl_allocationStatus.allocationStatus "

        obj.ConnectionString = con
        Dim ds As New DataSet("Vehicle")
        ds = obj.ExecuteDsQRY(qry)

        If ds.Tables(0).Rows.Count > 0 Then
            Return ds.Tables(0)
        Else
            Return Nothing
        End If

    End Function


End Class