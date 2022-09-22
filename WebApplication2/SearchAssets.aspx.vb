Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Telerik.Web.UI

Public Class SearchAssets
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

        obj.ConnectionString = con
        Dim accessMode As String = obj.groupAccessPermissionsDs(CokkiesWrapper.UserGroup, 6)

        Select Case accessMode
            Case "AllowReadNRead"
            Case "ReadNReadOnly"
                'cmdSave.Enabled = False
            Case "DenyAcces"
                Response.Redirect("~/AccessDenied.aspx")
                Exit Sub
            Case Else
                Response.Redirect("~/AccessDenied.aspx")
                Exit Sub
        End Select

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
End Class