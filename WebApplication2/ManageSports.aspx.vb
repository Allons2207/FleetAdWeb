Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing

Public Class ManageSports
    Inherits System.Web.UI.Page
    Dim objSports As New Sports(CokkiesWrapper.thisConnectionName)
    Dim db As Database = objSports.Database
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

    Protected Sub cmdSave_Click(sender As Object, e As EventArgs) Handles cmdSave.Click
        With objSports
            Try

                .sport = txtSportName.Text
                .ConnectionString = con

                .Insert()
                lblMsg.BackColor = Color.Green
                lblMsg.ForeColor = Color.White
                lblMsg.Text = "the sport was set successfully!!!"

            Catch ex As Exception

                lblMsg.BackColor = Color.Red
                lblMsg.ForeColor = Color.White
                lblMsg.Text = "the sport was not set successfully, Please contact system administrator!!!"

            End Try
        End With
    End Sub

    Private Sub lbSports_Load(sender As Object, e As EventArgs) Handles lbSports.Load
        Dim ds As DataSet = objSports.SelectRecords()

        With lbSports

            .DataValueField = "sport"
            .DataTextField = "sport"
            .DataSource = ds
            .DataBind()


        End With
    End Sub
End Class