Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports ClassLibrary1
Imports Telerik.Web.UI
Public Class UserDetails
    Inherits System.Web.UI.Page
    Private Shared log As log4net.ILog = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType)
    Dim objUser As New SystemUsers(CokkiesWrapper.thisConnectionName)
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = objUser.Database
    Dim con As String = db.ConnectionString
    Dim ds As DataSet

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            If (CokkiesWrapper.UserID <= 0 AndAlso Not IsNumeric(CokkiesWrapper.UserID)) Then
                Response.Redirect("../Login.aspx")
                Exit Sub
            End If

            obj.ConnectionString = con
            obj.loadComboBox(cboUserGroup, "SELECT DISTINCT [userGroupId], [userGroup] FROM [dbo].[tbl_userGroups]", "userGroup", "userGroupId")

            loadUserDetails()

            If grantPageWriteCommandPermission(CokkiesWrapper.UserID, 1) = True Then
                cmdSave.Enabled = True
                If Not IsNothing(Request.QueryString("op")) Then
                    cmdDelete.Enabled = True
                Else
                    cmdDelete.Enabled = False
                End If
            Else
                cmdSave.Enabled = False
            End If

        End If
    End Sub

    Private Sub loadUserDetails()

        txtUserId.Text = Request.QueryString("op")

        Dim qry As String = "SELECT DISTINCT UserId, [userName],[active],[userGroupId] FROM  [dbo].[tbl_systemUsers] WHERE UserId = " & txtUserId.Text

        Dim ds As DataSet = obj.ExecuteDsQRY(qry)

        Try
            If ds.Tables(0).Rows.Count > 0 Then
                With ds.Tables(0).Rows(0)
                    txtUserId.Text = .Item("UserId")
                    txtUsername.Text = .Item("userName")
                    cboUserGroup.SelectedValue = .Item("userGroupId")

                    If .Item("active") = 1 Then
                        chkActiveStatus.Checked = True
                    End If
                End With

                loadSystemModules()
                LoadUserModules()

            End If
        Catch ex As Exception

        End Try

    End Sub

    Protected Sub cmdSave_Click(sender As Object, e As EventArgs) Handles cmdSave.Click
        If txtUsername.Text = "" Then
            obj.MessageLabel(lblMsg, "Please enter the User Name, it cannot be empty.", "Red")
            Exit Sub
        End If

        If txtUserId.Text = "" Then
            insertNewUser()
        Else
            UnpdateUser()
        End If
    End Sub

    Private Sub insertNewUser()
        Dim activeStatus As Integer = 0
        If chkActiveStatus.Checked = True Then
            activeStatus = 1
        End If
        Dim qry As String = ""
        qry = "INSERT [dbo].[tbl_systemUsers] ([userName],[active],[userGroupId]) VALUES ('" & txtUsername.Text & "'," & activeStatus & "," & cboUserGroup.SelectedValue & ")  "

        Try
            obj.ConnectionString = con
            If obj.ExecuteNonQRY(qry) = 1 Then
                ' saveFromCheckGrid()
                obj.MessageLabel(lblMsg, "User details successfully added.", "Green")
                Exit Sub
            Else
                obj.MessageLabel(lblMsg, "Error while trying to add user details.", "Red")
                Exit Sub
            End If
        Catch ex As Exception
            obj.MessageLabel(lblMsg, "Error while trying to add user details.", "Red")
        End Try

    End Sub

    Private Sub UnpdateUser()
        Dim activeStatus As Integer = 0
        If chkActiveStatus.Checked = True Then
            activeStatus = 1
        End If

        Dim qry As String = "UPDATE tbl_systemUsers SET userName = '" & txtUsername.Text & "', active = " & activeStatus & ", userGroupId = " & cboUserGroup.SelectedValue & "  WHERE userId = " & txtUserId.Text

        Try
            obj.ConnectionString = con
            If obj.ExecuteNonQRY(qry) = 1 Then
                ' saveFromCheckGrid()
                obj.MessageLabel(lblMsg, "User details successfully updated.", "Green")
                Exit Sub
            Else
                obj.MessageLabel(lblMsg, "Error while trying to update user details.", "Red")
                Exit Sub
            End If
        Catch ex As Exception
            obj.MessageLabel(lblMsg, "Error while trying to update user details.", "Red")
        End Try
    End Sub


    Private Sub loadSystemModules()

        Dim sql As String = "SELECT DISTINCT [sysModuleId], [sysModule] As [Object] FROM [dbo].[tbl_systemModules] ORDER BY [sysModule]"
        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            db.ExecuteDataSet(CommandType.Text, sql)
            With gwList
                .DataSource = ds
                .DataBind()

            End With
        Catch ex As Exception
            '  log.Error(ex)
        End Try
    End Sub
    Private Sub loadAllReports()
        Dim sql As String = "SELECT [ReportID] as sysModuleId, [ReportAlias] as Object FROM [dbo].[tblReports] WHERE [ReportAlias] IS NOT NULL ORDER BY [ReportAlias]"

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            db.ExecuteDataSet(CommandType.Text, sql)
            With gwList
                .DataSource = ds
                .DataBind()

            End With
        Catch ex As Exception
            '  log.Error(ex)
        End Try
    End Sub

    Protected Sub cboPermissionType_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboPermissionType.SelectedIndexChanged
        lblMsg.Visible = False

        If cboPermissionType.Text = "Page Level Access" Then
            loadSystemModules()
            LoadUserModules()
            cmdSaveUserModules.Visible = True
        ElseIf cboPermissionType.Text = "Save/Edit and Delete Permissions" Then
            loadUserPermittedSystemModules()
        ElseIf cboPermissionType.Text = "Report Level Access"
            loadAllReports()
            loadUserReportPermissions()
            cmdSaveUserModules.Visible = True
        Else
            With gwList
                .DataSource = String.Empty
                .DataBind()
            End With
            cmdSaveUserModules.Visible = False
        End If

    End Sub
    Private Sub loadUserReportPermissions()
        Dim sql As String = ""
        Try
            For Each gridRow As GridDataItem In gwList.Items
                sql = "Select * FROM [tbl_userReportsPermissions] WHERE userId = '" & txtUserId.Text & "' AND reportId = " & Val(gridRow("sysModuleId").Text)
                obj.ConnectionString = con
                Dim ds As DataSet = obj.ExecuteDsQRY(sql)
                If ds.Tables(0).Rows.Count > 0 Then
                    gridRow.Selected = True
                End If
            Next
        Catch ex As Exception

        End Try
    End Sub
    Private Sub loadUserPermittedSystemModules()

        Dim qry As String = "SELECT DISTINCT TOP (100) PERCENT dbo.tbl_systemModules.sysModuleId, dbo.tbl_systemModules.sysModule AS Object, " &
                            " dbo.tbl_userSysPermissions.sysRead, dbo.tbl_userSysPermissions.userId FROM  dbo.tbl_systemModules INNER JOIN " &
                            " dbo.tbl_userSysPermissions ON dbo.tbl_systemModules.sysModuleId = dbo.tbl_userSysPermissions.sysModuleSectionId " &
                            "WHERE (dbo.tbl_userSysPermissions.sysRead = 1) AND (dbo.tbl_userSysPermissions.userId = " & txtUserId.Text & ") ORDER BY Object "
        Try
            obj.ConnectionString = con
            Dim ds As DataSet = obj.ExecuteDsQRY(qry)

            If ds.Tables(0).Rows.Count > 0 Then
                With gwList
                    .DataSource = ds
                    .DataBind()
                End With

                loadCurrentUserSaveEditDeletePermission()

                cmdSaveUserModules.Visible = True

            Else
                cmdSaveUserModules.Visible = False
                obj.MessageLabel(lblMsg, "Please first give the user Page Level Access Permissions!", "Red")
                lblMsg.Visible = True

                gwList.DataSource = String.Empty
                gwList.DataBind()

            End If
        Catch ex As Exception
            '  log.Error(ex)
            obj.MessageLabel(lblMsg, "Error while trying to load User Permitted System Modules.", "Red")
            cmdSaveUserModules.Visible = False
        End Try

    End Sub


    Private Sub saveUserModules()
        'INSERT [dbo].[tbl_userSysPermissions] ([userId],[sysModuleSectionId],[sysRead],[sysWrite])  VALUES ()

        Dim sql As String = ""
        Try
            obj.ConnectionString = con
            sql = "DELETE FROM tbl_userSysPermissions WHERE userId = '" & txtUserId.Text & "'"
            obj.ExecuteNonQRY(sql)

            For Each gridRow As GridDataItem In gwList.Items
                If gridRow.Selected Then
                    sql = "INSERT [dbo].[tbl_userSysPermissions] ([userId],[sysModuleSectionId],[sysRead]) " & _
                          " VALUES('" & txtUserId.Text & "', '" & Val(gridRow("sysModuleId").Text) & "', 1)"
                    obj.ExecuteNonQRY(sql)
                End If
            Next
        Catch ex As Exception
            obj.MessageLabel(lblMsg, "Error while trying to save User Module details.", "Red")
        End Try

    End Sub

    Private Sub saveUserReportPermissions()

        Dim sql As String = ""
        Try
            obj.ConnectionString = con
            sql = "DELETE FROM tbl_userReportsPermissions WHERE userId = '" & txtUserId.Text & "'"
            obj.ExecuteNonQRY(sql)

            For Each gridRow As GridDataItem In gwList.Items
                If gridRow.Selected Then
                    sql = "INSERT tbl_userReportsPermissions (userId,reportId) VALUES ('" & txtUserId.Text & "', " & Val(gridRow("sysModuleId").Text) & ")"
                    obj.ExecuteNonQRY(sql)
                End If
            Next

        Catch ex As Exception
            obj.MessageLabel(lblMsg, "Error While trying To save User Report Permissions.", "Red")
        End Try

    End Sub
    Private Sub saveSaveEditDeletePermissions()

        Dim sql As String = ""
        Try
            obj.ConnectionString = con
            ' sql = "DELETE FROM tbl_userSysPermissions WHERE userId = '" & txtUserId.Text & "'"
            obj.ExecuteNonQRY(sql)
            Dim selected As Integer = 0
            For Each gridRow As GridDataItem In gwList.Items
                If gridRow.Selected Then
                    selected = 1
                Else
                    selected = 0
                End If

                sql = "UPDATE tbl_userSysPermissions SET sysWrite = " & selected & " WHERE userId = '" & txtUserId.Text & "' AND sysModuleSectionId = '" & Val(gridRow("sysModuleId").Text) & "'"

                obj.ExecuteNonQRY(sql)
            Next
        Catch ex As Exception
            obj.MessageLabel(lblMsg, "Error While trying To save User Module details.", "Red")
        End Try


    End Sub
    Private Sub LoadUserModules()

        Dim sql As String = ""
        Try
            For Each gridRow As GridDataItem In gwList.Items
                sql = "Select * FROM [tbl_userSysPermissions] WHERE userId = '" & txtUserId.Text & "' AND sysModuleSectionId = " & Val(gridRow("sysModuleId").Text)
                obj.ConnectionString = con
                Dim ds As DataSet = obj.ExecuteDsQRY(sql)
                If ds.Tables(0).Rows.Count > 0 Then
                    gridRow.Selected = True
                End If
            Next
        Catch ex As Exception

        End Try
    End Sub

    Protected Sub cmdSaveUserModules_Click(sender As Object, e As EventArgs) Handles cmdSaveUserModules.Click

        If txtUserId.Text = "" Then
            lblMsg.Text = "Invalid User ID. No data saved."
            lblMsg.ForeColor = System.Drawing.Color.Red
            Exit Sub
        End If

        Select Case cboPermissionType.Text
            Case "--Select--"
                obj.MessageLabel(lblMsg, "Please specify the Permission Type.", "Red")
            Case "Page Level Access"
                saveUserModules()
            Case "Save/Edit and Delete Permissions"
                saveSaveEditDeletePermissions()
            Case "Report Level Access"
                saveUserReportPermissions()
        End Select



    End Sub

    Private Sub loadCurrentUserSaveEditDeletePermission()
        Dim sql As String = ""
        Try
            For Each gridRow As GridDataItem In gwList.Items
                sql = "Select DISTINCT dbo.tbl_userSysPermissions.userId, dbo.tbl_systemModules.sysModule, dbo.tbl_userSysPermissions.sysRead," &
                      " dbo.tbl_userSysPermissions.sysWrite FROM   dbo.tbl_userSysPermissions INNER JOIN dbo.tbl_systemModules On " &
                      " dbo.tbl_userSysPermissions.sysModuleSectionId = dbo.tbl_systemModules.sysModuleId " &
                      " WHERE (dbo.tbl_userSysPermissions.userId = '" & txtUserId.Text & "') AND (dbo.tbl_systemModules.sysModule = '" & gridRow("Object").Text & "') AND " &
                      " (dbo.tbl_userSysPermissions.sysWrite = 1)"

                obj.ConnectionString = con
                Dim ds As DataSet = obj.ExecuteDsQRY(sql)
                If ds.Tables(0).Rows.Count > 0 Then
                    gridRow.Selected = True
                End If
            Next
        Catch ex As Exception

        End Try

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

    Protected Sub cmdDelete_Click(sender As Object, e As EventArgs) Handles cmdDelete.Click
        If Not IsNothing(Request.QueryString("op")) Then

            If txtUserId.Text = CokkiesWrapper.UserID Then
                obj.MessageLabel(lblMsg, "You cannot delete this user while logged on here.", "Red")
                Exit Sub
            End If

            Dim qry As String = "DELETE FROM tbl_systemUsers WHERE userId = '" & txtUserId.Text & "'"

            obj.ConnectionString = con

            If obj.ExecuteNonQRY(qry) = 1 Then
                obj.MessageLabel(lblMsg, "Fleet-System User record entry deleted.", "Green")
            Else
                obj.MessageLabel(lblMsg, "Error while trying to delete Fleet-System record entry.", "Red")
            End If
        Else
            obj.MessageLabel(lblMsg, "Error. System could not find the associated Fleet-System User ID.", "Red")
        End If
    End Sub
End Class