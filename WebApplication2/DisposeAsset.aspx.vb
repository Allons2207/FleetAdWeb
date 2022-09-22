Imports Telerik.Web.UI
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing

Public Class DisposeAsset
    Inherits System.Web.UI.Page
    Private Shared ReadOnly log As log4net.ILog = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType)
    Dim objSchoolAssets As New SchoolAssets(CokkiesWrapper.thisConnectionName)
    Dim db As Database = objSchoolAssets.Database
    Dim con As String = db.ConnectionString

    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (CokkiesWrapper.UserID <= 0 AndAlso Not IsNumeric(CokkiesWrapper.UserID)) Then
            Response.Redirect("../Login.aspx")
            Exit Sub
        End If
    End Sub
    Public Sub LoadOutCome()

        Dim ds As DataSet = objSchoolAssets.SelectRecords()

        With gwAssetsSearch

            Try
                .DataSource = ds
                .DataBind()

            Catch ex As Exception

                log.Error(ex.Message)

            End Try

        End With
    End Sub

    Private Sub cmdSearch_Click(sender As Object, e As EventArgs) Handles cmdSearch.Click
        With objSchoolAssets

            .assetName = cbAssetName.SelectedValue
            .assetNumber = txtAssetNumber.Text
            .serialNumber = txtSerialNumber.Text
            .supplierId = cbSupplier.SelectedValue
            '.dateBought = radDateBought.SelectedDate
            .assetUser = txtAssetUser.Text

        End With
        Try
            LoadOutCome()


        Catch ex As Exception
            log.Error(ex.Message)

        End Try
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

    Private Sub cbSupplier_Load(sender As Object, e As EventArgs) Handles cbSupplier.Load
        If Not IsPostBack Then

            Dim objSupplier As New Suppliers(CokkiesWrapper.thisConnectionName)
            Dim ds As DataSet = objSupplier.SelectRecords()

            With cbSupplier

                .DataSource = ds
                .DataTextField = "supplier"
                .DataValueField = "supplier"
                .DataBind()

                .Items.Insert(0, New RadComboBoxItem("", ""))

            End With

        End If
    End Sub

    Private Sub gwAssetsSearch_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles gwAssetsSearch.ItemCommand

        Panel1.Visible = True
        Panel2.Visible = True

        If e.CommandName = "dispose" Then

            Dim item As GridDataItem = e.Item

            lblAssetName.Text = item("assetname").Text
            'lblAssetType.Text = item("asset").Text
            lblDateBought.Text = item("dateBought").Text
            lblDescription.Text = item("description").Text
            lblSupplier.Text = item("supplierId").Text
            lblSerialNumber.Text = item("serialNumber").Text
            lblFunctionalState.Text = item("functionalStateId").Text
            lblAssetNumber.Text = item("assetNumber").Text


        End If
    End Sub

    Protected Sub cmdSave_Click(sender As Object, e As EventArgs) Handles cmdSave.Click

        Dim objAssetDisposal As New SchoolAssetsDisposed(CokkiesWrapper.thisConnectionName)
        Try
            With objAssetDisposal

                .ConnectionString = con
                .assetName = lblAssetName.Text
                .assetNumber = lblAssetNumber.Text
                .assetType = ""
                .dateBought = lblDateBought.Text
                .dateDisposed = rdDateDisposed.SelectedDate
                .description = lblDescription.Text
                .functionalState = lblFunctionalState.Text
                .quantityDisposed = txtQuantitesDisposed.Text
                .reasonForDisposal = txtReasonForDisposal.Text
                .serialNumber = lblSerialNumber.Text
                .supplier = lblSupplier.Text
                .valueOfDisposedAssets = txtValueDisposed.Text

                .Insert()


            End With


            lblMsg.BackColor = Color.Green
            lblMsg.ForeColor = Color.White
            lblMsg.Text = "Loaning Details were saved successfully!!!"

        Catch ex As Exception

            log.Error(ex)
            lblMsg.BackColor = Color.Red
            lblMsg.ForeColor = Color.White
            lblMsg.Text = "Loaning Details were not saved successfully!!!"

        End Try
    End Sub
End Class