
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Telerik.Web.UI
Public Class OperationsDataEntry
    Inherits System.Web.UI.Page
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim saveMode As Boolean

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then
            loadSurfaceEquipment()
        End If

    End Sub

    Private Sub loadSurfaceEquipment()

        obj.loadComboBox(radMonth, "SELECT [mMonthId], [mMonth] FROM [dbo].[tbl_months]", "mMonth", "mMonthId")
        radMonth.Items.Insert(0, New RadComboBoxItem("--Select--", ""))

        radYear.Items.Insert(0, New RadComboBoxItem("--Select--", ""))

        Dim qry As String = "SELECT SE.SurfaceEquipmentID, dbo.tblSurfaceEquipmentTypes.SurfaceEquipmentType, SE.AssetNumber, SE.Description " &
                            " FROM     dbo.tblSurfaceEquipment AS SE INNER JOIN  dbo.tblSurfaceEquipmentTypes ON SE.AssetTypeID = " &
                            " dbo.tblSurfaceEquipmentTypes.SurfaceEquipmentTypeID "

        Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, qry)

        With gwGrid
            .DataSource = ds
            .DataBind()

            Session("DataList") = ds
        End With

    End Sub

    Private Sub rowValidations()

        Dim qry As String = ""

        Try
            For Each gridRow As GridDataItem In gwGrid.Items

                Dim txtOpeningHrs As New TextBox
                Dim txtClosingHrs As New TextBox
                Dim txtTotalHrs As New TextBox
                Dim txtTotalFuel As New TextBox
                Dim txtFuelCosts As New TextBox
                Dim txtSparesCosts As New TextBox
                Dim txtTotalCosts As New TextBox
                Dim txtConsumptionPerHr As New TextBox
                Dim txtCostPerHr As New TextBox
                Dim txtMaintHrs As New TextBox
                Dim txtBrkDownHrs As New TextBox
                Dim txtTotalDwnTime As New TextBox
                Dim txtAvailableHrs As New TextBox
                Dim txtAvailability As New TextBox
                ' Dim txtSurfaceEquipmentID As New TextBox


                txtOpeningHrs = gridRow.Item("OpeningHrs").FindControl("txtOpeningHrs")
                txtClosingHrs = gridRow.Item("ClosingHrs").FindControl("txtClosingHrs")
                txtTotalHrs = gridRow.FindControl("txtTotalHrs")
                txtTotalFuel = gridRow.Item("TotalFuel").FindControl("txtTotalFuel")
                txtFuelCosts = gridRow.FindControl("txtFuelCosts")
                txtSparesCosts = gridRow.Item("SparesCosts").FindControl("txtSparesCosts")
                txtTotalCosts = gridRow.FindControl("txtTotalCosts")
                txtConsumptionPerHr = gridRow.FindControl("txtConsumptionPerHr")
                txtCostPerHr = gridRow.FindControl("txtCostPerHr")
                txtMaintHrs = gridRow.Item("MaintHrs").FindControl("txtMaintHrs")
                txtBrkDownHrs = gridRow.Item("BrkDownHrs").FindControl("txtBrkDownHrs")

                txtTotalDwnTime = gridRow.FindControl("txtTotalDwnTime")
                txtAvailableHrs = gridRow.FindControl("txtAvailableHrs")
                txtAvailability = gridRow.FindControl("txtAvailability")

                txtAvailability = gridRow.Item("Availability").FindControl("txtAvailability")

                txtTotalHrs.Text = Val(txtClosingHrs.Text) - Val(txtOpeningHrs.Text)
                txtFuelCosts.Text = Val(txtTotalFuel.Text) * Val(txtCostOfDieselPerLitre.Text)

                txtTotalCosts.Text = Val(txtFuelCosts.Text) + Val(txtSparesCosts.Text)
                txtConsumptionPerHr.Text = Val(txtTotalFuel.Text) / Val(txtTotalHrs.Text)
                txtConsumptionPerHr.Text = Math.Round(Val(txtConsumptionPerHr.Text), 2)

                txtCostPerHr.Text = Val(txtTotalCosts.Text) / Val(txtTotalHrs.Text)
                txtCostPerHr.Text = Math.Round(Val(txtCostPerHr.Text), 2)

                txtTotalDwnTime.Text = Val(txtMaintHrs.Text) + Val(txtBrkDownHrs.Text)

                txtAvailableHrs.Text = Val(txtMaxPossibleHrs.Text) - Val(txtTotalDwnTime.Text)

                txtAvailability.Text = (Val(txtAvailableHrs.Text) / Val(txtMaxPossibleHrs.Text)) * 100

                txtAvailability.Text = Math.Round(Val(txtAvailability.Text), 1)

                Dim Availability As Long = Val(txtAvailability.Text)

                txtAvailability.Text = txtAvailability.Text & "%"


                If saveMode = True Then

                    qry = "DELETE From tblSurfaceEquipmentOperationsByMonth Where reportingMonth =  " & radMonth.SelectedValue &
                        " And reportingyear = " & radYear.SelectedValue & " And surfaceequipmentid =" & Val(gridRow.Item("SurfaceEquipmentID").Text)

                    db.ExecuteNonQuery(CommandType.Text, qry)

                    qry = "INSERT tblSurfaceEquipmentOperationsByMonth (reportingYear, reportingMonth, fromDate, toDate," &
                           " numberOfHrsInMonth,CostOfDieselPerLitre, SurfaceEquipmentID , OpeningHrs, ClosingHrs, TotalHrs, TotalFuel, " &
                           " FuelCosts, SparesCosts, TotalCosts,ConsumptionPerHr, CostPerHr, MaintenanceHrs, BreakdownHrs, TotalDownTime, " &
                           " AvailableHrs, [Availability] )  VALUES " &
                         " (" & radYear.SelectedValue & ", " & radMonth.SelectedValue & ", '" & rdFromDate.selecteddate & "', '" & rdToDate.selecteddate & "', " &
                             Val(txtMaxPossibleHrs.Text) & ", " & Val(txtCostOfDieselPerLitre.Text) & ", " & Val(gridRow.Item("SurfaceEquipmentID").Text) &
                            ", " & Val(txtOpeningHrs.Text) & ", " & Val(txtClosingHrs.Text) & ", " & Val(txtTotalHrs.Text) & ", " & Val(txtTotalFuel.Text) & ", " &
                             Val(txtFuelCosts.Text) & ", " & Val(txtSparesCosts.Text) & "," & txtTotalCosts.Text & " , " & txtConsumptionPerHr.Text &
                            "," & txtCostPerHr.Text & ", " & txtMaintHrs.Text & ", " & txtBrkDownHrs.Text & ", " & txtTotalDwnTime.Text & "," &
                            txtAvailableHrs.Text & ",'" & Availability & "') "

                    db.ExecuteNonQuery(CommandType.Text, qry)

                End If

            Next

        Catch ex As Exception

        End Try

    End Sub

    Protected Sub btnAutoFill_Click(sender As Object, e As EventArgs) Handles btnAutoFill.Click
        If validSave() = False Then Exit Sub
        saveMode = False
        rowValidations()
    End Sub
    Private Sub CalculateMaxPossibleHrs()

        If rdFromDate.IsEmpty Then
            Exit Sub
        End If

        If rdToDate.IsEmpty Then
            Exit Sub
        End If

        Dim firstDate As Date = rdFromDate.SelectedDate
        Dim secondDate As Date = rdToDate.SelectedDate

        Dim MaxPossibleHrs As Integer = DateDiff(DateInterval.Hour, firstDate, secondDate) + 24

        txtMaxPossibleHrs.Text = MaxPossibleHrs

    End Sub
    Private Function validSave() As Boolean

        validSave = False

        Dim qry As String = radYear.Text

        If radYear.Text = " -Select-" Then
            obj.MessageLabel(lblMsg, "Invalid Reporting Year.", "Red")
            Exit Function
        ElseIf radYear.Text = "" Then
            obj.MessageLabel(lblMsg, "Invalid Reporting Year.", "Red")
            Exit Function
        ElseIf radMonth.Text = "-Select-" Then
            obj.MessageLabel(lblMsg, "Invalid Reporting Month.", "Red")
            Exit Function
        ElseIf radMonth.Text = "" Then
            obj.MessageLabel(lblMsg, "Invalid Reporting Month.", "Red")
            Exit Function
        ElseIf rdFromDate.IsEmpty Then
            obj.MessageLabel(lblMsg, "Invalid Start Date.", "Red")
            Exit Function
        ElseIf rdToDate.IsEmpty Then
            obj.MessageLabel(lblMsg, "Invalid To Date.", "Red")
            Exit Function
        ElseIf txtCostOfDieselPerLitre.Text = "" Then
            obj.MessageLabel(lblMsg, "Invalid Cost of Diesel per Litre.", "Red")
            Exit Function
        ElseIf val(txtCostOfDieselPerLitre.Text) = 0 Then
            obj.MessageLabel(lblMsg, "Invalid Cost of Diesel per Litre.", "Red")
            Exit Function
        End If

        validSave = True

    End Function

    Protected Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click
        If validSave() = False Then Exit Sub
        saveMode = True
        rowValidations()
    End Sub

    Protected Sub rdFromDate_SelectedDateChanged(sender As Object, e As Calendar.SelectedDateChangedEventArgs) Handles rdFromDate.SelectedDateChanged
        txtMaxPossibleHrs.Text = ""
        CalculateMaxPossibleHrs()
    End Sub

    Protected Sub rdToDate_SelectedDateChanged(sender As Object, e As Calendar.SelectedDateChangedEventArgs) Handles rdToDate.SelectedDateChanged
        txtMaxPossibleHrs.Text = ""
        CalculateMaxPossibleHrs()
    End Sub

    Protected Sub gwGrid_NeedDataSource(sender As Object, e As GridNeedDataSourceEventArgs) Handles gwGrid.NeedDataSource
        gwGrid.DataSource = Session("DataList")
    End Sub


End Class