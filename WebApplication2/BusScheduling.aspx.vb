Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System
Imports System.Collections.Generic
Imports System.Configuration
Imports System.Data
Imports System.Data.SqlClient
Imports System.Linq
Imports System.Web
Imports System.Web.Script.Services
Imports System.Web.Services
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports Newtonsoft.Json
Imports System.IO




Public Class BusScheduling
    Inherits System.Web.UI.Page
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        If Not IsPostBack Then

            Loadlist()
        Else
            Loadlist()
        End If
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

                    Dim aa As String = Date.Today.ToShortDateString

                    For i As Integer = 0 To dt.Rows.Count - 1
                        Dim ax As String = aa + " " + dt.Rows(i)("SCESTAT").ToString
                        Dim Calendar As CalendarEvents = New CalendarEvents()
                        Calendar.evID = Convert.ToInt32(dt.Rows(i)("ID"))
                        Calendar.eDate = Convert.ToString(ax)
                        Calendar.Title = dt.Rows(i)("SCESTATUS").ToString()
                        Calendar.EventDescription = dt.Rows(i)("DESCR").ToString()
                        Calendar.Rute = dt.Rows(i)("RUTE").ToString()
                        Calendar.Driver = dt.Rows(i)("DRIVER").ToString()

                        Calendar.FleetId = dt.Rows(i)("FLEETID").ToString()
                        Calendar.start = Convert.ToDateTime(ax)
                        Calendar.endd = Convert.ToDateTime(ax)

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




    <WebMethod()>
    Public Shared Sub SaveUser(datasave As CalSchedule)

        Using page As New Page()
            Dim userControl As UserControl = DirectCast(page.LoadControl("Message.ascx"), UserControl)

            page.Controls.Add(userControl)
            Using writer As New StringWriter()
                page.Controls.Add(userControl)
                HttpContext.Current.Server.Execute(page, writer, False)

            End Using
        End Using

        Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
        Dim db As Database = obj.Database
        Dim constr As String = db.ConnectionString
        Using con As New SqlConnection(constr)
            Try

                Dim insert1 = db.GetSqlStringCommand("DELETE FROM [dbo].[tblBUSSCHEEDULE] WHERE ID = @a")
                db.AddInParameter(insert1, "@a", System.Data.DbType.Int32, Convert.ToInt32(datasave.evID))

                Dim insert_ds1 = db.ExecuteDataSet(insert1)

                Dim insert = db.GetSqlStringCommand("INSERT INTO [dbo].[tblBUSSCHEEDULE] ([SCEDATE],[SCESTATUS],[SCESTAT],[SCEEND],[DRIVER],[FLEETID],[DESCR],[RUTE])VALUES(@a,@b,@c,@d,@e,@f,@g,@h)")
                db.AddInParameter(insert, "@a", System.Data.DbType.Date, Convert.ToDateTime(datasave.start))
                db.AddInParameter(insert, "@b", System.Data.DbType.String, datasave.Title)
                db.AddInParameter(insert, "@c", System.Data.DbType.Date, Convert.ToDateTime(datasave.start))
                db.AddInParameter(insert, "@d", System.Data.DbType.Date, Convert.ToDateTime(datasave.start))
                db.AddInParameter(insert, "@e", System.Data.DbType.String, datasave.Driver)
                db.AddInParameter(insert, "@f", System.Data.DbType.String, datasave.FleetId)
                db.AddInParameter(insert, "@g", System.Data.DbType.String, datasave.EventDescription)
                db.AddInParameter(insert, "@h", System.Data.DbType.String, datasave.Rute)
                Dim insert_ds = db.ExecuteDataSet(insert)

            Catch ex As Exception

            End Try

        End Using

    End Sub





    <WebMethod()>
    Public Shared Sub DelUser(datasave As DelSchedule)
        Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
        Dim db As Database = obj.Database
        Dim constr As String = db.ConnectionString
        Using con As New SqlConnection(constr)
            Dim insert = db.GetSqlStringCommand("DELETE FROM [dbo].[tblBUSSCHEEDULE] WHERE ID = @a")
            db.AddInParameter(insert, "@a", System.Data.DbType.Int32, Convert.ToInt32(datasave.evID))

            Dim insert_ds = db.ExecuteDataSet(insert)


        End Using
    End Sub
    Private Sub Loadlist()


        'Dim myUser As New SecurityPolicy.UserManager(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)
        'Dim myAdmin As New AdminSettings(CookiesWrapper.thisConnectionName, 0)
        'Dim audit As New UserAudit(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)

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
                  WHERE (dbo.ENTASSETOBJECTTYPE.NAME = N'Bus' )
                  AND (A.OBJECTACTIVE = 1)"
            obj.ConnectionString = con
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, Sql)

            Dim dt As DataTable = ds.Tables(0)
            Dim x As Integer = dt.Rows.Count

        Catch ex As Exception
            'log.Error(ex)
        End Try

        Try

            Dim sql As String = "SELECT        H.PERSONNELNUMBER AS EC, P.FIRSTNAME AS FirstName, P.LASTNAME AS LastName, HP.DESCRIPTION AS Position, dbo.tblDRIVEREXTRA.LICNUMBER, dbo.tblDRIVEREXTRA.MEDICALRETEST, 
                         dbo.tblDRIVEREXTRA.DDCEXPIRY, dbo.tblDRIVEREXTRA.RETESTDATE
FROM            dbo.HCMWORKER AS H INNER JOIN
                         dbo.DIRPERSONNAME AS P ON H.PERSON = P.PERSON INNER JOIN
                         dbo.HCMPOSITIONENTITY AS HP ON H.RECID = HP.WORKER INNER JOIN
                         dbo.HCMJOBDETAIL AS HJ ON HP.JOB = HJ.JOB INNER JOIN
                         dbo.tblDRIVEREXTRA ON H.PERSONNELNUMBER = dbo.tblDRIVEREXTRA.PERSONELID
WHERE        (HJ.DESCRIPTION LIKE '%driver%')"
            obj.ConnectionString = con
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)

            Dim dt As DataTable = ds.Tables(0)
            Dim x As Integer = dt.Rows.Count

        Catch ex As Exception
            'log.Error(ex)
        End Try



    End Sub

    Public Shared Function GetCalendarDataFromDatabase() As List(Of CalendarEvents)
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
                        Calendar.eDate = Convert.ToDateTime(dt.Rows(i)("SCEDATE"))
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
        Return CalendarList
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
    Public Class CalSchedule
        Public Property evID As Integer
        Public Property start As DateTime

        Public Property EventDescription As String
        Public Property Title As String

        Public Property Driver As String
        Public Property FleetId As String

        Public Property Rute As String

        Public Property color As String
    End Class


    Public Class DelSchedule
        Public Property evID As Integer


    End Class

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