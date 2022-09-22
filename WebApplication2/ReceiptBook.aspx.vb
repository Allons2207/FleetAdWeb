Imports Telerik.Web.UI
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing
Public Class ReceiptBook
    Inherits System.Web.UI.Page
    Private Shared ReadOnly log As log4net.ILog = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType)
    Dim insRec As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = insRec.Database
    Dim con As String = db.ConnectionString

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (CokkiesWrapper.UserID <= 0 AndAlso Not IsNumeric(CokkiesWrapper.UserID)) Then
            Response.Redirect("../Login.aspx")
            Exit Sub
        End If


        insRec.ConnectionString = con
        Dim accessMode As String = insRec.groupAccessPermissionsDs(CokkiesWrapper.UserGroup, 6)

        Select Case accessMode
            Case "AllowReadNRead"
            Case "ReadNReadOnly"
                cmdAddNew.Enabled = False
            Case "DenyAcces"
                Response.Redirect("~/AccessDenied.aspx")
                Exit Sub
            Case Else
                Response.Redirect("~/AccessDenied.aspx")
                Exit Sub
        End Select


        loadDataGrid()
    End Sub

    Protected Sub cmdAddNew_Click(sender As Object, e As EventArgs) Handles cmdAddNew.Click
        Dim qryString As String = "INSERT INTO tbl_receiptBooks (dtDate, receiptNumber, purpose, receivedBy, issuedTo, acknowledgement, capturedBy )" & _
               " VALUES('" & rdDtDate.SelectedDate.Value.ToString & "','" & txtReceiptNum.Text & "','" & txtPurpose.Text & "','" & txtReceivedBy.Text & "','" & txtIssuedTo.Text & "','" & "Test Acknowledgement" & "','" & CokkiesWrapper.UserName & "')"


        Dim insRec As New commonFunction(CokkiesWrapper.thisConnectionName)

        insRec.ConnectionString = con

        If insRec.ExecuteNonQRY(qryString) = 1 Then
            lblMsg.Text = "Receipt book entry has been saved successfully."

            loadDataGrid()

            txtReceiptNum.Text = ""
            txtPurpose.Text = ""
            txtReceivedBy.Text = ""
            txtIssuedTo.Text = ""
        Else
            lblMsg.Text = "Receipt book entry has not been saved successfully."
        End If

    End Sub

    Private Sub loadDataGrid()
        Dim sql As String = " SELECT TOP 20 [entryNumber] AS [Entry #], [dtDate] AS [Date], [receiptNumber] AS [Receipt Number(s)], [purpose] AS [Purpose], [receivedBy] AS [Received By], [issuedTo] AS [Issued To], " & _
                            " [capturedBy] AS [Captured Into System By] FROM [dbo].[tbl_receiptBooks] ORDER BY [entryNumber] DESC"

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            db.ExecuteDataSet(CommandType.Text, sql)

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