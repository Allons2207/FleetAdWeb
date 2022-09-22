Imports ClassLibrary1
Imports Telerik.Web.UI
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing

Public Class CapturingBehaviour
    Inherits System.Web.UI.Page
    Private Shared ReadOnly log As log4net.ILog = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType)

    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (CokkiesWrapper.UserID <= 0 AndAlso Not IsNumeric(CokkiesWrapper.UserID)) Then
            Response.Redirect("../Login.aspx")
            Exit Sub
        End If

        'obj.ConnectionString = con
        'Dim accessMode As String = obj.groupAccessPermissionsDs(CokkiesWrapper.UserGroup, 11)

        'Select Case accessMode
        '    Case "AllowReadNRead"
        '    Case "ReadNReadOnly"
        '        cmdSave.Enabled = False
        '    Case "DenyAcces"
        '        Response.Redirect("~/AccessDenied.aspx")
        '        Exit Sub
        '    Case Else
        '        Response.Redirect("~/AccessDenied.aspx")
        '        Exit Sub
        'End Select
    End Sub

    Protected Sub cmdNew_Click(sender As Object, e As EventArgs) Handles cmdNew.Click
        If Not IsPostBack Then
            txOffenderID.Text = ""
            txtClass.Text = ""
            txtDescription.Text = ""
            txtIncidentNo.Text = ""
            txtLocation.Text = ""
            txtOffender.Text = ""
            txtStream.Text = ""
            RadDatePicker.Clear()
        End If
    End Sub


    Private Sub cbIncidentLevel_Load(sender As Object, e As EventArgs) Handles cbIncidentLevel.Load
        If Not IsPostBack Then

            Dim objLevel As New IncidentLevels(CokkiesWrapper.thisConnectionName)
            Dim ds As DataSet = objLevel.SelectRecords()

            With cbIncidentLevel

                .DataSource = ds
                .DataTextField = "incidentLevel"
                .DataValueField = "incidentLevelId"
                .DataBind()

                .Items.Insert(0, New RadComboBoxItem("", ""))

            End With

        End If
    End Sub

    Private Sub cbIncidentType_Load(sender As Object, e As EventArgs) Handles cbIncidentType.Load
        If Not IsPostBack Then

            Dim objType As New IncidentTypes(CokkiesWrapper.thisConnectionName)
            Dim ds As DataSet = objType.SelectRecords()

            With cbIncidentType

                .DataSource = ds
                .DataTextField = "incidentType"
                .DataValueField = "incidentTypeId"
                .DataBind()

                .Items.Insert(0, New RadComboBoxItem("", ""))

            End With

        End If
    End Sub

    'Private Sub cbLocation_Load(sender As Object, e As EventArgs) Handles cbLocation.Load
    '    If Not IsPostBack Then

    '        Dim objLocation As New IncidentsLocation(CokkiesWrapper.thisConnectionName)
    '        Dim ds As DataSet = objLocation.SelectRecords()

    '        With cbLocation

    '            .DataSource = ds
    '            .DataTextField = "location"
    '            .DataValueField = "locationID"
    '            .DataBind()

    '            .Items.Insert(0, New RadComboBoxItem("", ""))

    '        End With

    '    End If
    'End Sub

    Protected Sub cmdSave_Click(sender As Object, e As EventArgs) Handles cmdSave.Click

        Dim objIncident As New Incidents(CokkiesWrapper.thisConnectionName)
        Dim db As Database = objIncident.Database
        Dim con As String = db.ConnectionString

        Try
            With objIncident

                .ConnectionString = con
                .incidentNumber = txOffenderID.Text + Year(Today).ToString + Month(Today).ToString + Day(Today).ToString
                .incidentLevelId = cbIncidentLevel.SelectedValue
                .incidentTypeId = cbIncidentType.SelectedValue
                .offenderCategoryId = cbOffenderCategory.SelectedValue
                .Schclass = txtClass.Text
                .stream = txtStream.Text
                .offenderId = txOffenderID.Text
                .locationId = txtLocation.Text
                .offender = txtOffender.Text
                .dtDate = RadDatePicker.SelectedDate
                .disciplinaryActionId = cbDisActions.SelectedValue
                .incidentDescription = txtDescription.Text

                .Insert()
                lblMsg.BackColor = Color.Green
                lblMsg.ForeColor = Color.White
                lblMsg.Text = "Behaviour Details were uploaded successlly!!!"
            End With
        Catch ex As Exception
            log.Error(ex)
            lblMsg.BackColor = Color.Red
            lblMsg.ForeColor = Color.White
            lblMsg.Text = "Behaviour Details were not uploaded successlly!!! "
        End Try

    End Sub

    Protected Sub txOffenderID_TextChanged(sender As Object, e As EventArgs) Handles txOffenderID.TextChanged

        Dim objstudent As New Student(CokkiesWrapper.thisConnectionName)

        Dim ds As DataSet = objstudent.selectRecords(txOffenderID.Text)

        If ds.Tables.Count > 0 And ds.Tables(0).Rows.Count > 0 Then
            txtIncidentNo.Text = txOffenderID.Text + Year(Today).ToString + Month(Today).ToString + Day(Today).ToString
            txtClass.Text = ds.Tables(0).Rows(0)("schoolClass")
            txtStream.Text = ds.Tables(0).Rows(0)("stream")
            txtOffender.Text = ds.Tables(0).Rows(0)("firstname") + " " + ds.Tables(0).Rows(0)("surname")

        End If
    End Sub

    Private Sub cbDisActions_Load(sender As Object, e As EventArgs) Handles cbDisActions.Load
        If Not IsPostBack Then

            Dim objAction As New DisciplinaryActions(CokkiesWrapper.thisConnectionName)
            Dim ds As DataSet = objAction.SelectRecords()

            With cbDisActions

                .DataSource = ds
                .DataTextField = "action"
                .DataValueField = "actionId"
                .DataBind()

                .Items.Insert(0, New RadComboBoxItem("", ""))

            End With

        End If
    End Sub

   
End Class