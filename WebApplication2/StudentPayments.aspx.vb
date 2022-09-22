
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Microsoft.Practices.EnterpriseLibrary.Common
Imports ClassLibrary1
Imports Telerik.Web.UI
Imports System.Drawing

Public Class StudentPayments
    Inherits System.Web.UI.Page

    Private Shared log As log4net.ILog = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType)
    Dim objStudent As New Student(CokkiesWrapper.thisConnectionName)
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
        Dim accessMode As String = obj.groupAccessPermissionsDs(CokkiesWrapper.UserGroup, 13)

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


        'With objStudent

        '    .firstName = txtFName.Text
        '    .surname = txtSurname.Text
        '    .studentId = txtStudentNo.Text
        '    '.stream = txtStream.
        '    .classes = cbClass.SelectedValue
        '    .mstatus = drpdwnMStatus.SelectedValue
        '    .sexId = drpdnSex.SelectedValue
        '    .orphanhoodStatusId = drpdwnOStatus.SelectedValue

        'End With


    End Sub

    Public Sub loadStudentPayments(qry As String)

        Try
            obj.ConnectionString = con
            Dim ds As DataSet = obj.ExecuteDsQRY(qry)

            'Try
            '    Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, qry)
            '    db.ExecuteDataSet(CommandType.Text, qry)

            With gwStudentSearch
                Try
                    .DataSource = ds
                    .DataBind()
                Catch ex As Exception
                    log.Error(ex.Message)
                    lblMsg.BackColor = Color.Red
                    lblMsg.ForeColor = Color.White
                    lblMsg.Text = "Grid not loaded successfully, Please check your searching criteria"

                    log.Error(ex.Message)
                End Try
            End With
        Catch ex As Exception
            log.Error(ex)
        End Try
    End Sub
   

    Protected Sub btnSearch_Click(sender As Object, e As EventArgs) Handles btnSearch.Click
        Dim qryStr As String = ""


        Select Case cbPaymentType.Text
            Case "All Student Payments"
                qryStr = "SELECT [paymentId], [dtDate],[payment], [amountPaid], [receiptNumber],[cashier] FROM [dbo].[tbl_allPayments] " & _
                         " WHERE [studentId] = '" & txtStudentNo.Text & "'"
                loadStudentPayments(qryStr)
            Case "Tuition"
                qryStr = "SELECT [intYear], [strMonth], [expectedAmt], [amountPaid], [date], [penalty], [receiptNumber], [narrative] " & _
                        " FROM [dbo].[tbl_tuitionPayments] WHERE [studentId] = '" & txtStudentNo.Text & "'"
                loadStudentPayments(qryStr)
            Case "Levy"
                qryStr = "SELECT [intYear], [strTerm], [expectedAmt], [amountPaid], [penalty], [receiptNumber] " & _
                        " FROM [dbo].[tbl_LevyPayments] WHERE [studentd] = '" & txtStudentNo.Text & "'"
                loadStudentPayments(qryStr)
        End Select


    End Sub

    Private Sub drpdnSex_Load(sender As Object, e As EventArgs) Handles drpdnSex.Load
        If Not IsPostBack Then
            Dim objSex As New Sex(CokkiesWrapper.thisConnectionName)
            Dim ds As DataSet = objSex.SelectRecords()

            With drpdnSex

                .DataSource = ds
                .DataTextField = "sex"
                .DataValueField = "sexId"
                .DataBind()

                .Items.Insert(0, New RadComboBoxItem("--Select--", ""))
            End With

        End If
    End Sub


    Private Sub drpdwnMStatus_Load(sender As Object, e As EventArgs) Handles drpdwnMStatus.Load
        If Not IsPostBack Then
            Dim objMaritalStatus As New MaritalStatuses(CokkiesWrapper.thisConnectionName)
            Dim ds As DataSet = objMaritalStatus.luStatuses()

            With drpdwnMStatus

                .DataSource = ds
                .DataTextField = "maritalStatus"
                .DataValueField = "maritalStatusId"
                .DataBind()

                .Items.Insert(0, New RadComboBoxItem("--Select--", ""))

            End With

        End If
    End Sub

    Private Sub drpdwnBStatus_Load(sender As Object, e As EventArgs) Handles drpdwnBStatus.Load
        If Not IsPostBack Then
            Dim objBoardingStatus As New BoardingStatus(CokkiesWrapper.thisConnectionName)
            Dim ds As DataSet = objBoardingStatus.SelectRecords()

            With drpdwnBStatus

                .DataSource = ds
                .DataTextField = "boardingStatus"
                .DataValueField = "boardingStatusId"
                .DataBind()

                .Items.Insert(0, New RadComboBoxItem("--Select--", ""))

            End With
        End If
    End Sub

    Private Sub drpdwnOStatus_Load(sender As Object, e As EventArgs) Handles drpdwnOStatus.Load
        If Not IsPostBack Then
            Dim objOpharnHoodStatus As New OpharnHoodStatus(CokkiesWrapper.thisConnectionName)
            Dim ds As DataSet = objOpharnHoodStatus.SelectRecords()

            With drpdwnOStatus

                .DataSource = ds
                .DataTextField = "orphanhoodStatus"
                .DataValueField = "orphanhoodStatusId"
                .DataBind()

                .Items.Insert(0, New RadComboBoxItem("--Select--", ""))

            End With
        End If
    End Sub



    Private Sub gwStudentSearch_ItemCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs) Handles gwStudentSearch.ItemCommand

        If e.CommandName = "View" Then

            Dim item As GridDataItem = e.Item
            Dim studentId As String = item("studentId").Text
            Response.Redirect("~\StudentDetails.aspx?op=" + studentId)

        End If

    End Sub

    Private Sub txtClass_Load(sender As Object, e As EventArgs) Handles cbClass.Load
        If Not IsPostBack Then
            Dim objSchooolClass As New SchoolClasses(CokkiesWrapper.thisConnectionName)
            Dim ds As DataSet = objSchooolClass.SelectRecords()

            With cbClass

                .DataSource = ds
                .DataTextField = "schoolClass"
                .DataValueField = "schoolClass"
                .DataBind()

                .Items.Insert(0, New RadComboBoxItem("--Select--", ""))

            End With
        End If
    End Sub

    Protected Sub gwStudentSearch_NeedDataSource(sender As Object, e As GridNeedDataSourceEventArgs) Handles gwStudentSearch.NeedDataSource

    End Sub


    Protected Sub cbPaymentType_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cbPaymentType.SelectedIndexChanged
        Dim qryStr As String = ""


        Select Case cbPaymentType.Text
            Case "All Student Payments"
                qryStr = "SELECT [paymentId], [dtDate],[payment], [amountPaid], [receiptNumber],[cashier],[cashier] FROM [dbo].[tbl_allPayments] " & _
                         " WHERE [studentId] = '" & txtStudentNo.Text & "'"
                loadStudentPayments(qryStr)
            Case "Tuition"
                qryStr = "SELECT [intYear], [strMonth], [expectedAmt], [amountPaid], [date], [penalty], [receiptNumber], [narrative] " & _
                        " FROM [dbo].[tbl_tuitionPayments] WHERE [studentId] = '" & txtStudentNo.Text & "'"
                loadStudentPayments(qryStr)
            Case "Levy"
                qryStr = "SELECT [intYear], [strTerm], [expectedAmt], [amountPaid], [penalty], [receiptNumber] " & _
                        " FROM [dbo].[tbl_LevyPayments] WHERE [studentd] = '" & txtStudentNo.Text & "'"
                loadStudentPayments(qryStr)
        End Select
    End Sub




End Class