Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Telerik.Web.UI
Imports ClassLibrary1
Imports System.Data.SqlClient
Imports System.Data
Imports System.Data.SqlClient.SqlConnection
Imports Microsoft.VisualBasic
Imports System.Configuration
Imports System.IO

Public Class PremaintainanceDetails
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
        'Page.ClientScript.RegisterStartupScript(Page.GetType(), "randomText", "$(document).ready(function () {$('#modal-form').modal('show');});", True)
        'Page.ClientScript.RegisterStartupScript(Page.GetType(), "script", "openpopup();", True)
        'Page.ClientScript.RegisterStartupScript(Page.GetType(), "Popup", "$('#modal-form').modal('show')", True)
        'ClientScript.RegisterStartupScript(Me.GetType(), "Popup", "$('#modal-form').modal('show')", True)
        Loadlist()
        If Not IsPostBack Then
            Loadlist()

            'ShowToastr(Me.Page)
            'Page.ClientScript.RegisterStartupScript(Page.GetType(), "randomText", "$(document).ready(function () {$('#modal-form').modal('show');});", True)
            'Page.ClientScript.RegisterStartupScript(Page.GetType(), "script", "openpopup();", True)
            'loadData()
            If Not IsNothing(Request.QueryString("op")) Then

                Loadlist()


            End If

        End If
    End Sub




    Private Sub Loadlist()


        'Dim myUser As New SecurityPolicy.UserManager(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)
        'Dim myAdmin As New AdminSettings(CookiesWrapper.thisConnectionName, 0)
        'Dim audit As New UserAudit(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)


        Try

            Dim sql As String = "select  WORKORDERID from ENTASSETWORKORDERVIEW  WHERE  (FUNCTIONALLOCATIONID = 'H705' ) AND WORKORDERTYPEID='SCHEDULED' AND WORKORDERLIFECYCLESTATEID ='IN PROGRESS'"
            obj.ConnectionString = con
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)

            Dim dt As DataTable = ds.Tables(0)
            Dim x As Integer = dt.Rows.Count
            With DropDownList2
                Try
                    DropDownList2.DataSource = ds.Tables(0)
                    DropDownList2.DataTextField = "WORKORDERID"
                    DropDownList2.DataValueField = "WORKORDERID"
                    DropDownList2.DataBind()
                Catch ex As Exception
                    '  log.Error(ex.Message)
                End Try
            End With
        Catch ex As Exception
            'log.Error(ex)
        End Try



    End Sub
    Protected Sub Save(sender As Object, e As EventArgs)

        Try
            Dim del = db.GetSqlStringCommand("DELETE FROM tblPREMAINTINSP WHERE FLEETID = '" & txtFLEET.Text & "' ")

            Dim del_ds = db.ExecuteDataSet(del)
        Catch ex As Exception

        End Try
        Try

            Dim insert = db.GetSqlStringCommand("INSERT INTO [tblPREMAINTINSP]([FLEETID],[DATE],[INSPBY],[DEFA],[DEFB],[DEFC],[DEFD],[DEFE],[DEFF],[DEFG],[DEFH],[DEFI],[DEFJ],[DEFK],[DEFL],[DEFM],[DEFN],[DEFO],[DEFP],[DEFQ],[DEFR],[DEFS],[DEFT],[WORDER])VALUES(@aa,@bb,@cc,@a,@b,@c,@d,@e,@f,@g,@h,@i,@j,@k,@l,@m,@n,@o,@p,@q,@r,@s,@t,@u)")


            db.AddInParameter(insert, "@aa", System.Data.DbType.String, txtFLEET.Text)
            db.AddInParameter(insert, "@bb", System.Data.DbType.Date, Convert.ToDateTime(TextBox25.Text))
            db.AddInParameter(insert, "@cc", System.Data.DbType.String, CokkiesWrapper.UserName)
            db.AddInParameter(insert, "@a", System.Data.DbType.String, dfa.Text)
            db.AddInParameter(insert, "@b", System.Data.DbType.String, dfb.Text)
            db.AddInParameter(insert, "@c", System.Data.DbType.String, dfc.Text)
            db.AddInParameter(insert, "@d", System.Data.DbType.String, dfd.Text)
            db.AddInParameter(insert, "@e", System.Data.DbType.String, dfe.Text)
            db.AddInParameter(insert, "@f", System.Data.DbType.String, dff.Text)
            db.AddInParameter(insert, "@g", System.Data.DbType.String, dfg.Text)
            db.AddInParameter(insert, "@h", System.Data.DbType.String, dfh.Text)
            db.AddInParameter(insert, "@i", System.Data.DbType.String, dfi.Text)
            db.AddInParameter(insert, "@j", System.Data.DbType.String, dfj.Text)

            db.AddInParameter(insert, "@k", System.Data.DbType.String, dfk.Text)
            db.AddInParameter(insert, "@l", System.Data.DbType.String, dfl.Text)
            db.AddInParameter(insert, "@m", System.Data.DbType.String, dfm.Text)
            db.AddInParameter(insert, "@n", System.Data.DbType.String, dfn.Text)
            db.AddInParameter(insert, "@o", System.Data.DbType.String, dfo.Text)

            db.AddInParameter(insert, "@p", System.Data.DbType.String, dfp.Text)
            db.AddInParameter(insert, "@q", System.Data.DbType.String, dfq.Text)
            db.AddInParameter(insert, "@r", System.Data.DbType.String, dfr.Text)
            db.AddInParameter(insert, "@s", System.Data.DbType.String, dfs.Text)
            db.AddInParameter(insert, "@t", System.Data.DbType.String, dft.Text)
            db.AddInParameter(insert, "@u", System.Data.DbType.String, DropDownList2.SelectedValue)









            Dim insert_ds = db.ExecuteDataSet(insert)
            Hist()
            ErrorMessage(Me.Page, "Saved Succesfully")
        Catch x As Exception
        End Try

    End Sub

    Private Sub Hist()
        Try

            Dim insert = db.GetSqlStringCommand("INSERT INTO [tblPREMAINTINSPHIS]([FLEETID],[DATE],[INSPBY],[DEFA],[DEFB],[DEFC],[DEFD],[DEFE],[DEFF],[DEFG],[DEFH],[DEFI],[DEFJ],[DEFK],[DEFL],[DEFM],[DEFN],[DEFO],[DEFP],[DEFQ],[DEFR],[DEFS],[DEFT],[WORDER])VALUES(@aa,@bb,@cc,@a,@b,@c,@d,@e,@f,@g,@h,@i,@j,@k,@l,@m,@n,@o,@p,@q,@r,@s,@t,@u)")


            db.AddInParameter(insert, "@aa", System.Data.DbType.String, txtFLEET.Text)
            db.AddInParameter(insert, "@bb", System.Data.DbType.Date, Convert.ToDateTime(TextBox25.Text))
            db.AddInParameter(insert, "@cc", System.Data.DbType.String, CokkiesWrapper.UserName)
            db.AddInParameter(insert, "@a", System.Data.DbType.String, dfa.Text)
            db.AddInParameter(insert, "@b", System.Data.DbType.String, dfb.Text)
            db.AddInParameter(insert, "@c", System.Data.DbType.String, dfc.Text)
            db.AddInParameter(insert, "@d", System.Data.DbType.String, dfd.Text)
            db.AddInParameter(insert, "@e", System.Data.DbType.String, dfe.Text)
            db.AddInParameter(insert, "@f", System.Data.DbType.String, dff.Text)
            db.AddInParameter(insert, "@g", System.Data.DbType.String, dfg.Text)
            db.AddInParameter(insert, "@h", System.Data.DbType.String, dfh.Text)
            db.AddInParameter(insert, "@i", System.Data.DbType.String, dfi.Text)
            db.AddInParameter(insert, "@j", System.Data.DbType.String, dfj.Text)

            db.AddInParameter(insert, "@k", System.Data.DbType.String, dfk.Text)
            db.AddInParameter(insert, "@l", System.Data.DbType.String, dfl.Text)
            db.AddInParameter(insert, "@m", System.Data.DbType.String, dfm.Text)
            db.AddInParameter(insert, "@n", System.Data.DbType.String, dfn.Text)
            db.AddInParameter(insert, "@o", System.Data.DbType.String, dfo.Text)

            db.AddInParameter(insert, "@p", System.Data.DbType.String, dfp.Text)
            db.AddInParameter(insert, "@q", System.Data.DbType.String, dfq.Text)
            db.AddInParameter(insert, "@r", System.Data.DbType.String, dfr.Text)
            db.AddInParameter(insert, "@s", System.Data.DbType.String, dfs.Text)
            db.AddInParameter(insert, "@t", System.Data.DbType.String, dft.Text)
            db.AddInParameter(insert, "@u", System.Data.DbType.String, DropDownList2.SelectedValue)
            Dim insert_ds = db.ExecuteDataSet(insert)
        Catch ex As Exception

        End Try
    End Sub

    Private Sub loadData()
        Dim sql As String = "SELECT * from  tblPREMAINTINSP WHERE FLEETID ='" & Request.QueryString("op") & "'"
        obj.ConnectionString = con

        'Dim myUser As New SecurityPolicy.UserManager(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)
        'Dim myAdmin As New AdminSettings(CookiesWrapper.thisConnectionName, 0)
        'Dim audit As New UserAudit(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            db.ExecuteDataSet(CommandType.Text, sql)
            Dim dt As DataTable = ds.Tables(0)
            dfa.Text = dt.Rows(0).Item("DEFA").ToString
            dfb.Text = dt.Rows(0).Item("DEFB").ToString
            dfc.Text = dt.Rows(0).Item("DEFC").ToString
            dfd.Text = dt.Rows(0).Item("DEFD").ToString
            dfe.Text = dt.Rows(0).Item("DEFE").ToString
            dff.Text = dt.Rows(0).Item("DEFF").ToString
            dfg.Text = dt.Rows(0).Item("DEFG").ToString
            dfh.Text = dt.Rows(0).Item("DEFH").ToString
            dfi.Text = dt.Rows(0).Item("DEFI").ToString
            dfj.Text = dt.Rows(0).Item("DEFJ").ToString
            dfk.Text = dt.Rows(0).Item("DEFK").ToString
            dfl.Text = dt.Rows(0).Item("DEFL").ToString
            dfm.Text = dt.Rows(0).Item("DEFM").ToString
            dfo.Text = dt.Rows(0).Item("DEFO").ToString
            dfp.Text = dt.Rows(0).Item("DEFP").ToString
            dfq.Text = dt.Rows(0).Item("DEFQ").ToString
            dfr.Text = dt.Rows(0).Item("DEFR").ToString
            dfs.Text = dt.Rows(0).Item("DEFS").ToString
            dft.Text = dt.Rows(0).Item("DEFT").ToString
            DropDownList2.SelectedValue = dt.Rows(0).Item("WORDER").ToString
            txtFLEET.Text = dt.Rows(0).Item("FLEETID").ToString
            txtInsp.Text = dt.Rows(0).Item("INSPBY").ToString
            Dim SA As Date = Convert.ToDateTime(dt.Rows(0).Item("DATE").ToString)
            TextBox25.Text = SA.ToString("yyyy-MM-dd")
            ErrorMessage(Me.Page, "Saved Succesfully")
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