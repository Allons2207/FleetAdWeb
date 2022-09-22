﻿Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports ClassLibrary1
Imports System.Drawing

Public Class ManageXtraCurriculumActivities
    Inherits System.Web.UI.Page
    Dim objActivities As New ExtraCurriculaActivities(CokkiesWrapper.thisConnectionName)
    Dim db As Database = objActivities.Database
    Dim con As String = db.ConnectionString
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (CokkiesWrapper.UserID <= 0 AndAlso Not IsNumeric(CokkiesWrapper.UserID)) Then
            Response.Redirect("../Login.aspx")
            Exit Sub
        End If

        obj.ConnectionString = con
        Dim accessMode As String = obj.groupAccessPermissionsDs(CokkiesWrapper.UserGroup, 9)

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

    End Sub

    Private Sub lbActivities_Load(sender As Object, e As EventArgs) Handles lbActivities.Load
        Dim ds As DataSet = objActivities.SelectRecords()

        With lbActivities

            .DataValueField = "activityName"
            .DataTextField = "activityName"
            .DataSource = ds
            .DataBind()


        End With
    End Sub

    Protected Sub cmdSave_Click(sender As Object, e As EventArgs) Handles cmdSave.Click

        With objActivities
            Try

                .activityName = txtActivityName.Text
                .ConnectionString = con

                .Insert()

                lblMsg.BackColor = Color.Green
                lblMsg.ForeColor = Color.White
                lblMsg.Text = "the activity was set successfully!!!"

            Catch ex As Exception

                lblMsg.BackColor = Color.Red
                lblMsg.ForeColor = Color.White
                lblMsg.Text = "the activity was not set successfully, Please contact system administrator!!!"

            End Try
        End With
    End Sub
End Class