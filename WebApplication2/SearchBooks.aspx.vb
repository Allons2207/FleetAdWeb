Imports ClassLibrary1
Imports Telerik.Web.UI
Imports Microsoft.Practices.EnterpriseLibrary.Data

Public Class SearchBooks
    Inherits System.Web.UI.Page

    Private Shared ReadOnly log As log4net.ILog = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType)

    Dim objLibraryBooks As New LibraryBooks(CokkiesWrapper.thisConnectionName)
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)

    Dim db As Database = objLibraryBooks.Database
    Dim con As String = db.ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (CokkiesWrapper.UserID <= 0 AndAlso Not IsNumeric(CokkiesWrapper.UserID)) Then
            Response.Redirect("../Login.aspx")
            Exit Sub
        End If

        obj.ConnectionString = con
        Dim accessMode As String = obj.groupAccessPermissionsDs(CokkiesWrapper.UserGroup, 5)

        Select Case accessMode
            Case "AllowReadNRead"
            Case "ReadNReadOnly"
                'cmdSave.Enabled = False
            Case "DenyAcces"
                Response.Redirect("~/AccessDenied.aspx")
                Exit Sub
            Case Else
                Response.Redirect("~/AccessDenied.aspx")
                Exit Sub
        End Select

    End Sub

    Private Sub cblevel_Load(sender As Object, e As EventArgs) Handles cblevel.Load
        If Not IsPostBack Then

            Dim objStream As New Streams(CokkiesWrapper.thisConnectionName)
            Dim ds As DataSet = objStream.SelectRecords()

            With cblevel

                .DataSource = ds
                .DataTextField = "stream"
                .DataValueField = "streamId"
                .DataBind()

                .Items.Insert(0, New RadComboBoxItem("", ""))

            End With

        End If
    End Sub

    Private Sub cbBookType_Load(sender As Object, e As EventArgs) Handles cbBookType.Load
        If Not IsPostBack Then

            Dim objBookTypes As New BookTypes(CokkiesWrapper.thisConnectionName)
            Dim ds As DataSet = objBookTypes.SelectRecords()

            With cbBookType

                .DataSource = ds
                .DataTextField = "bookType"
                .DataValueField = "bookTypeId"
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
                .DataValueField = "subjectId"
                .DataBind()

                .Items.Insert(0, New RadComboBoxItem("", ""))

            End With

        End If
    End Sub

    Private Sub cmdSearch_Click(sender As Object, e As EventArgs) Handles cmdSearch.Click
        With objLibraryBooks

            .bookId = txtBookNumber.Text
            .authorFirstName = txtAurthorFName.Text
            .authorSurname = txtAurthorSurname.Text
            .bookTitle = txtBookTitle.Text
            .level1 = cblevel.SelectedValue
            .subjectId = cbSubject.SelectedValue
            .bookTypeId = cbBookType.SelectedValue
            .yearPublished = txtYearPublished.Text
            .serialNumber = txtSerialNumber.Text

        End With
        Try
            LoadOutCome()


        Catch ex As Exception
            log.Error(ex.Message)

        End Try
    End Sub

    Public Sub LoadOutCome()

        Dim ds As DataSet = objLibraryBooks.SelectBooks()

        With gwSubjectSearch

            Try
                .DataSource = ds
                .DataBind()

            Catch ex As Exception

                log.Error(ex.Message)

            End Try

        End With
    End Sub


    Protected Sub txtBookNumber_TextChanged(sender As Object, e As EventArgs) Handles txtBookNumber.TextChanged

    End Sub
End Class