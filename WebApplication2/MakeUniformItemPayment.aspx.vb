Imports ClassLibrary1
Imports Telerik.Web.UI
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing
Imports CrystalDecisions.CrystalReports
Imports CrystalDecisions.Shared

Public Class MakeUniformItemPayment
    Inherits System.Web.UI.Page
    Dim objSales As New UniformSales(CokkiesWrapper.thisConnectionName)
    Dim objAllPayments As New AllPayments(CokkiesWrapper.thisConnectionName)
    Dim db As Database = objSales.Database
    Dim con As String = db.ConnectionString
    Dim objStudents As New Student(CokkiesWrapper.thisConnectionName)
    Dim objItems As New UniformItems(CokkiesWrapper.thisConnectionName)
    Dim dsItems As DataSet = objItems.SelectRecords()
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim ds As New DataSet
    Dim dt As New DataTable
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If (CokkiesWrapper.UserID <= 0 AndAlso Not IsNumeric(CokkiesWrapper.UserID)) Then
            Response.Redirect("../Login.aspx")
            Exit Sub
        End If

        obj.ConnectionString = con
        Dim accessMode As String = obj.groupAccessPermissionsDs(CokkiesWrapper.UserGroup, 6)

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

    Private Sub RadComboBoxUniformItems_Load(sender As Object, e As EventArgs) Handles RadComboBoxUniformItems.Load
        If Not IsPostBack Then



            With RadComboBoxUniformItems

                .DataSource = dsItems
                .DataTextField = "uniformItem"
                .DataValueField = "uniformItem"
                .DataBind()

                .Items.Insert(0, New RadComboBoxItem("", ""))

            End With

        End If
    End Sub


    Private Sub RadComboBoxUniformItems_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles RadComboBoxUniformItems.SelectedIndexChanged


        Dim dss As DataSet = objItems.GetPrice(RadComboBoxUniformItems.SelectedValue)


        txtItemPrice.Text = dss.Tables(0).Rows(0)("price")



    End Sub

    Protected Sub txtQuantity_TextChanged(sender As Object, e As EventArgs) Handles txtQuantity.TextChanged
        txtTotalPrice.Text = txtItemPrice.Text * txtQuantity.Text
    End Sub


    Protected Sub txtStudentNo_TextChanged(sender As Object, e As EventArgs) Handles txtStudentNo.TextChanged

    End Sub

    Private Sub UniformPaymentsDataBind()

        Dim qryStr As String = "SELECT [uniformItem], [unitPrice], [quantity], [totalPrice] FROM [dbo].[tbl_uniformSales_TMP] WHERE [receiptNumber] = '" & txtReceiptNo.Text & "' "

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, qryStr)
            If ds.Tables().Count > 0 Then
                If ds.Tables(0).Rows.Count > 0 Then
                    gwUniformPayments.DataSource = ds
                    gwUniformPayments.DataBind()
                    showTotal()
                End If
            End If
        Catch ex As Exception

        End Try
    End Sub

    Private Sub showTotal()
        txtTotal.Text = ""
        Dim qryStr As String = "SELECT SUM([totalPrice]) AS totSale  FROM [tbl_uniformSales_TMP] GROUP BY [receiptNumber] HAVING [receiptNumber] = '" & txtReceiptNo.Text & "' "

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, qryStr)
            If ds.Tables().Count > 0 Then
                If ds.Tables(0).Rows.Count > 0 Then
                    txtTotal.Text = ds.Tables(0).Rows(0)("totSale").ToString
                End If
            End If
        Catch ex As Exception

        End Try
    End Sub
    '  txtTotal



    Private Sub prepareDataSet()


    End Sub



    Protected Sub cmdSave_Click(sender As Object, e As EventArgs) Handles cmdSave.Click

        Try

            For Each item As GridDataItem In gwUniformPayments.Items
                With objSales
                    .ConnectionString = con
                    .quantity = Val(item("quantity").Text)
                    .studentId = txtStudentNo.Text
                    .unitPrice = item("unitPrice").Text
                    .uniformItem = Val(item("uniformItem").Text)
                    .totalPrice = Val(item("totalPrice").Text)
                    .dtDate = Today
                    .receiptNumber = txtReceiptNo.Text

                    .Insert()

                End With

                With objAllPayments
                    .ConnectionString = con
                    .amountPaid = Val(item("totalPrice").Text)
                    .cashier = CokkiesWrapper.UserName
                    .studentId = txtStudentNo.Text
                    .details = "Uniform payment for " + " " + txtStudentNo.Text
                    .payment = "Uniform"
                    .dtDate = Today
                    .receiptNumber = txtReceiptNo.Text

                    .Insert()

                End With
            Next


            'If Not ((txtQuantity.Text = "") And (txtItemPrice.Text = "") And (txtTotalPrice.Text = "")) Then

            '    Try

            '        With objSales

            '            .ConnectionString = con
            '            .quantity = txtQuantity.Text
            '            .studentId = txtStudentNo.Text
            '            .unitPrice = txtItemPrice.Text
            '            .uniformItem = RadComboBoxUniformItems.Text
            '            .totalPrice = txtTotalPrice.Text
            '            .dtDate = Today
            '            .receiptNumber = txtReceiptNo.Text

            '            .Insert()

            '        End With


            '        With objAllPayments

            '            .amountPaid = txtTotalPrice.Text
            '            .ConnectionString = con
            '            .cashier = CokkiesWrapper.UserName
            '            .studentId = txtStudentNo.Text
            '            .details = "Uniform payment for " + " " + txtStudentNo.Text
            '            .payment = "Uniform"
            '            .dtDate = Today
            '            .receiptNumber = txtReceiptNo.Text
            '            .ConnectionString = con

            '            .Insert()

            '        End With

            lblMsg.BackColor = Color.Green
            lblMsg.ForeColor = Color.White
            lblMsg.Text = "Payment was saved successfully!!!"

            txtReceiptNo.Text = ""

        Catch ex As Exception

            lblMsg.BackColor = Color.Red
            lblMsg.ForeColor = Color.White
            lblMsg.Text = "Payment was not saved successfully!!!"

        End Try




    End Sub

    Protected Sub cmdAdd_Click(sender As Object, e As EventArgs) Handles cmdAdd.Click


        If txtReceiptNo.Text = "" Then
            generateNewReceiptNumber()
        End If

        If txtReceiptNo.Text = "" Then
            lblMsg.Text = "Error..! System failed to generate receipt number."
            Exit Sub
        End If


        Dim strQry As String = "INSERT INTO [tbl_uniformSales_TMP] ([receiptNumber], [studentId],[uniformItem],[unitPrice], [quantity],[totalPrice] ) " & _
                                " VALUES ('" & txtReceiptNo.Text & "','" & txtStudentNo.Text & "','" & RadComboBoxUniformItems.Text & "'," & txtItemPrice.Text & "," & txtQuantity.Text & "," & txtTotalPrice.Text & ") "

        Try
            obj.ConnectionString = con
            '.ConnectionString = con
            If obj.ExecuteNonQRY(strQry) = 1 Then
                lblMsg.Text = "Item payment captured successfully."
                UniformPaymentsDataBind()
            Else
                lblMsg.Text = "Errors occurred while trying to capture item payment entry."
            End If

        Catch ex As Exception

        End Try
    End Sub


    Private Sub generateNewReceiptNumber()
        obj.ConnectionString = con
        txtReceiptNo.Text = obj.fnReceiptNumber
    End Sub
    Protected Sub cmdFind_Click(sender As Object, e As EventArgs) Handles cmdFind.Click

        Dim sDS As DataSet = objStudents.selectRecords(txtStudentNo.Text)

        Try
            lblMsg.Text = ""

            txtFirstName.Text = sDS.Tables(0).Rows(0)("firstName")
            txtSurname.Text = sDS.Tables(0).Rows(0)("surname")
            txtStream.Text = sDS.Tables(0).Rows(0)("stream")
            txtClass.Text = sDS.Tables(0).Rows(0)("schoolClass")

            prepareDataSet()

        Catch ex As Exception
            lblMsg.Text = "Member not found"
            lblMsg.BackColor = Color.Red
        End Try


    End Sub
End Class