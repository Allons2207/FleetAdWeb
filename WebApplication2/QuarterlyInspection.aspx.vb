﻿Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Telerik.Web.UI
Imports ClassLibrary1
Imports System.Data.SqlClient
Imports System.Data
Imports System.Data.SqlClient.SqlConnection
Imports Microsoft.VisualBasic
Imports System.Configuration
Imports System.IO

Public Class QuarterlyInspection
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

            gvCustomers.UseAccessibleHeader = True
            gvCustomers.HeaderRow.TableSection = TableRowSection.TableHeader

        Catch ex As Exception

        End Try
    End Sub
    Private Sub VehicleData()
        Dim sql As String = "SELECT * FROM dbo.tblQUARTINSP"
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


    Protected Sub DownloadFile(sender As Object, e As EventArgs)

        Dim sql As String = "SELECT * FROM dbo.tblQUARTINSP"
        obj.ConnectionString = con

        'Dim myUser As New SecurityPolicy.UserManager(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)
        'Dim myAdmin As New AdminSettings(CookiesWrapper.thisConnectionName, 0)
        'Dim audit As New UserAudit(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            db.ExecuteDataSet(CommandType.Text, sql)
            Dim dt As DataTable = ds.Tables(0)

            If dt.Rows.Count > 0 Then
                Dim id = dt.Rows(0).Item("FLEETID").ToString
                Response.Redirect("~/QuartelyDetails.aspx?op=" + id)
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

    Protected Sub Details(sender As Object, e As EventArgs)

        Response.Redirect("~/QuartelyDetails.aspx")
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