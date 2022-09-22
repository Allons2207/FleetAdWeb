Imports Telerik.Web.UI
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing

Public Class CaptureAssets
    Inherits System.Web.UI.Page
    Private Shared ReadOnly log As log4net.ILog = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType)
    Dim objSchoolAssets As New SchoolAssets(CokkiesWrapper.thisConnectionName)
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = objSchoolAssets.Database
    Dim con As String = db.ConnectionString

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (CokkiesWrapper.UserID <= 0 AndAlso Not IsNumeric(CokkiesWrapper.UserID)) Then
            Response.Redirect("../Login.aspx")
            Exit Sub
        End If

        'obj.ConnectionString = con
        'Dim accessMode As String = obj.groupAccessPermissionsDs(CokkiesWrapper.UserGroup, 6)

        'Select Case accessMode
        '    Case "AllowReadNRead"
        '    Case "ReadNReadOnly"
        '        cmdSave.Enabled = False
        '    Case "DenyAcces"
        '        Response.Redirect("~/AccessDenied.aspx")
        '        Exit Sub
        '    Case Else
        '        Response.Redirect("~/AccessDenied.aspx")
        '        Exit Sub
        'End Select

    End Sub

    Private Sub cbAssetName_Load(sender As Object, e As EventArgs) Handles cbAssetName.Load
        If Not IsPostBack Then

            Dim objAsset As New Assets(CokkiesWrapper.thisConnectionName)
            Dim ds As DataSet = objAsset.SelectRecords()

            With cbAssetName

                .DataSource = ds
                .DataTextField = "asset"
                .DataValueField = "asset"
                .DataBind()

                .Items.Insert(0, New RadComboBoxItem("", ""))

            End With

        End If
    End Sub

    Private Sub rbFunctionalState_Load(sender As Object, e As EventArgs) Handles rbFunctionalState.Load

        If Not IsPostBack Then

            Dim objFunctionalStates As New FunctionalStates(CokkiesWrapper.thisConnectionName)
            Dim ds As DataSet = objFunctionalStates.SelectRecords()
            With rbFunctionalState
                .DataSource = ds
                .DataTextField = "functionalState"
                .DataValueField = "functionalState"
                .DataBind()
                .Items.Insert(0, New RadComboBoxItem("", ""))
            End With
        End If

    End Sub

    Private Sub rbSupplier_Load(sender As Object, e As EventArgs) Handles rbSupplier.Load
        If Not IsPostBack Then

            Dim objSupplier As New Suppliers(CokkiesWrapper.thisConnectionName)
            Dim ds As DataSet = objSupplier.SelectRecords()

            With rbSupplier

                .DataSource = ds
                .DataTextField = "supplier"
                .DataValueField = "supplier"
                .DataBind()

                .Items.Insert(0, New RadComboBoxItem("", ""))

            End With

        End If
    End Sub

    Private Sub cbAssetLocation_Load(sender As Object, e As EventArgs) Handles cbAssetLocation.Load
        If Not IsPostBack Then

            Dim objAssetLocation As New Locations(CokkiesWrapper.thisConnectionName)
            Dim ds As DataSet = objAssetLocation.SelectRecords()

            With cbAssetLocation

                .DataSource = ds
                .DataTextField = "location"
                .DataValueField = "location"
                .DataBind()

                .Items.Insert(0, New RadComboBoxItem("", ""))

            End With

        End If
    End Sub

    Private Sub cmdSave_Click(sender As Object, e As EventArgs) Handles cmdSave.Click

        Try

            With objSchoolAssets

                .ConnectionString = con
                .assetLocation = cbAssetLocation.SelectedValue
                .assetName = cbAssetName.SelectedValue
                .assetNumber = txtAssetNumber.Text
                .assetUser = txtAssetUser.Text
                .dateBought = rdDateBought.SelectedDate
                .description = txtDescription.Text
                .functionalStateId = rbFunctionalState.SelectedValue
                .quantity = txtQuantity.Text
                .serialNumber = txtSerialNumber.Text
                .supplierId = rbSupplier.SelectedValue
                .totalValue = txtTotalValue.Text

                .Insert()


            End With

            lblMsg.BackColor = Color.Green
            lblMsg.ForeColor = Color.White
            lblMsg.Text = "Book Details were saved successfully!!!"

        Catch ex As Exception

            log.Error(ex)
            lblMsg.BackColor = Color.Red
            lblMsg.ForeColor = Color.White
            lblMsg.Text = "Book Details were not saved successfully!!!"

        End Try



    End Sub
End Class