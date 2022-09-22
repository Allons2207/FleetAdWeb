Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Telerik.Web.UI
Imports System.Drawing

Public Class ManageUsers
    Inherits System.Web.UI.Page
    Private Shared ReadOnly log As log4net.ILog = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType)

    Dim objUsers As New SystemUsers(CokkiesWrapper.thisConnectionName)
    Dim db As Database = objUsers.Database
    Dim con As String = db.ConnectionString
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then

        End If

        loadSystemUsers()

    End Sub


    Private Sub loadSystemUsers()

        Dim sql As String = "SELECT DISTINCT dbo.tbl_systemUsers.userId, dbo.tbl_systemUsers.userName, dbo.tbl_systemUsers.active, " & _
                            " dbo.tbl_systemUsers.userGroupId, dbo.tbl_userGroups.userGroup FROM dbo.tbl_systemUsers INNER JOIN " & _
                            " dbo.tbl_userGroups ON dbo.tbl_systemUsers.userGroupId = dbo.tbl_userGroups.userGroupId " & _
                            " ORDER BY dbo.tbl_systemUsers.userName "
        ' WHERE dbo.tbl_vehicleData.disposalStatusId <> 3

        obj.ConnectionString = con

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            db.ExecuteDataSet(CommandType.Text, sql)

            With gwGrid
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

    Private Sub gwGrid_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles gwGrid.ItemCommand
        If e.CommandName = "Edita" Then
            Dim item As GridDataItem = e.Item
            Dim UserId As String = item("UserId").Text
            Response.Redirect("~\UserDetails.aspx?op=" + UserId)
        End If
    End Sub

    Protected Sub gwGrid_NeedDataSource(sender As Object, e As GridNeedDataSourceEventArgs) Handles gwGrid.NeedDataSource

    End Sub

    Protected Sub cmdAddNew_Click(sender As Object, e As EventArgs) Handles cmdAddNew.Click
        Response.Redirect("~\UserDetails.aspx")
    End Sub


    Public Function grantPageWriteCommandPermission(ByVal UserId As Integer, pageId As Integer) As Boolean
        grantPageWriteCommandPermission = False
        Dim qry As String = "SELECT * FROM [dbo].[tbl_userSysPermissions] WHERE [userId] = " & UserId & " AND [sysModuleSectionId] = " & pageId & " AND [sysWrite] = 1"

        Try
            obj.ConnectionString = con
            Dim ds As DataSet = obj.ExecuteDsQRY(qry)
            If ds.Tables(0).Rows.Count > 0 Then
                grantPageWriteCommandPermission = True
            End If
        Catch ex As Exception
        End Try
    End Function


End Class