Imports ClassLibrary1
Imports Telerik.Web.UI
Imports Microsoft.Practices.EnterpriseLibrary.Data
Public Class Student_Status_Management
    Inherits System.Web.UI.Page
    Dim objStudent As New Student(CokkiesWrapper.thisConnectionName)
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (CokkiesWrapper.UserID <= 0 AndAlso Not IsNumeric(CokkiesWrapper.UserID)) Then
            Response.Redirect("../Login.aspx")
            Exit Sub
        End If

        obj.ConnectionString = con
        Dim accessMode As String = obj.groupAccessPermissionsDs(CokkiesWrapper.UserGroup, 13)

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
    Private Sub cbStudentStatus_Load(sender As Object, e As EventArgs) Handles cbStatus.Load
        If Not IsPostBack Then

            Dim objStatuses As New Statuses(CokkiesWrapper.thisConnectionName)
            Dim ds As DataSet = objStatuses.SelectRecords()

            With cbStatus

                .DataSource = ds
                .DataTextField = "status"
                .DataValueField = "status"
                .DataBind()

                .Items.Insert(0, New RadComboBoxItem("", "0"))

            End With
        End If
    End Sub

    Protected Sub cmdSave_Click(sender As Object, e As EventArgs) Handles cmdSave.Click
        With objStudent

            .studentId = txtStudentNo.Text
            .status = cbStatus.SelectedValue

            .UpdateStatus()

        End With
    End Sub

    Protected Sub txtStudentNo_TextChanged(sender As Object, e As EventArgs) Handles txtStudentNo.TextChanged
        Dim ds As DataSet = objStudent.GetData(txtStudentNo.Text)

        txtFirstName.Text = ds.Tables(0).Rows(0)("firstName")
        txtSurname.Text = ds.Tables(0).Rows(0)("surname")

    End Sub
End Class