
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Telerik.Web.UI
Imports ClassLibrary1
Imports System.Data.SqlClient
Imports System.Data
Imports System.Data.SqlClient.SqlConnection
Imports Microsoft.VisualBasic
Imports System.Configuration
Imports System.IO
Imports System.Windows.Forms

Public Class ZBCNOTIFICATIONS
    Inherits System.Web.UI.Page
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString
    Dim strConnection As String = "Data Source=BUILD-MIM-ONEBO;Initial Catalog=AXDB;Integrated Security=True"
    Dim objConnection As New SqlConnection(strConnection)
    Dim siteUrl As String = "http://mim-sp-app-01/"


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            loadData()

        End If
        Try

            gvCustomers.UseAccessibleHeader = True
            gvCustomers.HeaderRow.TableSection = TableRowSection.TableHeader
        Catch ex As Exception

        End Try
    End Sub

    Private Sub loadData()
        Dim sql As String = "SELECT        FLEETID, LICNUMBER, DATEEXPIRY, COMMENTS, DATEDIFF(month, GETDATE(), DATEEXPIRY) AS DATEDIFF, DATEDIFF(DAY, GETDATE(), DATEEXPIRY) AS DAYS
FROM            dbo.tblZBC
WHERE        (DATEDIFF(month, GETDATE(), DATEEXPIRY) = 1) OR
                         (DATEDIFF(month, GETDATE(), DATEEXPIRY) = 0)"
        obj.ConnectionString = con

        'Dim myUser As New SecurityPolicy.UserManager(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)
        'Dim myAdmin As New AdminSettings(CookiesWrapper.thisConnectionName, 0)
        'Dim audit As New UserAudit(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            db.ExecuteDataSet(CommandType.Text, sql)

            With gvCustomers
                Try
                    .DataSource = ds
                    .DataBind()
                Catch ex As Exception
                    '  log.Error(ex.Message)
                End Try
            End With

            For Each dr As GridViewRow In gvCustomers.Rows
                If dr.RowType = DataControlRowType.DataRow Then


                End If
            Next
        Catch ex As Exception
            'log.Error(ex)
        End Try

    End Sub


    Protected Sub Zinara(sender As Object, e As EventArgs)

        Response.Redirect("~/ZinaraLicence.aspx")
    End Sub
    Protected Sub Zbc(sender As Object, e As EventArgs)

        Response.Redirect("~/RadioLicence.aspx")
    End Sub
    Protected Sub cof(sender As Object, e As EventArgs)

        Response.Redirect("~/COF.aspx")
    End Sub

    Protected Sub san(sender As Object, e As EventArgs)

        Response.Redirect("~/SandGravelPermits.aspx")
    End Sub

    Protected Sub pas(sender As Object, e As EventArgs)

        Response.Redirect("~/SandGravelPermits.aspx")
    End Sub

    Protected Sub rute(sender As Object, e As EventArgs)

        Response.Redirect("~/RouteAuthority.aspx")
    End Sub

    Protected Sub abc(sender As Object, e As EventArgs)

        Response.Redirect("~/AbnormalLoad.aspx")
    End Sub
    Protected Sub drvlist(sender As Object, e As EventArgs)

        Response.Redirect("~/DriverList.aspx")
    End Sub

    Protected Sub drvrestrict(sender As Object, e As EventArgs)

        Response.Redirect("~/RestrictedDrivers.aspx")
    End Sub

    Protected Sub vehiclelist(sender As Object, e As EventArgs)

        Response.Redirect("~/VehicleList.aspx")
    End Sub

    Protected Sub triplist(sender As Object, e As EventArgs)

        Response.Redirect("~/VehicleLicence.aspx")
    End Sub

    Protected Sub bus(sender As Object, e As EventArgs)

        Response.Redirect("~/BusScheduling.aspx")
    End Sub


    Protected Sub garage(sender As Object, e As EventArgs)

        Response.Redirect("~/VehicleLicence.aspx")
    End Sub

    Protected Sub gvCustomers_Load(sender As Object, e As EventArgs)
        Try
            For Each dr As GridViewRow In gvCustomers.Rows
                If dr.RowType = DataControlRowType.DataRow Then
                    Dim chkRow As LinkButton = TryCast(dr.Cells(6).FindControl("lnkstat"), LinkButton)
                    Dim aa As Int32 = Convert.ToInt32(dr.Cells(5).Text)
                    If aa > 10 Then

                        chkRow.CssClass = "btn bg-gradient-warning"
                        chkRow.Text = " About to Expire"
                    Else
                        chkRow.CssClass = "btn bg-gradient-danger"
                        chkRow.Text = " Expired"

                    End If

                End If
            Next
        Catch ex As Exception

        End Try
    End Sub


End Class