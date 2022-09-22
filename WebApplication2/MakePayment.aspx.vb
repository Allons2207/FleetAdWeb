Imports ClassLibrary1
Imports System.Math
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing

Public Class MakePayment
    Inherits System.Web.UI.Page

    Private Shared ReadOnly log As log4net.ILog = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType)

    Dim objPaymentsSchedule As New SetTuitionPaymentsSchedule(CokkiesWrapper.thisConnectionName)
    Dim objLevyPaymentsSchedule As New SetLevyPaymentsSchedule(CokkiesWrapper.thisConnectionName)
    Dim objStudent As New Student(CokkiesWrapper.thisConnectionName)
    Dim objStudentSubject As New StudentsSubjects(CokkiesWrapper.thisConnectionName)
    Dim objStudentTutionPayment As New studentTuitionPayments(CokkiesWrapper.thisConnectionName)
    Dim objStudentLevyPayments As New StudentLevyPayments(CokkiesWrapper.thisConnectionName)
    Dim objAllPayments As New AllPayments(CokkiesWrapper.thisConnectionName)
    Dim recieptNum As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)

    Dim db As Database = objStudent.Database
    Dim con As String = db.ConnectionString

    Dim TutionArrearsBfo As Integer = 0
    Dim LevyArrearsBfo As Integer = 0


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
         If (CokkiesWrapper.UserID <= 0 AndAlso Not IsNumeric(CokkiesWrapper.UserID)) Then
            Response.Redirect("~/Login.aspx")
            Exit Sub
        End If

        obj.ConnectionString = con
        Dim accessMode As String = obj.groupAccessPermissionsDs(CokkiesWrapper.UserGroup, 4)

        Select Case accessMode
            Case "AllowReadNRead"
            Case "ReadNReadOnly"
                cmdSaveShow.Enabled = False
            Case "DenyAcces"
                Response.Redirect("~/AccessDenied.aspx")
                Exit Sub
            Case Else
                Response.Redirect("~/AccessDenied.aspx")
                Exit Sub
        End Select


        Dim str As String = "SELECT [paymentMethodId], [paymentMethod] FROM [dbo].[luPaymentMethod]"
        obj.loadComboBox(radCboMethodOfPayment, str, "paymentMethod", "paymentMethodId")


    End Sub
    Private Sub ShowStudentDetails()

        Dim strx As String = ""
        Dim ds As DataSet = objStudent.selectRecords(txtStudentID.Text)

        Try
            If Not (ds.Tables.Count > 0 AndAlso ds.Tables(0).Rows.Count > 0) Then

                lblMsg.Visible = True
                lblMsg.BackColor = Color.Red
                lblMsg.ForeColor = Color.White
                lblMsg.Text = "Please cross check the studentID or contact the admin if the studentID is correct"

            Else

                Dim dsSubjects As DataSet = objStudentSubject.GetRecords(txtStudentID.Text)
                Dim dsStudentPayments As DataSet = objStudentTutionPayment.SelectRecords(txtStudentID.Text)
                Dim dsScheduledPayment As DataSet = objStudentTutionPayment.selectScheduledPaymentEntry(txtStudentID.Text)
                Dim dsLevyPayments As DataSet = objStudentLevyPayments.SelectRecords(txtStudentID.Text)
                Dim dsTuition As DataSet = objPaymentsSchedule.GetTuition(ds.Tables(0).Rows(0)("streamId"))
                Dim dslevy As DataSet = objLevyPaymentsSchedule.GetLevy(ds.Tables(0).Rows(0)("streamId"))
                ' Dim dsStudentTuitionPayments As DataSet

                Dim x As Integer = 0

                txtFirstName.Text = ds.Tables(0).Rows(0)("firstName")
                txtSurname.Text = ds.Tables(0).Rows(0)("surname")
                txtStream.Text = ds.Tables(0).Rows(0)("stream")
                txtClass.Text = ds.Tables(0).Rows(0)("schoolClass")

                If dsSubjects.Tables(0).Rows.Count > 0 AndAlso dsSubjects.Tables.Count > 0 Then
                    txtNumOfSubjects.Text = dsSubjects.Tables(0).Rows.Count
                End If

                txtRegistrationDate.Text = ds.Tables(0).Rows(0)("registrationDate")

                If dsTuition.Tables(0).Rows.Count > 0 AndAlso dslevy.Tables(0).Rows.Count > 0 Then
                    txtTuitionCurr.Text = dsTuition.Tables(0).Rows(0)("amountPerMonth")
                    txtLevyCurr.Text = dslevy.Tables(0).Rows(0)("amountPerTerm")
                    txtCurrTotal.Text = CType(dsTuition.Tables(0).Rows(0)("amountPerMonth"), Integer) + CType(dslevy.Tables(0).Rows(0)("amountPerTerm"), Integer)
                End If

                Dim xx As String = ""

                If dsScheduledPayment.Tables(0).Rows.Count > 0 Then
                    Dim Y As Integer = 0
                    xx = CStr(dsScheduledPayment.Tables(0).Rows(0)("monthNumber").ToString) & "/" & "1/" & CStr(dsScheduledPayment.Tables(0).Rows(0)("intYear").ToString)
                    Y = DateDiff(DateInterval.Day, CDate(xx), Today)

                    If Val(txtTuitionArrears.Text) - Val(txtTuitionCurr.Text) Then

                    End If

                    Select Case Y
                        Case 0 To 6

                        Case 7 To 13
                            txtTuitionPenalty.Text = 5
                        Case 14 To 20
                            txtTuitionPenalty.Text = 10
                        Case 21 To 27
                            txtTuitionPenalty.Text = 15
                        Case Is >= 28
                            txtTuitionPenalty.Text = 20
                    End Select

                    'If Y > 0 Then
                    '    Y = DateDiff(DateInterval.Weekday, CDate(xx), Today) + 1
                    '    txtTuitionPenalty.Text = Y * 5
                    'End If
                End If

                Dim i As Integer = 0

                If dsStudentPayments.Tables.Count > 0 AndAlso dsStudentPayments.Tables(0).Rows.Count > 0 Then
                    For Each row In dsStudentPayments.Tables(0).Rows
                        TutionArrearsBfo = TutionArrearsBfo + (dsStudentPayments.Tables(0).Rows(i)("expectedAmt") - dsStudentPayments.Tables(0).Rows(i)("amountPaid"))
                        If Not IsDBNull(dsStudentPayments.Tables(0).Rows(i)("penalty")) Then
                            TutionArrearsBfo = TutionArrearsBfo + dsStudentPayments.Tables(0).Rows(i)("penalty")
                        End If
                        If i < dsStudentPayments.Tables(0).Rows.Count Then
                            i = i + 1
                        End If
                    Next

                    txtTuitionArrears.Text = TutionArrearsBfo - CType(dsTuition.Tables(0).Rows(0)("amountPerMonth"), Integer)

                    If Not IsDBNull(txtLevyArrears.Text) Then
                        txtArrearsTotal.Text = Val(txtLevyArrears.Text) + Val(txtTuitionArrears.Text)
                    Else
                        txtArrearsTotal.Text = Val(txtTuitionArrears.Text)
                    End If

                    If (txtTuitionPenalty.Text = "") Then
                        txtTuitionAmtDue.Text = TutionArrearsBfo
                    Else
                        txtTuitionAmtDue.Text = Val(TutionArrearsBfo) + Val(txtTuitionPenalty.Text) '+ Val(txtTuitionCurr.Text)
                    End If
                Else
                    lblMsg.BackColor = Color.Red
                    lblMsg.ForeColor = Color.White
                    lblMsg.Text = "The student does not have any tuition transaction..."
                End If

                If dsLevyPayments.Tables.Count > 0 AndAlso dsLevyPayments.Tables(0).Rows.Count > 0 Then
                    i = 0
                    For Each row In dsLevyPayments.Tables(0).Rows
                        LevyArrearsBfo = LevyArrearsBfo + (dsLevyPayments.Tables(0).Rows(i)("expectedAmt") - dsLevyPayments.Tables(0).Rows(i)("amountPaid") + dsLevyPayments.Tables(0).Rows(i)("penalty"))
                        If i < dsLevyPayments.Tables(0).Rows.Count Then
                            i = i + 1
                        End If
                    Next

                    txtLevyArrears.Text = LevyArrearsBfo - CType(dslevy.Tables(0).Rows(0)("amountPerTerm"), Integer)

                    'txtArrearsTotal.Text = txtLevyArrears.Text

                    If Not (txtTuitionArrears.Text = "") Then
                        txtArrearsTotal.Text = CType(Val(txtLevyArrears.Text), Integer) + CType(Val(txtTuitionArrears.Text), Integer)
                    End If

                    If (txtLevyPenalty.Text = "") Then
                        txtLevyAmtDue.Text = LevyArrearsBfo
                    Else
                        txtLevyAmtDue.Text = LevyArrearsBfo + CType(txtLevyPenalty.Text, Integer) + Val(txtLevyCurr.Text)

                        If Not (txtTuitionPenalty.Text = "") Then

                            txtPenaltyTotal.Text = CType(txtTuitionPenalty.Text, Integer) + CType(txtLevyPenalty.Text, Integer)

                        Else

                            txtPenaltyTotal.Text = CType(txtLevyPenalty.Text, Integer)

                        End If

                    End If

                    If Not (txtTuitionAmtDue.Text = "") Then

                        txtAmtDueTotal.Text = CType(txtLevyAmtDue.Text, Integer) + CType(txtTuitionAmtDue.Text, Integer)

                    End If
                Else
                    lblMsg.BackColor = Color.Red
                    lblMsg.ForeColor = Color.White
                    lblMsg.Text = "No levy transactions for the student"

                End If

            End If

        Catch ex As Exception

            log.Error(ex)
            lblMsg.Visible = True
            lblMsg.BackColor = Color.Red
            lblMsg.ForeColor = Color.White
            lblMsg.Text = "Please contact the admin"

        End Try

        loadStudentPayments()

    End Sub

    Protected Sub txtTuitionPenalty_TextChanged(sender As Object, e As EventArgs) Handles txtTuitionPenalty.TextChanged

        If Not (txtTuitionPenalty.Text = "") Then

            Try
                With objStudentTutionPayment

                    .ConnectionString = con

                    .amountPaid = 0
                    .expectedAmt = 0
                    .intYear = Year(Today)
                    .monthNumber = Month(Today)
                    .strMonth = MonthName(.monthNumber, True)
                    .studentId = txtStudentID.Text
                    .penalty = txtTuitionPenalty.Text
                    .receiptNumber = txtReceiptrNumber.Text

                    .Insert()

                End With


                If Not (txtLevyPenalty.Text = "") Then

                    txtPenaltyTotal.Text = CType((txtLevyPenalty.Text), Integer) + txtTuitionPenalty.Text
                Else

                    txtPenaltyTotal.Text = txtTuitionPenalty.Text

                End If

                Dim x As Integer = txtTuitionAmtDue.Text

                txtTuitionAmtDue.Text = x + txtTuitionPenalty.Text

                x = txtTuitionAmtDue.Text

                txtAmtDueTotal.Text = x + txtLevyAmtDue.Text

                'txtTuitionArrears.Text = CType(txtTuitionArrears.Text, Integer) + txtTuitionPenalty.Text

                'txtArrearsTotal.Text = CType(txtTuitionArrears.Text, Integer) + CType(txtLevyArrears.Text, Integer)

                lblMsg.BackColor = Color.Green
                lblMsg.ForeColor = Color.White
                lblMsg.Text = "Penalty was added successfully!!!"

            Catch ex As Exception

                log.Error(ex)
                lblMsg.BackColor = Color.Red
                lblMsg.ForeColor = Color.White
                lblMsg.Text = "Penalty was not added successfully!!!"

            End Try
        End If

    End Sub

    'Protected Sub txtTuitionAmtPaid_TextChanged(sender As Object, e As EventArgs) Handles txtTuitionAmtPaid.TextChanged

    '    If (txtTuitionAmtPaid.Text = "") Then

    '        txtTuitionBalance.Text = txtTuitionAmtDue.Text

    '    Else

    '        Dim x As Integer = txtTuitionAmtDue.Text
    '        Dim y As Integer = txtTuitionAmtPaid.Text


    '        txtTuitionBalance.Text = x - y

    '        txtBalanceTotal.Text = x - y

    '        If Not (txtLevyAmtPaid.Text = "") Then

    '            Dim total As Integer = txtTuitionBalance.Text
    '            txtBalanceTotal.Text = total + txtLevyAmtPaid.Text

    '        End If

    '    End If
    'End Sub


    Protected Sub txtLevyPenalty_TextChanged(sender As Object, e As EventArgs) Handles txtLevyPenalty.TextChanged

        Try

            With objStudentLevyPayments

                .ConnectionString = con

                .amountPaid = 0
                .expectedAmt = 0
                .intYear = Year(Today)
                If Month(Today) < 4 Then
                    .TermNumber = 1
                    .strTerm = "First Term"

                ElseIf Month(Today) > 3 AndAlso Month(Today) < 9 Then

                    .TermNumber = 2
                    .strTerm = "Second Term"

                ElseIf Month(Today) > 8 Then


                    .TermNumber = 3
                    .strTerm = "Third Term "

                End If

                .studentd = txtStudentID.Text
                .penalty = txtLevyPenalty.Text
                .receiptNumber = txtReceiptrNumber.Text

                .Insert()

              
            End With
            Dim x As Integer
            If txtLevyAmtDue.Text = "" Then
                x = 0
            Else
                x = txtLevyAmtDue.Text
            End If

            txtLevyAmtDue.Text = x + txtLevyPenalty.Text

            x = txtLevyAmtDue.Text

            txtAmtDueTotal.Text = x + txtTuitionAmtDue.Text

            If Not (txtTuitionPenalty.Text = "") Then

                Dim g As Integer = txtLevyPenalty.Text

                txtPenaltyTotal.Text = g + txtTuitionPenalty.Text

            Else

                txtPenaltyTotal.Text = txtLevyPenalty.Text

            End If

            lblMsg.BackColor = Color.Green
            lblMsg.ForeColor = Color.White
            lblMsg.Text = "Penalty was added successfully!!!"

        Catch ex As Exception
            log.Error(ex)
            lblMsg.BackColor = Color.Red
            lblMsg.ForeColor = Color.White
            lblMsg.Text = "Penalty was not added successfully!!!"

        End Try


    End Sub

    Public Function validSave() As Integer

        If txtStudentID.Text = "" Then
            lblMsg.Text = "Invalid Student ID"
            lblMsg.ForeColor = Color.Red
            Return 0
            Exit Function
        ElseIf txtFirstName.Text = "" Then
            lblMsg.Text = "Invalid Student Details"
            lblMsg.ForeColor = Color.Red
            Return 0
            Exit Function
        ElseIf Val(txtTuitionAmtPaid.Text) = 0 And Val(txtLevyAmtPaid.Text) = 0 Then
            lblMsg.Text = "Invalid Amount Paid"
            lblMsg.ForeColor = Color.Red
            Return 0
            Exit Function
        End If
        Return 1
    End Function

    Private Sub levyPayment()

        Dim insRec As New commonFunction(CokkiesWrapper.thisConnectionName)
        Dim TermNumber As Integer = 0
        Dim strTerm As String = ""
        insRec.ConnectionString = con

        If Not (txtLevyAmtPaid.Text = "") Then

            Dim x As Integer = txtLevyAmtDue.Text
            Dim y As Integer = txtLevyAmtPaid.Text

            txtLevyBalance.Text = x - y
            txtBalanceTotal.Text = x - y

            If Not (txtTuitionBalance.Text = "") Then

                Dim total As Integer = txtLevyBalance.Text
                txtBalanceTotal.Text = total + txtTuitionBalance.Text
            End If

            Try

                With objStudentLevyPayments
                    .ConnectionString = con

                    '.Insert()

                    Dim sql As String = "SELECT TOP 1 * FROM [dbo].[tbl_LevyPayments] WHERE [studentd] = '" & txtStudentID.Text & "'  ORDER BY [levyPaymentId]  DESC, [termNumber] DESC"

                    Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)

                    If ds.Tables().Count > 0 Then

                        If ds.Tables(0).Rows.Count > 0 Then
                            '.intYear = .selectLastScheduledPaymentEntry(txtStudentID.Text).Tables(0).Rows(0)("intYear").ToString()
                            ' .penalty = Val(txtLevyPenalty.Text)
                            ' .expectedAmt = Val(txtLevyAmtDue.Text)
                            ' .studentd = txtStudentID.Text
                            ' .amountPaid = txtLevyAmtPaid.Text
                            ' .intYear = Year(Today)
                            ' .receiptNumber = txtReceiptrNumber.Text

                            If Month(Today) < 4 Then
                                TermNumber = 1
                                strTerm = "First Term"
                            ElseIf Month(Today) > 3 AndAlso Month(Today) < 9 Then
                                TermNumber = 2
                                strTerm = "Second Term"
                            ElseIf Month(Today) > 8 Then
                                TermNumber = 3
                                strTerm = "Third Term "
                            End If

                            Dim qry As String = "UPDATE [dbo].[tbl_LevyPayments] SET [amountPaid] =" & Val(txtLevyAmtPaid.Text) + ds.Tables(0).Rows(0)("amountPaid") & ", [penalty] =" & Val(txtLevyPenalty.Text) & _
                                ", [receiptNumber] = '" & txtReceiptrNumber.Text & "' WHERE [levyPaymentId] = " & ds.Tables(0).Rows(0)("levyPaymentId").ToString()

                            If insRec.ExecuteNonQRY(qry) = 1 Then


                                With objAllPayments

                                    .amountPaid = txtLevyAmtPaid.Text
                                    .ConnectionString = con

                                    If IsNumeric(CokkiesWrapper.UserName) Then
                                        .cashier = getNameFromID(CokkiesWrapper.UserName)
                                    Else
                                        .cashier = CokkiesWrapper.UserName
                                    End If

                                    .studentId = txtStudentID.Text

                                    If txtNotesComments.Text = "" Then
                                        .details = "Levy payment for " + " " + txtStudentID.Text
                                    Else
                                        .details = txtNotesComments.Text
                                    End If

                                    .paymentMethod = radCboMethodOfPayment.Text
                                    .payment = "Levy"
                                    .dtDate = Today
                                    .receiptNumber = txtReceiptrNumber.Text

                                    .Insert()
                                    ' .receiptNumber = objAllPayments.SelectRecords.Tables(0).Rows(objAllPayments.SelectRecords.Tables(0).Rows.Count - 1)("paymentId")
                                    ' .Update()
                                    ' txtReceiptrNumber.Text = .receiptNumber
                                End With

                                lblMsg.BackColor = Color.Green
                                lblMsg.ForeColor = Color.White
                                lblMsg.Text = "Payment was saved successfully!!!"

                                lblMsg.Text = "Levy payment successfully posted."
                                lblMsg.ForeColor = Color.Green
                                txtLevyArrears.Text = ""
                                txtLevyCurr.Text = ""
                                txtLevyPenalty.Text = ""
                                txtLevyAmtDue.Text = ""
                                txtLevyAmtPaid.Text = ""
                                txtLevyBalance.Text = ""
                            Else
                                lblMsg.Text = "Levy payment failed."
                                lblMsg.ForeColor = Color.Red
                                Exit Sub
                            End If

                        End If

                        Dim tAmtPaid As Integer = txtLevyAmtPaid.Text

                        If Not (txtTuitionAmtPaid.Text = "") Then

                            Dim h As Integer = txtTuitionAmtPaid.Text
                            txtAmtPaidTotal.Text = h + tAmtPaid
                        Else
                            txtAmtPaidTotal.Text = tAmtPaid
                        End If
                    End If

                End With

               

            Catch ex As Exception
                log.Error(ex)
                lblMsg.BackColor = Color.Red
                lblMsg.ForeColor = Color.White
                lblMsg.Text = "Payment was not saved successfully!!!"
            End Try

        Else
            txtLevyBalance.Text = txtLevyAmtDue.Text
            txtBalanceTotal.Text = txtLevyBalance.Text
        End If

    End Sub


    Private Sub tuitionPayment()
        Dim x As Integer = Val(txtTuitionAmtDue.Text)
        Dim y As Integer = Val(txtTuitionAmtPaid.Text)

        txtTuitionBalance.Text = x - y
        txtBalanceTotal.Text = x - y

        If Not (txtLevyAmtPaid.Text = "") Then
            Dim total As Integer = txtTuitionBalance.Text
            txtBalanceTotal.Text = total + txtLevyAmtPaid.Text
        End If

        Try
            With objStudentTutionPayment
                .ConnectionString = con
                .penalty = Val(txtTuitionPenalty.Text)
                .expectedAmt = txtTuitionAmtDue.Text
                .studentId = txtStudentID.Text

                If (.selectScheduledPaymentEntry(txtStudentID.Text).Tables.Count > 0) Then
                    .intYear = .selectScheduledPaymentEntry(txtStudentID.Text).Tables(0).Rows(0)("intYear").ToString()
                    .monthNumber = .selectScheduledPaymentEntry(txtStudentID.Text).Tables(0).Rows(0)("monthNumber").ToString()
                    .strMonth = MonthName(.monthNumber, True)

                    If Not IsDBNull(.selectScheduledPaymentEntry(txtStudentID.Text).Tables(0).Rows(0)("receiptNumber")) Then
                        If .selectScheduledPaymentEntry(txtStudentID.Text).Tables(0).Rows(0)("receiptNumber") <> "" Then
                            .narrative = "Composite/Combined Receipts."
                        End If
                    Else
                        .narrative = ""
                    End If

                    .receiptNumber = txtReceiptrNumber.Text
                    .amountPaid = Val(txtTuitionAmtPaid.Text) + .selectScheduledPaymentEntry(txtStudentID.Text).Tables(0).Rows(0)("amountPaid")

                    ' .Insert()

                    Dim qry As String = "UPDATE [tbl_tuitionPayments] SET [amountPaid] = " & .amountPaid & _
                        ", [penalty] = " & Val(txtTuitionPenalty.Text) & ", [receiptNumber] = '" & txtReceiptrNumber.Text & _
                        "', narrative = '" & .narrative & "' " & _
                        "  WHERE [tuitionPaymentId] = " & .selectScheduledPaymentEntry(txtStudentID.Text).Tables(0).Rows(0)("tuitionPaymentId").ToString()

                    Dim insRec As New commonFunction(CokkiesWrapper.thisConnectionName)
                    insRec.ConnectionString = con

                    If insRec.ExecuteNonQRY(qry) = 1 Then

                        With objAllPayments

                            .amountPaid = txtTuitionAmtPaid.Text
                            .ConnectionString = con

                            If IsNumeric(CokkiesWrapper.UserName) Then
                                .cashier = getNameFromID(CokkiesWrapper.UserName)
                            Else
                                .cashier = CokkiesWrapper.UserName
                            End If

                            .studentId = txtStudentID.Text

                            If txtNotesComments.Text = "" Then
                                .details = "Tuiton payment for " + " " + txtStudentID.Text
                            Else
                                .details = txtNotesComments.Text
                            End If

                            .paymentMethod = radCboMethodOfPayment.Text
                            .payment = "Tuition"
                            .dtDate = Today
                            .receiptNumber = txtReceiptrNumber.Text

                            .Insert()

                            ' .receiptNumber = objAllPayments.SelectRecords.Tables(0).Rows(objAllPayments.SelectRecords.Tables(0).Rows.Count - 1)("paymentId")
                            .receiptNumber = txtReceiptrNumber.Text

                            '.Update()

                            'txtReceiptrNumber.Text = .receiptNumber

                        End With

                        lblMsg.BackColor = Color.Green
                        lblMsg.ForeColor = Color.White
                        lblMsg.Text = "Payment was saved successfully!!!"

                        lblMsg.Text = "Tuition payment successfully posted."
                        lblMsg.ForeColor = Color.Green

                        ShowStudentDetails()

                        Response.Redirect("~\TuitionReceipt.aspx?op=" + txtReceiptrNumber.Text)
                    Else
                        lblMsg.Text = "Tuition payment failed."
                        lblMsg.ForeColor = Color.Red
                        Exit Sub
                    End If

                End If

                Dim tAmtPaid As Integer = txtTuitionAmtPaid.Text

                If Not (txtLevyAmtPaid.Text = "") Then
                    txtAmtPaidTotal.Text = tAmtPaid + txtLevyAmtPaid.Text
                Else
                    txtAmtPaidTotal.Text = tAmtPaid
                End If

            End With

           

            '    txtTuitionArrears.Text = ""
            '  txtTuitionCurr.Text = ""
            '   txtTuitionPenalty.Text = ""
            '   txtTuitionAmtPaid.Text = ""
            '   txtTuitionBalance.Text = ""
            '   txtTuitionAmtDue.Text = ""
            '   txtReceiptrNumber.Text = ""

        Catch ex As Exception
            log.Error(ex)
            lblMsg.BackColor = Color.Red
            lblMsg.ForeColor = Color.White
            lblMsg.Text = "Payment was not saved successfully!!!"

        End Try
    End Sub


    Protected Sub cmdSaveShow_Click(sender As Object, e As EventArgs) Handles cmdSaveShow.Click

        If validSave() = 0 Then Exit Sub

        recieptNum.ConnectionString = con
        txtReceiptrNumber.Text = recieptNum.fnReceiptNumber

        If txtReceiptrNumber.Text = "" Then
            lblMsg.BackColor = Color.Red
            lblMsg.ForeColor = Color.White
            lblMsg.Text = "Save failed. Application could not generate correct receipt number!!!"
            Exit Sub
        End If


        If Not (txtLevyAmtPaid.Text = "") Then
            levyPayment()
        End If


        If Not (txtTuitionAmtPaid.Text = "") Then
            tuitionPayment()
        Else
            'txtTuitionBalance.Text = txtTuitionAmtDue.Text

            'If Not (txtTuitionBalance.Text = "") Then

            '    Dim x As Double = txtTuitionBalance.Text

            '    If Not txtBalanceTotal.Text = "" Then

            '        txtBalanceTotal.Text = txtBalanceTotal.Text + x

            '    Else
            '        txtBalanceTotal.Text = x
            '    End If
            'End If
        End If

       

    End Sub

    Protected Sub cmdShowStudentDets_Click(sender As Object, e As EventArgs) Handles cmdShowStudentDets.Click

        ShowStudentDetails()

    End Sub

    Protected Sub btnShowPaymentsGrid_Click(sender As Object, e As EventArgs) Handles btnShowPaymentsGrid.Click
        loadStudentPayments()
    End Sub
    Private Sub loadStudentPayments()
        Select Case cboItemType.SelectedValue
            Case "Tuition"
                loadStudentTuitionPayments()
            Case "Levy"
                loadStudentLevyPayments()
            Case "All Payments"
                loadStudentAllPayments()
        End Select
    End Sub
    Private Sub loadStudentTuitionPayments()
        With gwTuitionPayments
            Try
                '  Dim sql As String = "select * from tbl_tuitionPayments where studentId = '" & txtStudentID.Text & "'"
                Dim sql = "SELECT studentId AS [Sudent ID], tuitionPaymentId AS [Payment ID], intYear AS Year, strMonth AS Month," & _
                          " expectedAmt AS [Expected Amount], amountPaid AS [Amount Paid], date AS [Payment Date], " & _
                         "  penalty AS Penalty, receiptNumber AS [Receipt #], narrative AS Narrative FROM dbo.tbl_tuitionPayments " & _
                        " WHERE   studentId = '" & txtStudentID.Text & "'"

                Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
                .DataSource = ds
                .DataBind()
            Catch ex As Exception
                log.Error(ex.Message)
            End Try
        End With
    End Sub

    Private Sub loadStudentLevyPayments()
        With gwTuitionPayments
            Try
                Dim sql As String = "select * from tbl_LevyPayments where studentd = '" & txtStudentID.Text & "'"
                Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
                .DataSource = ds
                .DataBind()
            Catch ex As Exception
                log.Error(ex.Message)
            End Try
        End With
    End Sub

    Private Sub loadStudentAllPayments()
        With gwTuitionPayments
            Try
                Dim sql As String = "select * from [dbo].[tbl_allPayments] WHERE studentId = '" & txtStudentID.Text & "'"
                Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
                .DataSource = ds
                .DataBind()
            Catch ex As Exception
                log.Error(ex.Message)
            End Try
        End With
    End Sub


    Public Function getNameFromID(ByVal userID As Integer) As String

        Dim sql As String = "SELECT [firstName] + ' ' + [lastName] AS fullName FROM [dbo].[tbl_systemUsers] WHERE [Id] = " & userID
        Try

            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)

            If ds.Tables(0).Rows.Count > 0 Then
                Return ds.Tables(0).Rows(0).Item(0)
            Else
                Return ""
            End If
        Catch ex As Exception
            Return ""
        End Try

    End Function

End Class