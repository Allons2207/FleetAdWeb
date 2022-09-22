Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Telerik.Web.UI
Imports ClassLibrary1
Imports System.Data.SqlClient
Imports System.Data
Imports System.Data.SqlClient.SqlConnection
Imports Microsoft.VisualBasic
Imports System.Configuration
Imports System.IO

Public Class QuartelyDetails
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

            VehicleData()
            VehicleData1()
            VehicleData2()
            'ShowToastr(Me.Page)
            'Page.ClientScript.RegisterStartupScript(Page.GetType(), "randomText", "$(document).ready(function () {$('#modal-form').modal('show');});", True)
            'Page.ClientScript.RegisterStartupScript(Page.GetType(), "script", "openpopup();", True)

            If Not IsNothing(Request.QueryString("op")) Then

                VehicleData()
                VehicleData1()
                VehicleData2()
                LoadDetails()

            End If
        Else
            ErrorMessage(Me, "Saved", "Succesfully")
        End If
        Try




            GridView3.UseAccessibleHeader = True
            GridView3.HeaderRow.TableSection = TableRowSection.TableHeader

        Catch ex As Exception

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



    Private Sub VehicleData()
        Dim sql As String = "SELECT Description FROM PRETRIP Where Type = 'Mechanical'"
        obj.ConnectionString = con

        'Dim myUser As New SecurityPolicy.UserManager(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)
        'Dim myAdmin As New AdminSettings(CookiesWrapper.thisConnectionName, 0)
        'Dim audit As New UserAudit(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            db.ExecuteDataSet(CommandType.Text, sql)

        Catch e As Exception
        End Try

    End Sub

    Private Sub VehicleData2()
        Dim sql As String = "SELECT Description FROM PRETRIP Where Type = 'Electrical'"
        obj.ConnectionString = con

        'Dim myUser As New SecurityPolicy.UserManager(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)
        'Dim myAdmin As New AdminSettings(CookiesWrapper.thisConnectionName, 0)
        'Dim audit As New UserAudit(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            db.ExecuteDataSet(CommandType.Text, sql)

        Catch e As Exception
        End Try

    End Sub

    Private Sub LoadDetails()
        Dim sql As String = "SELECT        dbo.tblQUARTINSP.FLEETID, dbo.tblQUARTINSP.REGNO, dbo.tblQUARTINSP.DRIVER, dbo.Sheet3.ID, dbo.Sheet3.Description, dbo.tblQUARTINSP.AVANO, dbo.tblQUARTINSP.AVAYES, dbo.tblQUARTINSP.TEC, 
                         dbo.tblQUARTINSP.ACCID, dbo.tblQUARTINSP.OWNER, dbo.tblQUARTINSP.ACTION, dbo.tblQUARTINSP.WINDMIRR, dbo.tblQUARTINSP.SUSST, dbo.tblQUARTINSP.ELECT, dbo.tblQUARTINSP.DENTS, 
                         dbo.tblQUARTINSP.DEFECTS, dbo.tblQUARTINSP.NEXTDATE, dbo.tblQUARTINSP.LASTSMILE, dbo.tblQUARTINSP.LASTDATE, dbo.tblQUARTINSP.LICVALID, dbo.tblQUARTINSP.CHASISNO, 
                         dbo.tblQUARTINSP.ENGNO, dbo.tblQUARTINSP.DEPT, dbo.tblQUARTINSP.MILE, dbo.tblQUARTINSP.DATE
FROM            dbo.tblQUARTINSP INNER JOIN
                         dbo.Sheet3 ON dbo.tblQUARTINSP.ACCID = dbo.Sheet3.ID WHERE FLEETID = '" & Request.QueryString("op") & "'"
        obj.ConnectionString = con

        'Dim myUser As New SecurityPolicy.UserManager(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)
        'Dim myAdmin As New AdminSettings(CookiesWrapper.thisConnectionName, 0)
        'Dim audit As New UserAudit(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            db.ExecuteDataSet(CommandType.Text, sql)
            Dim dt As DataTable = ds.Tables(0)
            txtfleet.Text = dt.Rows(0).Item("FLEETID").ToString
            txtmile.Text = dt.Rows(0).Item("MILE").ToString
            txtchasis.Text = dt.Rows(0).Item("CHASISNO").ToString
            txtmake.Text = dt.Rows(0).Item("REGNO").ToString
            txtEng.Text = dt.Rows(0).Item("ENGNO").ToString
            txtelec.Text = dt.Rows(0).Item("ELECT").ToString
            txtdents.Text = dt.Rows(0).Item("DENTS").ToString
            txtwind.Text = dt.Rows(0).Item("WINDMIRR").ToString
            txtxdef.Text = dt.Rows(0).Item("DEFECTS").ToString
            txtsuspe.Text = dt.Rows(0).Item("SUSST").ToString
            txtuser.Text = dt.Rows(0).Item("OWNER").ToString
            TextBox10.Text = dt.Rows(0).Item("OWNER").ToString
            txtwork.Text = dt.Rows(0).Item("DRIVER").ToString
            txtloc.Text = dt.Rows(0).Item("DEPT").ToString
            latmile.Text = dt.Rows(0).Item("LASTSMILE").ToString
            validlic.SelectedValue = dt.Rows(0).Item("LICVALID").ToString
            recact.SelectedValue = dt.Rows(0).Item("ACTION").ToString
            Dim ax As Date = Convert.ToDateTime(dt.Rows(0).Item("LASTDATE").ToString)
            Dim an As Date = Convert.ToDateTime(dt.Rows(0).Item("NEXTDATE").ToString)
            Dim af As Date = Convert.ToDateTime(dt.Rows(0).Item("DATE").ToString)
            latdate.Text = ax.ToString("yyyy-MM-dd")
            nxtdate.Text = an.ToString("yyyy-MM-dd")
            txtdate.Text = af.ToString("yyyy-MM-dd")
            txtuserdate.Text = af.ToString("yyyy-MM-dd")
            txttecdate.Text = af.ToString("yyyy-MM-dd")
            TextBox11.Text = af.ToString("yyyy-MM-dd")


            Try
                Dim aa As String = "SELECT        dbo.tblQUARTINSP.ACCID, dbo.tblQUARTINSP.AVAYES, dbo.tblQUARTINSP.AVANO, dbo.tblQUARTINSP.FLEETID
FROM            dbo.tblQUARTINSP INNER JOIN
                         dbo.Sheet3 ON dbo.tblQUARTINSP.ACCID = dbo.Sheet3.ID where FLEETID = '" & Request.QueryString("op") & "'"
                obj.ConnectionString = con

                'Dim myUser As New SecurityPolicy.UserManager(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)
                'Dim myAdmin As New AdminSettings(CookiesWrapper.thisConnectionName, 0)
                'Dim audit As New UserAudit(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)

                Try
                    Dim ak As DataSet = db.ExecuteDataSet(CommandType.Text, aa)
                    db.ExecuteDataSet(CommandType.Text, aa)
                    For Each row As GridViewRow In GridView3.Rows


                        Dim ID As Int32 = Convert.ToInt32(row.Cells(1).Text)
                        For j As Integer = 0 To ak.Tables(0).Rows.Count - 1
                            If ID = ak.Tables(0).Rows(j)(0).ToString Then
                                TryCast(row.FindControl("chkRow"), CheckBox).Checked = ak.Tables(0).Rows(j)(1).ToString
                                TryCast(row.FindControl("chkRow1"), CheckBox).Checked = ak.Tables(0).Rows(j)(2).ToString
                            End If
                        Next

                    Next

                Catch e As Exception
                End Try

            Catch ex As Exception

            End Try



        Catch e As Exception
        End Try
        ErrorMessage(Me.Page, "Loaded Succesfully")

    End Sub

    Private Sub VehicleData1()
        Dim sql As String = "SELECT * FROM Sheet3 "
        obj.ConnectionString = con

        'Dim myUser As New SecurityPolicy.UserManager(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)
        'Dim myAdmin As New AdminSettings(CookiesWrapper.thisConnectionName, 0)
        'Dim audit As New UserAudit(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            db.ExecuteDataSet(CommandType.Text, sql)
            With GridView3
                Try
                    .DataSource = ds
                    .DataBind()
                Catch ex As Exception
                    '  log.Error(ex.Message)
                End Try
            End With
        Catch e As Exception
        End Try

    End Sub
    Protected Sub Bulk_Insert(sender As Object, e As EventArgs)
        Dim dt As New DataTable()
        dt.Columns.AddRange(New DataColumn(22) {New DataColumn("FLEETID", GetType(String)), New DataColumn("REGNO", GetType(String)), New DataColumn("DRIVER", GetType(String)), New DataColumn("DATED", GetType(DateTime)), New DataColumn("MILE", GetType(String)), New DataColumn("DEPT", GetType(String)), New DataColumn("ENGNO", GetType(String)), New DataColumn("CHASISNO", GetType(String)), New DataColumn("LICVALID", GetType(String)), New DataColumn("LASTDATE", GetType(DateTime)), New DataColumn("LASTMILE", GetType(String)),
New DataColumn("NEXTDATE", GetType(DateTime)), New DataColumn("DEFECTS", GetType(String)),
New DataColumn("DENTS", GetType(String)), New DataColumn("ELECT", GetType(String)), New DataColumn("SUSST", GetType(String)), New DataColumn("WINDMIRR", GetType(String)), New DataColumn("ACTION", GetType(String)), New DataColumn("OWNER", GetType(String)), New DataColumn("ACCID", GetType(Int32)), New DataColumn("TEC", GetType(String)),
New DataColumn("AVAYES", GetType(Byte)), New DataColumn("AVANO", GetType(Byte))
})

        For Each row As GridViewRow In GridView3.Rows
            If row.RowType = DataControlRowType.DataRow Then
                Dim chkRow As CheckBox = TryCast(row.Cells(0).FindControl("chkRow"), CheckBox)
                If TryCast(row.FindControl("chkRow"), CheckBox).Checked Or TryCast(row.FindControl("chkRow1"), CheckBox).Checked Then
                    Dim ACCID As Int32 = Convert.ToInt32(row.Cells(1).Text)
                    Dim FLEETID As String = txtfleet.Text
                    Dim REGNO As String = txtmake.Text
                    Dim DRIVER As String = txtwork.Text
                    Dim DATED As Date = Convert.ToDateTime(txtdate.Text)
                    Dim MILE As String = txtmile.Text
                    Dim DEPT As String = txtloc.Text
                    Dim ENGNO As String = txtEng.Text
                    Dim CHASISNO As String = txtchasis.Text
                    Dim LICVALID As String = validlic.SelectedValue
                    Dim LASTDATE As Date = Convert.ToDateTime(latdate.Text)
                    Dim LASTMILE As String = latmile.Text
                    Dim NEXTDATE As Date = Convert.ToDateTime(nxtdate.Text)
                    Dim DEFECTS As String = txtxdef.Text
                    Dim DENTS As String = txtdents.Text
                    Dim ELECT As String = txtelec.Text
                    Dim SUSST As String = txtsuspe.Text
                    Dim WINDMIRR As String = txtwind.Text
                    Dim ACTION As String = recact.SelectedValue
                    Dim OWNER As String = txtuser.Text
                    Dim TEC As String = TextBox10.Text


                    Dim AVAYES As Byte = 0
                    If TryCast(row.FindControl("chkRow"), CheckBox).Checked Then
                        AVAYES = 1
                    Else
                        AVAYES = 0
                    End If
                    Dim AVANO As Byte = 0
                    If TryCast(row.FindControl("chkRow1"), CheckBox).Checked Then
                        AVANO = 1
                    Else
                        AVANO = 0
                    End If


                    dt.Rows.Add(FLEETID, REGNO, DRIVER, DATED, MILE, DEPT, ENGNO, CHASISNO, LICVALID, LASTDATE, LASTMILE, NEXTDATE, DEFECTS, DENTS, ELECT, SUSST, WINDMIRR, ACTION, OWNER, ACCID, TEC, AVAYES, AVANO)
                End If
            End If
        Next


        If dt.Rows.Count > 0 Then
            Dim consString As String = db.ConnectionString
            Try

                Dim insert = db.GetSqlStringCommand("DELETE FROM dbo. tblQUARTINSP  WHERE FLEETID = @a")
                db.AddInParameter(insert, "@a", System.Data.DbType.String, txtfleet.Text)
                Dim insert_ds = db.ExecuteDataSet(insert)
            Catch ex As Exception

            End Try

            Using con As New SqlConnection(consString)
                Using sqlBulkCopy As New SqlBulkCopy(con)
                    'Set the database table name
                    sqlBulkCopy.DestinationTableName = "dbo.tblQUARTINSP"

                    '[OPTIONAL]: Map the DataTable columns with that of the database table
                    sqlBulkCopy.ColumnMappings.Add("FLEETID", "FLEETID")
                    sqlBulkCopy.ColumnMappings.Add("ACCID", "ACCID")
                    sqlBulkCopy.ColumnMappings.Add("AVAYES", "AVAYES")
                    sqlBulkCopy.ColumnMappings.Add("AVANO", "AVANO")
                    sqlBulkCopy.ColumnMappings.Add("DRIVER", "DRIVER")
                    sqlBulkCopy.ColumnMappings.Add("MILE", "MILE")
                    sqlBulkCopy.ColumnMappings.Add("DEPT", "DEPT")
                    sqlBulkCopy.ColumnMappings.Add("DATED", "DATE")
                    sqlBulkCopy.ColumnMappings.Add("ENGNO", "ENGNO")
                    sqlBulkCopy.ColumnMappings.Add("TEC", "TEC")
                    sqlBulkCopy.ColumnMappings.Add("CHASISNO", "CHASISNO")
                    sqlBulkCopy.ColumnMappings.Add("LICVALID", "LICVALID")
                    sqlBulkCopy.ColumnMappings.Add("LASTDATE", "LASTDATE")
                    sqlBulkCopy.ColumnMappings.Add("LASTMILE", "LASTSMILE")
                    sqlBulkCopy.ColumnMappings.Add("NEXTDATE", "NEXTDATE")
                    sqlBulkCopy.ColumnMappings.Add("DEFECTS", "DEFECTS")
                    sqlBulkCopy.ColumnMappings.Add("DENTS", "DENTS")
                    sqlBulkCopy.ColumnMappings.Add("ELECT", "ELECT")
                    sqlBulkCopy.ColumnMappings.Add("SUSST", "SUSST")
                    sqlBulkCopy.ColumnMappings.Add("WINDMIRR", "WINDMIRR")
                    sqlBulkCopy.ColumnMappings.Add("ACTION", "ACTION")
                    sqlBulkCopy.ColumnMappings.Add("OWNER", "OWNER")

                    con.Open()
                    sqlBulkCopy.WriteToServer(dt)
                    con.Close()


                End Using



                Using sqlBulkCopy As New SqlBulkCopy(con)
                    'Set the database table name
                    sqlBulkCopy.DestinationTableName = "dbo.tblQUARTINSPHIST"

                    '[OPTIONAL]: Map the DataTable columns with that of the database table
                    sqlBulkCopy.ColumnMappings.Add("FLEETID", "FLEETID")
                    sqlBulkCopy.ColumnMappings.Add("ACCID", "ACCID")
                    sqlBulkCopy.ColumnMappings.Add("AVAYES", "AVAYES")
                    sqlBulkCopy.ColumnMappings.Add("AVANO", "AVANO")
                    sqlBulkCopy.ColumnMappings.Add("DRIVER", "DRIVER")
                    sqlBulkCopy.ColumnMappings.Add("MILE", "MILE")
                    sqlBulkCopy.ColumnMappings.Add("DEPT", "DEPT")
                    sqlBulkCopy.ColumnMappings.Add("DATED", "DATE")
                    sqlBulkCopy.ColumnMappings.Add("ENGNO", "ENGNO")
                    sqlBulkCopy.ColumnMappings.Add("TEC", "TEC")
                    sqlBulkCopy.ColumnMappings.Add("CHASISNO", "CHASISNO")
                    sqlBulkCopy.ColumnMappings.Add("LICVALID", "LICVALID")
                    sqlBulkCopy.ColumnMappings.Add("LASTDATE", "LASTDATE")
                    sqlBulkCopy.ColumnMappings.Add("LASTMILE", "LASTSMILE")
                    sqlBulkCopy.ColumnMappings.Add("NEXTDATE", "NEXTDATE")
                    sqlBulkCopy.ColumnMappings.Add("DEFECTS", "DEFECTS")
                    sqlBulkCopy.ColumnMappings.Add("DENTS", "DENTS")
                    sqlBulkCopy.ColumnMappings.Add("ELECT", "ELECT")
                    sqlBulkCopy.ColumnMappings.Add("SUSST", "SUSST")
                    sqlBulkCopy.ColumnMappings.Add("WINDMIRR", "WINDMIRR")
                    sqlBulkCopy.ColumnMappings.Add("ACTION", "ACTION")
                    sqlBulkCopy.ColumnMappings.Add("OWNER", "OWNER")

                    con.Open()
                    sqlBulkCopy.WriteToServer(dt)
                    con.Close()


                End Using
            End Using



        End If
    End Sub
End Class