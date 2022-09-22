Imports Telerik.Web.UI
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing

Public Class RevenueBook
    Inherits System.Web.UI.Page
    Private Shared ReadOnly log As log4net.ILog = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType)
    Dim insRec As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim objCBO As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)

    Dim db As Database = insRec.Database
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
                cmdAddNew.Enabled = False
            Case "DenyAcces"
                Response.Redirect("~/AccessDenied.aspx")
                Exit Sub
            Case Else
                Response.Redirect("~/AccessDenied.aspx")
                Exit Sub
        End Select

        objCBO.loadComboBox(cboItemType, "SELECT [itemTypeId], [itemType] FROM [tbl_revenueItemTypes]", "itemType", "itemTypeId")
        loadDataGrid()
    End Sub

    Protected Sub cmdAddNew_Click(sender As Object, e As EventArgs) Handles cmdAddNew.Click

        Dim insRec As New commonFunction(CokkiesWrapper.thisConnectionName)

        insRec.ConnectionString = con

        Dim qryString As String = "INSERT INTO [dbo].[tbl_revenueBook] " & _
                " ([itemType]" & _
                " ,[dtDate]" & _
                " ,[expected]" & _
                " ,[cashAtHand]" & _
                " ,[cashLeft]" & _
                " ,[variance]" & _
                " ,[acknowledgement]" & _
                " ,[notes]" & _
                " ,[capturedBy]" & _
                " ,[receiptedBy]" & _
                " ,[center])" & _
                " VALUES('" & cboItemType.Text & _
                "','" & rdDtDate.SelectedDate.Value.ToString & _
                "'," & txtExpected.Text & _
                "," & txtCashAtHand.Text & _
                "," & txtCashLeft.Text & _
                "," & txtVariance.Text & _
                ",'','" & txtNotes.Text & _
                "','" & CokkiesWrapper.UserName & "','" & txtReceiptedBy.Text & _
                "','" & txtCenter.Text & "')"

        If insRec.ExecuteNonQRY(qryString) = 1 Then
            lblMsg.Text = "Revenue book entry has been saved successfully."
            loadDataGrid()
        Else
            lblMsg.Text = "Revenue book entry has not been saved successfully."
        End If

    End Sub


    Private Sub loadDataGrid()

        Dim sql As String = "SELECT [entryNumber] AS [Entry #], [itemType] AS [Item Type], [dtDate] AS [Date], [expected] AS [Expected],[cashAtHand] AS [Cash at Hand], " & _
                            " [cashLeft] AS [Cash Left], [variance] AS [Variance], [receiptedBy] AS[ Receipted By] , [capturedBy] AS [Captured By], [notes] AS Notes " & _
                            " FROM [dbo].[tbl_revenueBook] "

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