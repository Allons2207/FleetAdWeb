Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Telerik.Web.UI
Imports ClassLibrary1
Imports System.Data.SqlClient
Imports System.Data
Imports System.Data.SqlClient.SqlConnection
Imports Microsoft.VisualBasic
Imports System.Configuration
Imports System.IO
Public Class TripDetails
    Inherits System.Web.UI.Page
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString
    Public vardate As String
    Public idd As String
    Public depts As String


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
        If Not IsPostBack Then
            VehicleData()
            VehicleData1()

            If Not IsNothing(Request.QueryString("op")) Then
                VehicleData2()
                Loadlist()
            End If
        Else
            If Not IsNothing(Request.QueryString("op")) Then
                VehicleData2()
                Loadlist()
            End If

        End If

        Try




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


    Private Sub Loadlist()


        'Dim myUser As New SecurityPolicy.UserManager(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)
        'Dim myAdmin As New AdminSettings(CookiesWrapper.thisConnectionName, 0)
        'Dim audit As New UserAudit(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)

        Try

            Dim sql As String = "SELECT        dbo.tblLICENCE.FLEETID, dbo.tblLICENCE.LICNUMBER AS INS, dbo.tblLICENCE.DATEEXPIRY AS INSEX, dbo.tblZINARA.DATEEXPIRY AS ZINEX, dbo.tblZBC.LICNUMBER AS ZBC, 
                         dbo.tblZBC.DATEEXPIRY AS ZBCEX, dbo.tblZINARA.LICNUMBER AS ZIN
FROM            dbo.tblLICENCE INNER JOIN
                         dbo.tblZINARA ON dbo.tblLICENCE.FLEETID = dbo.tblZINARA.FLEETID INNER JOIN
                         dbo.tblZBC ON dbo.tblZINARA.FLEETID = dbo.tblZBC.FLEETID
where dbo.tblLICENCE.DATEEXPIRY > '" & vardate & "' AND  dbo.tblZINARA.DATEEXPIRY > '" & vardate & "' AND dbo.tblZBC.LICNUMBER  > '" & vardate & "'
GROUP BY dbo.tblLICENCE.FLEETID, dbo.tblLICENCE.LICNUMBER, dbo.tblLICENCE.DATEEXPIRY, dbo.tblZINARA.DATEEXPIRY, dbo.tblZBC.LICNUMBER, dbo.tblZBC.DATEEXPIRY, dbo.tblZINARA.LICNUMBER"
            obj.ConnectionString = con
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)

            Dim dt As DataTable = ds.Tables(0)
            Dim x As Integer = dt.Rows.Count
            With veh
                Try
                    veh.DataSource = ds.Tables(0)
                    veh.DataTextField = "FLEETID"
                    veh.DataValueField = "FLEETID"
                    veh.DataBind()
                Catch ex As Exception
                    '  log.Error(ex.Message)
                End Try
                veh.Items.Insert(0, New ListItem("--Select--", "---Select---"))
            End With
        Catch ex As Exception
            'log.Error(ex)
        End Try

        Try

            Dim sql As String = "
select * from(
    
SELECT * FROM (
SELECT PERSONNELNUMBER, FIRSTNAME +' '+ LASTNAME AS Name ,TODATE, [OHSPERMITTYPE_PERMITTYPEID] from vwdriverlicence )    AS   AA    
PIVOT (MAX(TODATE) FOR [OHSPERMITTYPE_PERMITTYPEID] IN ([Defensive Driving], [Medicals-Gov])) AS Result) as out

where [Defensive Driving] > '" & vardate & "'  AND  [Medicals-Gov]  > '" & vardate & "'
"
            obj.ConnectionString = con
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)

            Dim dt As DataTable = ds.Tables(0)
            Dim x As Integer = dt.Rows.Count
            With drivr
                Try
                    drivr.DataSource = ds.Tables(0)
                    drivr.DataTextField = "Name"
                    drivr.DataValueField = "PERSONNELNUMBER"
                    drivr.DataBind()
                Catch ex As Exception
                    '  log.Error(ex.Message)
                End Try
                drivr.Items.Insert(0, New ListItem("--Select--", "---Select---"))
            End With
        Catch ex As Exception
            'log.Error(ex)
        End Try



    End Sub
    Private Sub VehicleData()
        Dim sql As String = "SELECT Description FROM PRETRIP Where Type = 'Mechanical'"
        obj.ConnectionString = con

        'Dim myUser As New SecurityPolicy.UserManager(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)
        'Dim myAdmin As New AdminSettings(CookiesWrapper.thisConnectionName, 0)
        'Dim audit As New UserAudit(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            db.ExecuteDataSet(CommandType.Text, sql)

        Catch e As Exception
        End Try

    End Sub

    Private Sub VehicleData2()
        Dim sql As String = "SELECT  REQID, REQUETSOR, DEPT, REQDATE, DEST, LOCINT, NATURE, WEIGHT, NUMPERSON, DEPTDATE, ARRDATE, DEPTTIME, ARRTIME, CONTACT, CONNUMBER, TYPE, SERVICE, STATUS, TRIPSTAT
FROM            dbo.tblTRIPREQUEST

where REQID = '" & Request.QueryString("op") & "'
GROUP BY REQID, REQUETSOR, DEPT, REQDATE, DEST, LOCINT, NATURE, WEIGHT, NUMPERSON, DEPTDATE, ARRDATE, DEPTTIME, ARRTIME, CONTACT, CONNUMBER, TYPE, SERVICE, STATUS, TRIPSTAT"
        obj.ConnectionString = con

        'Dim myUser As New SecurityPolicy.UserManager(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)
        'Dim myAdmin As New AdminSettings(CookiesWrapper.thisConnectionName, 0)
        'Dim audit As New UserAudit(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            db.ExecuteDataSet(CommandType.Text, sql)
            Dim dt As DataTable = ds.Tables(0)
            txtre.Text = dt.Rows(0).Item("REQUETSOR").ToString
            txtreid.Text = dt.Rows(0).Item("REQID").ToString
            txtdept.Text = dt.Rows(0).Item("DEPT").ToString
            txtdest.Text = dt.Rows(0).Item("DEST").ToString
            txtredate.Text = dt.Rows(0).Item("REQDATE").ToString
            txtloc.Text = dt.Rows(0).Item("TYPE").ToString
            txtnature.Text = dt.Rows(0).Item("NATURE").ToString
            txtweight.Text = dt.Rows(0).Item("WEIGHT").ToString
            txtreqtype.Text = dt.Rows(0).Item("SERVICE").ToString
            txtnumpp.Text = dt.Rows(0).Item("NUMPERSON").ToString
            txtarrdatae.Text = dt.Rows(0).Item("ARRDATE").ToString
            txtarrtime.Text = dt.Rows(0).Item("ARRTIME").ToString
            txtdatedep.Text = dt.Rows(0).Item("DEPTDATE").ToString
            txttimedep.Text = dt.Rows(0).Item("DEPTTIME").ToString
            txtconnum.Text = dt.Rows(0).Item("CONNUMBER").ToString
            txtcontper.Text = dt.Rows(0).Item("CONTACT").ToString
            vardate = Convert.ToDateTime(dt.Rows(0).Item("ARRDATE").ToString)


        Catch e As Exception
        End Try
        Message(Me, "Succesfully", "Loaded")

    End Sub
    Private Sub VehicleData1()
        Dim sql As String = "SELECT Description FROM PRETRIP Where Type = 'Tyres'"
        obj.ConnectionString = con

        'Dim myUser As New SecurityPolicy.UserManager(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)
        'Dim myAdmin As New AdminSettings(CookiesWrapper.thisConnectionName, 0)
        'Dim audit As New UserAudit(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            db.ExecuteDataSet(CommandType.Text, sql)

        Catch e As Exception
        End Try

    End Sub

    Private Sub Save(sender As Object, e As EventArgs)
        Dim sql As String = "SELECT * from tblTRIPS Where TRIPID = '" & Request.QueryString("op") & "'"
        obj.ConnectionString = con

        'Dim myUser As New SecurityPolicy.UserManager(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)
        'Dim myAdmin As New AdminSettings(CookiesWrapper.thisConnectionName, 0)
        'Dim audit As New UserAudit(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            db.ExecuteDataSet(CommandType.Text, sql)
            Dim ax As DataTable = ds.Tables(0)
            If ax.Rows.Count > 0 Then
                Message(Me, "Exists", "Trip")
                Exit Sub
            Else

                Try

                    Dim newsel As String = "Select SELECT REQUETSOR ,DISTANCE FROM tblTRIPREQUEST where REQID = '" & Request.QueryString("op") & "'"
                    Dim allfin As DataSet = db.ExecuteDataSet(CommandType.Text, newsel)
                    Dim kk As DataTable = allfin.Tables(0)

                    Dim mail = kk.Rows(0).Item("REQUETSOR").ToString
                    Dim distance As Int32 = Convert.ToInt32(kk.Rows(0).Item("DISTANCE").ToString)

                    Dim insert = db.GetSqlStringCommand("INSERT INTO [dbo].[tblTRIPS] ([TRIPID],[DEPT],[DATE],[VEH],[DRIVER],[STATUS],[Createdby],[ROUTE])VALUES(@a,@b,@c,@d,@e,@f,@g,@h)")
                    db.AddInParameter(insert, "@a", System.Data.DbType.String, txtreid.Text)
                    db.AddInParameter(insert, "@b", System.Data.DbType.String, txtdept.Text)
                    db.AddInParameter(insert, "@c", System.Data.DbType.Date, Convert.ToDateTime(vardate))
                    db.AddInParameter(insert, "@d", System.Data.DbType.String, veh.SelectedValue)
                    db.AddInParameter(insert, "@e", System.Data.DbType.String, drivr.SelectedValue)
                    db.AddInParameter(insert, "@f", System.Data.DbType.String, "OPEN")
                    db.AddInParameter(insert, "@g", System.Data.DbType.String, CokkiesWrapper.UserName)
                    db.AddInParameter(insert, "@h", System.Data.DbType.String, txtins.Text)
                    Dim insert_ds = db.ExecuteDataSet(insert)

                    Dim updt = db.GetSqlStringCommand("UPDATE tblTRIPREQUEST SET STATUS='OPEN' WHERE REQID = '" & Request.QueryString("op") & "' ")
                    Dim upt = db.ExecuteDataSet(updt)

                    If distance > 80 Then
                        Dim pend = db.GetSqlStringCommand("INSERT INTO [dbo].[tblPENDINGPRETRIP] ([TRIP],[DRIVER],[DEST],[DEPARTURE],[FLEETID],[DATE])VALUES(@a,@b,@c,@d,@e,@f)")
                        db.AddInParameter(pend, "@a", System.Data.DbType.String, txtreid.Text)
                        db.AddInParameter(pend, "@b", System.Data.DbType.String, drivr.SelectedValue)
                        db.AddInParameter(pend, "@c", System.Data.DbType.String, txtdest.Text)
                        db.AddInParameter(pend, "@d", System.Data.DbType.String, txtdatedep)
                        db.AddInParameter(pend, "@e", System.Data.DbType.String, veh.SelectedValue)
                        db.AddInParameter(pend, "@f", System.Data.DbType.String, Now.ToString)
                        Dim uptS = db.ExecuteDataSet(pend)
                    End If
                    Dim users As List(Of String) = New List(Of String)
                    users.Add(mail)
                    Dim user As String = "mazanit@mimosa.co.zw"
                    Dim subject As String = "Transport Request"
                    Dim body As String = "Your transport Request has been viewed by Transport Department"
                    Dim mailSender As MailSender = New MailSender()
                    mailSender.sendMailWithBody(users, "", "", body, subject)
                Catch ex As Exception

                End Try
                Message(Me, "Succesfully", "Saved")
            End If


        Catch eX As Exception
        End Try

    End Sub

    Protected Sub Button1_Click(sender As Object, e As EventArgs)
        Dim sql As String = "SELECT * from tblTRIPS Where TRIPID = '" & Request.QueryString("op") & "'"
        obj.ConnectionString = con

        Dim sql2 As String = "SELECT  REQID, REQUETSOR, DEPT, REQDATE, DEST, LOCINT, NATURE, WEIGHT, NUMPERSON, DEPTDATE, ARRDATE, DEPTTIME, ARRTIME, CONTACT, CONNUMBER, TYPE, SERVICE, STATUS, TRIPSTAT
FROM            dbo.tblTRIPREQUEST

where REQID = '" & Request.QueryString("op") & "'
GROUP BY REQID, REQUETSOR, DEPT, REQDATE, DEST, LOCINT, NATURE, WEIGHT, NUMPERSON, DEPTDATE, ARRDATE, DEPTTIME, ARRTIME, CONTACT, CONNUMBER, TYPE, SERVICE, STATUS, TRIPSTAT"
        obj.ConnectionString = con

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql2)
            db.ExecuteDataSet(CommandType.Text, sql)
            Dim dt As DataTable = ds.Tables(0)

            vardate = Convert.ToDateTime(dt.Rows(0).Item("ARRDATE").ToString)
            idd = dt.Rows(0).Item("REQID").ToString
            depts = dt.Rows(0).Item("DEPT").ToString


        Catch ec As Exception
        End Try
        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            db.ExecuteDataSet(CommandType.Text, sql)
            Dim ax As DataTable = ds.Tables(0)
            If ax.Rows.Count > 0 Then
                Message(Me, "Exists", "Trip")
                Exit Sub
            Else

                Try
                    Dim newsel As String = "SELECT REQUETSOR ,DISTANCE FROM tblTRIPREQUEST where REQID = '" & Request.QueryString("op") & "'"
                    Dim allfin As DataSet = db.ExecuteDataSet(CommandType.Text, newsel)
                    Dim kk As DataTable = allfin.Tables(0)

                    Dim mail = kk.Rows(0).Item("REQUETSOR").ToString
                    Dim distance As Int32 = Convert.ToInt32(kk.Rows(0).Item("DISTANCE").ToString)


                    Dim aa = vardate
                    Dim insert = db.GetSqlStringCommand("INSERT INTO [dbo].[tblTRIPS] ([TRIPID],[DEPT],[DATE],[VEH],[DRIVER],[STATUS],[Createdby],[ROUTE])VALUES(@a,@b,@c,@d,@e,@f,@g,@h)")
                    db.AddInParameter(insert, "@a", System.Data.DbType.String, idd)
                    db.AddInParameter(insert, "@b", System.Data.DbType.String, depts)
                    db.AddInParameter(insert, "@c", System.Data.DbType.Date, Convert.ToDateTime(vardate))
                    db.AddInParameter(insert, "@d", System.Data.DbType.String, veh.SelectedValue)
                    db.AddInParameter(insert, "@e", System.Data.DbType.String, drivr.SelectedValue)
                    db.AddInParameter(insert, "@f", System.Data.DbType.String, "OPEN")
                    db.AddInParameter(insert, "@g", System.Data.DbType.String, CokkiesWrapper.UserName)
                    db.AddInParameter(insert, "@h", System.Data.DbType.String, txtins.Text)
                    Dim insert_ds = db.ExecuteDataSet(insert)

                    Dim updt = db.GetSqlStringCommand("UPDATE tblTRIPREQUEST SET STATUS='OPEN' WHERE REQID = '" & Request.QueryString("op") & "' ")
                    Dim upt = db.ExecuteDataSet(updt)


                    If distance > 80 Then
                        Dim pend = db.GetSqlStringCommand("INSERT INTO [dbo].[tblPENDINGPRETRIP] ([TRIP],[DRIVER],[DEST],[DEPARTURE],[FLEETID],[DATE])VALUES(@a,@b,@c,@d,@e,@f)")
                        db.AddInParameter(pend, "@a", System.Data.DbType.String, txtreid.Text)
                        db.AddInParameter(pend, "@b", System.Data.DbType.String, drivr.SelectedValue)
                        db.AddInParameter(pend, "@c", System.Data.DbType.String, txtdest.Text)
                        db.AddInParameter(pend, "@d", System.Data.DbType.String, txtdatedep.Text)
                        db.AddInParameter(pend, "@e", System.Data.DbType.String, veh.SelectedValue)
                        db.AddInParameter(pend, "@f", System.Data.DbType.String, Now.ToString)
                        Dim uptS = db.ExecuteDataSet(pend)
                    End If
                    Dim users As List(Of String) = New List(Of String)
                    users.Add(mail)
                    Dim user As String = "mazanit@mimosa.co.zw"
                    Dim subject As String = "Transport Request"
                    Dim body As String = "Your transport Request has been viewed by Transport Department"
                    Dim mailSender As MailSender = New MailSender()
                    mailSender.sendMailWithBody(users, "", "", body, subject)
                Catch ex As Exception

                End Try
                Message(Me, "Succesfully", "Saved")
            End If


        Catch eX As Exception
        End Try
    End Sub
End Class