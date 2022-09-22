Imports System.DirectoryServices
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Data.SqlClient
Imports System.Data
Imports System.Data.SqlClient.SqlConnection
Imports Microsoft.VisualBasic
Imports System.Configuration
Imports System.IO

Public Class Index1
    Inherits System.Web.UI.Page

    Public Sub ErrorMessage(ByVal Control As UI.Control, ByVal Message As String, Optional ByVal Title As String = "Alert", Optional ByVal callback As String = "")
        Try
            ScriptManager.RegisterStartupScript(Control, Control.GetType, "Script", "swal('" + Title + "','" + Message + "','error');", True)
        Catch ex As Exception
        End Try
    End Sub

    Public Sub Message(ByVal Control As UI.Control, ByVal Message As String, Optional ByVal Title As String = "Alert", Optional ByVal callback As String = "")
        Try
            ScriptManager.RegisterStartupScript(Control, Control.GetType, "Script", "swal('" + Title + "','" + Message + "','success');", True)
        Catch ex As Exception
        End Try
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Page.ClientScript.RegisterClientScriptInclude("jQuery", "https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js")
        Page.ClientScript.RegisterClientScriptInclude("jQuery", "https://code.jquery.com/jquery-3.6.0.js")
        Page.ClientScript.RegisterClientScriptInclude("jQuery", "/assets/js/core/bootstrap.min.js")
        Page.ClientScript.RegisterClientScriptInclude("jQuery", "https://unpkg.com/sweetalert/dist/sweetalert.min.js")
        Page.ClientScript.RegisterClientScriptInclude("jQuery", "https://unpkg.com/sweetalert/dist/sweetalert.min.js")
        CokkiesWrapper.ClearCookies()

        If Not IsPostBack Then
            If Not IsPostBack Then
                'lblMessages.Text = ""
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
    Protected Sub cmdLogin_Click(sender As Object, e As EventArgs) Handles Button1.Click

        If username.Text = "" Or password.Text = "" Then

            Exit Sub
        End If

        CokkiesWrapper.ClearCookies()
        CokkiesWrapper.thisConnectionName = "FleetAd"

        Dim aaxx As DataTable = New DataTable
        Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
        Dim objUser As New SystemUsers(CokkiesWrapper.thisConnectionName)
        Dim db As Database = objUser.Database
        CokkiesWrapper.UserName = username.Text
        Dim names As String = "Names"
        Dim mails As String = "Email"
        aaxx.Columns.Add(names, GetType(String))
        aaxx.Columns.Add(mails, GetType(String))
        Dim de As New DirectoryEntry("LDAP://mimosa.co.zw", username.Text, password.Text, AuthenticationTypes.Secure)


        Dim Domain = "//mimosa.co.zw"
        Dim password1 = password.Text
        Dim user = username.Text

        Dim success As Boolean = False
        Using domainEntry As New DirectoryEntry("LDAP:" & Domain, user, password1)
            Using searcher As New DirectorySearcher(domainEntry)
                searcher.SearchScope = SearchScope.Subtree
                Try
                    Dim result As SearchResult = searcher.FindOne
                    Dim aa = result
                    success = result IsNot Nothing
                    searcher.Filter = "(&(objectCategory=User)(objectClass=person))"
                    Using results As SearchResultCollection = searcher.FindAll
                        Dim user1 As DirectoryEntry = Nothing
                        For Each result1 As SearchResult In results
                            user1 = result1.GetDirectoryEntry
                            Dim props = user1.Properties("samaccountname").Value
                            Dim prop = user1.Properties("mail").Value
                            Dim pro = user1.Properties("title").Value

                            aaxx.Rows.Add(props, prop)
                        Next
                    End Using
                    Dim consString As String = db.ConnectionString
                    Using con As New SqlConnection(consString)
                        Using sqlBulkCopy As New SqlBulkCopy(con)


                        End Using
                    End Using

                    FormsAuthentication.RedirectFromLoginPage(CokkiesWrapper.UserName, True)





                Catch ex As Exception

                    Message(Me, "Failed", "Login")

                End Try


            End Using
        End Using







    End Sub

    Private Function ValidateActiveDirectoryLogin(ByVal Domain As String, ByVal Username As String, ByVal Password As String) As Boolean
        Try
            Dim success As Boolean = False
            Using domainEntry As New DirectoryEntry("LDAP:" & Domain, Username, Password)
                Using searcher As New DirectorySearcher(domainEntry)
                    searcher.SearchScope = SearchScope.OneLevel
                    Try
                        Dim result As SearchResult = searcher.FindOne

                    Catch ex As Exception
                        success = False
                    End Try
                End Using
            End Using

            Return success

        Catch ex As Exception

        End Try
    End Function


    Protected Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click

    End Sub

End Class