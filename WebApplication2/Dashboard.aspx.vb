Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Telerik.Web.UI
Imports ClassLibrary1
Imports System.Data.SqlClient
Imports System.Data
Imports System.Data.SqlClient.SqlConnection
Imports Microsoft.VisualBasic
Imports System.Configuration
Public Class Dashboard
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
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Page.ClientScript.RegisterClientScriptInclude("jQuery", "https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js")
        Page.ClientScript.RegisterClientScriptInclude("jQuery", "https://code.jquery.com/jquery-3.6.0.js")
        Page.ClientScript.RegisterClientScriptInclude("jQuery", "/assets/js/core/bootstrap.min.js")
        Page.ClientScript.RegisterClientScriptInclude("jQuery", "https://unpkg.com/sweetalert/dist/sweetalert.min.js")


        If (CokkiesWrapper.UserID <= 0 AndAlso Not IsNumeric(CokkiesWrapper.UserID)) Then
            Response.Redirect("../Login.aspx")
            Exit Sub
        End If
        If Not IsPostBack Then
            'loadExistingVehicleData()
            VehicleData()
            'ShowToastr(Me.Page)
            'Page.ClientScript.RegisterStartupScript(Page.GetType(), "randomText", "$(document).ready(function () {$('#modal-form').modal('show');});", True)
            'Page.ClientScript.RegisterStartupScript(Page.GetType(), "script", "openpopup();", True)

            If Not IsNothing(Request.QueryString("op")) Then
                'loadExistingVehicleData()
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


    Private Sub VehicleData()
        Try

            Dim sql As String = "SELECT        COUNT(H.PERSONNELNUMBER) AS EC
FROM            dbo.HCMWORKER AS H INNER JOIN
                         dbo.DIRPERSONNAME AS P ON H.PERSON = P.PERSON INNER JOIN
                         dbo.HCMPOSITIONENTITY AS HP ON H.RECID = HP.WORKER INNER JOIN
                         dbo.HCMJOBDETAIL AS HJ ON HP.JOB = HJ.JOB INNER JOIN
                         dbo.tblDRIVEREXTRA ON H.PERSONNELNUMBER = dbo.tblDRIVEREXTRA.PERSONELID"
            obj.ConnectionString = con

            'Dim myUser As New SecurityPolicy.UserManager(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)
            'Dim myAdmin As New AdminSettings(CookiesWrapper.thisConnectionName, 0)
            'Dim audit As New UserAudit(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)

            Try
                Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
                db.ExecuteDataSet(CommandType.Text, sql)
                Dim dt As DataTable = ds.Tables(0)
                status1.Attributes("countto") = dt.Rows(0).Item("EC").ToString
                Label1.Text = dt.Rows(0).Item("EC").ToString

            Catch ex As Exception
                'log.Error(ex)
            End Try
        Catch ex As Exception

        End Try

        Try

            Dim sql As String = "SELECT        COUNT(OBJECTID) AS Count
FROM            (SELECT        A.OBJECTID, dbo.ENTASSETOBJECTTYPE.NAME AS TYPE, dbo.ENTASSETPRODUCT.DESCRIPTION AS PRODUCT_NAME_MAKE, dbo.ENTASSETMODEL.DESCRIPTION AS MODEL, A.NAME, A.NOTES, 
                                                    B.LOCATION, dbo.ENTASSETFUNCTIONALLOCATION.LOGISTICSLOCATION, dbo.ENTASSETFUNCTIONALLOCATION.NAME AS FunctionalLocationName, 
                                                    dbo.ENTASSETFUNCTIONALLOCATION.NOTES AS FunctionalLocationNotes, A.OBJECTACTIVE, dbo.ENTASSETFUNCTIONALLOCATION.FUNCTIONALLOCATIONID
                          FROM            dbo.ENTASSETOBJECTTABLE AS A LEFT OUTER JOIN
                                                    dbo.ENTASSETPRODUCT ON A.PRODUCT = dbo.ENTASSETPRODUCT.RECID LEFT OUTER JOIN
                                                    dbo.ENTASSETMODEL ON A.MODEL = dbo.ENTASSETMODEL.RECID LEFT OUTER JOIN
                                                    dbo.ENTASSETOBJECTTYPE ON A.OBJECTTYPE = dbo.ENTASSETOBJECTTYPE.RECID LEFT OUTER JOIN
                                                    dbo.ENTASSETFUNCTIONALLOCATION ON A.FUNCTIONALLOCATION = dbo.ENTASSETFUNCTIONALLOCATION.RECID LEFT OUTER JOIN
                                                    dbo.ENTASSETOBJECTLIFECYCLEMODELSTATE ON A.OBJECTLIFECYCLESTATE = dbo.ENTASSETOBJECTLIFECYCLEMODELSTATE.RECID LEFT OUTER JOIN
                                                    dbo.LOGISTICSPOSTALADDRESS AS B ON A.LOGISTICSLOCATION = B.LOCATION
                          WHERE        (dbo.ENTASSETFUNCTIONALLOCATION.FUNCTIONALLOCATIONID = N'A650') OR
                                                    (dbo.ENTASSETFUNCTIONALLOCATION.FUNCTIONALLOCATIONID = N'E850') OR
                                                    (dbo.ENTASSETFUNCTIONALLOCATION.FUNCTIONALLOCATIONID = N'H705') OR
                                                    (dbo.ENTASSETFUNCTIONALLOCATION.FUNCTIONALLOCATIONID = N'E880')) AS derivedtbl_1"
            obj.ConnectionString = con

            'Dim myUser As New SecurityPolicy.UserManager(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)
            'Dim myAdmin As New AdminSettings(CookiesWrapper.thisConnectionName, 0)
            'Dim audit As New UserAudit(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)

            Try
                Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
                db.ExecuteDataSet(CommandType.Text, sql)
                Dim dt As DataTable = ds.Tables(0)

                Label2.Text = dt.Rows(0).Item("Count").ToString


            Catch ex As Exception
                'log.Error(ex)
            End Try
        Catch ex As Exception

        End Try
        Try

            Dim sql As String = "SELECT        COUNT(OBJECTID) AS Count
FROM            (SELECT        A.OBJECTID, dbo.ENTASSETOBJECTTYPE.NAME AS TYPE, dbo.ENTASSETPRODUCT.DESCRIPTION AS PRODUCT_NAME_MAKE, dbo.ENTASSETMODEL.DESCRIPTION AS MODEL, A.NAME, A.NOTES, 
                                                    B.LOCATION, dbo.ENTASSETFUNCTIONALLOCATION.LOGISTICSLOCATION, dbo.ENTASSETFUNCTIONALLOCATION.NAME AS FunctionalLocationName, 
                                                    dbo.ENTASSETFUNCTIONALLOCATION.NOTES AS FunctionalLocationNotes, A.OBJECTACTIVE, dbo.ENTASSETFUNCTIONALLOCATION.FUNCTIONALLOCATIONID
                          FROM            dbo.ENTASSETOBJECTTABLE AS A LEFT OUTER JOIN
                                                    dbo.ENTASSETPRODUCT ON A.PRODUCT = dbo.ENTASSETPRODUCT.RECID LEFT OUTER JOIN
                                                    dbo.ENTASSETMODEL ON A.MODEL = dbo.ENTASSETMODEL.RECID LEFT OUTER JOIN
                                                    dbo.ENTASSETOBJECTTYPE ON A.OBJECTTYPE = dbo.ENTASSETOBJECTTYPE.RECID LEFT OUTER JOIN
                                                    dbo.ENTASSETFUNCTIONALLOCATION ON A.FUNCTIONALLOCATION = dbo.ENTASSETFUNCTIONALLOCATION.RECID LEFT OUTER JOIN
                                                    dbo.ENTASSETOBJECTLIFECYCLEMODELSTATE ON A.OBJECTLIFECYCLESTATE = dbo.ENTASSETOBJECTLIFECYCLEMODELSTATE.RECID LEFT OUTER JOIN
                                                    dbo.LOGISTICSPOSTALADDRESS AS B ON A.LOGISTICSLOCATION = B.LOCATION
                          WHERE       
                                                    (dbo.ENTASSETFUNCTIONALLOCATION.FUNCTIONALLOCATIONID = N'E850')
                                                    ) AS derivedtbl_1"
            obj.ConnectionString = con

            'Dim myUser As New SecurityPolicy.UserManager(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)
            'Dim myAdmin As New AdminSettings(CookiesWrapper.thisConnectionName, 0)
            'Dim audit As New UserAudit(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)

            Try
                Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
                db.ExecuteDataSet(CommandType.Text, sql)
                Dim dt As DataTable = ds.Tables(0)

                lblpool.Text = "Pool:" + " " + dt.Rows(0).Item("Count").ToString


            Catch ex As Exception
                'log.Error(ex)
            End Try
        Catch ex As Exception

        End Try

        Try

            Dim sql As String = "SELECT        COUNT(OBJECTID) AS Count
FROM            (SELECT        A.OBJECTID, dbo.ENTASSETOBJECTTYPE.NAME AS TYPE, dbo.ENTASSETPRODUCT.DESCRIPTION AS PRODUCT_NAME_MAKE, dbo.ENTASSETMODEL.DESCRIPTION AS MODEL, A.NAME, A.NOTES, 
                                                    B.LOCATION, dbo.ENTASSETFUNCTIONALLOCATION.LOGISTICSLOCATION, dbo.ENTASSETFUNCTIONALLOCATION.NAME AS FunctionalLocationName, 
                                                    dbo.ENTASSETFUNCTIONALLOCATION.NOTES AS FunctionalLocationNotes, A.OBJECTACTIVE, dbo.ENTASSETFUNCTIONALLOCATION.FUNCTIONALLOCATIONID
                          FROM            dbo.ENTASSETOBJECTTABLE AS A LEFT OUTER JOIN
                                                    dbo.ENTASSETPRODUCT ON A.PRODUCT = dbo.ENTASSETPRODUCT.RECID LEFT OUTER JOIN
                                                    dbo.ENTASSETMODEL ON A.MODEL = dbo.ENTASSETMODEL.RECID LEFT OUTER JOIN
                                                    dbo.ENTASSETOBJECTTYPE ON A.OBJECTTYPE = dbo.ENTASSETOBJECTTYPE.RECID LEFT OUTER JOIN
                                                    dbo.ENTASSETFUNCTIONALLOCATION ON A.FUNCTIONALLOCATION = dbo.ENTASSETFUNCTIONALLOCATION.RECID LEFT OUTER JOIN
                                                    dbo.ENTASSETOBJECTLIFECYCLEMODELSTATE ON A.OBJECTLIFECYCLESTATE = dbo.ENTASSETOBJECTLIFECYCLEMODELSTATE.RECID LEFT OUTER JOIN
                                                    dbo.LOGISTICSPOSTALADDRESS AS B ON A.LOGISTICSLOCATION = B.LOCATION
                          WHERE       
                                                    (dbo.ENTASSETFUNCTIONALLOCATION.FUNCTIONALLOCATIONID = N'H705')) AS derivedtbl_1"
            obj.ConnectionString = con

            'Dim myUser As New SecurityPolicy.UserManager(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)
            'Dim myAdmin As New AdminSettings(CookiesWrapper.thisConnectionName, 0)
            'Dim audit As New UserAudit(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)

            Try
                Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
                db.ExecuteDataSet(CommandType.Text, sql)
                Dim dt As DataTable = ds.Tables(0)

                lblbus.Text = "Buses:" + " " + dt.Rows(0).Item("Count").ToString


            Catch ex As Exception
                'log.Error(ex)
            End Try
        Catch ex As Exception

        End Try

        Try

            Dim sql As String = "SELECT        COUNT(OBJECTID) AS Count
FROM            (SELECT        A.OBJECTID, dbo.ENTASSETOBJECTTYPE.NAME AS TYPE, dbo.ENTASSETPRODUCT.DESCRIPTION AS PRODUCT_NAME_MAKE, dbo.ENTASSETMODEL.DESCRIPTION AS MODEL, A.NAME, A.NOTES, 
                                                    B.LOCATION, dbo.ENTASSETFUNCTIONALLOCATION.LOGISTICSLOCATION, dbo.ENTASSETFUNCTIONALLOCATION.NAME AS FunctionalLocationName, 
                                                    dbo.ENTASSETFUNCTIONALLOCATION.NOTES AS FunctionalLocationNotes, A.OBJECTACTIVE, dbo.ENTASSETFUNCTIONALLOCATION.FUNCTIONALLOCATIONID
                          FROM            dbo.ENTASSETOBJECTTABLE AS A LEFT OUTER JOIN
                                                    dbo.ENTASSETPRODUCT ON A.PRODUCT = dbo.ENTASSETPRODUCT.RECID LEFT OUTER JOIN
                                                    dbo.ENTASSETMODEL ON A.MODEL = dbo.ENTASSETMODEL.RECID LEFT OUTER JOIN
                                                    dbo.ENTASSETOBJECTTYPE ON A.OBJECTTYPE = dbo.ENTASSETOBJECTTYPE.RECID LEFT OUTER JOIN
                                                    dbo.ENTASSETFUNCTIONALLOCATION ON A.FUNCTIONALLOCATION = dbo.ENTASSETFUNCTIONALLOCATION.RECID LEFT OUTER JOIN
                                                    dbo.ENTASSETOBJECTLIFECYCLEMODELSTATE ON A.OBJECTLIFECYCLESTATE = dbo.ENTASSETOBJECTLIFECYCLEMODELSTATE.RECID LEFT OUTER JOIN
                                                    dbo.LOGISTICSPOSTALADDRESS AS B ON A.LOGISTICSLOCATION = B.LOCATION
                          WHERE        (dbo.ENTASSETFUNCTIONALLOCATION.FUNCTIONALLOCATIONID = N'A650') 
                                                  ) AS derivedtbl_1"
            obj.ConnectionString = con

            'Dim myUser As New SecurityPolicy.UserManager(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)
            'Dim myAdmin As New AdminSettings(CookiesWrapper.thisConnectionName, 0)
            'Dim audit As New UserAudit(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)

            Try
                Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
                db.ExecuteDataSet(CommandType.Text, sql)
                Dim dt As DataTable = ds.Tables(0)

                lblpav.Text = "PAVS:" + " " + dt.Rows(0).Item("Count").ToString


            Catch ex As Exception
                'log.Error(ex)
            End Try
        Catch ex As Exception

        End Try

        Try

            Dim sql As String = "SELECT        COUNT(OBJECTID) AS Count
FROM            (SELECT        A.OBJECTID, dbo.ENTASSETOBJECTTYPE.NAME AS TYPE, dbo.ENTASSETPRODUCT.DESCRIPTION AS PRODUCT_NAME_MAKE, dbo.ENTASSETMODEL.DESCRIPTION AS MODEL, A.NAME, A.NOTES, 
                                                    B.LOCATION, dbo.ENTASSETFUNCTIONALLOCATION.LOGISTICSLOCATION, dbo.ENTASSETFUNCTIONALLOCATION.NAME AS FunctionalLocationName, 
                                                    dbo.ENTASSETFUNCTIONALLOCATION.NOTES AS FunctionalLocationNotes, A.OBJECTACTIVE, dbo.ENTASSETFUNCTIONALLOCATION.FUNCTIONALLOCATIONID
                          FROM            dbo.ENTASSETOBJECTTABLE AS A LEFT OUTER JOIN
                                                    dbo.ENTASSETPRODUCT ON A.PRODUCT = dbo.ENTASSETPRODUCT.RECID LEFT OUTER JOIN
                                                    dbo.ENTASSETMODEL ON A.MODEL = dbo.ENTASSETMODEL.RECID LEFT OUTER JOIN
                                                    dbo.ENTASSETOBJECTTYPE ON A.OBJECTTYPE = dbo.ENTASSETOBJECTTYPE.RECID LEFT OUTER JOIN
                                                    dbo.ENTASSETFUNCTIONALLOCATION ON A.FUNCTIONALLOCATION = dbo.ENTASSETFUNCTIONALLOCATION.RECID LEFT OUTER JOIN
                                                    dbo.ENTASSETOBJECTLIFECYCLEMODELSTATE ON A.OBJECTLIFECYCLESTATE = dbo.ENTASSETOBJECTLIFECYCLEMODELSTATE.RECID LEFT OUTER JOIN
                                                    dbo.LOGISTICSPOSTALADDRESS AS B ON A.LOGISTICSLOCATION = B.LOCATION
                          WHERE      
                                                    (dbo.ENTASSETFUNCTIONALLOCATION.FUNCTIONALLOCATIONID = N'E880')) AS derivedtbl_1"
            obj.ConnectionString = con

            'Dim myUser As New SecurityPolicy.UserManager(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)
            'Dim myAdmin As New AdminSettings(CookiesWrapper.thisConnectionName, 0)
            'Dim audit As New UserAudit(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)

            Try
                Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
                db.ExecuteDataSet(CommandType.Text, sql)
                Dim dt As DataTable = ds.Tables(0)

                lblsurface.Text = "Surface Equipment:" + " " + dt.Rows(0).Item("Count").ToString


            Catch ex As Exception
                'log.Error(ex)
            End Try
        Catch ex As Exception

        End Try
        Try

            Dim sql As String = "SELECT        COUNT(OBJECTID) AS Count
FROM            (SELECT        A.OBJECTID, dbo.ENTASSETOBJECTTYPE.NAME AS TYPE, dbo.ENTASSETPRODUCT.DESCRIPTION AS PRODUCT_NAME_MAKE, dbo.ENTASSETMODEL.DESCRIPTION AS MODEL, A.NAME, A.NOTES, 
                                                    B.LOCATION, dbo.ENTASSETFUNCTIONALLOCATION.LOGISTICSLOCATION, dbo.ENTASSETFUNCTIONALLOCATION.NAME AS FunctionalLocationName, 
                                                    dbo.ENTASSETFUNCTIONALLOCATION.NOTES AS FunctionalLocationNotes, A.OBJECTACTIVE, dbo.ENTASSETFUNCTIONALLOCATION.FUNCTIONALLOCATIONID
                          FROM            dbo.ENTASSETOBJECTTABLE AS A LEFT OUTER JOIN
                                                    dbo.ENTASSETPRODUCT ON A.PRODUCT = dbo.ENTASSETPRODUCT.RECID LEFT OUTER JOIN
                                                    dbo.ENTASSETMODEL ON A.MODEL = dbo.ENTASSETMODEL.RECID LEFT OUTER JOIN
                                                    dbo.ENTASSETOBJECTTYPE ON A.OBJECTTYPE = dbo.ENTASSETOBJECTTYPE.RECID LEFT OUTER JOIN
                                                    dbo.ENTASSETFUNCTIONALLOCATION ON A.FUNCTIONALLOCATION = dbo.ENTASSETFUNCTIONALLOCATION.RECID LEFT OUTER JOIN
                                                    dbo.ENTASSETOBJECTLIFECYCLEMODELSTATE ON A.OBJECTLIFECYCLESTATE = dbo.ENTASSETOBJECTLIFECYCLEMODELSTATE.RECID LEFT OUTER JOIN
                                                    dbo.LOGISTICSPOSTALADDRESS AS B ON A.LOGISTICSLOCATION = B.LOCATION
                          WHERE      
                                                    (dbo.ENTASSETFUNCTIONALLOCATION.FUNCTIONALLOCATIONID = N'E880')) AS derivedtbl_1"
            obj.ConnectionString = con

            'Dim myUser As New SecurityPolicy.UserManager(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)
            'Dim myAdmin As New AdminSettings(CookiesWrapper.thisConnectionName, 0)
            'Dim audit As New UserAudit(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)

            Try
                Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
                db.ExecuteDataSet(CommandType.Text, sql)
                Dim dt As DataTable = ds.Tables(0)

                lblsurface.Text = "Surface Equipment:" + " " + dt.Rows(0).Item("Count").ToString


            Catch ex As Exception
                'log.Error(ex)
            End Try
        Catch ex As Exception

        End Try
        Try

            Dim sql As String = "SELECT        COUNT(PERSONNELNUMBER) AS Count
FROM            (SELECT        w.PERSONNELNUMBER, e.FIRSTNAME, e.LASTNAME, p.DESCRIPTION, t.TRUSTEDPOSTIONDESCRIPTION AS DriverCategory, t.EMPLOYER AS Employer, 
                                                    CASE FITNESSSTATUS WHEN 0 THEN 'Completely Fit' WHEN 4 THEN 'Fit for administration' WHEN 5 THEN 'Fit but bad eyesight' WHEN 7 THEN 'Fit but bad speech' WHEN 6 THEN 'Fit but bad hearing'
                                                     WHEN 2 THEN 'Temporary unfit' WHEN 3 THEN 'Not rated' ELSE 'Unfit' END AS Fitness, 
                                                    CASE OUTCOME WHEN 0 THEN 'Special Leave' WHEN 1 THEN 'Sick Leave' WHEN 3 THEN 'Termination' WHEN 2 THEN 'Transfer' WHEN 4 THEN 'Nothing' END AS Outcome, 
                                                    pe.DESCRIPTION AS [Licence/Certificate], pe.TODATE, pe.PERMITGROUP, pe.OHSPERMITTYPE_PERMITTYPEID, pe.OHSPERMITGROUP_PERMITGROUPID
                          FROM            dbo.HCMWORKER AS w INNER JOIN
                                                    dbo.DIRPERSONENTITY AS e ON w.PERSON = e.RECID INNER JOIN
                                                    dbo.HCMPERSONTRUSTEDPOSITION AS t ON w.PERSON = t.PERSON LEFT OUTER JOIN
                                                    dbo.HCMPOSITIONENTITY AS p ON w.RECID = p.WORKER LEFT OUTER JOIN
                                                    dbo.OHSFITNESS AS f ON w.RECID = f.WORKER LEFT OUTER JOIN
                                                    dbo.OHSWORKERPERMITLNK AS l ON w.RECID = l.WORKER LEFT OUTER JOIN
                                                    dbo.OHSPERMITSENTITY AS pe ON l.PERMIT = pe.RECID
                          WHERE        (t.TRUSTEDPOSTIONDESCRIPTION LIKE '%driver%')) AS derivedtbl_1
WHERE        (DriverCategory = 'Pool Driver Executive')"
            obj.ConnectionString = con

            'Dim myUser As New SecurityPolicy.UserManager(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)
            'Dim myAdmin As New AdminSettings(CookiesWrapper.thisConnectionName, 0)
            'Dim audit As New UserAudit(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)

            Try
                Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
                db.ExecuteDataSet(CommandType.Text, sql)
                Dim dt As DataTable = ds.Tables(0)

                lblpoolex.Text = "Pool Driver Executive: " + " " + dt.Rows(0).Item("Count").ToString


            Catch ex As Exception
                'log.Error(ex)
            End Try
        Catch ex As Exception

        End Try
        Try

            Dim sql As String = "SELECT        COUNT(PERSONNELNUMBER) AS Count
FROM            (SELECT        w.PERSONNELNUMBER, e.FIRSTNAME, e.LASTNAME, p.DESCRIPTION, t.TRUSTEDPOSTIONDESCRIPTION AS DriverCategory, t.EMPLOYER AS Employer, 
                                                    CASE FITNESSSTATUS WHEN 0 THEN 'Completely Fit' WHEN 4 THEN 'Fit for administration' WHEN 5 THEN 'Fit but bad eyesight' WHEN 7 THEN 'Fit but bad speech' WHEN 6 THEN 'Fit but bad hearing'
                                                     WHEN 2 THEN 'Temporary unfit' WHEN 3 THEN 'Not rated' ELSE 'Unfit' END AS Fitness, 
                                                    CASE OUTCOME WHEN 0 THEN 'Special Leave' WHEN 1 THEN 'Sick Leave' WHEN 3 THEN 'Termination' WHEN 2 THEN 'Transfer' WHEN 4 THEN 'Nothing' END AS Outcome, 
                                                    pe.DESCRIPTION AS [Licence/Certificate], pe.TODATE, pe.PERMITGROUP, pe.OHSPERMITTYPE_PERMITTYPEID, pe.OHSPERMITGROUP_PERMITGROUPID
                          FROM            dbo.HCMWORKER AS w INNER JOIN
                                                    dbo.DIRPERSONENTITY AS e ON w.PERSON = e.RECID INNER JOIN
                                                    dbo.HCMPERSONTRUSTEDPOSITION AS t ON w.PERSON = t.PERSON LEFT OUTER JOIN
                                                    dbo.HCMPOSITIONENTITY AS p ON w.RECID = p.WORKER LEFT OUTER JOIN
                                                    dbo.OHSFITNESS AS f ON w.RECID = f.WORKER LEFT OUTER JOIN
                                                    dbo.OHSWORKERPERMITLNK AS l ON w.RECID = l.WORKER LEFT OUTER JOIN
                                                    dbo.OHSPERMITSENTITY AS pe ON l.PERMIT = pe.RECID
                          WHERE        (t.TRUSTEDPOSTIONDESCRIPTION LIKE '%driver%')) AS derivedtbl_1
WHERE        (DriverCategory = 'Pool Driver Bus Driver')"
            obj.ConnectionString = con

            'Dim myUser As New SecurityPolicy.UserManager(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)
            'Dim myAdmin As New AdminSettings(CookiesWrapper.thisConnectionName, 0)
            'Dim audit As New UserAudit(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)

            Try
                Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
                db.ExecuteDataSet(CommandType.Text, sql)
                Dim dt As DataTable = ds.Tables(0)

                lblpoolbus.Text = "Pool Bus Driver:" + " " + dt.Rows(0).Item("Count").ToString


            Catch ex As Exception
                'log.Error(ex)
            End Try
        Catch ex As Exception

        End Try
        Try

            Dim sql As String = "SELECT        COUNT(PERSONNELNUMBER) AS Count
FROM            (SELECT        w.PERSONNELNUMBER, e.FIRSTNAME, e.LASTNAME, p.DESCRIPTION, t.TRUSTEDPOSTIONDESCRIPTION AS DriverCategory, t.EMPLOYER AS Employer, 
                                                    CASE FITNESSSTATUS WHEN 0 THEN 'Completely Fit' WHEN 4 THEN 'Fit for administration' WHEN 5 THEN 'Fit but bad eyesight' WHEN 7 THEN 'Fit but bad speech' WHEN 6 THEN 'Fit but bad hearing'
                                                     WHEN 2 THEN 'Temporary unfit' WHEN 3 THEN 'Not rated' ELSE 'Unfit' END AS Fitness, 
                                                    CASE OUTCOME WHEN 0 THEN 'Special Leave' WHEN 1 THEN 'Sick Leave' WHEN 3 THEN 'Termination' WHEN 2 THEN 'Transfer' WHEN 4 THEN 'Nothing' END AS Outcome, 
                                                    pe.DESCRIPTION AS [Licence/Certificate], pe.TODATE, pe.PERMITGROUP, pe.OHSPERMITTYPE_PERMITTYPEID, pe.OHSPERMITGROUP_PERMITGROUPID
                          FROM            dbo.HCMWORKER AS w INNER JOIN
                                                    dbo.DIRPERSONENTITY AS e ON w.PERSON = e.RECID INNER JOIN
                                                    dbo.HCMPERSONTRUSTEDPOSITION AS t ON w.PERSON = t.PERSON LEFT OUTER JOIN
                                                    dbo.HCMPOSITIONENTITY AS p ON w.RECID = p.WORKER LEFT OUTER JOIN
                                                    dbo.OHSFITNESS AS f ON w.RECID = f.WORKER LEFT OUTER JOIN
                                                    dbo.OHSWORKERPERMITLNK AS l ON w.RECID = l.WORKER LEFT OUTER JOIN
                                                    dbo.OHSPERMITSENTITY AS pe ON l.PERMIT = pe.RECID
                          WHERE        (t.TRUSTEDPOSTIONDESCRIPTION LIKE '%driver%')) AS derivedtbl_1
WHERE        (DriverCategory = 'Pool Driver General')"
            obj.ConnectionString = con

            'Dim myUser As New SecurityPolicy.UserManager(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)
            'Dim myAdmin As New AdminSettings(CookiesWrapper.thisConnectionName, 0)
            'Dim audit As New UserAudit(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)

            Try
                Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
                db.ExecuteDataSet(CommandType.Text, sql)
                Dim dt As DataTable = ds.Tables(0)

                lblpooldr.Text = "Pool General Drivers:" + " " + dt.Rows(0).Item("Count").ToString


            Catch ex As Exception
                'log.Error(ex)
            End Try
        Catch ex As Exception

        End Try
        Try

            Dim sql As String = "select COUNT(REQID) AS Count from tblTRIPREQUEST"
            obj.ConnectionString = con

            'Dim myUser As New SecurityPolicy.UserManager(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)
            'Dim myAdmin As New AdminSettings(CookiesWrapper.thisConnectionName, 0)
            'Dim audit As New UserAudit(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)

            Try
                Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
                db.ExecuteDataSet(CommandType.Text, sql)
                Dim dt As DataTable = ds.Tables(0)

                lbltri.Text = dt.Rows(0).Item("Count").ToString


            Catch ex As Exception
                'log.Error(ex)
            End Try
        Catch ex As Exception

        End Try
        Try

            Dim sql As String = "SELECT        COUNT(PERSONNELNUMBER) AS Count
FROM            (SELECT        w.PERSONNELNUMBER, e.FIRSTNAME, e.LASTNAME, p.DESCRIPTION, t.TRUSTEDPOSTIONDESCRIPTION AS DriverCategory, t.EMPLOYER AS Employer, 
                                                    CASE FITNESSSTATUS WHEN 0 THEN 'Completely Fit' WHEN 4 THEN 'Fit for administration' WHEN 5 THEN 'Fit but bad eyesight' WHEN 7 THEN 'Fit but bad speech' WHEN 6 THEN 'Fit but bad hearing'
                                                     WHEN 2 THEN 'Temporary unfit' WHEN 3 THEN 'Not rated' ELSE 'Unfit' END AS Fitness, 
                                                    CASE OUTCOME WHEN 0 THEN 'Special Leave' WHEN 1 THEN 'Sick Leave' WHEN 3 THEN 'Termination' WHEN 2 THEN 'Transfer' WHEN 4 THEN 'Nothing' END AS Outcome, 
                                                    pe.DESCRIPTION AS [Licence/Certificate], pe.TODATE, pe.PERMITGROUP, pe.OHSPERMITTYPE_PERMITTYPEID, pe.OHSPERMITGROUP_PERMITGROUPID
                          FROM            dbo.HCMWORKER AS w INNER JOIN
                                                    dbo.DIRPERSONENTITY AS e ON w.PERSON = e.RECID INNER JOIN
                                                    dbo.HCMPERSONTRUSTEDPOSITION AS t ON w.PERSON = t.PERSON LEFT OUTER JOIN
                                                    dbo.HCMPOSITIONENTITY AS p ON w.RECID = p.WORKER LEFT OUTER JOIN
                                                    dbo.OHSFITNESS AS f ON w.RECID = f.WORKER LEFT OUTER JOIN
                                                    dbo.OHSWORKERPERMITLNK AS l ON w.RECID = l.WORKER LEFT OUTER JOIN
                                                    dbo.OHSPERMITSENTITY AS pe ON l.PERMIT = pe.RECID
                          WHERE        (t.TRUSTEDPOSTIONDESCRIPTION LIKE '%driver%')) AS derivedtbl_1"
            obj.ConnectionString = con

            'Dim myUser As New SecurityPolicy.UserManager(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)
            'Dim myAdmin As New AdminSettings(CookiesWrapper.thisConnectionName, 0)
            'Dim audit As New UserAudit(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)

            Try
                Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
                db.ExecuteDataSet(CommandType.Text, sql)
                Dim dt As DataTable = ds.Tables(0)

                lbltotadrive.Text = dt.Rows(0).Item("Count").ToString

                status1.Attributes("countto") = dt.Rows(0).Item("Count").ToString
                Label1.Text = dt.Rows(0).Item("Count").ToString
            Catch ex As Exception
                'log.Error(ex)
            End Try
        Catch ex As Exception

        End Try

    End Sub

    Protected Sub logout(sender As Object, e As EventArgs)
        FormsAuthentication.SignOut()

        CokkiesWrapper.ClearCookies()

        Session.Abandon()

        Dim authCookie As HttpCookie = New HttpCookie(FormsAuthentication.FormsCookieName, "")
        authCookie.Expires = DateTime.Now.AddYears(-1)
        Response.Cookies.Add(authCookie)

        Dim sessionCookie As HttpCookie = New HttpCookie("ASP.NET_SessionId", "")
        sessionCookie.Expires = DateTime.Now.AddYears(-1)
        Response.Cookies.Add(sessionCookie)

        FormsAuthentication.RedirectToLoginPage()

        HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.NoCache)

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

End Class