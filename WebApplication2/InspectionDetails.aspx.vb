Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Telerik.Web.UI
Imports ClassLibrary1
Imports System.Data.SqlClient
Imports System.Data
Imports System.Data.SqlClient.SqlConnection
Imports Microsoft.VisualBasic
Imports System.Configuration
Imports System.IO


Public Class InspectionDetails
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

            GridView2.UseAccessibleHeader = True
            GridView2.HeaderRow.TableSection = TableRowSection.TableHeader
            GridView1.UseAccessibleHeader = True
            GridView1.HeaderRow.TableSection = TableRowSection.TableHeader
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
        Dim sql As String = "SELECT * FROM PRETRIP Where Type = 'Mechanical'"
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
        Catch e As Exception
        End Try

    End Sub

    Private Sub LoadDetails()
        Dim sql As String = "SELECT        dbo.PRETRIP.ID, dbo.tblPRETRIPINSP.FLEETID, dbo.tblPRETRIPINSP.LUID, dbo.tblPRETRIPINSP.FAULTY, dbo.tblPRETRIPINSP.OKAY, dbo.tblPRETRIPINSP.WOD, dbo.tblPRETRIPINSP.MAKE, 
                         dbo.tblPRETRIPINSP.LOCATION, dbo.tblPRETRIPINSP.DATE, dbo.tblPRETRIPINSP.MILE, dbo.tblPRETRIPINSP.TECMEC, dbo.tblPRETRIPINSP.TECELEC, dbo.tblPRETRIPINSP.TECTYRE
FROM            dbo.PRETRIP INNER JOIN
                         dbo.tblPRETRIPINSP ON dbo.PRETRIP.ID = dbo.tblPRETRIPINSP.LUID where FLEETID = '" & Request.QueryString("op") & "'"
        obj.ConnectionString = con

        'Dim myUser As New SecurityPolicy.UserManager(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)
        'Dim myAdmin As New AdminSettings(CookiesWrapper.thisConnectionName, 0)
        'Dim audit As New UserAudit(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            db.ExecuteDataSet(CommandType.Text, sql)
            Dim dt As DataTable = ds.Tables(0)
            txtFletID.Text = dt.Rows(0).Item("FLEETID").ToString
            txtMile.Text = dt.Rows(0).Item("MILE").ToString
            txtMake.Text = dt.Rows(0).Item("MAKE").ToString
            Dim af As Date = Convert.ToDateTime(dt.Rows(0).Item("DATE").ToString)
            txtdate.Text = af.ToString("yyyy-MM-dd")
            dateTelec.Text = af.ToString("yyyy-MM-dd")
            datetyre.Text = af.ToString("yyyy-MM-dd")
            txtDateTec.Text = af.ToString("yyyy-MM-dd")
            txtWKSHOP.Text = dt.Rows(0).Item("LOCATION").ToString
            txtWorkOrder.Text = dt.Rows(0).Item("WOD").ToString

            Try
                Dim aa As String = "SELECT        dbo.PRETRIP.ID, dbo.tblPRETRIPINSP.FAULTY, dbo.tblPRETRIPINSP.OKAY, dbo.PRETRIP.Type, dbo.tblPRETRIPINSP.TECMEC, dbo.tblPRETRIPINSP.FLEETID
                    FROM dbo.PRETRIP INNER JOIN
                     dbo.tblPRETRIPINSP ON dbo.PRETRIP.ID = dbo.tblPRETRIPINSP.LUID
                 Where dbo.PRETRIP.Type = 'Mechanical' AND  dbo.tblPRETRIPINSP.FLEETID = '" & Request.QueryString("op") & "'"
                obj.ConnectionString = con

                'Dim myUser As New SecurityPolicy.UserManager(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)
                'Dim myAdmin As New AdminSettings(CookiesWrapper.thisConnectionName, 0)
                'Dim audit As New UserAudit(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)

                Try
                    Dim ak As DataSet = db.ExecuteDataSet(CommandType.Text, aa)
                    db.ExecuteDataSet(CommandType.Text, aa)
                    For Each row As GridViewRow In GridView1.Rows


                        Dim ID As Int32 = Convert.ToInt32(row.Cells(1).Text)
                        For j As Integer = 0 To ak.Tables(0).Rows.Count - 1
                            If ID = ak.Tables(0).Rows(j)(0).ToString Then
                                TryCast(row.FindControl("chkFault"), CheckBox).Checked = ak.Tables(0).Rows(j)(1).ToString
                                TryCast(row.FindControl("chkOk"), CheckBox).Checked = ak.Tables(0).Rows(j)(2).ToString
                            End If
                        Next

                    Next
                    txtTecMeC.Text = ak.Tables(0).Rows(0)(4).ToString
                Catch e As Exception
                End Try

            Catch ex As Exception

            End Try


            Try

                Dim aa As String = "SELECT        dbo.PRETRIP.ID, dbo.tblPRETRIPINSP.FAULTY, dbo.tblPRETRIPINSP.OKAY, dbo.PRETRIP.Type, dbo.tblPRETRIPINSP.TECMEC, dbo.tblPRETRIPINSP.FLEETID
                    FROM dbo.PRETRIP INNER JOIN
                     dbo.tblPRETRIPINSP ON dbo.PRETRIP.ID = dbo.tblPRETRIPINSP.LUID
                 Where dbo.PRETRIP.Type = 'Electrical' AND  dbo.tblPRETRIPINSP.FLEETID = '" & Request.QueryString("op") & "'"
                obj.ConnectionString = con

                'Dim myUser As New SecurityPolicy.UserManager(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)
                'Dim myAdmin As New AdminSettings(CookiesWrapper.thisConnectionName, 0)
                'Dim audit As New UserAudit(CookiesWrapper.thisConnectionName, CookiesWrapper.thisUserID)

                Try
                    Dim ak As DataSet = db.ExecuteDataSet(CommandType.Text, aa)
                    db.ExecuteDataSet(CommandType.Text, aa)
                    For Each row As GridViewRow In GridView2.Rows


                        Dim ID As Int32 = Convert.ToInt32(row.Cells(1).Text)
                        For j As Integer = 0 To ak.Tables(0).Rows.Count - 1
                            If ID = ak.Tables(0).Rows(j)(0).ToString Then
                                TryCast(row.FindControl("chkRowfaulty"), CheckBox).Checked = ak.Tables(0).Rows(j)(1).ToString
                                TryCast(row.FindControl("chkRowok"), CheckBox).Checked = ak.Tables(0).Rows(j)(2).ToString
                            End If
                        Next

                    Next
                    tecElec.Text = ak.Tables(0).Rows(0)(4).ToString
                Catch e As Exception
                End Try

            Catch ex As Exception

            End Try


            Try
                Dim aa As String = "SELECT        dbo.PRETRIP.ID, dbo.tblPRETRIPINSP.FAULTY, dbo.tblPRETRIPINSP.OKAY, dbo.PRETRIP.Type, dbo.tblPRETRIPINSP.TECMEC, dbo.tblPRETRIPINSP.FLEETID
                    FROM dbo.PRETRIP INNER JOIN
                     dbo.tblPRETRIPINSP ON dbo.PRETRIP.ID = dbo.tblPRETRIPINSP.LUID
                 Where dbo.PRETRIP.Type = 'Tyres' AND  dbo.tblPRETRIPINSP.FLEETID = '" & Request.QueryString("op") & "'"
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
                    tecttyre.Text = ak.Tables(0).Rows(0)(4).ToString
                Catch e As Exception
                End Try


            Catch ex As Exception

            End Try
        Catch e As Exception
        End Try
        ErrorMessage(Me.Page, "Loaded Succesfully")

    End Sub

    Private Sub VehicleData2()
        Dim sql As String = "SELECT * FROM PRETRIP Where Type = 'Electrical'"
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
        Catch e As Exception
        End Try

    End Sub
    Private Sub VehicleData1()
        Dim sql As String = "SELECT * FROM PRETRIP Where Type = 'Tyres'"
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
        dt.Columns.AddRange(New DataColumn(9) {New DataColumn("FLEETID", GetType(String)), New DataColumn("ID", GetType(Int32)), New DataColumn("FAULTY", GetType(Byte)), New DataColumn("OKAY", GetType(Byte)), New DataColumn("WOD", GetType(String)), New DataColumn("MAKE", GetType(String)), New DataColumn("LOCATION", GetType(String)), New DataColumn("MILE", GetType(String)), New DataColumn("DATED", GetType(DateTime)), New DataColumn("TEC", GetType(String))})
        For Each row As GridViewRow In GridView1.Rows
            If row.RowType = DataControlRowType.DataRow Then
                Dim chkRow As CheckBox = TryCast(row.Cells(0).FindControl("chkFault"), CheckBox)
                If TryCast(row.FindControl("chkFault"), CheckBox).Checked Or TryCast(row.FindControl("chkOk"), CheckBox).Checked Then
                    Dim ID As Int32 = Convert.ToInt32(row.Cells(1).Text)
                    Dim FLEETID As String = txtFletID.Text
                    Dim FAULTY As Byte = 0
                    If TryCast(row.FindControl("chkFault"), CheckBox).Checked Then
                        FAULTY = 1
                    Else
                        FAULTY = 0
                    End If
                    Dim OKAY As Byte = 0
                    If TryCast(row.FindControl("chkOk"), CheckBox).Checked Then
                        OKAY = 1
                    Else
                        OKAY = 0
                    End If

                    Dim WOD As String = txtWorkOrder.Text
                    Dim LOCATION As String = txtWKSHOP.Text
                    Dim MAKE As String = txtMake.Text
                    Dim MILE As String = txtMile.Text
                    Dim DATED As DateTime = Convert.ToDateTime(txtdate.Text)
                    Dim TEC As String = txtTecMeC.Text
                    dt.Rows.Add(FLEETID, ID, FAULTY, OKAY, WOD, MAKE, LOCATION, MILE, DATED, TEC)
                End If
            End If
        Next

        For Each row As GridViewRow In GridView2.Rows

            If TryCast(row.FindControl("chkRowfaulty"), CheckBox).Checked Or TryCast(row.FindControl("chkRowok"), CheckBox).Checked Then
                Dim ID As Int32 = Convert.ToInt32(row.Cells(1).Text)
                Dim FLEETID As String = txtFletID.Text
                Dim FAULTY As Byte = 0
                If TryCast(row.FindControl("chkRowfaulty"), CheckBox).Checked Then
                    FAULTY = 1
                Else
                    FAULTY = 0
                End If
                Dim OKAY As Byte = 0
                If TryCast(row.FindControl("chkRowok"), CheckBox).Checked Then
                    OKAY = 1
                Else
                    OKAY = 0
                End If

                Dim WOD As String = txtWorkOrder.Text
                Dim LOCATION As String = txtWKSHOP.Text
                Dim MAKE As String = txtMake.Text
                Dim MILE As String = txtMile.Text
                Dim DATED As DateTime = Convert.ToDateTime(txtdate.Text)
                Dim TEC As String = tecElec.Text
                dt.Rows.Add(FLEETID, ID, FAULTY, OKAY, WOD, MAKE, MAKE, LOCATION, DATED, TEC)
            End If
        Next
        For Each row As GridViewRow In GridView3.Rows
            Try

                If TryCast(row.FindControl("chkRow"), CheckBox).Checked = True Then
                    Dim ID As Int32 = Convert.ToInt32(row.Cells(1).Text)
                    Dim FLEETID As String = txtFletID.Text
                    Dim FAULTY As Byte = 0
                    If TryCast(row.FindControl("chkRow"), CheckBox).Checked Then
                        FAULTY = 1
                    Else
                        FAULTY = 0
                    End If
                    Dim OKAY As Byte = 0
                    If TryCast(row.FindControl("chkRow1"), CheckBox).Checked Then
                        OKAY = 1
                    Else
                        OKAY = 0
                    End If

                    Dim WOD As String = txtWorkOrder.Text
                    Dim LOCATION As String = txtWKSHOP.Text
                    Dim MAKE As String = txtMake.Text
                    Dim MILE As String = txtMile.Text
                    Dim DATED As DateTime = Convert.ToDateTime(txtdate.Text)
                    Dim TEC As String = tecttyre.Text
                    dt.Rows.Add(FLEETID, ID, FAULTY, OKAY, WOD, MAKE, LOCATION, MILE, DATED, TEC)
                End If
            Catch ex As Exception

            End Try
        Next

        If dt.Rows.Count > 0 Then
            Dim consString As String = db.ConnectionString
            Try

                Dim insert = db.GetSqlStringCommand("DELETE FROM dbo.tblPRETRIPINSP  WHERE FLEETID = @a")
                db.AddInParameter(insert, "@a", System.Data.DbType.String, txtFletID.Text)
                Dim insert_ds = db.ExecuteDataSet(insert)
            Catch ex As Exception

            End Try

            Using con As New SqlConnection(consString)
                Using sqlBulkCopy As New SqlBulkCopy(con)
                    'Set the database table name
                    sqlBulkCopy.DestinationTableName = "dbo.tblPRETRIPINSP"

                    '[OPTIONAL]: Map the DataTable columns with that of the database table
                    sqlBulkCopy.ColumnMappings.Add("FLEETID", "FLEETID")
                    sqlBulkCopy.ColumnMappings.Add("ID", "LUID")
                    sqlBulkCopy.ColumnMappings.Add("FAULTY", "FAULTY")
                    sqlBulkCopy.ColumnMappings.Add("OKAY", "OKAY")
                    sqlBulkCopy.ColumnMappings.Add("WOD", "WOD")
                    sqlBulkCopy.ColumnMappings.Add("LOCATION", "LOCATION")
                    sqlBulkCopy.ColumnMappings.Add("MAKE", "MAKE")
                    sqlBulkCopy.ColumnMappings.Add("DATED", "DATE")
                    sqlBulkCopy.ColumnMappings.Add("MILE", "MILE")
                    sqlBulkCopy.ColumnMappings.Add("TEC", "TECMEC")
                    con.Open()
                    sqlBulkCopy.WriteToServer(dt)
                    con.Close()


                End Using

                Using sqlBulkCopy As New SqlBulkCopy(con)
                    'Set the database table name
                    sqlBulkCopy.DestinationTableName = "tblPRETRIPINSPHIST"

                    '[OPTIONAL]: Map the DataTable columns with that of the database table
                    sqlBulkCopy.ColumnMappings.Add("FLEETID", "FLEETID")
                    sqlBulkCopy.ColumnMappings.Add("ID", "LUID")
                    sqlBulkCopy.ColumnMappings.Add("FAULTY", "FAULTY")
                    sqlBulkCopy.ColumnMappings.Add("OKAY", "OKAY")
                    sqlBulkCopy.ColumnMappings.Add("WOD", "WOD")
                    sqlBulkCopy.ColumnMappings.Add("LOCATION", "LOCATION")
                    sqlBulkCopy.ColumnMappings.Add("MAKE", "MAKE")
                    sqlBulkCopy.ColumnMappings.Add("DATED", "DATE")
                    sqlBulkCopy.ColumnMappings.Add("MILE", "MILE")
                    sqlBulkCopy.ColumnMappings.Add("TEC", "TECMEC")
                    con.Open()
                    sqlBulkCopy.WriteToServer(dt)
                    con.Close()

                    ErrorMessage(Me.Parent, "Saved Succesfully")
                End Using
            End Using
        End If
    End Sub
End Class