Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing

Public Class MakeTransportPayment
    Inherits System.Web.UI.Page
    Dim objStudent As New Student(CokkiesWrapper.thisConnectionName)
    Dim objStudentPayment As New TransportPayments(CokkiesWrapper.thisConnectionName)
    Dim objAllPayments As New AllPayments(CokkiesWrapper.thisConnectionName)
    Dim recieptNum As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim dsPayment As DataSet
    Dim db As Database = objStudent.Database
    Dim con As String = db.ConnectionString
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)

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

    Protected Sub cmdSave_Click(sender As Object, e As EventArgs) Handles cmdSave.Click

        If Not (txtAmountPaid.Text = "") Then

            Try
                recieptNum.ConnectionString = con
                txtReceiptNo.Text = recieptNum.fnReceiptNumber

                If txtReceiptNo.Text = "" Then
                    lblMsg.BackColor = Color.Red
                    lblMsg.ForeColor = Color.White
                    lblMsg.Text = "Payment was not saved successfully!!! System could not generate receipt number."
                    Exit Sub
                End If

                With objStudentPayment

                    '.mMonth = Month(Today)
                    .mMonth = obj.monthNameFromMonthNumber(Month(Today))
                    .yYear = Year(Today)
                    .amountPaid = txtAmountPaid.Text
                    .ConnectionString = con
                    .receiptNumber = txtReceiptNo.Text
                    .studentId = txtStudentID.Text
                    ' .setAmount = 0
                    If .InsertAmountPaid = 0 Then
                        lblMsg.BackColor = Color.Red
                        lblMsg.ForeColor = Color.White
                        lblMsg.Text = "Payment was not saved successfully!!! System could not generate receipt number."
                        Exit Sub
                    End If

                End With

                With objAllPayments

                    .amountPaid = txtAmountPaid.Text
                    .ConnectionString = con
                    .cashier = CokkiesWrapper.UserName
                    .studentId = txtStudentID.Text
                    .details = "Transport payment for " + " " + txtStudentID.Text
                    .payment = "Transport"
                    .dtDate = Today
                    .receiptNumber = txtReceiptNo.Text

                    .Insert()

                    '.receiptNumber = objAllPayments.SelectRecords.Tables(0).Rows(objAllPayments.SelectRecords.Tables(0).Rows.Count - 1)("paymentId")
                    '.Update()
                    'txtReceiptNo.Text = .receiptNumber
                End With

                lblMsg.BackColor = Color.Green
                lblMsg.ForeColor = Color.White
                lblMsg.Text = "Payment was saved successfully!!!"

                Response.Redirect("~\TransportReceipt.aspx?op=" + txtReceiptNo.Text)

            Catch ex As Exception

                lblMsg.BackColor = Color.Red
                lblMsg.ForeColor = Color.White
                lblMsg.Text = "Payment was not saved successfully!!!"

            End Try

        End If

    End Sub
    Protected Sub txtStudentID_TextChanged(sender As Object, e As EventArgs) Handles txtStudentID.TextChanged

        Dim ds As DataSet = objStudent.selectRecords(txtStudentID.Text)
        dsPayment = objStudentPayment.SelectRecords(txtStudentID.Text)

        txtStudentFName.Text = ds.Tables(0).Rows(0)("firstName")
        txtSurname.Text = ds.Tables(0).Rows(0)("surname")
        txtStream.Text = ds.Tables(0).Rows(0)("stream")
        txtClass.Text = ds.Tables(0).Rows(0)("schoolClass")

        Dim setAmt As Integer = 0
        Dim paidAmt As Integer = 0
        Dim i As Integer = 0

        If dsPayment.Tables.Count > 0 AndAlso dsPayment.Tables(0).Rows.Count > 0 Then

            For Each row In dsPayment.Tables(0).Rows

                setAmt = setAmt + dsPayment.Tables(0).Rows(i)("setAmount")

                paidAmt = paidAmt + dsPayment.Tables(0).Rows(i)("amountPaid")

                i = i + 1

            Next

            txtAmountDue.Text = setAmt - paidAmt

        Else

            txtAmountDue.Text = 0

        End If

    End Sub


    Protected Sub txtAmountPaid_TextChanged(sender As Object, e As EventArgs) Handles txtAmountPaid.TextChanged
        txtBalance.Text = Val(txtAmountDue.Text) - Val(txtAmountPaid.Text)
    End Sub

    Protected Sub txtAmountDue_TextChanged(sender As Object, e As EventArgs) Handles txtAmountDue.TextChanged
        txtBalance.Text = Val(txtAmountDue.Text) - Val(txtAmountPaid.Text)
    End Sub
End Class