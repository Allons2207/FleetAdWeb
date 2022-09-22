Imports Telerik.Web.UI
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing

Public Class Bills
    Inherits System.Web.UI.Page

    Private Shared ReadOnly log As log4net.ILog = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType)
    Dim insRec As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = insRec.Database
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

        loadDataGrid()

    End Sub

    Protected Sub cmdAddNew_Click(sender As Object, e As EventArgs) Handles cmdAddNew.Click

        Dim qryString As String = "INSERT INTO [dbo].[tbl_billPayments] " & _
           " ([dtDate],[amountOwing],[amountPaid],[narration],[balance],[capturedBy]) " & _
           " VALUES('" & _
             rdDtDate.SelectedDate.Value.ToString & _
            "'," & Val(txtAmtOwing.Text) & _
            "," & Val(txtAmtPaid.Text) & _
            ",'" & txtNotes.Text & _
            "'," & Val(txtAmtOwing.Text) - Val(txtAmtPaid.Text) & _
            ",'" & CokkiesWrapper.UserName & "')"

        Dim insRec As New commonFunction(CokkiesWrapper.thisConnectionName)

        insRec.ConnectionString = con

        If insRec.ExecuteNonQRY(qryString) = 1 Then
            lblMsg.Text = "Receipt book entry has been saved successfully."
            loadDataGrid()
        Else
            lblMsg.Text = "Receipt book entry has not been saved successfully."
        End If
    End Sub

    Private Sub loadDataGrid()
        Dim sql As String = "SELECT TOP 20 [entryNumber] AS [Entry #], [dtDate] AS [Date], [amountOwing] AS [Amount Owing], [amountPaid] AS [Amount Paid], [balance] AS [Balance],[capturedBy] AS [Captured By] , [narration] AS [Narration] FROM [dbo].[tbl_billPayments] ORDER BY [entryNumber] DESC"
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