
Imports Telerik.Web.UI
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing
Imports System.Data.SqlClient

Public Class TyreLivesForFittedTyres
    Inherits System.Web.UI.Page

    Dim objCBO As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = objCBO.Database
    Dim con As String = db.ConnectionString

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
       
        If (CokkiesWrapper.UserID <= 0 AndAlso Not IsNumeric(CokkiesWrapper.UserID)) Then
            Response.Redirect("../Login.aspx")
            Exit Sub
        End If

        lblMsg.Text = ""

        'Convert(VARCHAR(10), dbo.tbl_tyres.detManufactured, 10) As DateManufactured

        loadGrid()

    End Sub


    Private Sub loadGrid()
        Try
            'Dim sql As String = "SELECT  TOP (100) PERCENT Convert(VARCHAR(10), dbo.tbl_tyres.detFittedOnVehicle, 10) As DateFitted, dbo.tbl_tyres.serialNumber AS SerialNumber," &
            '                    " dbo.tbl_tyreSizes.tyreSize AS TyreSize, dbo.tbl_tyreManufacturers.manufacturer AS Manufacturer, " &
            '                    " dbo.tbl_tyreSuppliers.supplierName AS Supplier, dbo.tbl_tyres.fleetId AS FleetID, dbo.tbl_vehicleData.registrationNumber" &
            '                    " AS RegNumber, dbo.tbl_vehicleMakes.vehicleMake AS Make, dbo.tbl_vehicleModels.vehicleModel AS Model, " &
            '                    " Convert(VARCHAR(10), dbo.tbl_tyres.detManufactured, 10) As DateManufactured, DATEDIFF(mm, dbo.tbl_tyres.detManufactured, GETDATE()) " &
            '                    " AS TyreAgeInMonths, dbo.tbl_tyres.vehicleMileageAtTyreFitting + dbo.tbl_tyres.expectedTyreMileage - " &
            '                    " dbo.tbl_tyres.currentVehicleMileage AS MileageTowardsReplacement, dbo.tbl_tyres.currentVehicleMileage " &
            '                    " FROM            dbo.tbl_vehicleModels INNER JOIN " &
            '           "  dbo.tbl_vehicleMakes ON dbo.tbl_vehicleModels.vehicleMakeId = dbo.tbl_vehicleMakes.vehicleMakeId INNER JOIN " &
            '          "   dbo.tbl_tyres INNER JOIN " &
            '           "  dbo.tbl_tyreManufacturers On dbo.tbl_tyres.manufacturerId = dbo.tbl_tyreManufacturers.manufacturerId INNER JOIN " &
            '            " dbo.tbl_tyreSizes On dbo.tbl_tyres.tyreSizeId = dbo.tbl_tyreSizes.tyreSizeId INNER JOIN " &
            '             "dbo.tbl_tyreSuppliers On dbo.tbl_tyres.supplierId = dbo.tbl_tyreSuppliers.supplierId INNER JOIN " &
            '             "dbo.tbl_vehicleData ON dbo.tbl_tyres.fleetId = dbo.tbl_vehicleData.fleetId ON dbo.tbl_vehicleModels.vehicleModelId = " &
            '             " dbo.tbl_vehicleData.modelId WHERE (dbo.tbl_tyres.fittingStatusId = 2) ORDER BY MileageTowardsReplacement "


            Dim sql As String = "SELECT TOP (100) PERCENT CONVERT(VARCHAR(10), dbo.tbl_tyres.detFittedOnVehicle, 10) AS DateFitted, " &
                          " dbo.tbl_tyres.serialNumber AS SerialNumber, dbo.tbl_tyreSizes.tyreSize AS TyreSize, " &
                         " dbo.tbl_tyreManufacturers.manufacturer As Manufacturer, dbo.tbl_tyreSuppliers.supplierName As Supplier," &
                         " dbo.tbl_tyres.fleetId As FleetID, dbo.tbl_vehicleData.registrationNumber As RegNumber, " &
                         " dbo.tbl_vehicleMakes.vehicleMake As Make, dbo.tbl_vehicleModels.vehicleModel As Model, " &
                         " CONVERT(VARCHAR(10), dbo.tbl_tyres.detManufactured, 10) As DateManufactured, DATEDIFF(mm, " &
                         " dbo.tbl_tyres.detManufactured, GETDATE()) AS TyreAgeInMonths " &
                         " FROM            dbo.tbl_vehicleModels INNER JOIN " &
                        " dbo.tbl_vehicleMakes ON dbo.tbl_vehicleModels.vehicleMakeId = dbo.tbl_vehicleMakes.vehicleMakeId INNER JOIN " &
                        " dbo.tbl_tyres INNER JOIN " &
                        "  dbo.tbl_tyreManufacturers ON dbo.tbl_tyres.manufacturerId = dbo.tbl_tyreManufacturers.manufacturerId INNER JOIN " &
                        " dbo.tbl_tyreSizes ON dbo.tbl_tyres.tyreSizeId = dbo.tbl_tyreSizes.tyreSizeId INNER JOIN " &
                         " dbo.tbl_tyreSuppliers ON dbo.tbl_tyres.supplierId = dbo.tbl_tyreSuppliers.supplierId INNER JOIN " &
                        " dbo.tbl_vehicleData ON dbo.tbl_tyres.fleetId = dbo.tbl_vehicleData.fleetId ON " &
                        " dbo.tbl_vehicleModels.vehicleModelId = dbo.tbl_vehicleData.modelId " &
                        " WHERE (dbo.tbl_tyres.fittingStatusId = 2) "

            'AND (DATEDIFF(mm, dbo.tbl_tyres.detManufactured, GETDATE()) = @Param1) ORDER BY TyreAgeInMonths DESC "
            ' cboTyreLife.SelectedValue

            'Select Case cboTyreLife.SelectedValue
            '    Case "<= 6 months"
            '        sql = sql & "  AND (DATEDIFF(mm, dbo.tbl_tyres.detManufactured, GETDATE()) <= 6) ORDER BY TyreAgeInMonths DESC "
            '    Case "<= 12 months"
            '        sql = sql & "  AND (DATEDIFF(mm, dbo.tbl_tyres.detManufactured, GETDATE()) <= 12) ORDER BY TyreAgeInMonths DESC "
            '    Case "<= 18 months"
            '        sql = sql & "  AND (DATEDIFF(mm, dbo.tbl_tyres.detManufactured, GETDATE()) <= 18) ORDER BY TyreAgeInMonths DESC "
            '    Case "<= 24 months"
            '        sql = sql & "  AND (DATEDIFF(mm, dbo.tbl_tyres.detManufactured, GETDATE()) <= 24) ORDER BY TyreAgeInMonths DESC "
            '    Case Else
            '        sql = sql & "  ORDER BY TyreAgeInMonths DESC "
            'End Select

            If cboTyreLife.SelectedValue = "<= 6 months" Then
                sql = sql & "  AND (DATEDIFF(mm, dbo.tbl_tyres.detManufactured, GETDATE()) <= 6) ORDER BY TyreAgeInMonths DESC "
            ElseIf cboTyreLife.SelectedValue = "<= 12 months" Then
                sql = sql & "  AND (DATEDIFF(mm, dbo.tbl_tyres.detManufactured, GETDATE()) <= 12) ORDER BY TyreAgeInMonths DESC "
            ElseIf cboTyreLife.SelectedValue = "<= 18 months" Then
                sql = sql & "  AND (DATEDIFF(mm, dbo.tbl_tyres.detManufactured, GETDATE()) <= 18) ORDER BY TyreAgeInMonths DESC "
            ElseIf cboTyreLife.SelectedValue = "<= 24 months" Then
                sql = sql & "  AND (DATEDIFF(mm, dbo.tbl_tyres.detManufactured, GETDATE()) <= 24) ORDER BY TyreAgeInMonths DESC "
            Else
                sql = sql & "  ORDER BY TyreAgeInMonths DESC "
            End If



            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            db.ExecuteDataSet(CommandType.Text, sql)

            With gwGrid
                Try
                    .DataSource = ds
                    .DataBind()
                Catch ex As Exception
                    ' log.Error(ex.Message)
                    lblMsg.Text = "An Error has occurred."
                    ' obj.MessageLabel(lblMsg, "Error While trying To un-allocate vehicle To user.", "Red")
                End Try
            End With
        Catch ex As Exception
            'log.Error(ex)
        End Try
    End Sub

    Protected Sub cboTyreLife_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboTyreLife.SelectedIndexChanged
        loadGrid()
    End Sub
End Class