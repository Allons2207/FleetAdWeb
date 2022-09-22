' To my beloved Father L.M Nyakudya
' who raised me up to sail through the stormy seas
Imports System.DirectoryServices
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Public Class Login
    Inherits System.Web.UI.Page
   
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        CokkiesWrapper.ClearCookies()

        If Not IsPostBack Then
            If Not IsPostBack Then
                lblMessages.Text = ""
                'With cboOrganisation
                '    .DataSource = GetCentres()
                '    .DataValueField = "ConnectionText"
                '    .DataTextField = "ConnectionName"
                '    .DataBind()
                'End With
            End If
        End If

    End Sub

    Function AuthenticateUser(path As String, user As String, pass As String) As Boolean
        Dim de As New DirectoryEntry(path, user, pass, AuthenticationTypes.Secure)
        Try
            'run a search using those credentials.  
            'If it returns anything, then you're authenticated
            Dim ds As DirectorySearcher = New DirectorySearcher(de)
            ds.FindOne()
            '  ds.Filter

            ' Dim entry As New DirectoryEntry("LDAP://ADservername,<BR>   username,password")
            ' Dim mySearcher As New DirectorySearcher(entry)
            ' Dim results As New SearchResultCollection
            ' mySearcher.Filter ("name=value");
            'results = mySearcher.FindAll();
            ' e.g()
            'mySearcher.Filter  ("cn=jignesh");

            Return True
        Catch
            'otherwise, it will crash out so return false
            Return False
        End Try
    End Function
    Protected Sub cmdLogin_Click(sender As Object, e As EventArgs) Handles cmdLogin.Click

        If txtUsername.Text = "" Or txtpassword.Text = "" Then
            lblMessages.ForeColor = System.Drawing.Color.Red
            lblMessages.Text = "Please Enter Valid Password and Username to Login"
            Exit Sub
        End If

        CokkiesWrapper.ClearCookies()
        CokkiesWrapper.thisConnectionName = "FleetAd"

        Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
        Dim objUser As New SystemUsers(CokkiesWrapper.thisConnectionName)
        Dim db As Database = objUser.Database

        Try
            Dim de As New DirectoryEntry("LDAP://mimosa.co.zw", txtUsername.Text, txtpassword.Text, AuthenticationTypes.Secure)

            Dim ds As DirectorySearcher = New DirectorySearcher(de)
            ds.FindOne()

            Dim UserName As String = txtUsername.Text
            Response.Redirect("~/Dashboard.aspx")

            'Dim UserId As Integer = 0
            'Dim userGroup As Integer = 0
            ''    Dim strx As String = db.ConnectionString.ToString
            'Dim sql As String = "SELECT * FROM [dbo].[tbl_systemUsers] WHERE [userName] ='" & txtUsername.Text & "'"
            'Dim dst As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            'If (dst.Tables.Count > 0 AndAlso dst.Tables(0).Rows.Count > 0) Then
            '    UserId = dst.Tables(0).Rows(0).Item("userId")
            '    CokkiesWrapper.UserName = UserName
            '    CokkiesWrapper.UserID = UserId
            '    CokkiesWrapper.UserGroup = dst.Tables(0).Rows(0).Item("userGroupId")
            '    FormsAuthentication.RedirectFromLoginPage(CokkiesWrapper.UserName, True)
            '    obj.MessageLabel(lblMessages, "Welcome.", "Green")
            'Else
            '    lblMessages.ForeColor = System.Drawing.Color.Red
            '    lblMessages.Text = "User not found in Fleet Database."
            'End If
        Catch ex As Exception

        End Try

        'If AuthenticateUser("LDAP://mimosa.co.zw", txtUsername.Text, txtpassword.Text) = True Then

        '    CokkiesWrapper.ClearCookies()
        '    CokkiesWrapper.thisConnectionName = "FleetAd"      ' & cboOrganisation.SelectedValue

        '    If txtUsername.Text = "" Or txtpassword.Text = "" Then
        '        lblMessages.ForeColor = System.Drawing.Color.Red
        '        lblMessages.Text = "Enter Correct Password and Username to Login"
        '    Else
        '        '  Try

        '        'Dim UserName As String = "Admin"
        '        'Dim password As String = "337"
        '        'Dim UserId As Integer = "1"

        '        'Dim objUser As New SystemUsers(CokkiesWrapper.thisConnectionName)
        '        'Dim db As Database = objUser.Database

        '        'Dim strx As String = db.ConnectionString.ToString

        '        'CokkiesWrapper.UserName = UserName
        '        'CokkiesWrapper.UserID = UserId
        '        'CokkiesWrapper.UserGroup = "Administrator"

        '        'FormsAuthentication.RedirectFromLoginPage(CokkiesWrapper.UserName, True)

        '        '    '    Dim sql As String = "select UserGroupId, id, firstname, lastname from tbl_systemUsers where userid ='" & txtUsername.Text & "' AND [password] = '" & txtpassword.Text & "'"
        '        '    Dim sql As String = "SELECT [userId], [userFirstName], [userLastName], [userPassword] FROM [dbo].[tbl_users]"

        '        '    Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
        '        '    If (ds.Tables.Count > 0 AndAlso ds.Tables(0).Rows.Count > 0) Then
        '        '        Dim userId As Integer = ds.Tables(0).Rows(0).Item("userId")
        '        '        Dim strUserName As String = ds.Tables(0).Rows(0).Item("userFirstName") & " " & ds.Tables(0).Rows(0).Item("userLastName")
        '        '        ' Dim UserGroup As Integer = ds.Tables(0).Rows(0).Item("UserGroupId")

        '        '        Dim UserGroup As Integer = 1

        '        '        CokkiesWrapper.UserName = strUserName
        '        '        CokkiesWrapper.UserID = userId
        '        '        CokkiesWrapper.UserGroup = UserGroup

        '        FormsAuthentication.RedirectFromLoginPage(CokkiesWrapper.UserName, True)

        '        Response.Redirect("~/Default.aspx")

        '        '        'If UserGroup = 3 Then

        '        '        '    sql = "SELECT employmentNumber FROM tbl_StaffSystemUserIDs WHERE [UserId] = '" & userId & "'"
        '        '        '    ds = db.ExecuteDataSet(CommandType.Text, sql)

        '        '        '    If (ds.Tables.Count > 0 AndAlso ds.Tables(0).Rows.Count > 0) Then
        '        '        '        CokkiesWrapper.EmploymentNumber = ds.Tables(0).Rows(0).Item("employmentNumber")
        '        '        '        Response.Redirect("~/Default.aspx")
        '        '        '    Else
        '        '        '        lblMessages.Text = "Error logging in. Make sure the account is linked to a staff account"
        '        '        '    End If
        '        '        'Else
        '        '        '    Response.Redirect("~/Default.aspx")
        '        '        'End If

        '        '        Exit Sub
        '        '    Else
        '        '        lblMessages.Text = "Invalid Password"
        '        '    End If

        '        'Catch ex As Exception
        '        '    Dim xx As String
        '        '    xx = ex.Message.ToString

        '        '    lblMessages.Text = xx
        '        '    ' "Error while trying to login!"

        '        'End Try
        '    End If
        'Else
        '    lblMessages.Text = "Invalid Password"
        'End If

    End Sub

    Protected Sub txtUsername_TextChanged(sender As Object, e As EventArgs) Handles txtUsername.TextChanged
        clearLabel()
    End Sub

    Private Sub clearLabel()
        With lblMessages
            .Text = ""
            .BackColor = Drawing.Color.White
            .ForeColor = Drawing.Color.White
            .Text = ""
            .BorderStyle = BorderStyle.NotSet
        End With
    End Sub

    Protected Sub txtpassword_TextChanged(sender As Object, e As EventArgs) Handles txtpassword.TextChanged
        clearLabel()
    End Sub

End Class