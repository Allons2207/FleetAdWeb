Imports ClassLibrary1
Imports Telerik.Web.UI
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing

Public Class ManageTimetable
    Inherits System.Web.UI.Page

    Private Shared ReadOnly log As log4net.ILog = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType)

    Dim objTimeTable As New ClassTimeTable(CokkiesWrapper.thisConnectionName)
    Dim db As Database = objTimeTable.Database
    Dim con As String = db.ConnectionString
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (CokkiesWrapper.UserID <= 0 AndAlso Not IsNumeric(CokkiesWrapper.UserID)) Then
            Response.Redirect("../Login.aspx")
            Exit Sub
        End If


        obj.ConnectionString = con
        Dim accessMode As String = obj.groupAccessPermissionsDs(CokkiesWrapper.UserGroup, 14)

        Select Case accessMode
            Case "AllowReadNRead"
            Case "ReadNReadOnly"
                cmdSave.Enabled = False
            Case "DenyAcces"
                Response.Redirect("~/AccessDenied.aspx")
                Exit Sub
            Case Else
                Response.Redirect("~/AccessDenied.aspx")
                Exit Sub
        End Select

        timeTableLoad()

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

    Private Sub cbPeriod_Load(sender As Object, e As EventArgs) Handles cbPeriod.Load
        If Not IsPostBack Then

            Dim objClassPeriods As New ClassPeriods(CokkiesWrapper.thisConnectionName)
            Dim ds As DataSet = objClassPeriods.SelectRecords()

            With cbPeriod

                .DataSource = ds
                .DataTextField = "period"
                .DataValueField = "period"
                .DataBind()

                .Items.Insert(0, New RadComboBoxItem("", ""))

            End With

        End If
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



    Private Sub cbSubject_Load(sender As Object, e As EventArgs) Handles cbSubject.Load
        If Not IsPostBack Then

            Dim objSubjects As New Subjects(CokkiesWrapper.thisConnectionName)
            Dim ds As DataSet = objSubjects.SelectRecords()

            With cbSubject

                .DataSource = ds
                .DataTextField = "subject"
                .DataValueField = "subject"
                .DataBind()

                .Items.Insert(0, New RadComboBoxItem("", ""))

            End With

        End If
    End Sub

    Private Sub cbPeriod_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cbPeriod.SelectedIndexChanged
        Dim objClassPeriods As New ClassPeriods(CokkiesWrapper.thisConnectionName)
        Dim ds As DataSet = objClassPeriods.SelectRecords(cbPeriod.SelectedValue.ToString)

        txtFromtime.Text = ds.Tables(0).Rows(0)("fromTime")
        txtToTime.Text = ds.Tables(0).Rows(0)("toTime")

    End Sub
    Protected Sub cmdSave_Click(sender As Object, e As EventArgs) Handles cmdSave.Click
        Try
            With objTimeTable
                .ConnectionString = con
                .dayNumba = cbDay.SelectedValue
                .dDay = cbDay.Text
                .periodNumber = cbPeriod.SelectedValue
                .stream = cbStream.SelectedValue
                .subject = cbSubject.SelectedValue
                .schClass = cbClass.SelectedValue
                .TeacherCode = cbTeacher.SelectedValue

                .Insert()

            End With
            lblMsg.BackColor = Color.Green
            lblMsg.ForeColor = Color.White
            lblMsg.Text = "TimeTable Details were saved successfully!!!"

        Catch ex As Exception

            log.Error(ex)
            lblMsg.BackColor = Color.Red
            lblMsg.ForeColor = Color.White
            lblMsg.Text = "TimeTable Details were not saved successfully!!!"

        End Try
    End Sub

    Sub timeTableLoad()

        Dim sql As String = " SELECT * FROM vwTimeTable ORDER BY dayNumba ASC,periodNumber ASC, stream ASC, schClass ASC "
        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)

            With gwTimeTable

                .DataSource = ds
                .DataBind()

            End With


        Catch ex As Exception
            log.Error(ex)

        End Try

    End Sub

    Private Sub cbTeacher_Load(sender As Object, e As EventArgs) Handles cbTeacher.Load

        If Not IsPostBack Then

            Dim objstaffDetails As New StaffDetails(CokkiesWrapper.thisConnectionName)
            Dim ds As DataSet = objstaffDetails.SelectRecords()

            With cbTeacher

                .DataSource = ds
                .DataTextField = "employmentNumber"
                .DataValueField = "employmentNumber"
                .DataBind()

                .Items.Insert(0, New RadComboBoxItem("", ""))

            End With

        End If

    End Sub
End Class