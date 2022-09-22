Public Class StudentsPortalMaster
    Inherits System.Web.UI.MasterPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        lblUserName.Text = "Logged in As: " & " " & CokkiesWrapper.UserName

        ' If Front Office

    End Sub

    Protected Sub RadMenu1_ItemClick(sender As Object, e As Telerik.Web.UI.RadMenuEventArgs) Handles RadMenu1.ItemClick

    End Sub

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