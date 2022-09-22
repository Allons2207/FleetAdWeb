Imports ClassLibrary1
Imports Telerik.Web.UI
Imports Microsoft.Practices.EnterpriseLibrary.Data
Public Class StuffSearch

    Inherits System.Web.UI.Page
    Private Shared log As log4net.ILog = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType)
    Dim objStuffDetails As New ClassLibrary1.StaffDetails(CokkiesWrapper.thisConnectionName)
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString
    Dim ds As DataSet


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (CokkiesWrapper.UserID <= 0 AndAlso Not IsNumeric(CokkiesWrapper.UserID)) Then
            Response.Redirect("../Login.aspx")
        End If

        obj.ConnectionString = con
        Dim accessMode As String = obj.groupAccessPermissionsDs(CokkiesWrapper.UserGroup, 3)

        Select Case accessMode
            Case "AllowReadNRead"
            Case "ReadNReadOnly"
                ' cmdSave.Enabled = False
            Case "DenyAcces"
                Response.Redirect("~/AccessDenied.aspx")
                Exit Sub
            Case Else
                Response.Redirect("~/AccessDenied.aspx")
                Exit Sub
        End Select


        
    End Sub
    Public Sub LoadOutCome(ByVal ds As DataSet)

        With gvStuffSearch
            Try
                .DataSource = ds
                .DataBind()

            Catch ex As Exception

                log.Error(ex)

            End Try

        End With

    End Sub
    Protected Sub btnSearch_Click(sender As Object, e As EventArgs) Handles btnSearch.Click

        With objStuffDetails
            .firstName = txtFName.Text
            .surname = txtSurname.Text
            .employmentNumber = txtEmploymentNum.Text
            .maritalStatusId = drpdnMaritalStatus.SelectedValue
            .titleId = drpdwnTitle.SelectedValue
            .sexId = drpdnSex.SelectedValue
            ds = .SearchStaff()

        End With

        Try

            LoadOutCome(ds)

        Catch ex As Exception

            log.Error(ex)

        End Try
    End Sub
    Private Sub drpdnMaritalStatus_Load(sender As Object, e As EventArgs) Handles drpdnMaritalStatus.Load

        If Not IsPostBack Then

            Dim objMaritalStatus As New MaritalStatuses(CokkiesWrapper.thisConnectionName)
            Dim ds As DataSet = objMaritalStatus.luStatuses()

            With drpdnMaritalStatus

                .DataSource = ds
                .DataTextField = "maritalStatus"
                .DataValueField = "maritalStatusId"
                .DataBind()
                .Items.Insert(0, New ListItem("--Select--", ""))
            End With

        End If
    End Sub

    Private Sub drpdnSex_Load(sender As Object, e As EventArgs) Handles drpdnSex.Load

        If Not IsPostBack Then

            Dim objSex As New Sex(CokkiesWrapper.thisConnectionName)
            Dim ds As DataSet = objSex.SelectRecords()

            With drpdnSex

                .DataSource = ds
                .DataTextField = "sex"
                .DataValueField = "sexId"
                .DataBind()
                .Items.Insert(0, New ListItem("--Select--", ""))
            End With

        End If
    End Sub

    Private Sub drpdwnTitle_Load(sender As Object, e As EventArgs) Handles drpdwnTitle.Load
        If Not IsPostBack Then

            Dim objTitle As New Titles(CokkiesWrapper.thisConnectionName)
            Dim ds As DataSet = objTitle.SelectRecords()

            With drpdwnTitle

                .DataSource = ds
                .DataTextField = "title"
                .DataValueField = "titleId"
                .DataBind()
                .Items.Insert(0, New ListItem("--Select--", ""))

            End With

        End If
    End Sub

    Private Sub gvStuffSearch_ItemCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs) Handles gvStuffSearch.ItemCommand

        If e.CommandName = "View" Then

            Dim item As GridDataItem = e.Item
            Dim employmentNumber As String = item("employmentNumber").Text
            Response.Redirect("~\StuffDetails.aspx?op=" + employmentNumber)

        End If

    End Sub

    Protected Sub gvStuffSearch_NeedDataSource(sender As Object, e As Telerik.Web.UI.GridNeedDataSourceEventArgs) Handles gvStuffSearch.NeedDataSource

    End Sub
End Class