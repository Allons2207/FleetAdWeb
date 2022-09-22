Imports ClassLibrary1
Imports System.Drawing.Printing
Imports Microsoft.Practices.EnterpriseLibrary.Data

Public Class TransportReceipt
    Inherits System.Web.UI.Page

    Public Property PaperSize As PaperSize
    Private Shared ReadOnly log As log4net.ILog = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType)
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsNothing(Request.QueryString("op")) Then
            CokkiesWrapper.StudentID = Request.QueryString("op")
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

            loadReceiptDetails(Request.QueryString("op"))

        End If
    End Sub


    Private Sub loadReceiptDetails(receiptNum As String)

        obj.ConnectionString = con

        Dim qryStr As String = "SELECT TOP (100) PERCENT dbo.tbl_schoolClasses.schoolClass, dbo.tbl_students.studentId, dbo.tbl_transportPayments.yYear, " & _
                            " dbo.tbl_transportPayments.mMonth, dbo.tbl_transportPayments.setAmount, dbo.tbl_transportPayments.amountPaid, " & _
                            " dbo.tbl_allPayments.dtDate, dbo.tbl_allPayments.cashier, dbo.tbl_allPayments.receiptNumber, " & _
                            " dbo.tbl_students.firstName + ' ' + dbo.tbl_students.surname AS student FROM            dbo.tbl_students INNER JOIN " & _
                            " dbo.tbl_schoolClasses ON dbo.tbl_students.schoolClassId = dbo.tbl_schoolClasses.schoolClassId INNER JOIN " & _
                            " dbo.tbl_transportPayments ON dbo.tbl_students.studentId = dbo.tbl_transportPayments.studentId INNER JOIN " & _
                            " dbo.tbl_allPayments ON dbo.tbl_transportPayments.receiptNumber = dbo.tbl_allPayments.receiptNumber " & _
                            " WHERE        (dbo.tbl_allPayments.receiptNumber = '" & receiptNum & "')"

        Dim ds As DataSet = obj.ExecuteDsQRY(qryStr)

        Try
            If (ds.Tables.Count > 0 AndAlso ds.Tables(0).Rows.Count > 0) Then
                txtStudentId.Text = ds.Tables(0).Rows(0)("studentId").ToString
                ' txtStream.Text = ds.Tables(0).Rows(0)("stream").ToString
                txtSchoolClass.Text = ds.Tables(0).Rows(0)("schoolClass").ToString
                txtIntYear.Text = ds.Tables(0).Rows(0)("yYear").ToString
                txtStrMonth.Text = ds.Tables(0).Rows(0)("mMonth").ToString
                txtExpectedAmt.Text = ds.Tables(0).Rows(0)("setAmount").ToString
                txtAmountPaid.Text = ds.Tables(0).Rows(0)("amountPaid").ToString
                '  txtBalance.Text = ds.Tables(0).Rows(0)("balance").ToString
                ' txtMonthNumber.Text = ds.Tables(0).Rows(0)("monthNumber").ToString
                txtdate.Text = ds.Tables(0).Rows(0)("dtDate").ToString
                ' txtPenalty.Text = ds.Tables(0).Rows(0)("penalty").ToString
                txtStudent.Text = ds.Tables(0).Rows(0)("student").ToString
                txtReceiptNumber.Text = ds.Tables(0).Rows(0)("receiptNumber").ToString
                txtCashier.Text = ds.Tables(0).Rows(0)("cashier").ToString
            End If
        Catch ex As Exception

        End Try
    End Sub

    Protected Sub BtnPrint_Click(sender As Object, e As EventArgs) Handles BtnPrint.Click
        BtnPrint.Enabled = False
        Response.Redirect("~\MakeTransportPayment.aspx")
    End Sub

End Class