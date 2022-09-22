Imports Telerik.Web.UI
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing

Public Class ReturnBook
    Inherits System.Web.UI.Page

    Private Shared ReadOnly log As log4net.ILog = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType)
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim objLibraryBooks As New LibraryBookLending(CokkiesWrapper.thisConnectionName)
    Dim db As Database = objLibraryBooks.Database
    Dim con As String = db.ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (CokkiesWrapper.UserID <= 0 AndAlso Not IsNumeric(CokkiesWrapper.UserID)) Then
            Response.Redirect("../Login.aspx")
            Exit Sub
        End If

        obj.ConnectionString = con
        Dim accessMode As String = obj.groupAccessPermissionsDs(CokkiesWrapper.UserGroup, 4)

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

    Private Sub cbBookType_Load(sender As Object, e As EventArgs) Handles cbBookType.Load
        If Not IsPostBack Then

            Dim objBookTypes As New BookTypes(CokkiesWrapper.thisConnectionName)
            Dim ds As DataSet = objBookTypes.SelectRecords()

            With cbBookType

                .DataSource = ds
                .DataTextField = "bookType"
                .DataValueField = "bookType"
                .DataBind()

                .Items.Insert(0, New RadComboBoxItem("", ""))

            End With

        End If
    End Sub

    Private Sub cmdSearch_Click(sender As Object, e As EventArgs) Handles cmdSearch.Click

        Panel1.Visible = True
        Panel2.Visible = True

        With objLibraryBooks

            .authour = txtAurthor.Text
            .bookType = cbBookType.SelectedValue
            .borrowerIdNumber = txtBorrowerID.Text
            .borrowerName = txtBorrowerName.Text
            .title = txtBookTitle.Text
            .serialNumber = txtSerialNumber.Text
            .ConnectionString = con


        End With
        Try
            LoadOutCome()


        Catch ex As Exception
            log.Error(ex.Message)

        End Try
    End Sub

    Public Sub LoadOutCome()

        Dim ds As DataSet = objLibraryBooks.SelectRecords()

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
        If e.CommandName = "Return" Then
            Dim item As GridDataItem = e.Item

            lblBooktitle.Text = item("title").Text
            lblAurthour.Text = item("authour").Text
            lblBookID.Text = item("bookId").Text
            lblBookType.Text = item("bookType").Text
            lblBorrowerID.Text = item("borrowerIdNumber").Text
            lblBorrowerName.Text = item("borrowerName").Text
            lblDateBorrowed.Text = item("dateLoanedOut").Text
            lblDateDue.Text = item("dueDate").Text

        End If
    End Sub

    Protected Sub cmdSave_Click(sender As Object, e As EventArgs) Handles cmdSave.Click


        With objLibraryBooks

            Try

                .ConnectionString = con
                .bookId = lblBookID.Text
                .returnDate = rdReturnDate.SelectedDate
                .returnStatus = cbReturnStatus.SelectedValue
                .penaltyPaid = txtPenalty.Text
                lblDaysOverDue.Text = Day(rdReturnDate.SelectedDate) - Day(lblDateDue.Text)

                .Update()

                Dim objLibBooks As New LibraryBooks(CokkiesWrapper.thisConnectionName)
                objLibBooks.ConnectionString = con
                objLibBooks.availability = .returnStatus
                objLibBooks.bookId = .bookId
                objLibBooks.Update()


                lblMsg.BackColor = Color.Green
                lblMsg.ForeColor = Color.White
                lblMsg.Text = "the book was returned successfully!!!"

            Catch ex As Exception

                lblMsg.BackColor = Color.Red
                lblMsg.ForeColor = Color.White
                lblMsg.Text = "the book was not returned successfully, Please contact system administrator!!!"

            End Try

        End With
    End Sub
End Class