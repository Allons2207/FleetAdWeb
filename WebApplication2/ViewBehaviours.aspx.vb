Imports System.Drawing
Imports ClassLibrary1
Imports Telerik.Web.UI
Imports Microsoft.Practices.EnterpriseLibrary.Data
Public Class ViewBehaviours
    Inherits System.Web.UI.Page
    Private Shared log As log4net.ILog = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType)
    Dim objIncident As New Incidents(CokkiesWrapper.thisConnectionName)
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString
    Dim ds As DataSet

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If (CokkiesWrapper.UserID <= 0 AndAlso Not IsNumeric(CokkiesWrapper.UserID)) Then
            Response.Redirect("../Login.aspx")
            Exit Sub
        End If

        obj.ConnectionString = con
        Dim accessMode As String = obj.groupAccessPermissionsDs(CokkiesWrapper.UserGroup, 11)

        Select Case accessMode
            Case "AllowReadNRead"
            Case "ReadNReadOnly"
                ' cmdaddnew.Enabled = False
            Case "DenyAcces"
                Response.Redirect("~/AccessDenied.aspx")
                Exit Sub
            Case Else
                Response.Redirect("~/AccessDenied.aspx")
                Exit Sub
        End Select

    End Sub

    Public Sub LoadOutCome()

        ds = objIncident.SearchBehaviour()

        With gwBehaviourSearch

            Try
                .DataSource = ds
                .DataBind()

            Catch ex As Exception

                lblMsg.BackColor = Color.Red
                lblMsg.ForeColor = Color.White
                lblMsg.Text = "Grid not loaded successfully, Please check your searching criteria"

                log.Error(ex.Message)

            End Try

        End With
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

    Private Sub cbDisciplinaryAction_Load(sender As Object, e As EventArgs) Handles cbDisciplinaryAction.Load
        If Not IsPostBack Then

            Dim objAction As New DisciplinaryActions(CokkiesWrapper.thisConnectionName)
            Dim ds As DataSet = objAction.SelectRecords()

            With cbDisciplinaryAction

                .DataSource = ds
                .DataTextField = "action"
                .DataValueField = "actionId"
                .DataBind()

                .Items.Insert(0, New RadComboBoxItem("", ""))

            End With

        End If
    End Sub

    Protected Sub cmdSearch_Click(sender As Object, e As EventArgs) Handles cmdSearch.Click

        With objIncident

            .incidentNumber = txtIncidentNo.Text
            .offenderId = txtOffenderID.Text
            .incidentTypeId = cbIncidentType.SelectedValue
            .incidentLevelId = cbIncidentLevel.SelectedValue
            .disciplinaryActionId = cbDisciplinaryAction.SelectedValue

        End With

        Try
            LoadOutCome()


        Catch ex As Exception
            log.Error(ex.Message)

        End Try
    End Sub
End Class