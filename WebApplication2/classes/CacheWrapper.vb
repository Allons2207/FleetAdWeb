Public Class CacheWrapper

    Public Shared Property ReportsCache() As DataSet

        Get

            Dim ds As DataSet = HttpContext.Current.Cache(CokkiesWrapper.thisConnectionName & "ReportsCache")

            If IsNothing(ds) Then

                Dim db As Microsoft.Practices.EnterpriseLibrary.Data.Database = New Microsoft.Practices.EnterpriseLibrary.Data.DatabaseProviderFactory().Create(CokkiesWrapper.thisConnectionName)
                ds = db.ExecuteDataSet(CommandType.Text, "SELECT * FROM tblReports")

                ' Dim xx As String = CokkiesWrapper.UserID

                HttpContext.Current.Cache(CokkiesWrapper.thisConnectionName & "ReportsCache") = ds

            End If

            Return ds

        End Get

        Set(ByVal value As DataSet)

            If IsNothing(value) Then
                HttpContext.Current.Cache.Remove(CokkiesWrapper.thisConnectionName & "ReportsCache")
            Else
                HttpContext.Current.Cache(CokkiesWrapper.thisConnectionName & "ReportsCache") = value
            End If

        End Set

    End Property

End Class
