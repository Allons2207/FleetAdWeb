Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Telerik.Web.UI
Imports ClassLibrary1
Imports System.Data.SqlClient
Imports System.Data
Imports System.Data.SqlClient.SqlConnection
Imports Microsoft.VisualBasic
Imports System.Configuration

Public Class ScheduleDetails
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

            Loadlist()
            If Not IsNothing(Request.QueryString("op")) Then
                loadDriversData()
                Loadlist()
                Message(Me, "Succesfully", "Loaded")
            End If

        End If
        If IsPostBack Then
            'ShowToastr(Me.Page)
            'ShowToastr(Me.Page)
            'Page.ClientScript.RegisterStartupScript(Page.GetType(), "randomText", " Sys.Application.add_load(function () {$('#modal-form').modal('show');});", True)

        End If
        Try

            'gvCustomers.UseAccessibleHeader = True
            'gvCustomers.HeaderRow.TableSection = TableRowSection.TableHeader
        Catch ex As Exception

        End Try


    End Sub

    Private Sub loadDriversData()
        Dim sql As String = "Select * FROM [dbo].[tblBUSSCHEEDULE] WHERE ID ='" & Request.QueryString("op") & "'"
        obj.ConnectionString = con

        'Dim myUser As New SecurityPolicy.UserManager(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)
        'Dim myAdmin As New AdminSettings(CookiesWrapper.thisConnectionName, 0)
        'Dim audit As New UserAudit(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            db.ExecuteDataSet(CommandType.Text, sql)
            Dim dt As DataTable = ds.Tables(0)
            txtdty.Text = dt.Rows(0).Item("SCESTATUS").ToString
            Dim allon As Date = Convert.ToDateTime(dt.Rows(0).Item("SCEDATE").ToString)

            txtdate.Text = allon.ToString("yyyy-MM-ddTHH:mm")
            DropDownList1.SelectedItem.Text = dt.Rows(0).Item("FLEETID").ToString
            DropDownList2.SelectedItem.Text = dt.Rows(0).Item("DRIVER").ToString
            txtfrm.Text = dt.Rows(0).Item("DESCR").ToString
            txtto.Text = dt.Rows(0).Item("RUTE").ToString

        Catch ex As Exception
            'log.Error(ex)
        End Try

    End Sub

    Protected Sub DownloadFile(sender As Object, e As EventArgs)

        Dim sql As String = "SELECT        H.PERSONNELNUMBER AS EC, P.FIRSTNAME AS FirstName, P.LASTNAME AS LastName, HP.DESCRIPTION AS Position, dbo.tblDRIVEREXTRA.LICNUMBER, dbo.tblDRIVEREXTRA.MEDICALRETEST, 
                         dbo.tblDRIVEREXTRA.DDCEXPIRY, dbo.tblDRIVEREXTRA.RETESTDATE
FROM            dbo.HCMWORKER AS H INNER JOIN
                         dbo.DIRPERSONNAME AS P ON H.PERSON = P.PERSON INNER JOIN
                         dbo.HCMPOSITIONENTITY AS HP ON H.RECID = HP.WORKER INNER JOIN
                         dbo.HCMJOBDETAIL AS HJ ON HP.JOB = HJ.JOB INNER JOIN
                         dbo.tblDRIVEREXTRA ON H.PERSONNELNUMBER = dbo.tblDRIVEREXTRA.PERSONELID
WHERE        (HJ.DESCRIPTION LIKE '%driver%')"
        obj.ConnectionString = con

        'Dim myUser As New SecurityPolicy.UserManager(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)
        'Dim myAdmin As New AdminSettings(CookiesWrapper.thisConnectionName, 0)
        'Dim audit As New UserAudit(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            db.ExecuteDataSet(CommandType.Text, sql)
            Dim dt As DataTable = ds.Tables(0)

            If dt.Rows.Count > 0 Then
                Dim id = dt.Rows(0).Item("EC").ToString
                Response.Redirect("~/DriverDetails.aspx?op=" + id)
            End If
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
    Private Sub Loadlist()


        'Dim myUser As New SecurityPolicy.UserManager(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)
        'Dim myAdmin As New AdminSettings(CookiesWrapper.thisConnectionName, 0)
        'Dim audit As New UserAudit(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)

        Try

            Dim sql As String = "Select        A.OBJECTID, dbo.ENTASSETOBJECTTYPE.NAME As TYPE, dbo.ENTASSETPRODUCT.DESCRIPTION As PRODUCT_NAME_MAKE, dbo.ENTASSETMODEL.DESCRIPTION As MODEL, A.NAME, A.NOTES, 
                         B.LOCATION, dbo.ENTASSETFUNCTIONALLOCATION.LOGISTICSLOCATION, dbo.ENTASSETFUNCTIONALLOCATION.NAME As FunctionalLocationName, 
                         dbo.ENTASSETFUNCTIONALLOCATION.NOTES AS FunctionalLocationNotes, A.OBJECTACTIVE, dbo.ENTASSETFUNCTIONALLOCATION.FUNCTIONALLOCATIONID
From dbo.ENTASSETOBJECTTABLE AS A LEFT OUTER Join
                         dbo.ENTASSETPRODUCT ON A.PRODUCT = dbo.ENTASSETPRODUCT.RECID LEFT OUTER Join
                         dbo.ENTASSETMODEL ON A.MODEL = dbo.ENTASSETMODEL.RECID LEFT OUTER Join
                         dbo.ENTASSETOBJECTTYPE ON A.OBJECTTYPE = dbo.ENTASSETOBJECTTYPE.RECID LEFT OUTER Join
                         dbo.ENTASSETFUNCTIONALLOCATION ON A.FUNCTIONALLOCATION = dbo.ENTASSETFUNCTIONALLOCATION.RECID LEFT OUTER Join
                         dbo.ENTASSETOBJECTLIFECYCLEMODELSTATE ON A.OBJECTLIFECYCLESTATE = dbo.ENTASSETOBJECTLIFECYCLEMODELSTATE.RECID LEFT OUTER Join
                         dbo.LOGISTICSPOSTALADDRESS AS B ON A.LOGISTICSLOCATION = B.LOCATION
Where (dbo.ENTASSETFUNCTIONALLOCATION.FUNCTIONALLOCATIONID = N'H705')"
            obj.ConnectionString = con
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)

            Dim dt As DataTable = ds.Tables(0)
            Dim x As Integer = dt.Rows.Count
            With DropDownList1
                Try
                    DropDownList1.DataSource = ds.Tables(0)
                    DropDownList1.DataTextField = "NAME"
                    DropDownList1.DataValueField = "OBJECTID"
                    DropDownList1.DataBind()
                Catch ex As Exception
                    '  log.Error(ex.Message)
                End Try
            End With
        Catch ex As Exception
            'log.Error(ex)
        End Try

        Try

            Dim sql As String = "SELECT        PERSONNELNUMBER, FIRSTNAME, LASTNAME, DESCRIPTION, DriverCategory, Employer, Fitness, Outcome, [Licence/Certificate], TODATE, PERMITGROUP, OHSPERMITTYPE_PERMITTYPEID, 
                         OHSPERMITGROUP_PERMITGROUPID
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
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)

            Dim dt As DataTable = ds.Tables(0)
            Dim x As Integer = dt.Rows.Count
            With DropDownList2
                Try
                    DropDownList2.DataSource = ds.Tables(0)
                    DropDownList2.DataTextField = "FIRSTNAME"
                    DropDownList2.DataValueField = "PERSONNELNUMBER"
                    DropDownList2.DataBind()
                Catch ex As Exception
                    '  log.Error(ex.Message)
                End Try
            End With
        Catch ex As Exception
            'log.Error(ex)
        End Try



    End Sub
    Protected Sub Open(sender As Object, e As EventArgs)
        Dim constr As String = db.ConnectionString
        Using con As New SqlConnection(constr)
            Try
                If Not IsNothing(Request.QueryString("op")) Then

                    Try

                        Dim insert1 = db.GetSqlStringCommand("DELETE FROM [dbo].[tblBUSSCHEEDULE] WHERE ID = @a")
                        db.AddInParameter(insert1, "@a", System.Data.DbType.Int32, Convert.ToInt32(Request.QueryString("op")))

                        Dim insert_ds1 = db.ExecuteDataSet(insert1)
                    Catch ex As Exception

                    End Try
                End If

                Dim insert = db.GetSqlStringCommand("INSERT INTO [dbo].[tblBUSSCHEEDULE] ([SCEDATE],[SCESTATUS],[SCESTAT],[SCEEND],[DRIVER],[FLEETID],[DESCR],[RUTE])VALUES(@a,@b,@c,@d,@e,@f,@g,@h)")
                db.AddInParameter(insert, "@a", System.Data.DbType.Time, Convert.ToDateTime(txtdate.Text).ToString("HH:mm"))
                db.AddInParameter(insert, "@b", System.Data.DbType.String, txtdty.Text)
                db.AddInParameter(insert, "@c", System.Data.DbType.Time, Convert.ToDateTime(txtdate.Text).ToString("HH:mm"))
                db.AddInParameter(insert, "@d", System.Data.DbType.Time, Convert.ToDateTime(txtdate.Text).ToString("HH:mm"))
                db.AddInParameter(insert, "@e", System.Data.DbType.String, DropDownList2.SelectedItem.Text)
                db.AddInParameter(insert, "@f", System.Data.DbType.String, DropDownList1.SelectedItem.Text)
                db.AddInParameter(insert, "@g", System.Data.DbType.String, txtfrm.Text)
                db.AddInParameter(insert, "@h", System.Data.DbType.String, txtto.Text)
                Dim insert_ds = db.ExecuteDataSet(insert)
            Catch ex As Exception

            End Try
            Message(Me, "Succesfully", "Saved")

        End Using
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

        Response.Redirect("~/DriverDetails.aspx")
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