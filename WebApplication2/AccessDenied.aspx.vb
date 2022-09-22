Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Telerik.Web.UI

Public Class AccessDenied
    Inherits System.Web.UI.Page
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)

    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        '     <--div style="text-align:center">
        '    <asp:Image ID="imgRestricted" ImageUrl="~/images/AccessRestricted.png" runat="server"/>
        '</--div>
        If Not IsPostBack Then
            lblUserFullName.Text = CokkiesWrapper.UserName
            lblUserGroup.Text = getUserGroupNameFromID(CokkiesWrapper.UserID)
            lblUserName.Text = getUserNameFromID(CokkiesWrapper.UserID)
        End If

    End Sub
    Private Function getUserGroupNameFromID(ByVal groupId As Integer) As String
        Try
            obj.ConnectionString = con
            Dim qry As String = "SELECT [userGroup] FROM [dbo].[tbl_userGroups] WHERE [userGroupId]=" & groupId
            Dim ds As DataSet = obj.ExecuteDsQRY(qry)

            If ds.Tables(0).Rows.Count > 0 Then
                Return ds.Tables(0).Rows(0).Item("userGroup")
            Else
                Return ""
            End If
        Catch ex As Exception
            Return ""
        End Try

    End Function


    Private Function getUserNameFromID(ByVal userId As Integer) As String
        Try
            obj.ConnectionString = con
            Dim qry As String = "SELECT  userid  FROM tbl_systemUsers WHERE id =" & userId
            Dim ds As DataSet = obj.ExecuteDsQRY(qry)

            If ds.Tables(0).Rows.Count > 0 Then
                Return ds.Tables(0).Rows(0).Item("userid")
            Else
                Return ""
            End If
        Catch ex As Exception
            Return ""
        End Try

    End Function




End Class