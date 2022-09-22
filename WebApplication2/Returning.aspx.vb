Public Class Returning
    Inherits System.Web.UI.Page

    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (CokkiesWrapper.UserID <= 0 AndAlso Not IsNumeric(CokkiesWrapper.UserID)) Then
            Response.Redirect("../Login.aspx")
            Exit Sub
        End If
    End Sub

End Class