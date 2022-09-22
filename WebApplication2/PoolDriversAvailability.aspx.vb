Imports Telerik.Web.UI
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing
Imports System.Data.SqlClient


Public Class PoolDriversAvailability
    Inherits System.Web.UI.Page
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        loadPoolDrivers()
    End Sub

    'SELECT        userId FROM            dbo.tbl_tripLogging

    '<Items>
    '<Telerik:RadComboBoxItem runat = "server" Text="--Select--" Value="--Select--" />
    '                                             <Telerik:RadComboBoxItem runat = "server" Text="Available Drivers" Value="Available Drivers" />
    '                                             <Telerik:RadComboBoxItem runat = "server" Text="UnAvailable Drivers" Value="UnAvailable Drivers" />
    '                                         </Items>


    Private Sub loadPoolDrivers()

        Dim sql As String = "SELECT DISTINCT dbo.tbl_vehicleUsers.surname AS Surname, dbo.tbl_vehicleUsers.firstName AS FirstName, " &
                            " dbo.tbl_vehicleUsers.department AS Department, dbo.tbl_vehicleUsers.position AS Position, " &
                            " dbo.tbl_vehicleUsers.nationalIDNo AS NationalIDNo, dbo.tbl_vehicleUsers.licenseNumber AS LicenseNo, " &
                            "  Convert(VARCHAR(10), dbo.tbl_vehicleUsers.defensiveLicenseExpiryDate, 10) AS DefensiveExpDate, dbo.tbl_allocationStatus.allocationStatus " &
                            " AS AllocationStatus, dbo.tbl_vehicleMakes.vehicleMake AS Make, dbo.tbl_vehicleModels.vehicleModel AS Model, " &
                            " dbo.tbl_vehicleUsers.regNumber AS RegNumber FROM            dbo.tbl_allocationStatus INNER JOIN " &
                            " dbo.tbl_vehicleUsers ON dbo.tbl_allocationStatus.allocationStatusId = dbo.tbl_vehicleUsers.allocationStatusId LEFT OUTER JOIN " &
                            " dbo.tbl_vehicleModels INNER JOIN dbo.tbl_vehicleMakes ON dbo.tbl_vehicleModels.vehicleMakeId = " &
                            " dbo.tbl_vehicleMakes.vehicleMakeId INNER JOIN dbo.tbl_vehicleData ON dbo.tbl_vehicleModels.vehicleModelId = " &
                            " dbo.tbl_vehicleData.modelId ON dbo.tbl_vehicleUsers.regNumber = dbo.tbl_vehicleData.registrationNumber " &
                            "  WHERE   (dbo.tbl_vehicleUsers.allocationStatusId = 4)  ORDER BY Surname, FirstName "

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            db.ExecuteDataSet(CommandType.Text, sql)

            With gwGrid
                Try
                    .DataSource = ds
                    .DataBind()

                    obj.MessageLabel(lblMsg, ds.Tables(0).Rows.Count & "   Driver(s) found.", "Green")
                Catch ex As Exception
                    '  log.Error(ex.Message)
                End Try
            End With
        Catch ex As Exception
            'log.Error(ex)
        End Try
    End Sub

    Private Sub availableDrivers()
        Dim sql As String = "SELECT DISTINCT dbo.tbl_vehicleUsers.surname AS Surname, dbo.tbl_vehicleUsers.firstName AS FirstName, " &
                            " dbo.tbl_vehicleUsers.department AS Department, dbo.tbl_vehicleUsers.position AS Position, " &
                            " dbo.tbl_vehicleUsers.nationalIDNo AS NationalIDNo, dbo.tbl_vehicleUsers.licenseNumber AS LicenseNo, " &
                            "  Convert(VARCHAR(10), dbo.tbl_vehicleUsers.defensiveLicenseExpiryDate, 10) AS DefensiveExpDate, dbo.tbl_allocationStatus.allocationStatus " &
                            " AS AllocationStatus, dbo.tbl_vehicleMakes.vehicleMake AS Make, dbo.tbl_vehicleModels.vehicleModel AS Model, " &
                            " dbo.tbl_vehicleUsers.regNumber AS RegNumber FROM            dbo.tbl_allocationStatus INNER JOIN " &
                            " dbo.tbl_vehicleUsers ON dbo.tbl_allocationStatus.allocationStatusId = dbo.tbl_vehicleUsers.allocationStatusId LEFT OUTER JOIN " &
                            " dbo.tbl_vehicleModels INNER JOIN dbo.tbl_vehicleMakes ON dbo.tbl_vehicleModels.vehicleMakeId = " &
                            " dbo.tbl_vehicleMakes.vehicleMakeId INNER JOIN dbo.tbl_vehicleData ON dbo.tbl_vehicleModels.vehicleModelId = " &
                            " dbo.tbl_vehicleData.modelId ON dbo.tbl_vehicleUsers.regNumber = dbo.tbl_vehicleData.registrationNumber " &
                            "  WHERE  (dbo.tbl_vehicleUsers.allocationStatusId = 4)  AND dbo.tbl_vehicleUsers.nationalIDNo NOT IN (SELECT userId AS nationalIDNo FROM dbo.tbl_tripLogging  WHERE  (returnStatus = 'Still Out'))    ORDER BY Surname, FirstName "
        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            db.ExecuteDataSet(CommandType.Text, sql)

            With gwGrid
                Try
                    .DataSource = ds
                    .DataBind()

                    obj.MessageLabel(lblMsg, ds.Tables(0).Rows.Count & "   Driver(s) found.", "Green")

                Catch ex As Exception
                    '  log.Error(ex.Message)
                End Try
            End With
        Catch ex As Exception
            'log.Error(ex)
        End Try

    End Sub

    Private Sub UnAvailableDrivers()
        Dim sql As String = "SELECT DISTINCT dbo.tbl_vehicleUsers.surname AS Surname, dbo.tbl_vehicleUsers.firstName AS FirstName, " &
                            " dbo.tbl_vehicleUsers.department AS Department, dbo.tbl_vehicleUsers.position AS Position, " &
                            " dbo.tbl_vehicleUsers.nationalIDNo AS NationalIDNo, dbo.tbl_vehicleUsers.licenseNumber AS LicenseNo, " &
                            "  Convert(VARCHAR(10), dbo.tbl_vehicleUsers.defensiveLicenseExpiryDate, 10) AS DefensiveExpDate, dbo.tbl_allocationStatus.allocationStatus " &
                            " AS AllocationStatus, dbo.tbl_vehicleMakes.vehicleMake AS Make, dbo.tbl_vehicleModels.vehicleModel AS Model, " &
                            " dbo.tbl_vehicleUsers.regNumber AS RegNumber FROM            dbo.tbl_allocationStatus INNER JOIN " &
                            " dbo.tbl_vehicleUsers ON dbo.tbl_allocationStatus.allocationStatusId = dbo.tbl_vehicleUsers.allocationStatusId LEFT OUTER JOIN " &
                            " dbo.tbl_vehicleModels INNER JOIN dbo.tbl_vehicleMakes ON dbo.tbl_vehicleModels.vehicleMakeId = " &
                            " dbo.tbl_vehicleMakes.vehicleMakeId INNER JOIN dbo.tbl_vehicleData ON dbo.tbl_vehicleModels.vehicleModelId = " &
                            " dbo.tbl_vehicleData.modelId ON dbo.tbl_vehicleUsers.regNumber = dbo.tbl_vehicleData.registrationNumber " &
                            "    WHERE  (dbo.tbl_vehicleUsers.allocationStatusId = 4)  AND dbo.tbl_vehicleUsers.nationalIDNo IN (SELECT userId AS nationalIDNo FROM dbo.tbl_tripLogging  WHERE  (returnStatus = 'Still Out'))    ORDER BY Surname, FirstName "
        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            db.ExecuteDataSet(CommandType.Text, sql)

            With gwGrid
                Try
                    .DataSource = ds
                    .DataBind()

                    obj.MessageLabel(lblMsg, ds.Tables(0).Rows.Count & "   Driver(s) found.", "Green")

                Catch ex As Exception
                    '  log.Error(ex.Message)
                End Try
            End With
        Catch ex As Exception
            'log.Error(ex)
        End Try

    End Sub

    Protected Sub cboSelect_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboSelect.SelectedIndexChanged

        obj.MessageLabel(lblMsg, "", "")

        Select Case cboSelect.Text
            Case "Available Drivers"
                availableDrivers()
            Case "UnAvailable Drivers"
                UnAvailableDrivers()
            Case Else
                loadPoolDrivers()
        End Select
    End Sub
End Class