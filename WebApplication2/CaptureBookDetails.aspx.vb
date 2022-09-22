Imports Telerik.Web.UI
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing

Public Class CaptureBookDetails
    Inherits System.Web.UI.Page

    Private Shared ReadOnly log As log4net.ILog = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType)
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim objLibraryBooks As New LibraryBooks(CokkiesWrapper.thisConnectionName)
    Dim db As Database = objLibraryBooks.Database
    Dim con As String = db.ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (CokkiesWrapper.UserID <= 0 AndAlso Not IsNumeric(CokkiesWrapper.UserID)) Then
            Response.Redirect("../Login.aspx")
            Exit Sub
        End If

        'obj.ConnectionString = con
        'Dim accessMode As String = obj.groupAccessPermissionsDs(CokkiesWrapper.UserGroup, 5)

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

    Private Sub cbBookCondition_Load(sender As Object, e As EventArgs) Handles cbBookCondition.Load
        If Not IsPostBack Then

            Dim objBookCondition As New BookCondition(CokkiesWrapper.thisConnectionName)
            Dim ds As DataSet = objBookCondition.SelectRecords()

            With cbBookCondition

                .DataSource = ds
                .DataTextField = "bookCondition"
                .DataValueField = "bookConditionId"
                .DataBind()

                .Items.Insert(0, New RadComboBoxItem("", ""))

            End With

        End If
    End Sub

    Private Sub cbLevel_Load(sender As Object, e As EventArgs) Handles cbLevel.Load
        If Not IsPostBack Then

            Dim objStream As New Streams(CokkiesWrapper.thisConnectionName)
            Dim ds As DataSet = objStream.SelectRecords()

            With cbLevel

                .DataSource = ds
                .DataTextField = "stream"
                .DataValueField = "streamId"
                .DataBind()

                .Items.Insert(0, New RadComboBoxItem("", ""))

            End With

        End If
    End Sub

    Private Sub cbSubjects_Load(sender As Object, e As EventArgs) Handles cbSubjects.Load
        If Not IsPostBack Then

            Dim objSubjects As New Subjects(CokkiesWrapper.thisConnectionName)
            Dim ds As DataSet = objSubjects.SelectRecords()

            With cbSubjects

                .DataSource = ds
                .DataTextField = "subject"
                .DataValueField = "subjectId"
                .DataBind()

                .Items.Insert(0, New RadComboBoxItem("", ""))

            End With

        End If
    End Sub

    Private Sub cbSupplier_Load(sender As Object, e As EventArgs) Handles cbSupplier.Load
        If Not IsPostBack Then

            Dim objSupplier As New Suppliers(CokkiesWrapper.thisConnectionName)
            Dim ds As DataSet = objSupplier.SelectRecords()

            With cbSupplier

                .DataSource = ds
                .DataTextField = "supplier"
                .DataValueField = "supplierId"
                .DataBind()

                .Items.Insert(0, New RadComboBoxItem("", ""))

            End With

        End If
    End Sub

    Private Sub cbVersion_Load(sender As Object, e As EventArgs) Handles cbVersion.Load
        If Not IsPostBack Then

            Dim objBookVersions As New BookVersions(CokkiesWrapper.thisConnectionName)
            Dim ds As DataSet = objBookVersions.SelectRecords()

            With cbVersion

                .DataSource = ds
                .DataTextField = "version"
                .DataValueField = "versionId"
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

    Private Sub cmdSave_Click(sender As Object, e As EventArgs) Handles cmdSave.Click

        Try
            With objLibraryBooks

                .ConnectionString = con
                .authorFirstName = txtAurthorFName.Text
                .authorSurname = txtAurthorSname.Text
                .availability = "available"
                .bookId = txtBookNumber.Text
                .bookTitle = txtBookTitle.Text
                .bookTypeId = cbBookType.SelectedValue
                .conditionId = cbBookCondition.SelectedValue
                .dateSupplied = rdDateSupplied.SelectedDate
                .lendingDays = txtLendingDays.Text
                .level1 = cbLevel.SelectedValue
                .level2 = cbLevel.SelectedValue
                .serialNumber = txtSerialNumber.Text
                .subjectId = cbSubjects.SelectedValue
                .supplierId = cbSupplier.SelectedValue
                .version = cbVersion.SelectedValue
                .yearPublished = txtYearPublished.Text

                .Insert()

            End With
            lblMsg.BackColor = Color.Green
            lblMsg.ForeColor = Color.White
            lblMsg.Text = "Book Details were saved successfully!!!"

        Catch ex As Exception

            log.Error(ex)
            lblMsg.BackColor = Color.Red
            lblMsg.ForeColor = Color.White
            lblMsg.Text = "Book Details were not saved successfully!!!"

        End Try
    End Sub

 
End Class