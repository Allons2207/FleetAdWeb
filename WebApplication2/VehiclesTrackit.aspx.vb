
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Telerik.Web.UI
Imports ClassLibrary1
Imports System.Data.SqlClient
Imports System.Data
Imports System.Data.SqlClient.SqlConnection
Imports Microsoft.VisualBasic
Imports System.Configuration
Imports System.IO
Imports System
Imports System.Collections.Generic
Imports System.Linq
Imports System.Net
Imports Newtonsoft.Json.Linq
Imports Newtonsoft.Json
Imports System.Xml

Public Class VehiclesTrackit
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
        If Not IsPostBack Then
            'loadExistingVehicleData()
            VehicleData()

            CreateDataTableXML()
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

            GridView1.UseAccessibleHeader = True
            GridView1.HeaderRow.TableSection = TableRowSection.TableHeader
        Catch ex As Exception

        End Try
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
                  
                  dbo.ENTASSETOBJECTTYPE.NAME = N'Tractor'
                 
                  ) AND (A.OBJECTACTIVE = 1)"
        obj.ConnectionString = con

        'Dim myUser As New SecurityPolicy.UserManager(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)
        'Dim myAdmin As New AdminSettings(CookiesWrapper.thisConnectionName, 0)
        'Dim audit As New UserAudit(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)


    End Sub


    Protected Sub DownloadFile(sender As Object, e As CommandEventArgs)


        Try

            Dim id = e.CommandArgument.ToString()
            Response.Redirect("~/VehicleInformation.aspx?op=" + id)

        Catch ex As Exception
            'log.Error(ex)
        End Try

    End Sub


    Private Function CreateDataTableXML()
        Dim dt As DataTable = New DataTable()
        Try

            Dim data = "http://dataexport.st-fleetweb.com/dataexport.beta.aspx?username=mimosa_api&password=systech&data=realtime"



            Dim ds As DataSet = New DataSet()


            Dim xml As XmlDocument = New XmlDocument()
            xml.Load(data)

            Dim nodoEstructu = xml.DocumentElement.LastChild.ChildNodes.Cast(Of XmlNode)().ToList()
            For Each columna In nodoEstructu

                dt.Columns.Add(columna.Name, GetType(String))
            Next
            Dim ii As Integer = 0
            Dim nod = xml.DocumentElement.ChildNodes
            For Each nods As XmlNode In nod
                If nods.Name = "PositionLog" Then
                    Try
                        Dim a = nods.ChildNodes.Cast(Of XmlNode)().ToList()(0).InnerText()
                        Dim b = nods.ChildNodes.Cast(Of XmlNode)().ToList()(1).InnerText()
                        Dim c = nods.ChildNodes.Cast(Of XmlNode)().ToList()(2).InnerText()
                        Dim d = nods.ChildNodes.Cast(Of XmlNode)().ToList()(3).InnerText()
                        Dim e = nods.ChildNodes.Cast(Of XmlNode)().ToList()(4).InnerText()
                        Dim f = nods.ChildNodes.Cast(Of XmlNode)().ToList()(5).InnerText()
                        Dim g = nods.ChildNodes.Cast(Of XmlNode)().ToList()(6).InnerText()
                        Dim h = nods.ChildNodes.Cast(Of XmlNode)().ToList()(7).InnerText()
                        Dim i = nods.ChildNodes.Cast(Of XmlNode)().ToList()(8).InnerText()
                        Dim j = nods.ChildNodes.Cast(Of XmlNode)().ToList()(9).InnerText()
                        Dim k = nods.ChildNodes.Cast(Of XmlNode)().ToList()(10).InnerText()
                        Dim l = nods.ChildNodes.Cast(Of XmlNode)().ToList()(11).InnerText()
                        Dim m = nods.ChildNodes.Cast(Of XmlNode)().ToList()(12).InnerText()
                        Dim n = nods.ChildNodes.Cast(Of XmlNode)().ToList()(13).InnerText()
                        Dim o = nods.ChildNodes.Cast(Of XmlNode)().ToList()(14).InnerText()
                        Dim p = nods.ChildNodes.Cast(Of XmlNode)().ToList()(15).InnerText()
                        Dim q = nods.ChildNodes.Cast(Of XmlNode)().ToList()(16).InnerText()

                        Dim r = nods.ChildNodes.Cast(Of XmlNode)().ToList()(17).InnerText()
                        Dim s = nods.ChildNodes.Cast(Of XmlNode)().ToList()(18).InnerText()
                        Dim t = nods.ChildNodes.Cast(Of XmlNode)().ToList()(19).InnerText()
                        Dim u = nods.ChildNodes.Cast(Of XmlNode)().ToList()(20).InnerText()
                        Dim v = nods.ChildNodes.Cast(Of XmlNode)().ToList()(21).InnerText()
                        Dim w = nods.ChildNodes.Cast(Of XmlNode)().ToList()(22).InnerText()
                        Dim x = nods.ChildNodes.Cast(Of XmlNode)().ToList()(23).InnerText()
                        Dim y = nods.ChildNodes.Cast(Of XmlNode)().ToList()(24).InnerText()

                        dt.Rows.Add(a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y)
                    Catch ex As Exception

                    End Try
                End If
            Next


            With GridView1
                    Try
                    .DataSource = dt
                    .DataBind()
                    Catch ex As Exception
                        '  log.Error(ex.Message)
                    End Try
                End With


        Catch ex As Exception

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