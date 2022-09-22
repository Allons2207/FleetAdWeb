Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Telerik.Web.UI
Imports ClassLibrary1
Imports System.Data.SqlClient
Imports System.Data
Imports System.Data.SqlClient.SqlConnection
Imports Microsoft.VisualBasic
Imports System.Configuration
Imports System.IO

Public Class DriverList
    Inherits System.Web.UI.Page
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString
    Dim strConnection As String = "Data Source=BUILD-MIM-ONEBO;Initial Catalog=AXDB;Integrated Security=True"
    Dim objConnection As New SqlConnection(strConnection)


    Public Class ConnectionVB
        Function GetConnectionString(ByVal clientName As String) As String
            Dim connStr As String = ""
            If clientName.ToLower() = "fleet" Then
                connStr = (ConfigurationManager.ConnectionStrings("FleetAd").ConnectionString)
            ElseIf clientName.ToLower() = "d365" Then
                connStr = (ConfigurationManager.ConnectionStrings("FleetAdMain").ConnectionString)

            End If

            Return connStr
        End Function
    End Class

    Public Sub ErrorMessage(ByVal Control As UI.Control, ByVal Message As String, Optional ByVal Title As String = "Alert", Optional ByVal callback As String = "")
        Try
            ScriptManager.RegisterStartupScript(Control, Control.GetType, "Script", "swal('" + Title + "','" + Message + "','error');", True)
        Catch ex As Exception
        End Try
    End Sub

    Public Sub Message(ByVal Control As UI.Control, ByVal Message As String, Optional ByVal Title As String = "Alert", Optional ByVal callback As String = "")
        Try
            ScriptManager.RegisterStartupScript(Control, Control.GetType, "Script", "swal('" + Title + "','" + Message + "','success');", True)
        Catch ex As Exception
        End Try
    End Sub
    Public Shared Sub ShowToastr(ByVal page As Page)
        'page.ClientScript.RegisterStartupScript(page.GetType(), "Popup", "$('#modal-form').modal.('show')", True)

        'page.ClientScript.RegisterStartupScript(page.GetType(), "randomText", "$(window).load(function() {$('#modal-form').modal('show');});", True)
        'page.ClientScript.RegisterStartupScript(page.GetType(), "script", "openpopup();", True)
        page.ClientScript.RegisterStartupScript(page.GetType(), "randomText", "$(document).ready(function () {$('#modal-form').modal('show');});", True)
        page.ClientScript.RegisterStartupScript(page.GetType(), "script", "openpopup();", True)

    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Page.ClientScript.RegisterClientScriptInclude("jQuery", "https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js")
        Page.ClientScript.RegisterClientScriptInclude("jQuery", "https://code.jquery.com/jquery-3.6.0.js")
        Page.ClientScript.RegisterClientScriptInclude("jQuery", "/assets/js/core/bootstrap.min.js")
        Page.ClientScript.RegisterClientScriptInclude("jQuery", "https://unpkg.com/sweetalert/dist/sweetalert.min.js")
        'Page.ClientScript.RegisterStartupScript(Page.GetType(), "randomText", "$(document).ready(function () {$('#modal-form').modal('show');});", True)
        'Page.ClientScript.RegisterStartupScript(Page.GetType(), "script", "openpopup();", True)
        'Page.ClientScript.RegisterStartupScript(Page.GetType(), "Popup", "$('#modal-form').modal('show')", True)
        'ClientScript.RegisterStartupScript(Me.GetType(), "Popup", "$('#modal-form').modal('show')", True)
        If Not IsPostBack Then

            'ShowToastr(Me.Page)
            'Page.ClientScript.RegisterStartupScript(Page.GetType(), "randomText", "$(document).ready(function () {$('#modal-form').modal('show');});", True)
            'Page.ClientScript.RegisterStartupScript(Page.GetType(), "script", "openpopup();", True)
            loadDriversData()
            If Not IsNothing(Request.QueryString("op")) Then
                loadDriversData()
            End If

        End If
        If IsPostBack Then
            'ShowToastr(Me.Page)
            'ShowToastr(Me.Page)
            'Page.ClientScript.RegisterStartupScript(Page.GetType(), "randomText", " Sys.Application.add_load(function () {$('#modal-form').modal('show');});", True)

        End If
        Try

            gvCustomers.UseAccessibleHeader = True
            gvCustomers.HeaderRow.TableSection = TableRowSection.TableHeader
            GridView1.UseAccessibleHeader = True
            GridView1.HeaderRow.TableSection = TableRowSection.TableHeader
            GridView3.UseAccessibleHeader = True
            GridView3.HeaderRow.TableSection = TableRowSection.TableHeader
            GridView2.UseAccessibleHeader = True
            GridView2.HeaderRow.TableSection = TableRowSection.TableHeader
        Catch ex As Exception

        End Try


    End Sub

    Private Sub loadDriversData()
        Try


            Dim sql As String = "SELECT   distinct     PERSONNELNUMBER, FIRSTNAME, LASTNAME, DESCRIPTION, DriverCategory, Employer, Fitness, Outcome
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
              

                With gvCustomers
                    Try
                        .DataSource = ds
                        .DataBind()
                    Catch ex As Exception
                        '  log.Error(ex.Message)
                    End Try
                End With

            Catch ex As Exception
                'log.Error(ex)
            End Try
        Catch ex As Exception

        End Try




        Try


            Dim sql As String = "SELECT   distinct     PERSONNELNUMBER, FIRSTNAME, LASTNAME, DESCRIPTION, DriverCategory, Employer, Fitness, Outcome
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


                With GridView2
                    Try
                        .DataSource = ds
                        .DataBind()
                    Catch ex As Exception
                        '  log.Error(ex.Message)
                    End Try
                End With

            Catch ex As Exception
                'log.Error(ex)
            End Try
        Catch ex As Exception

        End Try

        Try


            Dim sql As String = "SELECT   distinct     PERSONNELNUMBER, FIRSTNAME, LASTNAME, DESCRIPTION, DriverCategory, Employer, Fitness, Outcome
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
WHERE        (DriverCategory = 'Staff Driver')"
            obj.ConnectionString = con

            'Dim myUser As New SecurityPolicy.UserManager(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)
            'Dim myAdmin As New AdminSettings(CookiesWrapper.thisConnectionName, 0)
            'Dim audit As New UserAudit(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)

            Try
                Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
                db.ExecuteDataSet(CommandType.Text, sql)

                With GridView3
                    Try
                        .DataSource = ds
                        .DataBind()
                    Catch ex As Exception
                        '  log.Error(ex.Message)
                    End Try
                End With

            Catch ex As Exception
                'log.Error(ex)
            End Try
        Catch ex As Exception

        End Try
        Try


            Dim sql As String = "SELECT   distinct     PERSONNELNUMBER, FIRSTNAME, LASTNAME, DESCRIPTION, DriverCategory, Employer, Fitness, Outcome
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



                With GridView1
                    Try
                        .DataSource = ds
                        .DataBind()
                    Catch ex As Exception
                        '  log.Error(ex.Message)
                    End Try
                End With
            Catch ex As Exception
                'log.Error(ex)
            End Try
        Catch ex As Exception

        End Try
    End Sub
    Protected Sub GridView1_DataBound1(ByVal sender As Object, ByVal e As EventArgs)
        For rowIndex As Integer = 0 To gvCustomers.Rows.Count - 1
            Dim gvRow As GridViewRow = gvCustomers.Rows(rowIndex)
            Dim gvPreviousRow As GridViewRow = gvCustomers.Rows(rowIndex + 1)

            For cellCount As Integer = 0 To gvRow.Cells.Count - 1

                If gvRow.Cells(cellCount).Text = gvPreviousRow.Cells(cellCount).Text Then

                    If gvPreviousRow.Cells(cellCount).RowSpan < 2 Then
                        gvRow.Cells(cellCount).RowSpan = 2
                    Else
                        gvRow.Cells(cellCount).RowSpan = gvPreviousRow.Cells(cellCount).RowSpan + 1
                    End If

                    gvPreviousRow.Cells(cellCount).Visible = False
                End If
            Next
        Next
    End Sub
    Protected Sub DownloadFile(sender As Object, e As CommandEventArgs)


        Try

            Dim id = e.CommandArgument.ToString()
            Response.Redirect("~/DriverDetails.aspx?op=" + id)

        Catch ex As Exception
            'log.Error(ex)
        End Try


        'Dim id As Integer = Integer.Parse(TryCast(sender, LinkButton).CommandArgument)
        'Dim bytes As Byte()
        'Dim fileName As String, contentType As String

        'Dim Query As String = "SELECT * FROM tblLICENCE WHERE ID = '" & id & "'"


        'Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, Query)
        'Dim dt As DataTable = ds.Tables(0)

        'If dt.Rows.Count > 0 Then
        '    bytes = DirectCast(dt.Rows(0).Item("DATA"), Byte())
        '    contentType = dt.Rows(0).Item("CONTENTTYPE").ToString()
        '    fileName = dt.Rows(0).Item("FILE").ToString
        '    'bytes = DirectCast(sdr("Data"), Byte())
        '    'contentType = sdr("ContentType").ToString()
        '    'fileName = sdr("Name").ToString()
        '    Response.Clear()
        '    Response.Buffer = True
        '    Response.Charset = ""
        '    Response.Cache.SetCacheability(HttpCacheability.NoCache)
        '    Response.ContentType = contentType
        '    Response.AppendHeader("Content-Disposition", "attachment; filename=" + fileName)
        '    Response.BinaryWrite(bytes)
        '    Response.Flush()
        '    Response.End()
        'End If


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
End Class