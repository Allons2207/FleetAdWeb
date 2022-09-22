
Imports Telerik.Web.UI
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing

Public Class Cashbook
    Inherits System.Web.UI.Page
    Private Shared ReadOnly log As log4net.ILog = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType)
    Dim objCashBookEntry As New CashBookEntries(CokkiesWrapper.thisConnectionName)
    Dim db As Database = objCashBookEntry.Database
    Dim con As String = db.ConnectionString
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If (CokkiesWrapper.UserID <= 0 AndAlso Not IsNumeric(CokkiesWrapper.UserID)) Then
            Response.Redirect("../Login.aspx")
            Exit Sub
        End If


        'obj.ConnectionString = con
        'Dim accessMode As String = obj.groupAccessPermissionsDs(CokkiesWrapper.UserGroup, 8)

        'Select Case accessMode
        '    Case "AllowReadNRead"
        '    Case "ReadNReadOnly"
        '        cmdAddNew.Enabled = False
        '    Case "DenyAcces"
        '        Response.Redirect("~/AccessDenied.aspx")
        '        Exit Sub
        '    Case Else
        '        Response.Redirect("~/AccessDenied.aspx")
        '        Exit Sub
        'End Select

        rdDtDate.MinDate = Today
        rdDtDate.MaxDate = Today
        lblOpeningBal.Text = objCashBookEntry.fnGetCashBookOpening(Today)
        lblCurrentBalance.Text = currentBalance()

        loadDataGrid()


    End Sub

    Protected Sub cmdAddNew_Click(sender As Object, e As EventArgs) Handles cmdAddNew.Click
        ' If MsgBox("You are about to save a Cash Book Transaction.", vbOKCancel) = vbCancel Then Exit Sub
        fnNewBalance()

        If validSave() = False Then Exit Sub

        Dim queryString As String = ""
        ' Dim dt As Date

        ' dt = DatePart(DateInterval.Day, rdDtDate.SelectedDate.Value) & "/" & DatePart(DateInterval.Month, rdDtDate.SelectedDate.Value) & "/" & DatePart(DateInterval.Year, rdDtDate.SelectedDate.Value)
        ' dt = rdDtDate.SelectedDate

        If (cboAction.Text = "Closing Balance" Or cboAction.Text = "Opening Balance") And (Val(txtAmount.Text) <> Val(lblCurrentBalance.Text)) Then
            insertCashBookVariance()
        End If

        Select Case cboAction.Text
            Case "In Coming"
                With objCashBookEntry
                    .ConnectionString = con
                    .dtDate = rdDtDate.SelectedDate
                    .incoming = Val(txtAmount.Text)
                    .balance = Val(lblNewBalance.Text)
                    .narration = txtNotes.Text
                    .capturedBy = CokkiesWrapper.UserName
                    .InsertIncoming()
                    lblCurrentBalance.Text = .fnGetCashBookBalance
                    clearControls()
                End With
            Case "Out Going"
                With objCashBookEntry
                    .ConnectionString = con
                    .dtDate = rdDtDate.SelectedDate
                    .incoming = Val(txtAmount.Text)
                    .outgoing = Val(txtAmount.Text)
                    .balance = Val(lblNewBalance.Text)
                    .narration = txtNotes.Text
                    .capturedBy = CokkiesWrapper.UserName
                    .InsertOutgoing()
                    lblCurrentBalance.Text = .fnGetCashBookBalance
                    clearControls()
                End With
            Case "Closing Balance"
                With objCashBookEntry
                    .ConnectionString = con
                    .dtDate = rdDtDate.SelectedDate
                    .incoming = Val(txtAmount.Text)
                    .closing = Val(txtAmount.Text)
                    .balance = Val(lblNewBalance.Text)
                    .narration = txtNotes.Text
                    .capturedBy = CokkiesWrapper.UserName
                    .InsertClosing()
                    lblCurrentBalance.Text = .fnGetCashBookBalance
                    clearControls()
                End With
            Case "Opening Balance"
                With objCashBookEntry
                    .ConnectionString = con
                    .dtDate = rdDtDate.SelectedDate
                    .incoming = Val(txtAmount.Text)
                    .opening = Val(txtAmount.Text)
                    .balance = Val(lblNewBalance.Text)
                    .narration = txtNotes.Text
                    .capturedBy = CokkiesWrapper.UserName
                    .InsertOpening()
                    lblCurrentBalance.Text = .fnGetCashBookBalance
                    clearControls()
                End With

                '   lblMsg.BackColor = Color.Green
                ' lblMsg.ForeColor = Color.White
                '  lblMsg.Text = "Book Details were saved successfully!!!"

                'Catch ex As Exception

                '    log.Error(ex)
                '    lblMsg.BackColor = Color.Red
                '    lblMsg.ForeColor = Color.White
                '    lblMsg.Text = "Book Details were not saved successfully!!!"

                ' End Try
            Case ""
                ' MsgBox("Unknown Action. Nothing Done", vbInformation + vbOKOnly)
        End Select

        '  If queryString = "" Then Exit Sub

        'insertRecord(queryString)

        'populateTransactions()
        'fnGetCashBookBalance()



        ' objCashBookEntry.InsertOpening()

        'lblOpeningBal.Text = objCashBookEntry.fnGetCashBookBalance

        'clearControls()
        lblOpeningBal.Text = objCashBookEntry.fnGetCashBookOpening(Today)
        lblCurrentBalance.Text = currentBalance()

        loadDataGrid()

    End Sub

    Private Sub insertCashBookVariance()

        Dim mode As String = ""
        Dim variance As Long
        Dim queryString As String

        Select Case cboAction.Text
            Case "Closing Balance"
                mode = "Closing Balance"
            Case "Opening Balance"
                mode = "Opening Balance"
        End Select

        variance = Val(txtAmount.Text) - Val(lblCurrentBalance.Text)

        queryString = "INSERT INTO tbl_cashBookVariances(dtDate, mode, expected, captured, variance, narration)" & _
                               " VALUES ('" & CDate(rdDtDate.SelectedDate) & "','" & mode & "'," & Val(lblCurrentBalance.Text) & _
                               "," & Val(txtAmount.Text) & "," & variance & ",'" & txtNotes.Text & "')"

        Dim insRec As New commonFunction(CokkiesWrapper.thisConnectionName)

        insRec.ConnectionString = con

        If insRec.ExecuteNonQRY(queryString) = 1 Then
            ' lblMsg.Text = "Cashbook entry successfully saved."
        Else
            ' lblMsg.Text = "Cashbook entry has not been saved successfully."
        End If

    End Sub

    Private Sub clearControls()
        ' dtpDate.Value = Now
        txtAmount.Text = ""
        txtNotes.Text = ""
        ' txtContactDets.Text = ""
        lblNewBalance.Text = ""
        cboAction.Text = ""
    End Sub

    Public Function fnNewBalance() As Long

        Select Case cboAction.Text
            Case "In Coming"
                lblNewBalance.Text = Val(lblCurrentBalance.Text) + Val(txtAmount.Text)
            Case "Out Going"
                lblNewBalance.Text = Val(lblCurrentBalance.Text) - Val(txtAmount.Text)
            Case "Closing Balance"
                lblNewBalance.Text = Val(txtAmount.Text)
            Case "Opening Balance"
                lblNewBalance.Text = Val(txtAmount.Text)
            Case ""
        End Select

    End Function


    Public Function currentBalance() As Long
        currentBalance = objCashBookEntry.fnGetCashBookBalance()
    End Function



    Public Function validSave() As Boolean
        lblMsg.Text = ""
        validSave = False

        If cboAction.Text = "" Then
            lblMsg.Text = "Please specify the Action, it cannot be empty."
            Exit Function
        ElseIf Val(txtAmount.Text) = 0 Then
            lblMsg.Text = "Please specify a valid amount, the amount entered is invalid."
            Exit Function
        End If

        If txtNotes.Text = "" Then
            lblMsg.Text = "Please qualify the transaction with notes."
            Exit Function
        End If

        If Val(lblNewBalance.Text) < 0 Then
            lblMsg.Text = "Invalid Transaction. The new balance cannot be less than 0."
            Exit Function
        End If

        'Dim x As Boolean

        'x = fnHasOpeningBalance()

        'If x = False And cboAction.Text <> "Opening Balance" Then
        '    MsgBox("Please first capture the Opening Balance for the day.", vbInformation + vbOKOnly)
        '    Exit Function
        'End If

        validSave = True

    End Function

    Protected Sub txtAmount_TextChanged(sender As Object, e As EventArgs) Handles txtAmount.TextChanged

        fnNewBalance()
    End Sub

    Private Sub loadDataGrid()
        ' Dim sql As String = "SELECT TOP 20 [entryNumber] AS [Entry #], [dtDate] AS [Date], [amountOwing] AS [Amount Owing], [amountPaid] AS [Amount Paid], [balance] AS [Balance],[capturedBy] AS [Captured By] , [narration] AS [Narration] FROM [dbo].[tbl_billPayments] ORDER BY [entryNumber] DESC"
        Dim sql As String = "SELECT TOP 20 [entryNumber] AS [Entry #], [dtDate] AS [Date], [opening] AS [Opening Balance], [incoming] AS [Incoming], " & _
                            "[outgoing] AS [Outgoing], [closing] AS [Closing], [balance] AS Balance, [narration] AS Narration, [capturedBy] AS [Captured By] FROM [dbo].[tbl_cashBook] ORDER BY [entryNumber] DESC"


        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            ' db.ExecuteDataSet(CommandType.Text, sql)

            With gwBillPayments
                Try
                    .DataSource = ds
                    .DataBind()
                Catch ex As Exception
                    log.Error(ex.Message)
                End Try
            End With
        Catch ex As Exception
            log.Error(ex)
        End Try

    End Sub

End Class