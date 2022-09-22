Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Telerik.Web.UI
Imports ClassLibrary1
Imports System.Data.SqlClient
Imports System.Data
Imports System.Data.SqlClient.SqlConnection
Imports Microsoft.VisualBasic
Imports System.Configuration
Imports System.IO
Imports System.Web.Script.Services
Imports System.Web.Services
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports Newtonsoft.Json

Public Class VehicleInformation
    Inherits System.Web.UI.Page
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString
    Dim strConnection As String = "Data Source=BUILD-MIM-ONEBO;Initial Catalog=AXDB;Integrated Security=True"
    Dim objConnection As New SqlConnection(strConnection)


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
            'VehicleData()
            If Not IsNothing(Request.QueryString("op")) Then
                VehicleData()
                Message(Me, "Succesfully", "Loaded")
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
                  dbo.ENTASSETOBJECTTYPE.NAME = N'Utility Vehicle') AND (A.OBJECTACTIVE = 1) AND A.OBJECTID='" & Request.QueryString("op") & "' "
            obj.ConnectionString = con

            'Dim myUser As New SecurityPolicy.UserManager(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)
            'Dim myAdmin As New AdminSettings(CookiesWrapper.thisConnectionName, 0)
            'Dim audit As New UserAudit(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)44

            Try
                Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
                db.ExecuteDataSet(CommandType.Text, sql)
                Dim dt As DataTable = ds.Tables(0)
                lblid.Text = dt.Rows(0).Item("OBJECTID").ToString
                txtFleet.Text = dt.Rows(0).Item("OBJECTID").ToString
                txtName.Text = dt.Rows(0).Item("PRODUCT_NAME_MAKE").ToString
                txtdes.Text = dt.Rows(0).Item("NAME").ToString
                txttype.Text = dt.Rows(0).Item("TYPE").ToString
                txtnotes.Text = dt.Rows(0).Item("NOTES").ToString
                txtmod.Text = dt.Rows(0).Item("MODEL").ToString

            Catch ex As Exception
                'log.Error(ex)
            End Try
        Catch ex As Exception

        End Try



        Try


            Dim sql As String = "SELECT        dbo.tblLICENCE.FLEETID, dbo.tblLICENCE.LICNUMBER AS INS, dbo.tblLICENCE.DATEEXPIRY AS INSEX, dbo.tblZINARA.DATEEXPIRY AS ZINEX, dbo.tblZBC.LICNUMBER AS ZBC, 
                         dbo.tblZBC.DATEEXPIRY AS ZBCEX, dbo.tblZINARA.LICNUMBER AS ZIN
FROM            dbo.tblLICENCE INNER JOIN
                         dbo.tblZINARA ON dbo.tblLICENCE.FLEETID = dbo.tblZINARA.FLEETID INNER JOIN
                         dbo.tblZBC ON dbo.tblZINARA.FLEETID = dbo.tblZBC.FLEETID
where dbo.tblLICENCE.FLEETID = '" & Request.QueryString("op") & "' 
GROUP BY dbo.tblLICENCE.FLEETID, dbo.tblLICENCE.LICNUMBER, dbo.tblLICENCE.DATEEXPIRY, dbo.tblZINARA.DATEEXPIRY, dbo.tblZBC.LICNUMBER, dbo.tblZBC.DATEEXPIRY, dbo.tblZINARA.LICNUMBER"
            obj.ConnectionString = con

            'Dim myUser As New SecurityPolicy.UserManager(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)
            'Dim myAdmin As New AdminSettings(CookiesWrapper.thisConnectionName, 0)
            'Dim audit As New UserAudit(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)44

            Try
                Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
                db.ExecuteDataSet(CommandType.Text, sql)

                Dim dt As DataTable = ds.Tables(0)
                allgood.Text = dt.Rows(0).Item("INS").ToString
                txtzin.Text = dt.Rows(0).Item("ZIN").ToString
                txtzb.Text = dt.Rows(0).Item("ZBC").ToString
                allgooddate.Text = dt.Rows(0).Item("INSEX").ToString
                txtzindate.Text = dt.Rows(0).Item("ZINEX").ToString
                txtzbdate.Text = dt.Rows(0).Item("ZBCEX").ToString

            Catch ex As Exception
                'log.Error(ex)
            End Try

        Catch ex As Exception

        End Try

    End Sub


    <WebMethod>
    <ScriptMethod(UseHttpGet:=True)>
    Public Shared Function GetCalendarData() As String
        Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
        Dim db As Database = obj.Database

        Dim CalendarList As List(Of CalendarEvents) = New List(Of CalendarEvents)()
        Dim constring As String = db.ConnectionString

        Using con As SqlConnection = New SqlConnection(constring)
            Dim strQuery As String = "Select * FROM tblBUSSCHEEDULE "

            Using cmd As SqlCommand = New SqlCommand(strQuery, con)
                cmd.CommandType = CommandType.Text

                Using sda As SqlDataAdapter = New SqlDataAdapter(cmd)
                    Dim ds As DataSet = New DataSet()
                    Dim dt As DataTable = New DataTable()
                    sda.Fill(dt)

                    For i As Integer = 0 To dt.Rows.Count - 1
                        Dim Calendar As CalendarEvents = New CalendarEvents()
                        Calendar.evID = Convert.ToInt32(dt.Rows(i)("ID"))
                        Calendar.eDate = Convert.ToString(dt.Rows(i)("SCEDATE"))
                        Calendar.Title = dt.Rows(i)("SCESTATUS").ToString()
                        Calendar.EventDescription = dt.Rows(i)("DESCR").ToString()
                        Calendar.Rute = dt.Rows(i)("RUTE").ToString()
                        Calendar.Driver = dt.Rows(i)("DRIVER").ToString()
                        Calendar.FleetId = dt.Rows(i)("FLEETID").ToString()
                        Calendar.start = Convert.ToDateTime(dt.Rows(i)("SCESTAT"))
                        Calendar.endd = Convert.ToDateTime(dt.Rows(i)("SCEEND"))

                        If Calendar.Status = "ACTIVE" Then
                            Calendar.color = "green"
                        Else
                            Calendar.color = "grey"
                        End If

                        CalendarList.Add(Calendar)
                    Next
                End Using
            End Using
        End Using
        Dim jsonstring = JsonConvert.SerializeObject(CalendarList)
        Return jsonstring
    End Function

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
    Public Class CalendarEvents
        Public Property evID As Integer
        Public Property start As DateTime
        Public Property endd As DateTime
        Public Property eDate As DateTime
        Public Property EventDescription As String
        Public Property Title As String

        Public Property Driver As String
        Public Property FleetId As String

        Public Property Rute As String
        Public Property Status As String
        Public Property bookingID As Integer
        Public Property AllDayEvent As Boolean
        Public Property color As String
    End Class
End Class