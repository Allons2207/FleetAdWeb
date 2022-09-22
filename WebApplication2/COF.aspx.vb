Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Telerik.Web.UI
Imports ClassLibrary1
Imports System.Data.SqlClient
Imports System.Data
Imports System.Data.SqlClient.SqlConnection
Imports Microsoft.VisualBasic
Imports System.Configuration
Imports System.IO

Public Class COF
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
        Valida()
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
        Catch ex As Exception

        End Try


    End Sub
    Private Sub Valida()
        Dim aa = CokkiesWrapper.UserName
        Dim canViewLicence = "View all permits"

        Dim sql As String = "SELECT        k.ID, k.ROLE, k.Permission, i.ID AS Expr1, i.ROLE AS Expr2, i.Username AS [User], dbo.tblROLES.ID AS Expr3, dbo.tblROLES.Description
FROM            dbo.tbluserrolepermission AS k INNER JOIN
                         dbo.tbluserrole AS i ON k.ROLE = i.ROLE INNER JOIN
                         dbo.tblROLES ON i.ROLE = dbo.tblROLES.ID where  k.Permission ='" & canViewLicence & "' and i.Username ='" & aa & "' "
        obj.ConnectionString = con
        Try

            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            db.ExecuteDataSet(CommandType.Text, sql)
            Dim dt As DataTable = ds.Tables(0)
            If dt.Rows.Count < 1 Then
                Response.Redirect("~/Error.aspx")
            End If


        Catch ex As Exception

        End Try
    End Sub
    Private Sub loadExistingVehicleData()
        Dim sql As String = "SELECT * FROM tblCOF"
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


    Protected Sub cmdSave_Click(sender As Object, e As EventArgs) Handles cmdSave.Click

        'ShowToastr(Me.Page)

        Dim filename As String = Path.GetFileName(fdfile.PostedFile.FileName)
        Dim contentType As String = fdfile.PostedFile.ContentType
        Using fs As Stream = fdfile.PostedFile.InputStream
            Using br As New BinaryReader(fs)
                If Convert.ToDateTime(txtDateEx.Text) < Convert.ToDateTime(txtDateIssued.Text) Then
                    ErrorMessage(Me, "Issued Date cannot be greater than expiry date")
                    Exit Sub
                End If
                Dim bytes As Byte() = br.ReadBytes(DirectCast(fs.Length, Long))
                Try

                    Dim del = db.GetSqlStringCommand("DELETE FROM  [tblCOF] where FLEETID ='" & txtFleetID.Text & "'")
                    Dim deleted = db.ExecuteDataSet(del)
                Catch ex As Exception

                End Try
                Try
                    Dim insert1 = db.GetSqlStringCommand("INSERT INTO [tblHISTORY]([FLEETID],[LICNUMBER],[DATEISSUED],[DATEEXPIRY],[COMMENTS],[FILE],[CONTENTTYPE],[DATA],[POLICYID],[Userid],[DateModidfied])VALUES(@a,@b,@c,@d,@e,@f,@g,@h,@i,@j,@k)")


                    db.AddInParameter(insert1, "@a", System.Data.DbType.String, txtFleetID.Text)
                    db.AddInParameter(insert1, "@b", System.Data.DbType.String, txtLicence.Text)
                    db.AddInParameter(insert1, "@c", System.Data.DbType.Date, Convert.ToDateTime(txtDateIssued.Text))
                    db.AddInParameter(insert1, "@d", System.Data.DbType.Date, Convert.ToDateTime(txtDateEx.Text))
                    db.AddInParameter(insert1, "@e", System.Data.DbType.String, txtDateEx.Text)
                    db.AddInParameter(insert1, "@f", System.Data.DbType.String, filename)
                    db.AddInParameter(insert1, "@g", System.Data.DbType.String, contentType)
                    db.AddInParameter(insert1, "@h", System.Data.DbType.Binary, bytes)
                    db.AddInParameter(insert1, "@i", System.Data.DbType.String, "COF")
                    db.AddInParameter(insert1, "@j", System.Data.DbType.String, CokkiesWrapper.UserName)
                    db.AddInParameter(insert1, "@k", System.Data.DbType.String, DateTime.Now.ToString)
                    Dim insert_d1s = db.ExecuteDataSet(insert1)

                Catch ex As Exception

                End Try

                Dim insert = db.GetSqlStringCommand("INSERT INTO [tblCOF]([FLEETID],[LICNUMBER],[DATEISSUED],[DATEEXPIRY],[COMMENTS],[FILE],[CONTENTTYPE],[DATA])VALUES(@a,@b,@c,@d,@e,@f,@g,@h)")


                db.AddInParameter(insert, "@a", System.Data.DbType.String, txtFleetID.Text)
                db.AddInParameter(insert, "@b", System.Data.DbType.String, txtLicence.Text)
                db.AddInParameter(insert, "@c", System.Data.DbType.Date, Convert.ToDateTime(txtDateIssued.Text))
                db.AddInParameter(insert, "@d", System.Data.DbType.Date, Convert.ToDateTime(txtDateEx.Text))
                db.AddInParameter(insert, "@e", System.Data.DbType.String, txtDateEx.Text)
                db.AddInParameter(insert, "@f", System.Data.DbType.String, filename)
                db.AddInParameter(insert, "@g", System.Data.DbType.String, contentType)
                db.AddInParameter(insert, "@h", System.Data.DbType.Binary, bytes)
                Dim insert_ds = db.ExecuteDataSet(insert)
                Message(Me, "Saved", "Succefully")
            End Using
        End Using
        Message(Me, "Saved", "Succefully")



    End Sub



    Protected Sub cmdFleet_Click(sender As Object, e As EventArgs) Handles cmdFleet.Click
        obj.ConnectionString = con
        Dim qrySTR As String = "SELECT        A.OBJECTID, dbo.ENTASSETOBJECTTYPE.NAME AS TYPE, dbo.ENTASSETPRODUCT.DESCRIPTION AS PRODUCT_NAME_MAKE, dbo.ENTASSETMODEL.DESCRIPTION AS MODEL, A.NAME, A.NOTES, 
                         B.LOCATION, dbo.ENTASSETFUNCTIONALLOCATION.LOGISTICSLOCATION, dbo.ENTASSETFUNCTIONALLOCATION.NAME AS FunctionalLocationName, 
                         dbo.ENTASSETFUNCTIONALLOCATION.NOTES AS FunctionalLocationNotes, A.OBJECTACTIVE, dbo.ENTASSETFUNCTIONALLOCATION.FUNCTIONALLOCATIONID, dbo.ENTASSETOBJECTATTRIBUTE.DESCRIPTION, 
                         dbo.ENTASSETOBJECTATTRIBUTE.VALUESTRING
FROM            dbo.ENTASSETOBJECTTABLE AS A LEFT OUTER JOIN
                         dbo.ENTASSETPRODUCT ON A.PRODUCT = dbo.ENTASSETPRODUCT.RECID LEFT OUTER JOIN
                         dbo.ENTASSETMODEL ON A.MODEL = dbo.ENTASSETMODEL.RECID LEFT OUTER JOIN
                         dbo.ENTASSETOBJECTTYPE ON A.OBJECTTYPE = dbo.ENTASSETOBJECTTYPE.RECID LEFT OUTER JOIN
                         dbo.ENTASSETFUNCTIONALLOCATION ON A.FUNCTIONALLOCATION = dbo.ENTASSETFUNCTIONALLOCATION.RECID LEFT OUTER JOIN
                         dbo.ENTASSETOBJECTLIFECYCLEMODELSTATE ON A.OBJECTLIFECYCLESTATE = dbo.ENTASSETOBJECTLIFECYCLEMODELSTATE.RECID LEFT OUTER JOIN
                         dbo.LOGISTICSPOSTALADDRESS AS B ON A.LOGISTICSLOCATION = B.LOCATION INNER JOIN
                         dbo.ENTASSETOBJECTATTRIBUTE ON dbo.ENTASSETOBJECTATTRIBUTE.OBJECT = A.RECID
WHERE        ((dbo.ENTASSETFUNCTIONALLOCATION.FUNCTIONALLOCATIONID = N'A650') AND (dbo.ENTASSETOBJECTATTRIBUTE.DESCRIPTION = N'Registration Number') OR
                         (dbo.ENTASSETFUNCTIONALLOCATION.FUNCTIONALLOCATIONID = N'E850') AND (dbo.ENTASSETOBJECTATTRIBUTE.DESCRIPTION = N'Registration Number') OR
                         (dbo.ENTASSETFUNCTIONALLOCATION.FUNCTIONALLOCATIONID = N'H705') AND (dbo.ENTASSETOBJECTATTRIBUTE.DESCRIPTION = N'Registration Number') OR
                         (dbo.ENTASSETFUNCTIONALLOCATION.FUNCTIONALLOCATIONID = N'E880') AND (dbo.ENTASSETOBJECTATTRIBUTE.DESCRIPTION = N'Registration Number') AND (A.OBJECTACTIVE = 1))  AND A.OBJECTID = '" & txtFleetID.Text & "'"


        Try



            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, qrySTR)
            Dim dt As DataTable = ds.Tables(0)

            If dt.Rows.Count > 0 Then
                txtDesvription.Text = dt.Rows(0).Item("PRODUCT_NAME_MAKE").ToString & " " & dt.Rows(0).Item("MODEL").ToString
                txtfleet.Text = dt.Rows(0).Item("TYPE").ToString
                txtReg.Text = dt.Rows(0).Item("VALUESTRING").ToString
                Message(Me, "Found", "Details")
            End If


        Catch ex As Exception
            txtDesvription.Text = "failed to get asset information"
            ErrorMessage(Me, "Search failed", "No Asset with details")
        End Try
        ShowToastr(Me.Page)
    End Sub

    Protected Sub DownloadFile(sender As Object, e As EventArgs)
        Dim id As Integer = Integer.Parse(TryCast(sender, LinkButton).CommandArgument)
        Dim bytes As Byte()
        Dim fileName As String, contentType As String

        Dim Query As String = "SELECT * FROM tblCOF WHERE ID = '" & id & "'"


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
    Protected Sub Del(sender As Object, e As EventArgs)
        Dim aa = CokkiesWrapper.UserName
        Dim canViewLicence = "Update_or _edit"

        Dim sql As String = "SELECT        k.ID, k.ROLE, k.Permission, i.ID AS Expr1, i.ROLE AS Expr2, i.Username AS [User], dbo.tblROLES.ID AS Expr3, dbo.tblROLES.Description
FROM            dbo.tbluserrolepermission AS k INNER JOIN
                         dbo.tbluserrole AS i ON k.ROLE = i.ROLE INNER JOIN
                         dbo.tblROLES ON i.ROLE = dbo.tblROLES.ID where  k.Permission ='" & canViewLicence & "' and i.Username ='" & aa & "' "
        obj.ConnectionString = con
        Try

            Dim dX As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            db.ExecuteDataSet(CommandType.Text, sql)
            Dim dXt As DataTable = dX.Tables(0)
            If dXt.Rows.Count < 1 Then
                Response.Redirect("~/Error.aspx")
                Exit Sub
            End If


        Catch ex As Exception

        End Try
        Dim id As Integer = Integer.Parse(TryCast(sender, LinkButton).CommandArgument)


        Dim Query As String = "DELETE FROM tblCOF WHERE ID = '" & id & "'"


        Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, Query)



        Message(Me, "Succesfully", "Deleted")



    End Sub

    Protected Sub Update(sender As Object, e As EventArgs)
        Dim aa = CokkiesWrapper.UserName
        Dim canViewLicence = "Update_or _edit"

        Dim sql As String = "SELECT        k.ID, k.ROLE, k.Permission, i.ID AS Expr1, i.ROLE AS Expr2, i.Username AS [User], dbo.tblROLES.ID AS Expr3, dbo.tblROLES.Description
FROM            dbo.tbluserrolepermission AS k INNER JOIN
                         dbo.tbluserrole AS i ON k.ROLE = i.ROLE INNER JOIN
                         dbo.tblROLES ON i.ROLE = dbo.tblROLES.ID where  k.Permission ='" & canViewLicence & "' and i.Username ='" & aa & "' "
        obj.ConnectionString = con
        Try

            Dim dX As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            db.ExecuteDataSet(CommandType.Text, sql)
            Dim dXt As DataTable = dX.Tables(0)
            If dXt.Rows.Count < 1 Then
                Response.Redirect("~/Error.aspx")
                Exit Sub
            End If


        Catch ex As Exception

        End Try
        ShowToastr(Me.Page)
        Dim id As Integer = Integer.Parse(TryCast(sender, LinkButton).CommandArgument)


        Dim Query As String = "SELECT * FROM tblCOF WHERE ID = '" & id & "'"


        Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, Query)
        Dim dt As DataTable = ds.Tables(0)

        If dt.Rows.Count > 0 Then
            Dim af As Date = Convert.ToDateTime(dt.Rows(0).Item("DATEEXPIRY").ToString)
            Dim ak As Date = Convert.ToDateTime(dt.Rows(0).Item("DATEISSUED").ToString)
            txtDateEx.Text = af.ToString("yyyy-MM-dd")
            txtDateIssued.Text = af.ToString("yyyy-MM-dd")
            txtFleetID.Text = dt.Rows(0).Item("FLEETID").ToString()

            txtLicence.Text = dt.Rows(0).Item("LICNUMBER").ToString()
            Dim qrySTR As String = "SELECT        A.OBJECTID, dbo.ENTASSETOBJECTTYPE.NAME AS TYPE, dbo.ENTASSETPRODUCT.DESCRIPTION AS PRODUCT_NAME_MAKE, dbo.ENTASSETMODEL.DESCRIPTION AS MODEL, A.NAME, A.NOTES, 
                         B.LOCATION, dbo.ENTASSETFUNCTIONALLOCATION.LOGISTICSLOCATION, dbo.ENTASSETFUNCTIONALLOCATION.NAME AS FunctionalLocationName, 
                         dbo.ENTASSETFUNCTIONALLOCATION.NOTES AS FunctionalLocationNotes, A.OBJECTACTIVE, dbo.ENTASSETFUNCTIONALLOCATION.FUNCTIONALLOCATIONID, dbo.ENTASSETOBJECTATTRIBUTE.DESCRIPTION, 
                         dbo.ENTASSETOBJECTATTRIBUTE.VALUESTRING
FROM            dbo.ENTASSETOBJECTTABLE AS A LEFT OUTER JOIN
                         dbo.ENTASSETPRODUCT ON A.PRODUCT = dbo.ENTASSETPRODUCT.RECID LEFT OUTER JOIN
                         dbo.ENTASSETMODEL ON A.MODEL = dbo.ENTASSETMODEL.RECID LEFT OUTER JOIN
                         dbo.ENTASSETOBJECTTYPE ON A.OBJECTTYPE = dbo.ENTASSETOBJECTTYPE.RECID LEFT OUTER JOIN
                         dbo.ENTASSETFUNCTIONALLOCATION ON A.FUNCTIONALLOCATION = dbo.ENTASSETFUNCTIONALLOCATION.RECID LEFT OUTER JOIN
                         dbo.ENTASSETOBJECTLIFECYCLEMODELSTATE ON A.OBJECTLIFECYCLESTATE = dbo.ENTASSETOBJECTLIFECYCLEMODELSTATE.RECID LEFT OUTER JOIN
                         dbo.LOGISTICSPOSTALADDRESS AS B ON A.LOGISTICSLOCATION = B.LOCATION INNER JOIN
                         dbo.ENTASSETOBJECTATTRIBUTE ON dbo.ENTASSETOBJECTATTRIBUTE.OBJECT = A.RECID
WHERE        ((dbo.ENTASSETFUNCTIONALLOCATION.FUNCTIONALLOCATIONID = N'A650') AND (dbo.ENTASSETOBJECTATTRIBUTE.DESCRIPTION = N'Registration Number') OR
                         (dbo.ENTASSETFUNCTIONALLOCATION.FUNCTIONALLOCATIONID = N'E850') AND (dbo.ENTASSETOBJECTATTRIBUTE.DESCRIPTION = N'Registration Number') OR
                         (dbo.ENTASSETFUNCTIONALLOCATION.FUNCTIONALLOCATIONID = N'H705') AND (dbo.ENTASSETOBJECTATTRIBUTE.DESCRIPTION = N'Registration Number') OR
                         (dbo.ENTASSETFUNCTIONALLOCATION.FUNCTIONALLOCATIONID = N'E880') AND (dbo.ENTASSETOBJECTATTRIBUTE.DESCRIPTION = N'Registration Number') AND (A.OBJECTACTIVE = 1))  AND A.OBJECTID = '" & txtFleetID.Text & "'"

            Dim ds1 As DataSet = db.ExecuteDataSet(CommandType.Text, qrySTR)
            Dim dt1 As DataTable = ds1.Tables(0)

            If dt1.Rows.Count > 0 Then
                txtDesvription.Text = dt1.Rows(0).Item("PRODUCT_NAME_MAKE").ToString & " " & dt1.Rows(0).Item("MODEL").ToString
                txtfleet.Text = dt1.Rows(0).Item("TYPE").ToString
                txtReg.Text = dt1.Rows(0).Item("VALUESTRING").ToString
                Message(Me, "Found", "Details")
            Else
                txtDesvription.Text = "Missing"
                txtfleet.Text = "Missing"
                txtReg.Text = "Missing"
            End If
        End If


    End Sub

    Protected Sub cmdReg_Click(sender As Object, e As EventArgs) Handles cmdReg.Click


        Dim qrySTR As String = "SELECT        A.OBJECTID, dbo.ENTASSETOBJECTTYPE.NAME AS TYPE, dbo.ENTASSETPRODUCT.DESCRIPTION AS PRODUCT_NAME_MAKE, dbo.ENTASSETMODEL.DESCRIPTION AS MODEL, A.NAME, A.NOTES, 
                         B.LOCATION, dbo.ENTASSETFUNCTIONALLOCATION.LOGISTICSLOCATION, dbo.ENTASSETFUNCTIONALLOCATION.NAME AS FunctionalLocationName, 
                         dbo.ENTASSETFUNCTIONALLOCATION.NOTES AS FunctionalLocationNotes, A.OBJECTACTIVE, dbo.ENTASSETFUNCTIONALLOCATION.FUNCTIONALLOCATIONID, dbo.ENTASSETOBJECTATTRIBUTE.DESCRIPTION, 
                         dbo.ENTASSETOBJECTATTRIBUTE.VALUESTRING
FROM            dbo.ENTASSETOBJECTTABLE AS A LEFT OUTER JOIN
                         dbo.ENTASSETPRODUCT ON A.PRODUCT = dbo.ENTASSETPRODUCT.RECID LEFT OUTER JOIN
                         dbo.ENTASSETMODEL ON A.MODEL = dbo.ENTASSETMODEL.RECID LEFT OUTER JOIN
                         dbo.ENTASSETOBJECTTYPE ON A.OBJECTTYPE = dbo.ENTASSETOBJECTTYPE.RECID LEFT OUTER JOIN
                         dbo.ENTASSETFUNCTIONALLOCATION ON A.FUNCTIONALLOCATION = dbo.ENTASSETFUNCTIONALLOCATION.RECID LEFT OUTER JOIN
                         dbo.ENTASSETOBJECTLIFECYCLEMODELSTATE ON A.OBJECTLIFECYCLESTATE = dbo.ENTASSETOBJECTLIFECYCLEMODELSTATE.RECID LEFT OUTER JOIN
                         dbo.LOGISTICSPOSTALADDRESS AS B ON A.LOGISTICSLOCATION = B.LOCATION INNER JOIN
                         dbo.ENTASSETOBJECTATTRIBUTE ON dbo.ENTASSETOBJECTATTRIBUTE.OBJECT = A.RECID
WHERE        ((dbo.ENTASSETFUNCTIONALLOCATION.FUNCTIONALLOCATIONID = N'A650') AND (dbo.ENTASSETOBJECTATTRIBUTE.DESCRIPTION = N'Registration Number') OR
                         (dbo.ENTASSETFUNCTIONALLOCATION.FUNCTIONALLOCATIONID = N'E850') AND (dbo.ENTASSETOBJECTATTRIBUTE.DESCRIPTION = N'Registration Number') OR
                         (dbo.ENTASSETFUNCTIONALLOCATION.FUNCTIONALLOCATIONID = N'H705') AND (dbo.ENTASSETOBJECTATTRIBUTE.DESCRIPTION = N'Registration Number') OR
                         (dbo.ENTASSETFUNCTIONALLOCATION.FUNCTIONALLOCATIONID = N'E880') AND (dbo.ENTASSETOBJECTATTRIBUTE.DESCRIPTION = N'Registration Number') AND (A.OBJECTACTIVE = 1))  AND dbo.ENTASSETOBJECTATTRIBUTE.VALUESTRING = '" & txtReg.Text & "'"

        'Dim cmd As New SqlCommand(qrySTR, obj)
        'cmd.CommandType = CommandType.Text
        obj.ConnectionString = con

        Try

            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, qrySTR)
            Dim dt As DataTable = ds.Tables(0)

            If dt.Rows.Count > 0 Then
                txtDesvription.Text = dt.Rows(0).Item("PRODUCT_NAME_MAKE").ToString & " " & dt.Rows(0).Item("MODEL").ToString
                txtfleet.Text = dt.Rows(0).Item("TYPE").ToString
                txtFleetID.Text = dt.Rows(0).Item("OBJECTID").ToString
                Message(Me, "Found", "Details")
            End If
        Catch ex As Exception
            txtDesvription.Text = "failed to get asset information"
            ErrorMessage(Me, "Search failed", "No Asset with details")
        End Try
        ShowToastr(Me.Page)
    End Sub

End Class