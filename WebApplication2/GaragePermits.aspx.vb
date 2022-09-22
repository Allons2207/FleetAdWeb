Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Telerik.Web.UI
Imports ClassLibrary1
Imports System.Data.SqlClient
Imports System.Data
Imports System.Data.SqlClient.SqlConnection
Imports Microsoft.VisualBasic
Imports System.Configuration
Imports System.IO
Public Class GaragePermits
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
    Public Shared Sub ShowAlert(ByVal page As Page)
        'page.ClientScript.RegisterStartupScript(page.GetType(), "Popup", "$('#modal-form').modal.('show')", True)

        'page.ClientScript.RegisterStartupScript(page.GetType(), "randomText", "$(window).load(function() {$('#modal-form').modal('show');});", True)
        'page.ClientScript.RegisterStartupScript(page.GetType(), "script", "openpopup();", True)
        page.ClientScript.RegisterStartupScript(page.GetType(), "randomText", "material.showSwal('success-message')", True)


    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Page.ClientScript.RegisterClientScriptInclude("jQuery", "https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js")
        Page.ClientScript.RegisterClientScriptInclude("jQuery", "https://code.jquery.com/jquery-3.6.0.js")
        Page.ClientScript.RegisterClientScriptInclude("jQuery", "/assets/js/core/bootstrap.min.js")
        Page.ClientScript.RegisterClientScriptInclude("jQuery", "https://unpkg.com/sweetalert/dist/sweetalert.min.js")

        If Not IsPostBack Then
            loadExistingVehicleData()
            VehicleData()
            'ShowToastr(Me.Page)
            'Page.ClientScript.RegisterStartupScript(Page.GetType(), "randomText", "$(document).ready(function () {$('#modal-form').modal('show');});", True)
            'Page.ClientScript.RegisterStartupScript(Page.GetType(), "script", "openpopup();", True)

            If Not IsNothing(Request.QueryString("op")) Then
                loadExistingVehicleData()
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
            GridView1.UseAccessibleHeader = True
            GridView1.HeaderRow.TableSection = TableRowSection.TableHeader
        Catch ex As Exception

        End Try

    End Sub


    Private Sub loadExistingVehicleData()
        Dim sql As String = "SELECT * FROM tblSANDANDGRAVEL"
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
                  dbo.ENTASSETOBJECTTYPE.NAME = N'Rig' OR
                  dbo.ENTASSETOBJECTTYPE.NAME = N'Tractor' OR
                  dbo.ENTASSETOBJECTTYPE.NAME = N'Trailer' OR
                  dbo.ENTASSETOBJECTTYPE.NAME = N'Utility Vehicle') AND (A.OBJECTACTIVE = 1)"
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


    End Sub

    Protected Sub DownloadFile(sender As Object, e As EventArgs)
        Dim id As Integer = Integer.Parse(TryCast(sender, LinkButton).CommandArgument)
        Dim bytes As Byte()
        Dim fileName As String, contentType As String

        Dim Query As String = "SELECT * FROM tblSANDANDGRAVEL WHERE ID = '" & id & "'"


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

    Protected Sub Bulk_Insert(sender As Object, e As EventArgs)
        Dim filename As String = Path.GetFileName(fdfile.PostedFile.FileName)
        Dim contenType As String = fdfile.PostedFile.ContentType
        Using fs As Stream = fdfile.PostedFile.InputStream
            Using br As New BinaryReader(fs)
                Dim bytes As Byte() = br.ReadBytes(DirectCast(fs.Length, Long))
                Dim dt As New DataTable()
                dt.Columns.AddRange(New DataColumn(7) {New DataColumn("FLEETID", GetType(String)), New DataColumn("LICNUMBER", GetType(String)), New DataColumn("DATEISSUED", GetType(DateTime)), New DataColumn("DATEEXPIRY", GetType(DateTime)), New DataColumn("COMMENTS", GetType(String)), New DataColumn("FILE", GetType(String)), New DataColumn("CONTENTTYPE", GetType(String)), New DataColumn("DATA", GetType(Byte()))})
                For Each row As GridViewRow In GridView1.Rows
                    If TryCast(row.FindControl("chkRow"), CheckBox).Checked Then
                        Dim FLEETID As String = row.Cells(1).Text
                        Dim LICNUMBER As String = txtLicence.Text
                        Dim DATEISSUED As DateTime = Convert.ToDateTime(txtDateIssued.Text)
                        Dim DATEEXPIRY As DateTime = Convert.ToDateTime(txtDateEx.Text)
                        Dim COMMENTS As String = txtComment.Text
                        Dim FILE As String = filename
                        Dim CONTENTTYPE As String = contenType
                        Dim DATA As Byte() = bytes
                        dt.Rows.Add(FLEETID, LICNUMBER, DATEISSUED, DATEEXPIRY, COMMENTS, FILE, CONTENTTYPE, DATA)



                        'Dim insert = db.GetSqlStringCommand("INSERT INTO [tblSANDANDGRAVEL]([FLEETID],[LICNUMBER],[DATEISSUED],[DATEEXPIRY],[COMMENTS],[FILE],[CONTENTTYPE],[DATA])VALUES(@a,@b,@c,@d,@e,@f,@g,@h)")


                        'db.AddInParameter(insert, "@a", System.Data.DbType.String, FLEETID)
                        'db.AddInParameter(insert, "@b", System.Data.DbType.String, txtLicence.Text)
                        'db.AddInParameter(insert, "@c", System.Data.DbType.Date, Convert.ToDateTime(txtDateIssued.Text))
                        'db.AddInParameter(insert, "@d", System.Data.DbType.Date, Convert.ToDateTime(txtDateEx.Text))
                        'db.AddInParameter(insert, "@e", System.Data.DbType.String, txtDateEx.Text)
                        'db.AddInParameter(insert, "@f", System.Data.DbType.String, filename)
                        'db.AddInParameter(insert, "@g", System.Data.DbType.String, CONTENTTYPE)
                        'db.AddInParameter(insert, "@h", System.Data.DbType.Binary, bytes)
                        'Dim insert_ds = db.ExecuteDataSet(insert)
                    End If
                Next

                If dt.Rows.Count > 0 Then
                    Dim consString As String = db.ConnectionString
                    Using con As New SqlConnection(consString)
                        Using sqlBulkCopy As New SqlBulkCopy(con)
                            'Set the database table name
                            sqlBulkCopy.DestinationTableName = "dbo.tblSANDANDGRAVEL"

                            '[OPTIONAL]: Map the DataTable columns with that of the database table
                            sqlBulkCopy.ColumnMappings.Add("FLEETID", "FLEETID")
                            sqlBulkCopy.ColumnMappings.Add("LICNUMBER", "LICNUMBER")
                            sqlBulkCopy.ColumnMappings.Add("DATEISSUED", "DATEISSUED")
                            sqlBulkCopy.ColumnMappings.Add("DATEEXPIRY", "DATEEXPIRY")
                            sqlBulkCopy.ColumnMappings.Add("COMMENTS", "COMMENTS")
                            sqlBulkCopy.ColumnMappings.Add("FILE", "FILE")
                            sqlBulkCopy.ColumnMappings.Add("CONTENTTYPE", "CONTENTTYPE")
                            sqlBulkCopy.ColumnMappings.Add("DATA", "DATA")
                            con.Open()
                            sqlBulkCopy.WriteToServer(dt)
                            con.Close()

                        End Using
                    End Using
                End If
            End Using
        End Using

        ErrorMessage(Me, "Saved", "Succesfully")
    End Sub

    Protected Sub cmdSave_Click(sender As Object, e As EventArgs)

    End Sub
End Class