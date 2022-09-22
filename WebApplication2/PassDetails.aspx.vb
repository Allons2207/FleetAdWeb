Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Microsoft.SharePoint
Imports Microsoft.SharePoint.Client
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
Imports ListItemCollection = Microsoft.SharePoint.Client.ListItemCollection
Imports ListItem = Microsoft.SharePoint.Client.ListItem
Imports System.Net
Imports System.Security

Public Class PassDetails
    Inherits System.Web.UI.Page
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString
    Dim strConnection As String = "Data Source=BUILD-MIM-ONEBO;Initial Catalog=AXDB;Integrated Security=True"
    Dim objConnection As New SqlConnection(strConnection)
    Dim siteUrl As String = "http://mim-sp-app-01/"
    'namedomain is the name of the site domain, TaskSP is the name site.

    Dim context As New ClientContext(siteUrl)
    Dim web As Web


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

            test()

            'ShowToastr(Me.Page)
            'Page.ClientScript.RegisterStartupScript(Page.GetType(), "randomText", "$(document).ready(function () {$('#modal-form').modal('show');});", True)
            'Page.ClientScript.RegisterStartupScript(Page.GetType(), "script", "openpopup();", True)


            If Not IsNothing(Request.QueryString("op")) Then
                loadDriversData()

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
        Dim sql As String = "select * from tblBUSPASS WHERE ID ='" & Request.QueryString("op") & "'"
        obj.ConnectionString = con

        'Dim myUser As New SecurityPolicy.UserManager(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)
        'Dim myAdmin As New AdminSettings(CookiesWrapper.thisConnectionName, 0)
        'Dim audit As New UserAudit(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            db.ExecuteDataSet(CommandType.Text, sql)
            Dim dt As DataTable = ds.Tables(0)
            txtname.Text = dt.Rows(0).Item("NAME").ToString
            txtdept.Text = dt.Rows(0).Item("DEPT").ToString
            txtID.Text = dt.Rows(0).Item("ID").ToString
            txtT.Text = dt.Rows(0).Item("PASS NO").ToString
            Label1.Text = dt.Rows(0).Item("NUMBER").ToString
            Label2.Text = dt.Rows(0).Item("Stakeholders").ToString

            Dim Filepath As String = dt.Rows(0).Item("PROFILE").ToString
            Dim fileName = Path.GetFileName(Filepath)
            Image1.ImageUrl = "~/FileUploads/" + fileName
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
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)

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

                Dim insert_ds = db.ExecuteDataSet(insert)
            Catch ex As Exception

            End Try
            Message(Me, "Succesfully", "Saved")

        End Using
    End Sub


    Private Sub SurroundingSub()
        Try

            Dim userNameSP As String = "mazanit"
            'Textbox1.text is the mail account to access site.
            Dim password As String = "@Maxani22."
            'Textbox2.text is the password of your mail account to access site.
            Dim secureString As SecureString = New SecureString()



            'Dim cred = New SharePointOnlineCredentials(userNameSP, secureString)
            Dim clientContext As New ClientContext(siteUrl)
            clientContext.Credentials = New System.Net.NetworkCredential(userNameSP, password)
            Dim web As Web = clientContext.Web
            Dim oWebsite As Web = clientContext.Web
            Dim collList As ListCollection = oWebsite.Lists

            Dim oList As List = collList.GetByTitle("Transport Request Form")
            'TestList is the name of the list you want to query

            clientContext.Load(oList)

            clientContext.ExecuteQuery()

        Catch ex As Exception
            Console.WriteLine(ex.Message)
        End Try
    End Sub

    Public Sub test()
        Try

            Using context = New ClientContext(siteUrl)
                context.AuthenticationMode = ClientAuthenticationMode.Default
                context.Credentials = New NetworkCredential("mazanit", "@Maxani22.")
                Dim web As Web = context.Web
                Dim collList As ListCollection = web.Lists
                context.Load(web, Function(website) website.Title)
                context.Load(web.Webs)

                context.Load(web.Lists, Function(lists) lists.Include(Function(list) list.Title, Function(list) list.Id))
                Dim oList As List = collList.GetByTitle("Transport Request Form")

                Dim camlQuery As CamlQuery = New CamlQuery()
                camlQuery.ViewXml = "<View><Query><Where><Geq><FieldRef Name='ID'/>" & "<Value Type='Number'>10</Value></Geq></Where></Query><RowLimit>100</RowLimit></View>"
                Dim collListItem As ListItemCollection = oList.GetItems(camlQuery)


                Dim items As Microsoft.SharePoint.Client.ListItemCollection = oList.GetItems(camlQuery)
                Dim fieldcol As FieldCollection = oList.Fields
                context.Load(oList)
                context.Load(items)

                context.ExecuteQuery()



                Console.ForegroundColor = ConsoleColor.White

                For Each i As Microsoft.SharePoint.Client.ListItem In items
                    context.Load(i)
                    Console.WriteLine(i)
                Next

                context.ExecuteQuery()
                For Each list As List In web.Lists
                    Console.WriteLine("List title is: " & list.Title)
                Next
                GetInboxListData(oList, items)



            End Using

        Catch ex As Exception
            Console.WriteLine("Error is: " & ex.Message)


        End Try
    End Sub
    Private Function GetInboxListData(ByVal inboxList As List, ByVal items As Microsoft.SharePoint.Client.ListItemCollection) As DataTable
        Dim dt As DataTable = New DataTable()
        dt.Columns.Add("From")
        dt.Columns.Add("To")
        dt.Columns.Add("Subject")
        dt.Columns.Add("Body")
        dt.Columns.Add("Attachments")
        dt.Columns.Add("Sent")
        Dim row As DataRow
        Try

            For Each item As Microsoft.SharePoint.Client.ListItem In items

                Dim Reqtor = item("Actio").ToString()
                Dim Reid = item("Actio").ToString()
                Dim dept = item("Actio").ToString()
                Dim dest = item("Actio").ToString()
                Dim srtype = item("Actio").ToString()
                Dim detail = item("Actio").ToString()
                Dim weght = item("Actio").ToString()
                Dim numpp = item("Actio").ToString()
                Dim redate = item("Actio").ToString()
                Dim arrdate = item("Actio").ToString()
                Dim dptdate = item("Actio").ToString()
                Dim arrtime = item("Actio").ToString()
                Dim depttime = item("Actio").ToString()
                Dim contpe = item("Actio").ToString()
                Dim contpenum = item("Actio").ToString()
                Dim triptype = item("Actio").ToString()
                Dim servicetype = item("Actio").ToString()
                Dim locint = item("Actio").ToStr
                Dim stat = item("Actio").ToString()





            Next
        Catch ex As Exception

        End Try

        Return dt
    End Function
    Private Function PeoplePicker() As String
        Throw New NotImplementedException()
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
End Class