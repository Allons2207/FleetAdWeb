Imports ClassLibrary1
Imports Telerik.Web.UI
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing

Public Class LendBook
    Inherits System.Web.UI.Page

    Private Shared ReadOnly log As log4net.ILog = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType)

    Dim objLibraryBooks As New LibraryBooks(CokkiesWrapper.thisConnectionName)
    Dim objStudent As New Student(CokkiesWrapper.thisConnectionName)
    Dim objLibraryBookLending As New LibraryBookLending(CokkiesWrapper.thisConnectionName)
    Dim db As Database = objLibraryBooks.Database
    Dim con As String = db.ConnectionString
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)

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
                cmdSave.Enabled = False
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

        Panel1.Visible = True
        Panel2.Visible = True
        Panel3.Visible = True

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

    Private Sub gwSubjectSearch_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles gwSubjectSearch.ItemCommand
        If e.CommandName = "Lend" Then
            Dim item As GridDataItem = e.Item

            lblSubject.Text = item("subject").Text
            lblAurthour.Text = item("Author FirstName").Text + " " + item("Author Surname").Text
            lblBookTitle.Text = item("Book Title").Text
            lblBookId.Text = item("bookId").Text
            lblLevel.Text = item("stream").Text
            lblAvaible.Text = item("availability").Text
            lblBookType.Text = item("bookType").Text
            lblSerialNumber.Text = item("Serial Number").Text
           
        End If

    End Sub

    Protected Sub txtName_TextChanged(sender As Object, e As EventArgs) Handles txtBorrowerID.TextChanged
        Dim Dss As DataSet = objStudent.selectRecords(txtBorrowerID.Text)

        txtBorrowerName.Text = Dss.Tables(0).Rows(0)("firstName") + " " + Dss.Tables(0).Rows(0)("surname")
        txtBorrowerCategory.Text = "Student(s)"

    End Sub

    Protected Sub cmdSave_Click(sender As Object, e As EventArgs) Handles cmdSave.Click

        Try

            With objLibraryBookLending

                .authour = lblAurthour.Text
                .bookId = lblBookId.Text
                .bookType = lblBookType.Text
                .borrowerIdNumber = txtBorrowerID.Text
                .borrowerName = txtBorrowerName.Text
                .borrowerType = "Student(s)"
                .comments = txtComments.Text
                .ConnectionString = con
                .dateLoanedOut = rdDateLoanedOut.SelectedDate
                .dueDate = rdDueDate.SelectedDate
                .loanDays = txtLoanDays.Text
                .serialNumber = lblSerialNumber.Text
                .title = lblBookTitle.Text
                .penaltyAmt = txtPenaltyRate.Text
                '.returnDate = Today
                .returnStatus = "not available"

                .Insert()

            End With
            lblMsg.BackColor = Color.Green
            lblMsg.ForeColor = Color.White
            lblMsg.Text = "Loaning Details were saved successfully!!!"

        Catch ex As Exception

            log.Error(ex)
            lblMsg.BackColor = Color.Red
            lblMsg.ForeColor = Color.White
            lblMsg.Text = "Loaning Details were not saved successfully!!!"

        End Try
    End Sub

    Protected Sub rdDueDate_SelectedDateChanged(sender As Object, e As Calendar.SelectedDateChangedEventArgs) Handles rdDueDate.SelectedDateChanged

        txtLoanDays.Text = Day(rdDueDate.SelectedDate) - Day(rdDateLoanedOut.SelectedDate)

    End Sub

    Protected Sub cmdCheckerBorrowerHistory_Click(sender As Object, e As EventArgs) Handles cmdCheckerBorrowerHistory.Click
        If Not IsNothing(txtBorrowerID.Text) Then

            LibraryHistory()

        Else
            lblMsg.Text = "First enter the Borrower ID"

        End If
    End Sub
    Sub LibraryHistory()

        Dim sql As String = "SELECT [bookId],[title],[authour],[serialNumber],[bookType],[borrowerName],[borrowerType],[borrowerIdNumber],[dateLoanedOut],[loanDays] ,[dueDate] ,[returnDate],[returnStatus],[penaltyAmt],[comments],[penaltyPaid] FROM [SchoolAd].[dbo].[tbl_libraryBookLending] where borrowerIdNumber = '" & txtBorrowerID.Text & "' and returnStatus = 'not available'"

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            If ds.Tables.Count > 0 Then

                With RadListViewStaffQualifications

                    .DataSource = ds
                    .DataBind()

                End With
            End If
        Catch ex As Exception

            log.Error(ex)
        End Try

    End Sub
End Class