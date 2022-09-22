
Imports Telerik.Web.UI
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing
Imports System.Data.SqlClient

Public Class SearchStore
    Inherits System.Web.UI.Page

    Dim objCBO As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = objCBO.Database
    Dim con As String = db.ConnectionString

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


        If (CokkiesWrapper.UserID <= 0 AndAlso Not IsNumeric(CokkiesWrapper.UserID)) Then
            Response.Redirect("../Login.aspx")
            Exit Sub
        End If

        If Not IsPostBack Then
            objCBO.loadComboBox(cboSupplier, "SELECT [supplierName], [supplierId] FROM [dbo].[tbl_tyreSuppliers]", "supplierName", "supplierId")
            objCBO.loadComboBox(cboManufacturer, "SELECT [manufacturer],[manufacturerId] FROM [dbo].[tbl_tyreManufacturers]", "manufacturer", "manufacturerId")
            objCBO.loadComboBox(cboTyreSize, "SELECT [tyreSize] , [tyreSizeId]   FROM [dbo].[tbl_tyreSizes]", "tyreSize", "tyreSizeId")

            'cboSupplier.Items.Insert(0, New RadComboBoxItem("--Select--", ""))
            'cboManufacturer.Items.Insert(0, New RadComboBoxItem("--Select--", ""))
            'cboTyreSize.Items.Insert(0, New RadComboBoxItem("--Select--", ""))

            If grantPageWriteCommandPermission(CokkiesWrapper.UserID, 1) = True Then
                btnSearch.Enabled = True
            Else
                btnSearch.Enabled = False
            End If

        End If

    End Sub






    Protected Sub btnSearch_Click(sender As Object, e As EventArgs) Handles btnSearch.Click

        loadDataGrid()

    End Sub

    Private Sub loadDataGrid()

        Dim manufacturer As String = cboManufacturer.Text
        If manufacturer = "--Select--" Then

        End If


        Dim sql As String = " SELECT dbo.tbl_tyres.batchNumber AS [Purchase Order #], dbo.tbl_tyres.serialNumber AS [Serial Number],  " &
                                " dbo.tbl_tyres.detReceived AS [Date Received],  " &
                                " dbo.tbl_tyres.detManufactured AS [Date Manufactured], dbo.tbl_tyreManufacturers.manufacturer AS Manufacturer,   " &
                                " dbo.tbl_tyreSuppliers.supplierName AS Supplier, dbo.tbl_tyres.unitCost AS [Unit Cost]," &
                                " dbo.tbl_tyreSizes.tyreSize AS [Tyre Size], dbo.tbl_tyreFittingStatus.fittingStatus AS [Fitting Status],  " &
                                " dbo.tbl_tyres.expectedTyreMileage AS [Expected Mileage]" &
 "        FROM            dbo.tbl_tyres INNER JOIN " &
 "                         dbo.tbl_tyreSuppliers ON dbo.tbl_tyres.supplierId = dbo.tbl_tyreSuppliers.supplierId INNER JOIN " &
 "                        dbo.tbl_tyreManufacturers ON dbo.tbl_tyres.manufacturerId = dbo.tbl_tyreManufacturers.manufacturerId INNER JOIN  " &
 "                        dbo.tbl_tyreSizes ON dbo.tbl_tyres.tyreSizeId = dbo.tbl_tyreSizes.tyreSizeId INNER JOIN  " &
 "                        dbo.tbl_tyreFittingStatus ON dbo.tbl_tyres.fittingStatusId = dbo.tbl_tyreFittingStatus.fittingStatusId  " &
 "WHERE dbo.tbl_tyres.[fittingStatusId] = 1    AND   (dbo.tbl_tyreManufacturers.manufacturer LIKE '%" & objCBO.fnComboBoxValidText(cboManufacturer.Text) &
 "%'   AND dbo.tbl_tyreSuppliers.supplierName LIKE '%" & objCBO.fnComboBoxValidText(cboSupplier.Text) &
 "%' AND dbo.tbl_tyres.batchNumber LIKE '%" & txtPurchaseOrderNumber.Text & "%' " &
 " AND dbo.tbl_tyres.serialNumber LIKE '%" & txtSerialNumber.Text & "%' AND tbl_tyreSizes.tyreSize LIKE '%" & objCBO.fnComboBoxValidText(cboTyreSize.Text) & "%' " &
  "   )     ORDER BY dbo.tbl_tyres.batchNumber, dbo.tbl_tyres.serialNumber "

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            db.ExecuteDataSet(CommandType.Text, sql)

            With gwStores
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

    Protected Sub gwStores_NeedDataSource(sender As Object, e As GridNeedDataSourceEventArgs) Handles gwStores.NeedDataSource
        loadDataGrid()
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