Imports ClassLibrary1
Imports System.Drawing.Printing
Imports Microsoft.Practices.EnterpriseLibrary.Data

Public Class TuitionReceipt
    Inherits System.Web.UI.Page
    Public Property PaperSize As PaperSize
    Private Shared ReadOnly log As log4net.ILog = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType)

    Dim objStudentTutionPayment As New studentTuitionPayments(CokkiesWrapper.thisConnectionName)
    Dim recieptNum As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)

    Dim db As Database = objStudentTutionPayment.Database
    Dim con As String = db.ConnectionString

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsNothing(Request.QueryString("op")) Then
            CokkiesWrapper.StudentID = Request.QueryString("op")
            loadReceiptDetails(Request.QueryString("op"))

            obj.ConnectionString = con
            Dim accessMode As String = obj.groupAccessPermissionsDs(CokkiesWrapper.UserGroup, 4)

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

        End If


    End Sub

    Private Sub loadReceiptDetails(receiptNum As String)

        Dim ds As DataSet = objStudentTutionPayment.selectedTuitionReceiptDetails(receiptNum)

        Try
            If (ds.Tables.Count > 0 AndAlso ds.Tables(0).Rows.Count > 0) Then
                txtStudentId.Text = ds.Tables(0).Rows(0)("studentId").ToString
                ' txtStream.Text = ds.Tables(0).Rows(0)("stream").ToString
                txtSchoolClass.Text = ds.Tables(0).Rows(0)("schoolClass").ToString
                txtIntYear.Text = ds.Tables(0).Rows(0)("intYear").ToString
                txtStrMonth.Text = ds.Tables(0).Rows(0)("strMonth").ToString
                txtExpectedAmt.Text = ds.Tables(0).Rows(0)("expectedAmt").ToString
                txtAmountPaid.Text = ds.Tables(0).Rows(0)("amountPaid").ToString
                txtBalance.Text = ds.Tables(0).Rows(0)("balance").ToString
                ' txtMonthNumber.Text = ds.Tables(0).Rows(0)("monthNumber").ToString
                txtdate.Text = ds.Tables(0).Rows(0)("date").ToString
                txtPenalty.Text = ds.Tables(0).Rows(0)("penalty").ToString
                txtStudent.Text = ds.Tables(0).Rows(0)("student").ToString
                txtReceiptNumber.Text = ds.Tables(0).Rows(0)("receiptNumber").ToString
                txtCashier.Text = ds.Tables(0).Rows(0)("cashier").ToString

            End If
        Catch ex As Exception

        End Try
    End Sub


    Protected Sub BtnPrint_Click(sender As Object, e As EventArgs) Handles BtnPrint.Click
        BtnPrint.Enabled = False
        Response.Redirect("~\Makepayment.aspx")
    End Sub

End Class