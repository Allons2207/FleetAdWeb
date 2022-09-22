
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Telerik.Web.UI

Public Class GroupAccessManager
    Inherits System.Web.UI.Page
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)

    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then


            If (CokkiesWrapper.UserID <= 0 AndAlso Not IsNumeric(CokkiesWrapper.UserID)) Then
                Response.Redirect("../Login.aspx")
                Exit Sub
            End If

            obj.ConnectionString = con

            Dim qry As String = "SELECT [userGroupId], [userGroup] FROM [dbo].[tbl_userGroups]"
            Dim ds As DataSet = obj.ExecuteDsQRY(qry)

            With cboUserGroup
                .DataSource = ds
                .DataTextField = "userGroup"
                .DataValueField = "userGroupId"
                .DataBind()
                .Items.Insert(0, New RadComboBoxItem("", ""))
            End With

            qry = "SELECT moduleId AS [Module ID], [Description] FROM luSystemModules"
            ds = obj.ExecuteDsQRY(qry)

            With gwList
                .DataSource = String.Empty
                .DataBind()
                .DataSource = ds
                .DataBind()
            End With

            If grantPageWriteCommandPermission(CokkiesWrapper.UserID, 1) = True Then
                cmdSave.Enabled = True

            Else
                cmdSave.Enabled = False

            End If

        End If

    End Sub

    Protected Sub cmdSave_Click(sender As Object, e As EventArgs) Handles cmdSave.Click

        If cboUserGroup.Text = "" Then
            lblMsg.Text = "Please specify the user group, it cannot be empty."
            Exit Sub
        End If

        Dim allowRead As Integer = 0
        Dim allowWrite As Integer = 0

        Dim x As Integer = deleteGroupPermissions(cboUserGroup.SelectedValue)
        If x = 0 Then

        Else

        End If

        For Each item As GridDataItem In gwList.Items
            Dim chkReadd As CheckBox = DirectCast(item.FindControl("chkRead"), CheckBox)
            Dim chkWritee As CheckBox = DirectCast(item.FindControl("chkWrite"), CheckBox)
            ' Dim txtModuleId As TextBox = DirectCast(item.FindControl("chkWrite"), CheckBox

            If chkReadd.Checked = True Then
                allowRead = 1
            Else
                allowRead = 0
            End If

            If chkWritee.Checked = True Then
                allowWrite = 1
                allowRead = 1
            Else
                allowWrite = 0
            End If

            Dim moduleId As Integer = Val(item("Module ID").Text)
            insertGroupModulePermission(moduleId, allowRead, allowWrite)

        Next

    End Sub

    Private Function deleteGroupPermissions(groupId As Integer) As Integer
        Dim strQry As String = ""

        strQry = "DELETE FROM tbl_groupPageAccessPermissions WHERE groupId =" & groupId
        Try
            obj.ConnectionString = con
            Return obj.ExecuteNonQRY(strQry)
        Catch ex As Exception
            Return 0
        End Try

    End Function


    Private Function insertGroupModulePermission(ByVal moduleId As Integer, readPermission As Integer, writePermission As Integer) As Integer
        Dim strQry As String = ""

        strQry = "INSERT tbl_groupPageAccessPermissions (groupId, moduleId,readMode,writeMode) VALUES (" & _
        cboUserGroup.SelectedValue & "," & moduleId & "," & readPermission & "," & writePermission & ")"

        Try
            obj.ConnectionString = con
            Return obj.ExecuteNonQRY(strQry)
        Catch ex As Exception
            Return 0
        End Try
      
    End Function


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