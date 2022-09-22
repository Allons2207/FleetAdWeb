Public Class myModalFormTest
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Page.ClientScript.RegisterStartupScript(Me.GetType, "Summary", "$('#login-modal').modal('show');", True)
    End Sub

End Class