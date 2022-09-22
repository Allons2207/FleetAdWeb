﻿Imports Microsoft.Practices.EnterpriseLibrary.Data
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

Public Class TripManagement
    Inherits System.Web.UI.Page
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString
    Dim strConnection As String = "Data Source=BUILD-MIM-ONEBO;Initial Catalog=AXDB;Integrated Security=True"
    Dim objConnection As New SqlConnection(strConnection)
    Dim siteUrl As String = "http://mim-sp-app-01/"

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
            loadData()

            If Not IsNothing(Request.QueryString("op")) Then
                loadData()
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
        Catch ex As Exception

        End Try


    End Sub
    Private Sub loadData()
        Dim sql As String = "SELECT        REQID, REQUETSOR, DEPT, REQDATE, DEST, LOCINT, NATURE, WEIGHT, NUMPERSON, DEPTDATE, ARRDATE, DEPTTIME, ARRTIME, CONTACT, CONNUMBER, TYPE, SERVICE, STATUS, TRIPSTAT
FROM            dbo.tblTRIPREQUEST
 WHERE STATUS IS NULL
GROUP BY REQID, REQUETSOR, DEPT, REQDATE, DEST, LOCINT, NATURE, WEIGHT, NUMPERSON, DEPTDATE, ARRDATE, DEPTTIME, ARRTIME, CONTACT, CONNUMBER, TYPE, SERVICE, STATUS, TRIPSTAT"
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
        Catch ex As Exception
            'log.Error(ex)
        End Try

    End Sub
    Protected Sub DownloadFile(sender As Object, e As CommandEventArgs)



        'Dim myUser As New SecurityPolicy.UserManager(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)
        'Dim myAdmin As New AdminSettings(CookiesWrapper.thisConnectionName, 0)
        'Dim audit As New UserAudit(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)

        Try

            Dim id = e.CommandArgument
            Response.Redirect("~/TripDetails.aspx?op=" + id)

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

                Dim Reqtor As String = item("Author").LookupValue.ToString()
                Dim Reid As String = item("ID").ToString()
                Dim dept = item("Department").ToString()
                Dim dest = item("Destination0").ToString()
                Dim srtype = item("SerrviceType").ToString()
                Dim detail = item("DescriptionOfGoods").ToString()
                Dim weght = item("EstimatedWeightOfGoods").ToString()
                Dim numpp = "5"
                Dim redate = Convert.ToDateTime(item("Created").ToString())
                Dim arrdate = Convert.ToDateTime(item("DateTo").ToString())
                Dim dptdate = Convert.ToDateTime(item("DateFroma").ToString())
                Dim arrtime As String = item("ReturnTime").ToString()
                Dim depttime As String = item("DepartureTime").ToString()
                Dim contpenum = item("CONTACTNUMBER").ToString()
                Dim cont = item("CONTACTPERSON").ToString()
                Dim dist = item("DISTANCERANGE").ToString()
                Dim triptype = item("TripType").ToString()
                Dim servicetype = item("Trip").ToString()

                Dim stat = item("State").ToString()


                Try

                    Dim sel = db.GetSqlStringCommand("select * from tblTRIPREQUEST where REQID ='" & Reid & "'  ")
                    Dim SEL_ds = db.ExecuteDataSet(sel)
                    Dim seltable = SEL_ds.Tables(0)
                    If seltable.Rows.Count() > 0 Then
                        Dim insert = db.GetSqlStringCommand("UPDATE [tblTRIPREQUEST] set [DEPT]=@c,[DEST]=@d,[SERVICE]=@e,[NATURE]=@f,[WEIGHT]=@g,[NUMPERSON]=@h,[REQDATE]=@i,[ARRDATE]=@j,[DEPTDATE]=@k,[ARRTIME]=@l,[DEPTTIME]=@m,[CONNUMBER]=@n,[CONTACT]=@o,[TYPE]=@p,[TRIPSTAT]=@q,[LOCINT]=@r ,[Distance]=@s ,[REQUETSOR]=@t  where REQID = '" & Reid & "' ")

                        db.AddInParameter(insert, "@b", System.Data.DbType.String, Reid.ToString)
                        Try

                            db.AddInParameter(insert, "@a", System.Data.DbType.String, Reqtor.ToString)
                        Catch ex As Exception
                            Console.WriteLine("Error is: " & ex.Message)
                        End Try
                        db.AddInParameter(insert, "@c", System.Data.DbType.String, dept.ToString)
                        db.AddInParameter(insert, "@d", System.Data.DbType.String, dest.ToString)
                        db.AddInParameter(insert, "@e", System.Data.DbType.String, srtype.ToString)
                        db.AddInParameter(insert, "@f", System.Data.DbType.String, detail.ToString)
                        db.AddInParameter(insert, "@g", System.Data.DbType.String, weght.ToString)
                        db.AddInParameter(insert, "@h", System.Data.DbType.String, numpp.ToString)
                        db.AddInParameter(insert, "@i", System.Data.DbType.Date, Convert.ToDateTime(redate.ToString))
                        db.AddInParameter(insert, "@j", System.Data.DbType.Date, Convert.ToDateTime(arrdate.ToString))
                        db.AddInParameter(insert, "@k", System.Data.DbType.Date, Convert.ToDateTime(dptdate.ToString))
                        db.AddInParameter(insert, "@l", System.Data.DbType.String, arrtime.ToString)
                        db.AddInParameter(insert, "@m", System.Data.DbType.String, depttime.ToString)
                        db.AddInParameter(insert, "@n", System.Data.DbType.String, contpenum.ToString)
                        db.AddInParameter(insert, "@o", System.Data.DbType.String, cont.ToString)
                        db.AddInParameter(insert, "@p", System.Data.DbType.String, triptype.ToString)
                        db.AddInParameter(insert, "@q", System.Data.DbType.String, servicetype.ToString)
                        db.AddInParameter(insert, "@r", System.Data.DbType.String, stat.ToString)
                        db.AddInParameter(insert, "@s", System.Data.DbType.String, dist.ToString)
                        db.AddInParameter(insert, "@t", System.Data.DbType.String, Reqtor.ToString)
                        Dim insert_ds = db.ExecuteDataSet(insert)


                    Else


                        Dim insert = db.GetSqlStringCommand("INSERT INTO [tblTRIPREQUEST]([REQID],[DEPT],[DEST],[SERVICE],[NATURE],[WEIGHT],[NUMPERSON],[REQDATE],[ARRDATE],[DEPTDATE],[ARRTIME],[DEPTTIME],[CONNUMBER],[CONTACT],[TYPE],[TRIPSTAT],[LOCINT],[Distance],[REQUETSOR])VALUES(@b,@c,@d,@e,@f,@g,@h,@i,@j,@k,@l,@m,@n,@o,@p,@q,@r,@s,@t)")

                        db.AddInParameter(insert, "@b", System.Data.DbType.String, Reid.ToString)
                        Try

                            db.AddInParameter(insert, "@a", System.Data.DbType.String, Reqtor.ToString)
                        Catch ex As Exception
                            Console.WriteLine("Error is: " & ex.Message)
                        End Try
                        db.AddInParameter(insert, "@c", System.Data.DbType.String, dept.ToString)
                        db.AddInParameter(insert, "@d", System.Data.DbType.String, dest.ToString)
                        db.AddInParameter(insert, "@e", System.Data.DbType.String, srtype.ToString)
                        db.AddInParameter(insert, "@f", System.Data.DbType.String, detail.ToString)
                        db.AddInParameter(insert, "@g", System.Data.DbType.String, weght.ToString)
                        db.AddInParameter(insert, "@h", System.Data.DbType.String, numpp.ToString)
                        db.AddInParameter(insert, "@i", System.Data.DbType.Date, Convert.ToDateTime(redate.ToString))
                        db.AddInParameter(insert, "@j", System.Data.DbType.Date, Convert.ToDateTime(arrdate.ToString))
                        db.AddInParameter(insert, "@k", System.Data.DbType.Date, Convert.ToDateTime(dptdate.ToString))
                        db.AddInParameter(insert, "@l", System.Data.DbType.String, arrtime.ToString)
                        db.AddInParameter(insert, "@m", System.Data.DbType.String, depttime.ToString)
                        db.AddInParameter(insert, "@n", System.Data.DbType.String, contpenum.ToString)
                        db.AddInParameter(insert, "@o", System.Data.DbType.String, cont.ToString)
                        db.AddInParameter(insert, "@p", System.Data.DbType.String, triptype.ToString)
                        db.AddInParameter(insert, "@q", System.Data.DbType.String, servicetype.ToString)
                        db.AddInParameter(insert, "@r", System.Data.DbType.String, stat.ToString)
                        db.AddInParameter(insert, "@s", System.Data.DbType.String, dist.ToString)
                        db.AddInParameter(insert, "@t", System.Data.DbType.String, Reqtor.ToString)


                        Dim insert_ds = db.ExecuteDataSet(insert)
                    End If


                Catch ex As Exception
                    Console.WriteLine("Error is: " & ex.Message)
                End Try




            Next
        Catch ex As Exception
            Console.WriteLine("Error is: " & ex.Message)
        End Try

        Return dt
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


    Protected Sub Details(sender As Object, e As EventArgs)

        Response.Redirect("~/InspectionDetails.aspx")
    End Sub
    Protected Sub garage(sender As Object, e As EventArgs)

        Response.Redirect("~/VehicleLicence.aspx")
    End Sub

End Class