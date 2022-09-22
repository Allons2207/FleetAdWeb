
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Public Class StudentsPortalBehaviour
    Inherits System.Web.UI.Page

    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        gwBehaviourSearchLoad(CokkiesWrapper.StudentID)
    End Sub

    Private Sub gwBehaviourSearchLoad(ByVal StudentId As String)

        Dim sql As String = "  SELECT incidentNumber [Incident Number], dtDate [Incident Date],incidentType,incidentLevel,location, offenderId [Student Number], offender [Student Name], incidentDescription,action, stream, Schclass FROM tbl_incidents I left outer join tbl_incidentTypes IT on I.incidentTypeId = IT.incidentTypeId left outer join tbl_incidentLevels IL on I.incidentLevelId = IL.incidentLevelId left outer join tbl_disciplinaryActions DA on I.disciplinaryActionId = DA.actionId where offenderId = '" + StudentId + "'"
        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            db.ExecuteDataSet(CommandType.Text, sql)

            With gwBehaviourSearch

                .DataSource = ds
                .DataBind()

            End With


        Catch ex As Exception
            '  log.Error(ex)

        End Try

    End Sub
End Class