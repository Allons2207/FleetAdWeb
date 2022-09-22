

Imports Telerik.Web.UI
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing
Imports System.Data.SqlClient

Public Class ReceiveTyresIntoStore
    Inherits System.Web.UI.Page

    Dim objCBO As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = objCBO.Database
    Dim con As String = db.ConnectionString

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then
            objCBO.loadComboBox(cboSupplier, "SELECT [supplierName], [supplierId] FROM [dbo].[tbl_tyreSuppliers]", "supplierName", "supplierId")
            objCBO.loadComboBox(cboManufacturer, "SELECT [manufacturer],[manufacturerId] FROM [dbo].[tbl_tyreManufacturers]", "manufacturer", "manufacturerId")
            objCBO.loadComboBox(cboTyreSize, "SELECT [tyreSize] , [tyreSizeId]   FROM [dbo].[tbl_tyreSizes]", "tyreSize", "tyreSizeId")

            cboSupplier.Items.Insert(0, New RadComboBoxItem("", ""))
            cboSupplier.SelectedIndex = 0

            cboManufacturer.Items.Insert(0, New RadComboBoxItem("", ""))
            cboManufacturer.SelectedIndex = 0

            cboTyreSize.Items.Insert(0, New RadComboBoxItem("", ""))
            cboTyreSize.SelectedIndex = 0

            If grantPageWriteCommandPermission(CokkiesWrapper.UserID, 1) = True Then
                cmdAddNew.Enabled = True
            Else
                cmdAddNew.Enabled = False
            End If
        End If

    End Sub

    Protected Sub cmdAddNew_Click(sender As Object, e As EventArgs) Handles cmdAddNew.Click
        Dim qry As String = ""
        Dim serialNumber As String = ""
        Dim insRec As New commonFunction(CokkiesWrapper.thisConnectionName)
        insRec.ConnectionString = con


        Dim qrySTR As String = "SELECT lastGeneratedNumber, preFixLetters,suffixLetters FROM tbl_tyreSerialNumGenerator"
       
        Dim ds As DataSet = insRec.ExecuteDsQRY(qrySTR)

        Dim prefix As String = ""
        Dim suffix As String = ""
        Dim lastSavedSNum As Integer = 0

        If ds.Tables.Count > 0 Then
            If ds.Tables(0).Rows.Count > 0 Then
                lastSavedSNum = ds.Tables(0).Rows(0).Item("lastGeneratedNumber")
                prefix = Trim(ds.Tables(0).Rows(0).Item("preFixLetters"))
                suffix = Trim(ds.Tables(0).Rows(0).Item("suffixLetters"))


                For ctr = 1 To Val(txtNumberOfTyresInBatch.Text)
                    lastSavedSNum = lastSavedSNum + 1

                    Select Case Len(CStr(lastSavedSNum))
                        Case 1
                            serialNumber = prefix & "000000" & CStr(lastSavedSNum) & suffix
                        Case 2
                            serialNumber = prefix & "00000" & CStr(lastSavedSNum) & suffix
                        Case 3
                            serialNumber = prefix & "0000" & CStr(lastSavedSNum) & suffix
                        Case 4
                            serialNumber = prefix & "000" & CStr(lastSavedSNum) & suffix
                        Case 5
                            serialNumber = prefix & "00" & CStr(lastSavedSNum) & suffix
                        Case 6
                            serialNumber = prefix & "0" & CStr(lastSavedSNum) & suffix
                        Case 7
                            serialNumber = prefix & CStr(lastSavedSNum) & suffix
                            'Case 8
                            '    serialNumber = prefix & CStr(lastSavedSNum) & suffix
                    End Select
                    '   Convert(VARCHAR(10), detReceived, 10) As detReceived

                    qry = "INSERT INTO [dbo].[tbl_tyres]" & _
                            " ([serialNumber], [batchNumber], [detReceived], [supplierId], [manufacturerId], [tyreSizeId], [unitCost],[description] , [expectedTyreMileage], " & _
                            " [currentTyreMilage], [fittingStatusId], [detManufactured]) VALUES " & _
                            " ('" & serialNumber & "','" & txtPONumber.Text & "','" & rdDtDate.SelectedDate.ToString & "', " & cboSupplier.SelectedValue & ", " & cboManufacturer.SelectedValue & _
                            ", " & cboTyreSize.SelectedValue & ", " & txtUnitCost.Text & ",'" & txtNotes.Text & "', " & txtStandardMileage.Text & ", " & _
                            txtCurrentMileage.Text & ", 1,'" & rdDtDateManufactured.SelectedDate.ToString & "')"

                    If insRec.ExecuteNonQRY(qry) = 1 Then
                    End If

                Next
            End If
        End If

        qry = "UPDATE tbl_tyreSerialNumGenerator SET lastGeneratedNumber =" & lastSavedSNum

        If insRec.ExecuteNonQRY(qry) = 1 Then
        End If


        loadDataGrid()

    End Sub


    Private Sub loadDataGrid()
        '  Dim sql As String = " SELECT * FROM tbl_tyres WHERE batchNumber = '" & txtPONumber.Text & "'"
        'Convert(VARCHAR(10), dbo.tbl_tyres.detManufactured, 10) As [Date Manufactured]
        Dim sql As String = "SELECT dbo.tbl_tyres.batchNumber AS [Purchase Order #], dbo.tbl_tyres.serialNumber AS [Serial Number], Convert(VARCHAR(10), dbo.tbl_tyres.detReceived, 10) As [Date Received], " &
                     "    Convert(VARCHAR(10), dbo.tbl_tyres.detManufactured, 10) As [Date Manufactured], dbo.tbl_tyreManufacturers.manufacturer AS Manufacturer, dbo.tbl_tyreSuppliers.supplierName AS Supplier, dbo.tbl_tyres.unitCost AS [Unit Cost], " &
                      "   dbo.tbl_tyreSizes.tyreSize AS [Tyre Size], dbo.tbl_tyreFittingStatus.fittingStatus AS [Fitting Status], dbo.tbl_tyres.expectedTyreMileage AS [Expected Mileage]" &
                    "  FROM            dbo.tbl_tyres INNER JOIN " &
                     "    dbo.tbl_tyreSuppliers ON dbo.tbl_tyres.supplierId = dbo.tbl_tyreSuppliers.supplierId INNER JOIN " &
                     "    dbo.tbl_tyreManufacturers ON dbo.tbl_tyres.manufacturerId = dbo.tbl_tyreManufacturers.manufacturerId INNER JOIN " &
                     "    dbo.tbl_tyreSizes ON dbo.tbl_tyres.tyreSizeId = dbo.tbl_tyreSizes.tyreSizeId INNER JOIN " &
                     "    dbo.tbl_tyreFittingStatus ON dbo.tbl_tyres.fittingStatusId = dbo.tbl_tyreFittingStatus.fittingStatusId " &
                    " WHERE        (dbo.tbl_tyres.batchNumber)  ='" & txtPONumber.Text & "'" &
                    " ORDER BY [Purchase Order #], [Serial Number]"
        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            db.ExecuteDataSet(CommandType.Text, sql)

            With gwBillPayments
                Try
                    .DataSource = ds
                    .DataBind()
                Catch ex As Exception
                    '  log.Error(ex.Message)
                End Try
            End With
        Catch ex As Exception
            'log.Error(ex)
        End Try

    End Sub

    Protected Sub cmdClear_Click(sender As Object, e As EventArgs) Handles cmdClear.Click
        txtPONumber.Text = ""
        ' rdDtDate.SelectedDate.ToString & "', " & 
        cboSupplier.SelectedIndex = 0
        cboManufacturer.SelectedIndex = 0
        cboTyreSize.SelectedIndex = 0
        txtUnitCost.Text = ""
        txtNotes.Text = ""
        txtStandardMileage.Text = ""
        txtCurrentMileage.Text = ""
        txtNumberOfTyresInBatch.Text = ""
    End Sub

    Public Function grantPageWriteCommandPermission(ByVal UserId As Integer, pageId As Integer) As Boolean
        grantPageWriteCommandPermission = False
        Dim qry As String = "SELECT * FROM [dbo].[tbl_userSysPermissions] WHERE [userId] = " & UserId & " AND [sysModuleSectionId] = " & pageId & " AND [sysWrite] = 1"

        Try
            objCBO.ConnectionString = con
            Dim ds As DataSet = objCBO.ExecuteDsQRY(qry)
            If ds.Tables(0).Rows.Count > 0 Then
                grantPageWriteCommandPermission = True
            End If
        Catch ex As Exception
        End Try
    End Function


End Class