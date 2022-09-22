Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Telerik.Web.UI
Imports ClassLibrary1
Imports System.Data.SqlClient
Imports System.Data
Imports System.Data.SqlClient.SqlConnection
Imports Microsoft.VisualBasic
Imports System.Configuration
Imports System.IO

Public Class Details
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

            'ShowToastr(Me.Page)
            'Page.ClientScript.RegisterStartupScript(Page.GetType(), "randomText", "$(document).ready(function () {$('#modal-form').modal('show');});", True)
            'Page.ClientScript.RegisterStartupScript(Page.GetType(), "script", "openpopup();", True)

            Loadlist()
            If Not IsNothing(Request.QueryString("op")) Then
                loadDriversData()
                Loadlist()
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
        Dim sql As String = "SELECT        dbo.tblLICENCE.FLEETID, dbo.tblLICENCE.LICNUMBER, dbo.tblLICENCE.DATEISSUED, dbo.tblLICENCE.DATEEXPIRY, dbo.tblLICENCE.COMMENTS, dbo.tblLICENCE.[FILE], dbo.tblZBC.LICNUMBER AS LICZB, 
                         dbo.tblZBC.DATEISSUED AS ISUZB, dbo.tblZBC.DATEEXPIRY AS EXPZB, dbo.tblZBC.COMMENTS AS COMZB, dbo.tblZINARA.LICNUMBER AS LICZIN, dbo.tblZINARA.DATEISSUED AS DATEZN, 
                         dbo.tblZINARA.DATEEXPIRY AS EXPZIN, dbo.tblZINARA.COMMENTS AS COMZIN
FROM            dbo.tblLICENCE INNER JOIN
                         dbo.tblZBC ON dbo.tblLICENCE.FLEETID = dbo.tblZBC.FLEETID INNER JOIN
                         dbo.tblZINARA ON dbo.tblZBC.FLEETID = dbo.tblZINARA.FLEETID
WHERE dbo.tblLICENCE.FLEETID = '" & Request.QueryString("op") & "'"
        obj.ConnectionString = con

        'Dim myUser As New SecurityPolicy.UserManager(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)
        'Dim myAdmin As New AdminSettings(CookiesWrapper.thisConnectionName, 0)
        'Dim audit As New UserAudit(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            db.ExecuteDataSet(CommandType.Text, sql)
            Dim dt As DataTable = ds.Tables(0)
            DropDownList1.SelectedValue = dt.Rows(0).Item("FLEETID").ToString
            txcommzin.Text = dt.Rows(0).Item("COMZIN").ToString
            txtcommzb.Text = dt.Rows(0).Item("COMZB").ToString
            txtxcommin.Text = dt.Rows(0).Item("COMMENTS").ToString
            txtlic.Text = dt.Rows(0).Item("LICZiN").ToString
            txtlicin.Text = dt.Rows(0).Item("LICNUMBER").ToString
            txtliczb.Text = dt.Rows(0).Item("LICZB").ToString
            fdfile.Enabled = False
            Dim a As Date = Convert.ToDateTime(dt.Rows(0).Item("DATEISSUED").ToString)
            Dim b As Date = Convert.ToDateTime(dt.Rows(0).Item("ISUZB").ToString)
            Dim c As Date = Convert.ToDateTime(dt.Rows(0).Item("DATEZN").ToString)





            txtstartin.Text = a.ToString("yyyy-MM-dd")
            txtstartzb.Text = b.ToString("yyyy-MM-dd")
            txtstartzin.Text = c.ToString("yyyy-MM-dd")

            Dim x As Date = Convert.ToDateTime(dt.Rows(0).Item("DATEEXPIRY").ToString)
            Dim y As Date = Convert.ToDateTime(dt.Rows(0).Item("EXPZB").ToString)
            Dim z As Date = Convert.ToDateTime(dt.Rows(0).Item("EXPZIN").ToString)



            txtendin.Text = x.ToString("yyyy-MM-dd")
            txtendzb.Text = y.ToString("yyyy-MM-dd")
            txtendzin.Text = z.ToString("yyyy-MM-dd")
            txtlicin.Text = dt.Rows(0).Item("COMZIN").ToString
            allons()



        Catch ex As Exception
            'log.Error(ex)
        End Try

    End Sub


    Private Sub allons()
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
                  dbo.ENTASSETOBJECTTYPE.NAME = N'Tractor' OR
                  dbo.ENTASSETOBJECTTYPE.NAME = N'Trailer') AND (A.OBJECTACTIVE = 1) AND A.OBJECTID = '" & Request.QueryString("op") & "' "
        obj.ConnectionString = con

        'Dim myUser As New SecurityPolicy.UserManager(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)
        'Dim myAdmin As New AdminSettings(CookiesWrapper.thisConnectionName, 0)
        'Dim audit As New UserAudit(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            db.ExecuteDataSet(CommandType.Text, sql)
            Dim dt As DataTable = ds.Tables(0)

            If dt.Rows.Count > 0 Then
                Dim id = dt.Rows(0).Item("PRODUCT_NAME_MAKE").ToString + " " + dt.Rows(0).Item("MODEL").ToString

                If id = " " Then
                    txtdesc.Text = "Missing Make and Model"
                Else
                    txtdesc.Text = id
                End If
            Else
                txtdesc.Text = "Invalid ID"
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
    Protected Sub DownloadFile(sender As Object, e As EventArgs)

        Dim sql As String = "SELECT        A.OBJECTID, dbo.ENTASSETOBJECTTYPE.NAME AS TYPE, dbo.ENTASSETPRODUCT.DESCRIPTION AS PRODUCT_NAME_MAKE, dbo.ENTASSETMODEL.DESCRIPTION AS MODEL, A.NAME, A.NOTES, 
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
                         (dbo.ENTASSETFUNCTIONALLOCATION.FUNCTIONALLOCATIONID = N'E880') AND (dbo.ENTASSETOBJECTATTRIBUTE.DESCRIPTION = N'Registration Number') AND (A.OBJECTACTIVE = 1))  AND A.OBJECTID AND A.OBJECTID = '" & DropDownList1.SelectedValue & "' "
        obj.ConnectionString = con

        'Dim myUser As New SecurityPolicy.UserManager(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)
        'Dim myAdmin As New AdminSettings(CookiesWrapper.thisConnectionName, 0)
        'Dim audit As New UserAudit(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            db.ExecuteDataSet(CommandType.Text, sql)
            Dim dt As DataTable = ds.Tables(0)

            If dt.Rows.Count > 0 Then
                Dim id = dt.Rows(0).Item("PRODUCT_NAME_MAKE").ToString + " " + dt.Rows(0).Item("MODEL").ToString

                If id = " " Then
                    txtdesc.Text = "Missing Make and Model"
                Else
                    txtdesc.Text = id
                    txtreg.Text = dt.Rows(0).Item("VALUESTRING").ToString
                End If
            Else
                txtdesc.Text = "Invalid ID"
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
                  WHERE (dbo.ENTASSETOBJECTTYPE.NAME = N'Bus' OR
                  dbo.ENTASSETOBJECTTYPE.NAME = N'Earth Moving Vehicle' OR
                  dbo.ENTASSETOBJECTTYPE.NAME = N'Forklift' OR
                  dbo.ENTASSETOBJECTTYPE.NAME = N'Heavy Motor Vehicle' OR
                  dbo.ENTASSETOBJECTTYPE.NAME = N'Inspection Vehicle' OR
                  dbo.ENTASSETOBJECTTYPE.NAME = N'Light Motor Vehicle' OR
                  dbo.ENTASSETOBJECTTYPE.NAME = N'Personal Alc Vehicle' OR
                  dbo.ENTASSETOBJECTTYPE.NAME = N'Tractor' OR
                  dbo.ENTASSETOBJECTTYPE.NAME = N'Trailer') AND (A.OBJECTACTIVE = 1)"
            obj.ConnectionString = con
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)

            Dim dt As DataTable = ds.Tables(0)
            Dim x As Integer = dt.Rows.Count
            With DropDownList1
                Try
                    DropDownList1.DataSource = ds.Tables(0)
                    DropDownList1.DataTextField = "OBJECTID"
                    DropDownList1.DataValueField = "OBJECTID"
                    DropDownList1.DataBind()
                Catch ex As Exception
                    '  log.Error(ex.Message)
                End Try
            End With
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


            Catch ex As Exception

            End Try
            Message(Me, "Succesfully", "Saved")

        End Using
    End Sub



    Protected Sub cmdSave(sender As Object, e As EventArgs)

        'ShowToastr(Me.Page)

        Try

            Dim filename As String = Path.GetFileName(fdfile.PostedFile.FileName)
            Dim contentType As String = fdfile.PostedFile.ContentType
            Using fs As Stream = fdfile.PostedFile.InputStream
                Using br As New BinaryReader(fs)
                    Dim bytes As Byte() = br.ReadBytes(DirectCast(fs.Length, Long))

                    Try

                        Try

                            Dim del = db.GetSqlStringCommand("DELETE FROM  [tblLICENCE] where FLEETID ='" & DropDownList1.SelectedValue & "'")
                            Dim deleted = db.ExecuteDataSet(del)
                        Catch ex As Exception

                        End Try
                        Try
                            Dim insert1 = db.GetSqlStringCommand("INSERT INTO [tblHISTORY]([FLEETID],[LICNUMBER],[DATEISSUED],[DATEEXPIRY],[COMMENTS],[FILE],[CONTENTTYPE],[DATA],[POLICYID],[Userid],[DateModidfied])VALUES(@a,@b,@c,@d,@e,@f,@g,@h,@i,@j,@k)")


                            db.AddInParameter(insert1, "@a", System.Data.DbType.String, DropDownList1.SelectedValue)
                            db.AddInParameter(insert1, "@b", System.Data.DbType.String, txtlicin.Text)
                            db.AddInParameter(insert1, "@c", System.Data.DbType.Date, Convert.ToDateTime(txtstartin.Text))
                            db.AddInParameter(insert1, "@d", System.Data.DbType.Date, Convert.ToDateTime(txtendin.Text))
                            db.AddInParameter(insert1, "@e", System.Data.DbType.String, txtxcommin.Text)
                            db.AddInParameter(insert1, "@f", System.Data.DbType.String, filename)
                            db.AddInParameter(insert1, "@g", System.Data.DbType.String, contentType)
                            db.AddInParameter(insert1, "@h", System.Data.DbType.Binary, bytes)
                            db.AddInParameter(insert1, "@i", System.Data.DbType.String, "Insurance")
                            db.AddInParameter(insert1, "@j", System.Data.DbType.String, CokkiesWrapper.UserName)
                            db.AddInParameter(insert1, "@k", System.Data.DbType.String, DateTime.Now.ToString)
                            Dim insert_d1s = db.ExecuteDataSet(insert1)

                        Catch ex As Exception

                        End Try

                        Dim insert = db.GetSqlStringCommand("INSERT INTO [tblLICENCE]([FLEETID],[LICNUMBER],[DATEISSUED],[DATEEXPIRY],[COMMENTS],[FILE],[CONTENTTYPE],[DATA])VALUES(@a,@b,@c,@d,@e,@f,@g,@h)")


                        db.AddInParameter(insert, "@a", System.Data.DbType.String, DropDownList1.SelectedValue)
                        db.AddInParameter(insert, "@b", System.Data.DbType.String, txtlicin.Text)
                        db.AddInParameter(insert, "@c", System.Data.DbType.Date, Convert.ToDateTime(txtstartin.Text))
                        db.AddInParameter(insert, "@d", System.Data.DbType.Date, Convert.ToDateTime(txtendin.Text))
                        db.AddInParameter(insert, "@e", System.Data.DbType.String, txtxcommin.Text)
                        db.AddInParameter(insert, "@f", System.Data.DbType.String, filename)
                        db.AddInParameter(insert, "@g", System.Data.DbType.String, contentType)
                        db.AddInParameter(insert, "@h", System.Data.DbType.Binary, bytes)
                        Dim insert_ds = db.ExecuteDataSet(insert)
                    Catch ex As Exception

                    End Try


                    Try


                        Try

                            Dim del = db.GetSqlStringCommand("DELETE FROM  [tblZBC] where FLEETID ='" & DropDownList1.SelectedValue & "'")
                            Dim deleted = db.ExecuteDataSet(del)
                        Catch ex As Exception

                        End Try


                        Try
                            Dim insert1 = db.GetSqlStringCommand("INSERT INTO [tblHISTORY]([FLEETID],[LICNUMBER],[DATEISSUED],[DATEEXPIRY],[COMMENTS],[FILE],[CONTENTTYPE],[DATA],[POLICYID],[Userid],[DateModidfied])VALUES(@a,@b,@c,@d,@e,@f,@g,@h,@i,@j,@k)")


                            db.AddInParameter(insert1, "@a", System.Data.DbType.String, DropDownList1.SelectedValue)
                            db.AddInParameter(insert1, "@b", System.Data.DbType.String, txtliczb.Text)
                            db.AddInParameter(insert1, "@c", System.Data.DbType.Date, Convert.ToDateTime(txtstartzb.Text))
                            db.AddInParameter(insert1, "@d", System.Data.DbType.Date, Convert.ToDateTime(txtendzb.Text))
                            db.AddInParameter(insert1, "@e", System.Data.DbType.String, txtxcommin.Text)
                            db.AddInParameter(insert1, "@f", System.Data.DbType.String, filename)
                            db.AddInParameter(insert1, "@g", System.Data.DbType.String, contentType)
                            db.AddInParameter(insert1, "@h", System.Data.DbType.Binary, bytes)
                            db.AddInParameter(insert1, "@i", System.Data.DbType.String, "ZBC")
                            db.AddInParameter(insert1, "@j", System.Data.DbType.String, CokkiesWrapper.UserName)
                            db.AddInParameter(insert1, "@k", System.Data.DbType.String, DateTime.Now.ToString)
                            Dim insert_d1s = db.ExecuteDataSet(insert1)

                        Catch ex As Exception

                        End Try
                        Dim insert = db.GetSqlStringCommand("INSERT INTO [tblZBC]([FLEETID],[LICNUMBER],[DATEISSUED],[DATEEXPIRY],[COMMENTS],[FILE],[CONTENTTYPE],[DATA])VALUES(@a,@b,@c,@d,@e,@f,@g,@h)")




                        db.AddInParameter(insert, "@a", System.Data.DbType.String, DropDownList1.SelectedValue)
                        db.AddInParameter(insert, "@b", System.Data.DbType.String, txtliczb.Text)
                        db.AddInParameter(insert, "@c", System.Data.DbType.Date, Convert.ToDateTime(txtstartzb.Text))
                        db.AddInParameter(insert, "@d", System.Data.DbType.Date, Convert.ToDateTime(txtendzb.Text))
                        db.AddInParameter(insert, "@e", System.Data.DbType.String, txtcommzb.Text)
                        db.AddInParameter(insert, "@f", System.Data.DbType.String, filename)
                        db.AddInParameter(insert, "@g", System.Data.DbType.String, contentType)
                        db.AddInParameter(insert, "@h", System.Data.DbType.Binary, bytes)
                        Dim insert_ds = db.ExecuteDataSet(insert)
                    Catch ex As Exception

                    End Try


                    Try

                        Try

                            Dim del = db.GetSqlStringCommand("DELETE FROM  [tblZINARA] where FLEETID ='" & DropDownList1.SelectedValue & "'")
                            Dim deleted = db.ExecuteDataSet(del)
                        Catch ex As Exception

                        End Try


                        Try
                            Dim insert1 = db.GetSqlStringCommand("INSERT INTO [tblHISTORY]([FLEETID],[LICNUMBER],[DATEISSUED],[DATEEXPIRY],[COMMENTS],[FILE],[CONTENTTYPE],[DATA],[POLICYID],[Userid],[DateModidfied])VALUES(@a,@b,@c,@d,@e,@f,@g,@h,@i,@j,@k)")


                            db.AddInParameter(insert1, "@a", System.Data.DbType.String, DropDownList1.SelectedValue)
                            db.AddInParameter(insert1, "@b", System.Data.DbType.String, txtlic.Text)
                            db.AddInParameter(insert1, "@c", System.Data.DbType.Date, Convert.ToDateTime(txtstartzin.Text))
                            db.AddInParameter(insert1, "@d", System.Data.DbType.Date, Convert.ToDateTime(txtendzin.Text))
                            db.AddInParameter(insert1, "@e", System.Data.DbType.String, txtxcommin.Text)
                            db.AddInParameter(insert1, "@f", System.Data.DbType.String, filename)
                            db.AddInParameter(insert1, "@g", System.Data.DbType.String, contentType)
                            db.AddInParameter(insert1, "@h", System.Data.DbType.Binary, bytes)
                            db.AddInParameter(insert1, "@i", System.Data.DbType.String, "ZINARA")
                            db.AddInParameter(insert1, "@j", System.Data.DbType.String, CokkiesWrapper.UserName)
                            db.AddInParameter(insert1, "@k", System.Data.DbType.String, DateTime.Now.ToString)
                            Dim insert_d1s = db.ExecuteDataSet(insert1)

                        Catch ex As Exception

                        End Try

                        Dim insert = db.GetSqlStringCommand("INSERT INTO [tblZINARA]([FLEETID],[LICNUMBER],[DATEISSUED],[DATEEXPIRY],[COMMENTS],[FILE],[CONTENTTYPE],[DATA])VALUES(@a,@b,@c,@d,@e,@f,@g,@h)")


                        db.AddInParameter(insert, "@a", System.Data.DbType.String, DropDownList1.SelectedValue)
                        db.AddInParameter(insert, "@b", System.Data.DbType.String, txtlic.Text)
                        db.AddInParameter(insert, "@c", System.Data.DbType.Date, Convert.ToDateTime(txtstartzin.Text))
                        db.AddInParameter(insert, "@d", System.Data.DbType.Date, Convert.ToDateTime(txtendzin.Text))
                        db.AddInParameter(insert, "@e", System.Data.DbType.String, txcommzin.Text)
                        db.AddInParameter(insert, "@f", System.Data.DbType.String, filename)
                        db.AddInParameter(insert, "@g", System.Data.DbType.String, contentType)
                        db.AddInParameter(insert, "@h", System.Data.DbType.Binary, bytes)
                        Dim insert_ds = db.ExecuteDataSet(insert)
                    Catch ex As Exception

                    End Try
                End Using
            End Using
            Message(Me, "Saved", "Succefully")

            'If txtFleetIDSearch.Text = "" Then
        Catch ex As Exception
            ErrorMessage(Me, "Failed", "Saving")
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
End Class