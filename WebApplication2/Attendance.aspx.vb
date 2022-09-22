Imports ClassLibrary1
Imports Telerik.Web.UI
Imports Microsoft.Practices.EnterpriseLibrary.Data

Public Class Attendance
    Inherits System.Web.UI.Page
    Private Shared ReadOnly log As log4net.ILog = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType)

    Dim objAttendance As New AttendanceRegister(CokkiesWrapper.thisConnectionName)
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = objAttendance.Database
    Dim con As String = db.ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (CokkiesWrapper.UserID <= 0 AndAlso Not IsNumeric(CokkiesWrapper.UserID)) Then
            Response.Redirect("../Login.aspx")
            Exit Sub
        End If

        'obj.ConnectionString = con
        'Dim accessMode As String = obj.groupAccessPermissionsDs(CokkiesWrapper.UserGroup, 10)

        'Select Case accessMode
        '    Case "AllowReadNRead"
        '    Case "ReadNReadOnly"
        '        cmdRegSelected.Enabled = False
        '    Case "DenyAcces"
        '        Response.Redirect("~/AccessDenied.aspx")
        '        Exit Sub
        '    Case Else
        '        Response.Redirect("~/AccessDenied.aspx")
        '        Exit Sub
        'End Select

    End Sub



    Private Sub cbStream_Load(sender As Object, e As EventArgs) Handles cbStream.Load
        If Not IsPostBack Then

            Dim objStream As New Streams(CokkiesWrapper.thisConnectionName)
            Dim ds As DataSet = objStream.SelectRecords()

            With cbStream

                .DataSource = ds
                .DataTextField = "stream"
                .DataValueField = "stream"
                .DataBind()

                .Items.Insert(0, New RadComboBoxItem("", ""))

            End With

        End If
    End Sub

    Private Sub cbClass_Load(sender As Object, e As EventArgs) Handles cbClass.Load
        If Not IsPostBack Then

            Dim objSchoolClasses As New SchoolClasses(CokkiesWrapper.thisConnectionName)
            Dim ds As DataSet = objSchoolClasses.SelectRecords()

            With cbClass

                .DataSource = ds
                .DataTextField = "schoolClass"
                .DataValueField = "schoolClass"
                .DataBind()

                .Items.Insert(0, New RadComboBoxItem("", ""))

            End With

        End If
    End Sub
    Sub LoadStudents()

        Dim sql As String = " SELECT [stream],[schoolClass],[studentId],firstname, Surname FROM tbl_students S inner join tbl_schoolClasses C on S.schoolClassId = C.schoolClassId inner join   tbl_streams St on St.streamId = C.streamId where schoolClass = '" & cbClass.SelectedValue & "' "
        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            db.ExecuteDataSet(CommandType.Text, sql)

            With gwAttendance

                .DataSource = ds
                .DataBind()

            End With


        Catch ex As Exception
            log.Error(ex)

        End Try

    End Sub

    Protected Sub cmdViewStudents_Click(sender As Object, e As EventArgs) Handles cmdViewStudents.Click

        If cbClass.SelectedValue Is Nothing Then
            lblMsg.Visible = True
            lblMsg.ForeColor = Drawing.Color.Red
            lblMsg.Text = "Select the stream and class to view the students"
        Else
            LoadStudents()
        End If

    End Sub

    Private Sub gwAttendance_ItemDataBound(sender As Object, e As GridItemEventArgs) Handles gwAttendance.ItemDataBound

        Dim sql As String = "SELECT *  FROM [SchoolAd].[dbo].[tbl_reasonsForAbsence]"
        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)

            Dim item As GridDataItem = e.Item
            Dim cbReasons As DropDownList = item.FindControl("cbComments")
            cbReasons.DataSource = ds
            cbReasons.DataTextField = "reasonForAbsence"
            cbReasons.DataValueField = "reasonForAbsence"
            cbReasons.DataBind()

            cbReasons.Items.Insert(0, New ListItem("", ""))
        Catch ex As Exception
            log.Error(ex)
        End Try

    End Sub

    Private Sub grddata()

        With objAttendance


            Try
                For Each gridRow As GridDataItem In gwAttendance.Items

                    If gridRow.Selected Then

                        .attendance = 1
                        .comments = ""

                    Else

                        .attendance = 0
                        Dim drpdwnlist As DropDownList = gridRow.Item("comments").FindControl("cbComments")
                        .comments = drpdwnlist.SelectedValue

                    End If

                    .ConnectionString = con
                    .dtDate = rdAttendanceDate.SelectedDate
                    .schClass = cbClass.SelectedValue
                    .stream = cbStream.SelectedValue
                    .studentId = gridRow("studentId").Text

                    .Insert()
                Next

            Catch ex As Exception

            End Try

        End With
    End Sub

    Protected Sub cmdRegSelected_Click(sender As Object, e As EventArgs) Handles cmdRegSelected.Click
        If rdAttendanceDate.SelectedDate Is Nothing And cbClass.SelectedValue Is Nothing Then

            lblMsg.Visible = True
            lblMsg.ForeColor = Drawing.Color.Red
            lblMsg.Text = "Please select attendance date and class id to continue"

            Exit Sub

        End If
        grddata()
    End Sub


    Protected Sub gwAttendance_NeedDataSource(sender As Object, e As GridNeedDataSourceEventArgs) Handles gwAttendance.NeedDataSource

    End Sub
End Class