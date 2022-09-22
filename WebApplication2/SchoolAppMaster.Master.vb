
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing
Imports ClassLibrary1
Imports Telerik.Web.UI
Public Class SchoolAppMaster
    Inherits System.Web.UI.MasterPage
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString
    Dim ds As DataSet
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        lblUserName.Text = "Logged in As: " & " " & CokkiesWrapper.UserName
        ' If Front Office

        For Each x As RadMenuItem In RadMenu1.Items
            Select Case x.Text
                Case "Vehicles"
                    x.Enabled = False
                Case ""
            End Select
        Next

        Dim sql As String = ""

        Try
            For Each x As RadMenuItem In RadMenu1.Items
                Select Case x.Text
                    Case "Vehicles"
                        x.Enabled = checkUserModule(1)
                    Case "Tyre Management"
                        x.Enabled = checkUserModule(2)
                    Case "Allocation"
                        x.Enabled = checkUserModule(3)
                    Case "Inspections"
                        x.Enabled = checkUserModule(4)
                    Case "Mileage Updates"
                        x.Enabled = checkUserModule(5)
                    Case "Trip Logging"
                        x.Enabled = checkUserModule(6)
                    Case "Licensing"
                        x.Enabled = checkUserModule(7)
                        x.Enabled = checkUserModule(8)
                        x.Enabled = checkUserModule(9)
                    Case "Accidents/Incidents"
                        x.Enabled = checkUserModule(10)
                    Case "Maintenance"
                        x.Enabled = checkUserModule(11)
                    Case "Vehicle Users"
                        x.Enabled = checkUserModule(12)
                    Case "Write Offs"
                        x.Enabled = checkUserModule(13)
                    Case "Vehicle Disposal"
                        x.Enabled = checkUserModule(14)
                    Case "Reports"
                        x.Enabled = checkUserModule(1)
                    Case "Administration"
                        x.Enabled = checkUserModule(15)
                        x.Enabled = checkUserModule(16)
                    Case "Fuelling"
                        x.Enabled = checkUserModule(17)
                End Select
            Next


            '6	Trip Logging	Page
          

            '11	Vehicle Servicing/Maintenance	Page
            '12	Vehicle User/Driver Details	Page
            '13	Vehicle Write Offs	Page
            '14	Vehicle Disposal	Page
            '15	User Management	Page
            '16	Parameter Management	Page
            'NULL	NULL	NULL



        Catch ex As Exception

        End Try

    End Sub

    Protected Sub RadMenu1_ItemClick(sender As Object, e As Telerik.Web.UI.RadMenuEventArgs) Handles RadMenu1.ItemClick

    End Sub
    Private Function checkUserModule(moduleId As Integer) As Boolean
        checkUserModule = False

        Dim sql As String = "SELECT * FROM [tbl_userSysPermissions] WHERE userId = '" & CokkiesWrapper.UserID & "' AND [sysModuleSectionId] = " & moduleId
        obj.ConnectionString = con
        Dim ds As DataSet = obj.ExecuteDsQRY(sql)
        If ds.Tables(0).Rows.Count > 0 Then
            checkUserModule = True
        End If

    End Function
    Private Sub lnkLogout_Click(sender As Object, e As EventArgs) Handles lnkLogout.Click

        FormsAuthentication.SignOut()

        CokkiesWrapper.ClearCookies()

        Session.Abandon()

        Dim authCookie As HttpCookie = New HttpCookie(FormsAuthentication.FormsCookieName, "")
        authCookie.Expires = DateTime.Now.AddYears(-1)
        Response.Cookies.Add(authCookie)

        Dim sessionCookie As HttpCookie = New HttpCookie("ASP.NET_SessionId", "")
        sessionCookie.Expires = DateTime.Now.AddYears(-1)
        Response.Cookies.Add(sessionCookie)

        FormsAuthentication.RedirectToLoginPage()

        HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.NoCache)

    End Sub
End Class