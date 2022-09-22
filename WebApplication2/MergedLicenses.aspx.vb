Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Telerik.Web.UI
Imports ClassLibrary1
Imports System.Data.SqlClient
Imports System.Data
Imports System.Data.SqlClient.SqlConnection
Imports Microsoft.VisualBasic
Imports System.Configuration
Imports System.IO
Public Class MergedLicenses
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
            loadExistingVehicleData()
            'ShowToastr(Me.Page)
            'Page.ClientScript.RegisterStartupScript(Page.GetType(), "randomText", "$(document).ready(function () {$('#modal-form').modal('show');});", True)
            'Page.ClientScript.RegisterStartupScript(Page.GetType(), "script", "openpopup();", True)
            loadAllocatedRegNumbers()
            If Not IsNothing(Request.QueryString("op")) Then
                loadExistingVehicleData()
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
            GridView2.UseAccessibleHeader = True

            GridView2.HeaderRow.TableSection = TableRowSection.TableHeader
            GridView1.UseAccessibleHeader = True
            GridView1.HeaderRow.TableSection = TableRowSection.TableHeader
        Catch ex As Exception

        End Try


    End Sub

    Protected Sub DownloadFilein(sender As Object, e As EventArgs)
        Dim id As Integer = Integer.Parse(TryCast(sender, LinkButton).CommandArgument)
        Dim bytes As Byte()
        Dim fileName As String, contentType As String


        Dim Query As String = "SELECT * FROM tblLICENCE WHERE ID = '" & id & "'"


        Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, Query)
        Dim dt As DataTable = ds.Tables(0)

        If dt.Rows.Count > 0 Then
            bytes = DirectCast(dt.Rows(0).Item("DATA"), Byte())
            contentType = dt.Rows(0).Item("CONTENTTYPE").ToString()
            fileName = dt.Rows(0).Item("FILE").ToString
            'bytes = DirectCast(sdr("Data"), Byte())
            'contentType = sdr("ContentType").ToString()
            'fileName = sdr("Name").ToString()
            Response.Clear()
            Response.Buffer = True
            Response.Charset = ""
            Response.Cache.SetCacheability(HttpCacheability.NoCache)
            Response.ContentType = contentType
            Response.AppendHeader("Content-Disposition", "attachment; filename=" + fileName)
            Response.BinaryWrite(bytes)
            Response.Flush()
            Response.End()
        End If


    End Sub

    Protected Sub DownloadFilezb(sender As Object, e As EventArgs)
        Dim id As Integer = Integer.Parse(TryCast(sender, LinkButton).CommandArgument)
        Dim bytes As Byte()
        Dim fileName As String, contentType As String


        Dim Query As String = "SELECT * FROM tblZBC WHERE ID = '" & id & "'"


        Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, Query)
        Dim dt As DataTable = ds.Tables(0)

        If dt.Rows.Count > 0 Then
            bytes = DirectCast(dt.Rows(0).Item("DATA"), Byte())
            contentType = dt.Rows(0).Item("CONTENTTYPE").ToString()
            fileName = dt.Rows(0).Item("FILE").ToString
            'bytes = DirectCast(sdr("Data"), Byte())
            'contentType = sdr("ContentType").ToString()
            'fileName = sdr("Name").ToString()
            Response.Clear()
            Response.Buffer = True
            Response.Charset = ""
            Response.Cache.SetCacheability(HttpCacheability.NoCache)
            Response.ContentType = contentType
            Response.AppendHeader("Content-Disposition", "attachment; filename=" + fileName)
            Response.BinaryWrite(bytes)
            Response.Flush()
            Response.End()
        End If


    End Sub

    Protected Sub DownloadFilezin(sender As Object, e As EventArgs)
        Dim id As Integer = Integer.Parse(TryCast(sender, LinkButton).CommandArgument)
        Dim bytes As Byte()
        Dim fileName As String, contentType As String


        Dim Query As String = "SELECT * FROM tblZINARA WHERE ID = '" & id & "'"


        Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, Query)
        Dim dt As DataTable = ds.Tables(0)

        If dt.Rows.Count > 0 Then
            bytes = DirectCast(dt.Rows(0).Item("DATA"), Byte())
            contentType = dt.Rows(0).Item("CONTENTTYPE").ToString()
            fileName = dt.Rows(0).Item("FILE").ToString
            'bytes = DirectCast(sdr("Data"), Byte())
            'contentType = sdr("ContentType").ToString()
            'fileName = sdr("Name").ToString()
            Response.Clear()
            Response.Buffer = True
            Response.Charset = ""
            Response.Cache.SetCacheability(HttpCacheability.NoCache)
            Response.ContentType = contentType
            Response.AppendHeader("Content-Disposition", "attachment; filename=" + fileName)
            Response.BinaryWrite(bytes)
            Response.Flush()
            Response.End()
        End If


    End Sub

    Private Sub loadExistingVehicleData()


        Try

            Dim sql As String = "SELECT * FROM tblZINARA"
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
        Catch ex As Exception

        End Try
        Try

            Dim sql As String = "SELECT * FROM tblZBC"
            obj.ConnectionString = con

            'Dim myUser As New SecurityPolicy.UserManager(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)
            'Dim myAdmin As New AdminSettings(CookiesWrapper.thisConnectionName, 0)
            'Dim audit As New UserAudit(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)

            Try
                Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
                db.ExecuteDataSet(CommandType.Text, sql)

                With GridView1
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
        Catch ex As Exception

        End Try
        Try

            Dim sql As String = "SELECT * FROM tblLICENCE"
            obj.ConnectionString = con

            'Dim myUser As New SecurityPolicy.UserManager(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)
            'Dim myAdmin As New AdminSettings(CookiesWrapper.thisConnectionName, 0)
            'Dim audit As New UserAudit(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)

            Try
                Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
                db.ExecuteDataSet(CommandType.Text, sql)

                With GridView2
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
        Catch ex As Exception

        End Try


    End Sub
    Private Sub loadAllocatedRegNumbers()
    End Sub

    'Protected Sub btnSearchByFleetID_Click(sender As Object, e As EventArgs) Handles btnSearchByFleetID.Click
    '    obj.ConnectionString = con
    '    txtRegNo.Text = obj.fnVehicleRegNumFromFleetID(txtFleetIDSearch.Text)
    '    loadVehicleData()
    'End Sub

    Private Sub loadVehicleData()

        'txtFleetID.Text = ""
        'txtDesvription.Text = ""
        'txtReg.Text = ""
        'txtfleet.Text = ""

        'Dim qry As String = "SELECT dbo.tbl_vehicleMakes.vehicleMake, dbo.tbl_vehicleModels.vehicleModel, dbo.tbl_vehicleData.registrationNumber," &
        '                   " dbo.tbl_vehicleData.fleetId FROM dbo.tbl_vehicleModels INNER JOIN dbo.tbl_vehicleMakes ON " &
        '                   " dbo.tbl_vehicleModels.vehicleMakeId = dbo.tbl_vehicleMakes.vehicleMakeId INNER JOIN dbo.tbl_vehicleData ON " &
        '                   " dbo.tbl_vehicleModels.vehicleModelId = dbo.tbl_vehicleData.modelId WHERE  dbo.tbl_vehicleData.fleetId = '" & txtFleetIDSearch.Text & "'"

        'Try


        '    obj.ConnectionString = con
        '    Dim ds As DataSet = obj.ExecuteDsQRY(qry)
        '    If ds.Tables(0).Rows.Count > 0 Then
        '        txtRegNo.Text = ds.Tables(0).Rows(0).Item("registrationNumber")
        '        txtMake.Text = ds.Tables(0).Rows(0).Item("vehicleMake")
        '        txtModel.Text = ds.Tables(0).Rows(0).Item("vehicleModel")
        '        txtFleetID.Text = ds.Tables(0).Rows(0).Item("fleetId")
        '    Else
        '        obj.MessageLabel(lblMsg, "No such vehicle found under ALLOCATED and POOL vehicles.", "Yellow")
        '    End If
        'Catch ex As Exception

        'End Try


    End Sub


    Protected Sub cmdSave_Click(sender As Object, e As EventArgs)

        'ShowToastr(Me.Page)


        'Dim filename As String = Path.GetFileName(fdfile.PostedFile.FileName)
        'Dim contentType As String = fdfile.PostedFile.ContentType
        'Using fs As Stream = fdfile.PostedFile.InputStream
        '    Using br As New BinaryReader(fs)
        '        Dim bytes As Byte() = br.ReadBytes(DirectCast(fs.Length, Long))


        '        Dim insert = db.GetSqlStringCommand("INSERT INTO [tblMERGE]([FLEETID],[LICNUMBER],[DATEISSUED],[DATEEXPIRY],[COMMENTS],[FILE],[CONTENTTYPE],[DATA])VALUES(@a,@b,@c,@d,@e,@f,@g,@h)")


        '        db.AddInParameter(insert, "@a", System.Data.DbType.String, txtFleetID.Text)
        '        db.AddInParameter(insert, "@b", System.Data.DbType.String, txtLicence.Text)
        '        db.AddInParameter(insert, "@c", System.Data.DbType.Date, Convert.ToDateTime(txtDateIssued.Text))
        '        db.AddInParameter(insert, "@d", System.Data.DbType.Date, Convert.ToDateTime(txtDateEx.Text))
        '        db.AddInParameter(insert, "@e", System.Data.DbType.String, txtDateEx.Text)
        '        db.AddInParameter(insert, "@f", System.Data.DbType.String, filename)
        '        db.AddInParameter(insert, "@g", System.Data.DbType.String, contentType)
        '        db.AddInParameter(insert, "@h", System.Data.DbType.Binary, bytes)
        '        Dim insert_ds = db.ExecuteDataSet(insert)
        '        Message(Me, "Saved", "Succefully")
        '    End Using
        'End Using
        'Message(Me, "Saved", "Succefully")

        'If txtFleetIDSearch.Text = "" Then



    End Sub

    Protected Sub View(sender As Object, e As CommandEventArgs)


        Try



            Dim id = e.CommandArgument.ToString()
            Response.Redirect("~/Details.aspx?op=" + id)

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
        Response.Redirect("~/PassengerInsurance.aspx")
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
    Protected Sub bud(sender As Object, e As EventArgs)


    End Sub



    Protected Sub garage(sender As Object, e As EventArgs)

        Response.Redirect("~/VehicleLicence.aspx")
    End Sub

    Protected Sub Details(sender As Object, e As EventArgs)

        Response.Redirect("~/Details.aspx")
    End Sub

    Protected Sub cmdFleet_Click(sender As Object, e As EventArgs)
        'obj.ConnectionString = con
        'Dim qrySTR As String = "SELECT     A.OBJECTID, dbo.ENTASSETOBJECTTYPE.NAME AS TYPE, dbo.ENTASSETPRODUCT.DESCRIPTION AS PRODUCT_NAME_MAKE, dbo.ENTASSETMODEL.DESCRIPTION AS MODEL, A.NAME, A.NOTES, B.LOCATION, 
        '          dbo.ENTASSETFUNCTIONALLOCATION.LOGISTICSLOCATION, dbo.ENTASSETFUNCTIONALLOCATION.NAME AS FunctionalLocationName, dbo.ENTASSETFUNCTIONALLOCATION.NOTES AS FunctionalLocationNotes, A.OBJECTACTIVE
        '           FROM        dbo.ENTASSETOBJECTTABLE AS A LEFT OUTER JOIN
        '          dbo.ENTASSETPRODUCT ON A.PRODUCT = dbo.ENTASSETPRODUCT.RECID LEFT OUTER JOIN
        '          dbo.ENTASSETMODEL ON A.MODEL = dbo.ENTASSETMODEL.RECID LEFT OUTER JOIN
        '          dbo.ENTASSETOBJECTTYPE ON A.OBJECTTYPE = dbo.ENTASSETOBJECTTYPE.RECID LEFT OUTER JOIN
        '          dbo.ENTASSETFUNCTIONALLOCATION ON A.FUNCTIONALLOCATION = dbo.ENTASSETFUNCTIONALLOCATION.RECID LEFT OUTER JOIN
        '          dbo.ENTASSETOBJECTLIFECYCLEMODELSTATE ON A.OBJECTLIFECYCLESTATE = dbo.ENTASSETOBJECTLIFECYCLEMODELSTATE.RECID LEFT OUTER JOIN
        '          dbo.LOGISTICSPOSTALADDRESS AS B ON A.LOGISTICSLOCATION = B.LOCATION
        '          WHERE (dbo.ENTASSETOBJECTTYPE.NAME = N'Bus' OR
        '          dbo.ENTASSETOBJECTTYPE.NAME = N'Earth Moving Vehicle' OR
        '          dbo.ENTASSETOBJECTTYPE.NAME = N'Forklift' OR
        '          dbo.ENTASSETOBJECTTYPE.NAME = N'Heavy Motor Vehicle' OR
        '          dbo.ENTASSETOBJECTTYPE.NAME = N'Inspection Vehicle' OR
        '          dbo.ENTASSETOBJECTTYPE.NAME = N'Light Motor Vehicle' OR
        '          dbo.ENTASSETOBJECTTYPE.NAME = N'Personal Alc Vehicle' OR
        '          dbo.ENTASSETOBJECTTYPE.NAME = N'Rig' OR
        '          dbo.ENTASSETOBJECTTYPE.NAME = N'Tractor' OR
        '          dbo.ENTASSETOBJECTTYPE.NAME = N'Trailer' OR
        '          dbo.ENTASSETOBJECTTYPE.NAME = N'Utility Vehicle') AND (A.OBJECTACTIVE = 1)  AND A.OBJECTID = '" & txtFleetID.Text & "'"


        'Try



        '    Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, qrySTR)
        '    Dim dt As DataTable = ds.Tables(0)

        '    If dt.Rows.Count > 0 Then
        '        txtDesvription.Text = dt.Rows(0).Item("PRODUCT_NAME_MAKE").ToString & " " & dt.Rows(0).Item("MODEL").ToString
        '    End If


        'Catch ex As Exception
        '    txtDesvription.Text = "failed to get asset information"
        'End Try
        'ShowToastr(Me.Page)
        'ErrorMessage(Me, "Search failed", "No Asset with details")
    End Sub



    Protected Sub cmdReg_Click(sender As Object, e As EventArgs)

        'Dim qrySTR As String = "SELECT *  FROM [dbo].[tblVEHICLE] WHERE [REGID] = '" & txtReg.Text & "'"

        ''Dim cmd As New SqlCommand(qrySTR, obj)
        ''cmd.CommandType = CommandType.Text
        'obj.ConnectionString = con

        'Try

        '    Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, qrySTR)
        '    Dim dt As DataTable = ds.Tables(0)

        '    If dt.Rows.Count > 0 Then
        '        txtDesvription.Text = dt.Rows(0).Item("Make").ToString & " " & dt.Rows(0).Item("Model").ToString
        '    End If
        'Catch ex As Exception
        '    txtDesvription.Text = "failed to get asset information"
        '    ErrorMessage(Me, "Search failed", "No Asset with details")
        'End Try
        'ShowToastr(Me.Page)

    End Sub

End Class