Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Telerik.Web.UI
Imports ClassLibrary1
Imports System.Data.SqlClient
Imports System.Data
Imports System.Data.SqlClient.SqlConnection
Imports Microsoft.SharePoint
Imports Microsoft.SharePoint.Client

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

Public Class BusPass
    Inherits System.Web.UI.Page
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString
    Dim strConnection As String = "Data Source=BUILD-MIM-ONEBO;Initial Catalog=AXDB;Integrated Security=True"
    Dim objConnection As New SqlConnection(strConnection)
    Dim siteUrl As String = "http://mim-sp-app-01/sites/james/"


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            test()
            loadData()

        End If
        Try


        Catch ex As Exception

        End Try
    End Sub
    Public Sub test()
        Try

            Using context = New ClientContext(siteUrl)
                context.AuthenticationMode = ClientAuthenticationMode.Default
                context.Credentials = New NetworkCredential("mazanit", "Mimosa2023")
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




            End Using

        Catch ex As Exception
            Console.WriteLine("Error is: " & ex.Message)


        End Try
    End Sub

    Private Sub loadData()
        Dim sql As String = "SELECT * FROM tblTRIPS"
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