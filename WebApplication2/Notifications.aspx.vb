Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Telerik.Web.UI
Imports ClassLibrary1
Imports System.Data.SqlClient
Imports System.Data
Imports System.Data.SqlClient.SqlConnection
Imports Microsoft.VisualBasic
Imports System.Configuration
Imports System.IO

Public Class Notifications
    Inherits System.Web.UI.Page

    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString
    Public Shared Sub ShowToastr(ByVal page As Page)
        'page.ClientScript.RegisterStartupScript(page.GetType(), "Popup", "$('#modal-form').modal.('show')", True)

        'page.ClientScript.RegisterStartupScript(page.GetType(), "randomText", "$(window).load(function() {$('#modal-form').modal('show');});", True)
        'page.ClientScript.RegisterStartupScript(page.GetType(), "script", "openpopup();", True)
        page.ClientScript.RegisterStartupScript(page.GetType(), "randomText", "$(document).ready(function () {$('#modal-form').modal('show');});", True)
        page.ClientScript.RegisterStartupScript(page.GetType(), "script", "openpopup();", True)

    End Sub
    Public Sub ErrorMessage(ByVal Control As UI.Control, ByVal Message As String, Optional ByVal Title As String = "Alert", Optional ByVal callback As String = "")
        Try
            ScriptManager.RegisterStartupScript(Control, Control.GetType, "Script", "swal('" + Title + "','" + Message + "','success');", True)
        Catch ex As Exception
        End Try
    End Sub
    Public Shared Sub ShowAlert(ByVal page As Page)
        'page.ClientScript.RegisterStartupScript(page.GetType(), "Popup", "$('#modal-form').modal.('show')", True)

        'page.ClientScript.RegisterStartupScript(page.GetType(), "randomText", "$(window).load(function() {$('#modal-form').modal('show');});", True)
        'page.ClientScript.RegisterStartupScript(page.GetType(), "script", "openpopup();", True)
        page.ClientScript.RegisterStartupScript(page.GetType(), "randomText", "material.showSwal('success-message')", True)


    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Page.ClientScript.RegisterClientScriptInclude("jQuery", "https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js")
        Page.ClientScript.RegisterClientScriptInclude("jQuery", "https://code.jquery.com/jquery-3.6.0.js")
        Page.ClientScript.RegisterClientScriptInclude("jQuery", "/assets/js/core/bootstrap.min.js")
        Page.ClientScript.RegisterClientScriptInclude("jQuery", "https://unpkg.com/sweetalert/dist/sweetalert.min.js")

        If Not IsPostBack Then
            loadExistingVehicleData()
            VehicleData()
            'ShowToastr(Me.Page)
            'Page.ClientScript.RegisterStartupScript(Page.GetType(), "randomText", "$(document).ready(function () {$('#modal-form').modal('show');});", True)
            'Page.ClientScript.RegisterStartupScript(Page.GetType(), "script", "openpopup();", True)

            If Not IsNothing(Request.QueryString("op")) Then
                loadExistingVehicleData()
                VehicleData()
            End If

        End If
        If IsPostBack Then
            'ShowToastr(Me.Page)
            'ShowToastr(Me.Page)
            'Page.ClientScript.RegisterStartupScript(Page.GetType(), "randomText", " Sys.Application.add_load(function () {$('#modal-form').modal('show');});", True)

        End If
        Try


        Catch ex As Exception

        End Try

    End Sub


    Private Sub loadExistingVehicleData()
        Try

            Dim sql As String = "SELECT        COUNT(FLEETID) AS Count
FROM            dbo.tblZBC
WHERE        (DATEDIFF(month, GETDATE(), DATEEXPIRY) = 1) OR
                         (DATEDIFF(month, GETDATE(), DATEEXPIRY) = 0)"
            obj.ConnectionString = con


            Try
                Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
                db.ExecuteDataSet(CommandType.Text, sql)
                Dim dt As DataTable = ds.Tables(0)
                txtlab.Text = dt.Rows(0).Item("Count")

            Catch ex As Exception
                'log.Error(ex)
            End Try
        Catch ex As Exception

        End Try
        Try

            Dim sql As String = "SELECT        COUNT(FLEETID) AS Count
FROM            dbo.tblCOF
WHERE        (DATEDIFF(month, GETDATE(), DATEEXPIRY) = 1) OR
                         (DATEDIFF(month, GETDATE(), DATEEXPIRY) = 0)"
            obj.ConnectionString = con


            Try
                Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
                db.ExecuteDataSet(CommandType.Text, sql)
                Dim dt As DataTable = ds.Tables(0)
                txtcof.Text = dt.Rows(0).Item("Count")

            Catch ex As Exception
                'log.Error(ex)
            End Try
        Catch ex As Exception

        End Try
        Try

            Dim sql As String = "SELECT        COUNT(FLEETID) AS Count
FROM            dbo.tblZBC
WHERE        (DATEDIFF(month, GETDATE(), DATEEXPIRY) = 1) OR
                         (DATEDIFF(month, GETDATE(), DATEEXPIRY) = 0)"
            obj.ConnectionString = con


            Try
                Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
                db.ExecuteDataSet(CommandType.Text, sql)
                Dim dt As DataTable = ds.Tables(0)
                txtlab.Text = dt.Rows(0).Item("Count")

            Catch ex As Exception
                'log.Error(ex)
            End Try
        Catch ex As Exception

        End Try

        Try

            Dim sql As String = "SELECT        COUNT(FLEETID) AS Count
FROM            dbo.tblZINARA
WHERE        (DATEDIFF(month, GETDATE(), DATEEXPIRY) = 1) OR
                         (DATEDIFF(month, GETDATE(), DATEEXPIRY) = 0)"
            obj.ConnectionString = con


            Try
                Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
                db.ExecuteDataSet(CommandType.Text, sql)
                Dim dt As DataTable = ds.Tables(0)
                lblzina.Text = dt.Rows(0).Item("Count")

            Catch ex As Exception
                'log.Error(ex)
            End Try
        Catch ex As Exception

        End Try
        Try

            Dim sql As String = "SELECT        COUNT(FLEETID) AS Count
FROM            dbo.tblLICENCE
WHERE        (DATEDIFF(month, GETDATE(), DATEEXPIRY) = 1) OR
                         (DATEDIFF(month, GETDATE(), DATEEXPIRY) = 0)"
            obj.ConnectionString = con


            Try
                Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
                db.ExecuteDataSet(CommandType.Text, sql)
                Dim dt As DataTable = ds.Tables(0)
                txtins.Text = dt.Rows(0).Item("Count")

            Catch ex As Exception
                'log.Error(ex)
            End Try
        Catch ex As Exception

        End Try

        Try

            Dim sql As String = "SELECT        COUNT(FLEETID) AS Count
FROM            dbo.tblROUTE
WHERE        (DATEDIFF(month, GETDATE(), DATEEXPIRY) = 1) OR
                         (DATEDIFF(month, GETDATE(), DATEEXPIRY) = 0)"
            obj.ConnectionString = con


            Try
                Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
                db.ExecuteDataSet(CommandType.Text, sql)
                Dim dt As DataTable = ds.Tables(0)
                txtrute.Text = dt.Rows(0).Item("Count")

            Catch ex As Exception
                'log.Error(ex)
            End Try
        Catch ex As Exception

        End Try
        Try

            Dim sql As String = "SELECT        COUNT(FLEETID) AS Count
FROM            dbo.tblABL
WHERE        (DATEDIFF(month, GETDATE(), DATEEXPIRY) = 1) OR
                         (DATEDIFF(month, GETDATE(), DATEEXPIRY) = 0)"
            obj.ConnectionString = con


            Try
                Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
                db.ExecuteDataSet(CommandType.Text, sql)
                Dim dt As DataTable = ds.Tables(0)
                txtabl.Text = dt.Rows(0).Item("Count")

            Catch ex As Exception
                'log.Error(ex)
            End Try
        Catch ex As Exception

        End Try
        Try

            Dim sql As String = "SELECT        COUNT(FLEETID) AS Count
FROM            dbo.tblSANDANDGRAVEL
WHERE        (DATEDIFF(month, GETDATE(), DATEEXPIRY) = 1) OR
                         (DATEDIFF(month, GETDATE(), DATEEXPIRY) = 0)"
            obj.ConnectionString = con


            Try
                Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
                db.ExecuteDataSet(CommandType.Text, sql)
                Dim dt As DataTable = ds.Tables(0)
                txtsan.Text = dt.Rows(0).Item("Count")

            Catch ex As Exception
                'log.Error(ex)
            End Try
        Catch ex As Exception

        End Try
        Try

            Dim sql As String = "SELECT        COUNT(FLEETID) AS Count
FROM            dbo.tblGARAGE
WHERE        (DATEDIFF(month, GETDATE(), DATEEXPIRY) = 1) OR
                         (DATEDIFF(month, GETDATE(), DATEEXPIRY) = 0)"
            obj.ConnectionString = con


            Try
                Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
                db.ExecuteDataSet(CommandType.Text, sql)
                Dim dt As DataTable = ds.Tables(0)
                txtgra.Text = dt.Rows(0).Item("Count")

            Catch ex As Exception
                'log.Error(ex)
            End Try
        Catch ex As Exception

        End Try
        Try

            Dim sql As String = "SELECT        COUNT(FLEETID) AS Count
FROM            dbo.tblPASS
WHERE        (DATEDIFF(month, GETDATE(), DATEEXPIRY) = 1) OR
                         (DATEDIFF(month, GETDATE(), DATEEXPIRY) = 0)"
            obj.ConnectionString = con


            Try
                Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
                db.ExecuteDataSet(CommandType.Text, sql)
                Dim dt As DataTable = ds.Tables(0)
                txtpass.Text = dt.Rows(0).Item("Count")

            Catch ex As Exception
                'log.Error(ex)
            End Try
        Catch ex As Exception

        End Try

        Try

            Dim sql As String = "SELECT COUNT ([PersonnelNumber]) AS Count

  FROM [AXDB].[dbo].[vwUpdateDrivers]

  where  NOT FitnessStatus = 'Completely Fit'"
            obj.ConnectionString = con


            Try
                Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
                db.ExecuteDataSet(CommandType.Text, sql)
                Dim dt As DataTable = ds.Tables(0)
                txtres.Text = dt.Rows(0).Item("Count")

            Catch ex As Exception
                'log.Error(ex)
            End Try
        Catch ex As Exception

        End Try

        Try

            Dim sql As String = "SELECT    COUNT(PersonnelNumber) AS Count FROM            dbo.vwUpdateDrivers
WHERE        (DATEDIFF(month, GETDATE(), DDC) = 1) OR
                         (DATEDIFF(month, GETDATE(), DDC) = 0) OR
                         (DATEDIFF(month, GETDATE(), DDC) IS NULL)"
            obj.ConnectionString = con


            Try
                Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
                db.ExecuteDataSet(CommandType.Text, sql)
                Dim dt As DataTable = ds.Tables(0)
                ddc.Text = dt.Rows(0).Item("Count")

            Catch ex As Exception
                'log.Error(ex)
            End Try
        Catch ex As Exception

        End Try
        Try

            Dim sql As String = "
						 SELECT        COUNT(PersonnelNumber) AS Count
FROM            dbo.vwUpdateDrivers
WHERE        (DATEDIFF(month, GETDATE(), [MED-MIM]) = 1) OR
                         (DATEDIFF(month, GETDATE(), [MED-MIM]) = 0) OR
                         (DATEDIFF(month, GETDATE(), [MED-MIM]) IS NULL)"
            obj.ConnectionString = con


            Try
                Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
                db.ExecuteDataSet(CommandType.Text, sql)
                Dim dt As DataTable = ds.Tables(0)
                mmm.Text = dt.Rows(0).Item("Count")

            Catch ex As Exception
                'log.Error(ex)
            End Try
        Catch ex As Exception

        End Try
        Try

            Dim sql As String = "
						 SELECT        COUNT(PersonnelNumber) AS Count
FROM            dbo.vwUpdateDrivers
WHERE        (DATEDIFF(month, GETDATE(), [MED-GOV]) = 1) OR
                         (DATEDIFF(month, GETDATE(), [MED-GOV]) = 0) OR
                         (DATEDIFF(month, GETDATE(), [MED-GOV]) IS NULL)"
            obj.ConnectionString = con


            Try
                Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
                db.ExecuteDataSet(CommandType.Text, sql)
                Dim dt As DataTable = ds.Tables(0)
                mmgov.Text = dt.Rows(0).Item("Count")

            Catch ex As Exception
                'log.Error(ex)
            End Try
        Catch ex As Exception

        End Try

        Try

            Dim sql As String = "					 SELECT        COUNT(PersonnelNumber) AS Count
FROM            dbo.vwUpdateDrivers
WHERE        (DATEDIFF(month, GETDATE(), RETEST) = 1) OR
                         (DATEDIFF(month, GETDATE(), RETEST) = 0) OR
                         (DATEDIFF(month, GETDATE(), RETEST) IS NULL)"
            obj.ConnectionString = con


            Try
                Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
                db.ExecuteDataSet(CommandType.Text, sql)
                Dim dt As DataTable = ds.Tables(0)
                test.Text = dt.Rows(0).Item("Count")

            Catch ex As Exception
                'log.Error(ex)
            End Try
        Catch ex As Exception

        End Try
        Try

            Dim sql As String = "SELECT        COUNT(FLEETID) AS Count
FROM            dbo.tblQUARTINSP
WHERE        (DATEDIFF(month, NEXTDATE, DATE) = 0)"
            obj.ConnectionString = con


            Try
                Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
                db.ExecuteDataSet(CommandType.Text, sql)
                Dim dt As DataTable = ds.Tables(0)
                txt.Text = dt.Rows(0).Item("Count")

            Catch ex As Exception
                'log.Error(ex)
            End Try
        Catch ex As Exception

        End Try
        Try

            Dim sql As String = "SELECT        COUNT(FLEETID) AS Count
FROM            dbo.tblMORNINSPECTIONS
WHERE        (DATEDIFF(day, DATE, GETDATE()) < 0)"
            obj.ConnectionString = con


            Try
                Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
                db.ExecuteDataSet(CommandType.Text, sql)
                Dim dt As DataTable = ds.Tables(0)
                mn.Text = dt.Rows(0).Item("Count")

            Catch ex As Exception
                'log.Error(ex
            End Try
        Catch ex As Exception

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
        Response.Redirect("~/PassengerInsurance.aspx")
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
    Protected Sub bud(sender As Object, e As EventArgs)


    End Sub



    Protected Sub garage(sender As Object, e As EventArgs)

        Response.Redirect("~/VehicleLicence.aspx")
    End Sub

    Protected Sub Details(sender As Object, e As EventArgs)

        Response.Redirect("~/Details.aspx")
    End Sub
    Private Sub VehicleData()
        Dim sql As String = "SELECT     A.OBJECTID, dbo.ENTASSETOBJECTTYPE.NAME AS TYPE, dbo.ENTASSETPRODUCT.DESCRIPTION AS PRODUCT_NAME_MAKE, dbo.ENTASSETMODEL.DESCRIPTION AS MODEL, A.NAME, A.NOTES, B.LOCATION, 
                  dbo.ENTASSETFUNCTIONALLOCATION.LOGISTICSLOCATION, dbo.ENTASSETFUNCTIONALLOCATION.NAME AS FunctionalLocationName, dbo.ENTASSETFUNCTIONALLOCATION.NOTES AS FunctionalLocationNotes, A.OBJECTACTIVE
                   FROM        dbo.ENTASSETOBJECTTABLE AS A LEFT OUTER JOIN
                  dbo.ENTASSETPRODUCT ON A.PRODUCT = dbo.ENTASSETPRODUCT.RECID LEFT OUTER JOIN
                  dbo.ENTASSETMODEL ON A.MODEL = dbo.ENTASSETMODEL.RECID LEFT OUTER JOIN
                  dbo.ENTASSETOBJECTTYPE ON A.OBJECTTYPE = dbo.ENTASSETOBJECTTYPE.RECID LEFT OUTER JOIN
                  dbo.ENTASSETFUNCTIONALLOCATION ON A.FUNCTIONALLOCATION = dbo.ENTASSETFUNCTIONALLOCATION.RECID LEFT OUTER JOIN
                  dbo.ENTASSETOBJECTLIFECYCLEMODELSTATE ON A.OBJECTLIFECYCLESTATE = dbo.ENTASSETOBJECTLIFECYCLEMODELSTATE.RECID LEFT OUTER JOIN
                  dbo.LOGISTICSPOSTALADDRESS AS B ON A.LOGISTICSLOCATION = B.LOCATION
                  WHERE (dbo.ENTASSETOBJECTTYPE.NAME = N'Bus' OR
                  dbo.ENTASSETOBJECTTYPE.NAME = N'Earth Moving Vehicle' OR
                  dbo.ENTASSETOBJECTTYPE.NAME = N'Forklift' OR
                  dbo.ENTASSETOBJECTTYPE.NAME = N'Heavy Motor Vehicle' OR
                  dbo.ENTASSETOBJECTTYPE.NAME = N'Inspection Vehicle' OR
                  dbo.ENTASSETOBJECTTYPE.NAME = N'Light Motor Vehicle' OR
                  dbo.ENTASSETOBJECTTYPE.NAME = N'Personal Alc Vehicle' OR
                  dbo.ENTASSETOBJECTTYPE.NAME = N'Rig' OR
                  dbo.ENTASSETOBJECTTYPE.NAME = N'Tractor' OR
                  dbo.ENTASSETOBJECTTYPE.NAME = N'Trailer' OR
                  dbo.ENTASSETOBJECTTYPE.NAME = N'Utility Vehicle') AND (A.OBJECTACTIVE = 1)"
        obj.ConnectionString = con

        'Dim myUser As New SecurityPolicy.UserManager(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)
        'Dim myAdmin As New AdminSettings(CookiesWrapper.thisConnectionName, 0)
        'Dim audit As New UserAudit(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            db.ExecuteDataSet(CommandType.Text, sql)

        Catch ex As Exception
            'log.Error(ex)
        End Try


    End Sub

    Protected Sub DownloadFile(sender As Object, e As EventArgs)
        Dim id As Integer = Integer.Parse(TryCast(sender, LinkButton).CommandArgument)
        Dim bytes As Byte()
        Dim fileName As String, contentType As String

        Dim Query As String = "SELECT * FROM tblABL WHERE ID = '" & id & "'"


        Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, Query)
        Dim dt As DataTable = ds.Tables(0)

        If dt.Rows.Count > 0 Then
            bytes = DirectCast(dt.Rows(0).Item("DATA"), Byte())
            contentType = dt.Rows(0).Item("CONTENTTYPE").ToString()
            fileName = dt.Rows(0).Item("FILE").ToString
            'bytes = DirectCast(sdr("Data"), Byte())
            'contentType = sdr("ContentType").ToString()
            'fileName = sdr("Name").ToString()
            Response.Clear()
            Response.Buffer = True
            Response.Charset = ""
            Response.Cache.SetCacheability(HttpCacheability.NoCache)
            Response.ContentType = contentType
            Response.AppendHeader("Content-Disposition", "attachment; filename=" + fileName)
            Response.BinaryWrite(bytes)
            Response.Flush()
            Response.End()
        End If


    End Sub

    Protected Sub Bulk_Insert(sender As Object, e As EventArgs)


        ErrorMessage(Me, "Saved", "Succesfully")
    End Sub

    Protected Sub LinkButton14_Click(sender As Object, e As EventArgs)
        Response.Redirect("~/ZBCNotifications.aspx")


    End Sub
End Class