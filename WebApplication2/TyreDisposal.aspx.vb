Imports Telerik.Web.UI
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data

Public Class TyreDisposal
    Inherits System.Web.UI.Page
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            obj.loadComboBox(cboReasonForDisposal, "SELECT [reasonForReplacementId], [reasonForReplacement] FROM [dbo].[tbl_tyreReasonForReplacement]", "reasonForReplacement", "reasonForReplacementId")
            rdDisposalDate.SelectedDate = Now
            loadTyreDetails()
        End If
    End Sub

    Private Sub loadTyreDetails()

        ' If Not IsNothing(Request.QueryString("op")) Then
        Dim qry As String = "SELECT  dbo.tbl_tyres.serialNumber, dbo.tbl_tyres.batchNumber, dbo.tbl_tyreSuppliers.supplierName, " &
            " dbo.tbl_tyres.detReceived, dbo.tbl_tyreManufacturers.manufacturer, dbo.tbl_tyres.detManufactured, dbo.tbl_tyreSizes.tyreSize, " &
            " dbo.tbl_tyres.unitCost FROM  dbo.tbl_tyres INNER JOIN " &
            " dbo.tbl_tyreSuppliers ON dbo.tbl_tyres.supplierId = dbo.tbl_tyreSuppliers.supplierId INNER JOIN " &
            " dbo.tbl_tyreManufacturers ON dbo.tbl_tyres.manufacturerId = dbo.tbl_tyreManufacturers.manufacturerId INNER JOIN " &
            " dbo.tbl_tyreSizes ON dbo.tbl_tyres.tyreSizeId = dbo.tbl_tyreSizes.tyreSizeId WHERE  (dbo.tbl_tyres.serialNumber = '" & Request.QueryString("op") & "') "

        obj.ConnectionString = con

        Dim ds As DataSet = obj.ExecuteDsQRY(qry)

        If ds.Tables(0).Rows.Count > 0 Then
            lblSerialNumber.Text = ds.Tables(0).Rows(0).Item("serialNumber")
            lblPONumber.Text = ds.Tables(0).Rows(0).Item("batchNumber")
            lblSupplier.Text = ds.Tables(0).Rows(0).Item("supplierName")
            lblDateReceived.Text = ds.Tables(0).Rows(0).Item("detReceived")
            lblManufacturer.Text = ds.Tables(0).Rows(0).Item("manufacturer")
            lblDateManufactured.Text = ds.Tables(0).Rows(0).Item("detManufactured")
            lblTyreSize.Text = ds.Tables(0).Rows(0).Item("tyreSize")
            lblUnitCost.Text = ds.Tables(0).Rows(0).Item("unitCost")
        End If

    End Sub

    Protected Sub cmdSave_Click(sender As Object, e As EventArgs) Handles cmdSave.Click

        obj.MessageLabel(lblMsg, "", "")

        If cboReasonForDisposal.Text = "" Or cboReasonForDisposal.Text = "--Select--" Then
            obj.MessageLabel(lblMsg, "Please specify the Reason for Disposal. It cannot be empty.", "Red")
            Exit Sub
        ElseIf lblSerialNumber.Text = "" Then
            obj.MessageLabel(lblMsg, "Invalid Serial Number.", "Red")
            Exit Sub
        End If

        Dim qry As String = "UPDATE tbl_tyres SET [fittingStatusId] = 4,     [detDisposed] = '" & rdDisposalDate.SelectedDate & "', [reasonForRemovalId] = " & cboReasonForDisposal.SelectedValue &
            "  WHERE serialNumber = '" & lblSerialNumber.Text & "'"

        obj.ConnectionString = con

        If obj.ExecuteNonQRY(qry) = 1 Then
            obj.MessageLabel(lblMsg, "Specified tyre successfully disposed.", "Green")
            cmdSave.Enabled = False
        Else
            obj.MessageLabel(lblMsg, "Error while trying to dispose specified tyre.", "Red")
        End If

    End Sub

End Class