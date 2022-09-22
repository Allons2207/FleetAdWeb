
Imports Microsoft.Practices.EnterpriseLibrary.Data
Public Class test
    Inherits System.Web.UI.Page
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        RadHtmlChart1.DataSource = loadAllocation()
        RadHtmlChart1.DataBind()
    End Sub


    Private Function loadAllocation() As DataTable
        Dim qry As String = "SELECT    dbo.tbl_allocationStatus.allocationStatus,     COUNT(dbo.tbl_vehicleData.fleetId) AS NumOfVehicles " &
                        " FROM   dbo.tbl_vehicleData INNER JOIN dbo.tbl_allocationStatus ON dbo.tbl_vehicleData.allocationStatusId " &
                        " = dbo.tbl_allocationStatus.allocationStatusId WHERE        (dbo.tbl_vehicleData.disposalStatusId = 0) " &
                        " Group BY dbo.tbl_allocationStatus.allocationStatus "

        obj.ConnectionString = con

        Dim ds As New DataSet("Allocation")
        ds = obj.ExecuteDsQRY(qry)

        If ds.Tables(0).Rows.Count > 0 Then
            Return ds.Tables(0)
        Else
            Return Nothing
        End If

    End Function
End Class