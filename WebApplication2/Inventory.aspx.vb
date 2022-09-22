Imports Telerik.Web.UI
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing

Public Class Inventory
    Inherits System.Web.UI.Page
    Private Shared ReadOnly log As log4net.ILog = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType)
    Dim objCashBookEntry As New CashBookEntries(CokkiesWrapper.thisConnectionName)
    Dim objCBO As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = objCashBookEntry.Database
    Dim con As String = db.ConnectionString
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If (CokkiesWrapper.UserID <= 0 AndAlso Not IsNumeric(CokkiesWrapper.UserID)) Then
            Response.Redirect("../Login.aspx")
            Exit Sub
        End If

        If Not IsPostBack Then

            obj.ConnectionString = con
            Dim accessMode As String = obj.groupAccessPermissionsDs(CokkiesWrapper.UserGroup, 8)

            Select Case accessMode
                Case "AllowReadNRead"
                Case "ReadNReadOnly"
                    cmdAddNew.Enabled = False
                Case "DenyAcces"
                    Response.Redirect("~/AccessDenied.aspx")
                Case Else
                    Response.Redirect("~/AccessDenied.aspx")
            End Select

            objCBO.loadComboBox(cboItemType, "SELECT [itemTypeId], [itemType] FROM [tbl_revenueItemTypes]", "itemType", "itemTypeId")
            loadDataGrid()
        End If

    End Sub

    Private Sub loadDataGrid()
        Dim sql As String = " SELECT TOP 20 [entryNumber] AS [Entry #], [dtDate] AS [Date],[itemType] AS [Item Type],  [opening] AS [Opening], [incoming] AS [Incoming], [outgoing] AS [Out Going], [closing] AS Closing, " & _
                            " [balance] AS [Balance], [narration] AS [Narration], [capturedBy] AS [Captured By] FROM [tbl_inventory] WHERE [itemType] = '" & cboItemType.Text & "' ORDER BY [entryNumber] DESC"


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



    Protected Sub cmdAddNew_Click(sender As Object, e As EventArgs) Handles cmdAddNew.Click

        lblOpeningBal.Text = ""
        lblCurrentBalance.Text = ""

        fnGetInventoryBookBalance()
        fnGetInventoryOpeningBalance()


        If (cboAction.Text = "Closing Balance" Or cboAction.Text = "Opening Balance") And (Val(txtAmount.Text) <> Val(lblCurrentBalance.Text)) Then
            insertInventoryVariance()
        End If

        Dim qry As String = ""
        Select Case cboAction.Text
            Case "Incoming"
                qry = "INSERT INTO tbl_inventory (itemType, dtDate, incoming, balance, narration, capturedBy) VALUES " & _
                        "('" & cboItemType.Text & "','" & rdDtDate.SelectedDate & "'," & Val(txtAmount.Text) & "," & _
                         Val(txtAmount.Text) + Val(lblCurrentBalance.Text) & ",'" & txtNotes.Text & "','" & CokkiesWrapper.UserName & "')"
            Case "Outgoing"
                qry = "INSERT INTO tbl_inventory (itemType, dtDate, outgoing, balance, narration, capturedBy) VALUES " & _
                        "('" & cboItemType.Text & "','" & rdDtDate.SelectedDate & "'," & Val(txtAmount.Text) & "," & _
                         Val(lblCurrentBalance.Text) - Val(txtAmount.Text) & ",'" & txtNotes.Text & "','" & CokkiesWrapper.UserName & "')"
            Case "Closing Balance"
                qry = "INSERT INTO tbl_inventory (itemType, dtDate, closing, balance, narration, capturedBy) VALUES " & _
                        "('" & cboItemType.Text & "','" & rdDtDate.SelectedDate & "'," & Val(txtAmount.Text) & "," & _
                         Val(txtAmount.Text) & ",'" & txtNotes.Text & "','" & CokkiesWrapper.UserName & "')"
            Case "Opening Balance"
                qry = "INSERT INTO tbl_inventory (itemType, dtDate, opening, balance, narration, capturedBy) VALUES " & _
                        "('" & cboItemType.Text & "','" & rdDtDate.SelectedDate & "'," & Val(txtAmount.Text) & "," & _
                         Val(txtAmount.Text) & ",'" & txtNotes.Text & "','" & CokkiesWrapper.UserName & "')"
            Case ""
                lblMsg.Text = "Unknown Action. Nothing Done"
                Exit Sub
        End Select

        If qry = "" Then
            lblMsg.Text = "Unknown Action. Nothing Done"
            Exit Sub
        End If

        Dim insRec As New commonFunction(CokkiesWrapper.thisConnectionName)
        insRec.ConnectionString = con

        If Not insRec.ExecuteNonQRY(qry) = 1 Then
            lblMsg.Text = "Inventory entry has been saved successfully."
            loadDataGrid()
        Else
            lblMsg.Text = "Inventory entry has not been saved successfully."
        End If


        fnGetInventoryBookBalance()
        fnGetInventoryOpeningBalance()

        loadDataGrid()
    End Sub

    Private Sub fnGetInventoryBookBalance()

        Dim insRec As New commonFunction(CokkiesWrapper.thisConnectionName)
        Dim qry As String = "SELECT TOP 1 balance FROM tbl_inventory WHERE itemType = '" & cboItemType.Text & "' ORDER BY entryNumber DESC"

        insRec.ConnectionString = con

        Dim ds As DataSet = insRec.ExecuteDsQRY(qry)
        If ds.Tables.Count > 0 Then
            If ds.Tables(0).Rows.Count > 0 Then
                lblCurrentBalance.Text = Val(ds.Tables(0).Rows(0)("balance"))
            End If
        End If
    End Sub


    Private Sub fnGetInventoryOpeningBalance()

        Dim insRec As New commonFunction(CokkiesWrapper.thisConnectionName)
        Dim qry As String = "SELECT TOP 1 opening FROM tbl_inventory WHERE opening IS NOT NULL AND itemType = '" & cboItemType.Text & "' ORDER BY entryNumber DESC"



        insRec.ConnectionString = con

        Dim ds As DataSet = insRec.ExecuteDsQRY(qry)
        If ds.Tables.Count > 0 Then
            If ds.Tables(0).Rows.Count > 0 Then
                lblOpeningBal.Text = Val(ds.Tables(0).Rows(0)("opening"))
            End If
        End If

    End Sub


    Private Sub insertInventoryVariance()
        Dim mode As String = ""
        Dim variance As Long

        Select Case cboAction.Text
            Case "Closing Balance"
                mode = "Closing Balance"
            Case "Opening Balance"
                mode = "Opening Balance"
        End Select
        'itemType
        variance = Val(txtAmount.Text) - Val(lblCurrentBalance.Text)

        Dim queryString As String = "INSERT INTO tbl_inventoryVariances(itemType,dtDate, mode, expected, captured, variance, narration)" & _
                               " VALUES ('" & cboItemType.Text & "',#" & rdDtDate.SelectedDate & "#,'" & mode & "'," & Val(lblCurrentBalance.Text) & _
                               "," & Val(txtAmount.Text) & "," & variance & ",'" & txtNotes.Text & "')"

        Dim insRec As New commonFunction(CokkiesWrapper.thisConnectionName)
        insRec.ConnectionString = con

        'If insRec.ExecuteNonQRY(queryString) = 1 Then
        '    lblMsg.Text = "Receipt book entry has been saved successfully."
        '    loadDataGrid()
        'Else
        '    lblMsg.Text = "Receipt book entry has not been saved successfully."
        'End If

    End Sub

    Protected Sub cboItemType_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboItemType.SelectedIndexChanged
        fnGetInventoryBookBalance()
    End Sub

    Protected Sub cmdAddNew0_Click(sender As Object, e As EventArgs) Handles cmdAddNew0.Click

        lblOpeningBal.Text = ""
        lblCurrentBalance.Text = ""

        fnGetInventoryBookBalance()
        fnGetInventoryOpeningBalance()
    End Sub

    Private Sub cboItemType_TextChanged(sender As Object, e As EventArgs) Handles cboItemType.TextChanged
        fnGetInventoryBookBalance()
    End Sub
End Class