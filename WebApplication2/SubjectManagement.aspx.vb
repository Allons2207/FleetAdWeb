Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing

Public Class SubjectManagement
    Inherits System.Web.UI.Page
    Dim objCourses As New Subjects(CokkiesWrapper.thisConnectionName)
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = objCourses.Database
    Dim con As String = db.ConnectionString

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
                ' cmdSave.Enabled = False
            Case "DenyAcces"
                Response.Redirect("~/AccessDenied.aspx")
                Exit Sub
            Case Else
                Response.Redirect("~/AccessDenied.aspx")
                Exit Sub
        End Select

    End Sub

    Private Sub lbSubjects_Load(sender As Object, e As EventArgs) Handles lbSubjects.Load

        Dim ds As DataSet = objCourses.SelectRecords()

        With lbSubjects
            .DataValueField = "subject"
            .DataTextField = "subject"
            .DataSource = ds
            .DataBind()
        End With


    End Sub

    Protected Sub cmdSave_Click(sender As Object, e As EventArgs) Handles cmdSave.Click
        With objCourses
            Try

                .subject = txtSubjectName.Text
                .ConnectionString = con

                .Insert()

                lblMsg.BackColor = Color.Green
                lblMsg.ForeColor = Color.White
                lblMsg.Text = "the subject was set successfully!!!"

            Catch ex As Exception

                lblMsg.BackColor = Color.Red
                lblMsg.ForeColor = Color.White
                lblMsg.Text = "the subject was not set successfully, Please contact system administrator!!!"

            End Try
        End With
    End Sub
End Class