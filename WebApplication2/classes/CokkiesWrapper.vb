Imports System.ComponentModel
Public Class CokkiesWrapper
#Region "Variables"

    Private Shared mGotNothing As Boolean

    Private mStudentID As String
    Private mUserID As String
    Private mUserGroup As Integer
    Private mEmploymentNumber As String

    Public Shared NON_CLEARABLE_COOKIES As String = "ConnectionName,StudentID,UserID,UserName"

#End Region

#Region "Properties"
    Public ReadOnly Property GotNothing() As Boolean
        Get
            GotNothing = mGotNothing
        End Get
    End Property

#End Region

    <Description("Gets or sets a Connection Name saved into the ConnectionName cookie.")> _
    Public Shared Property thisConnectionName() As String
        Get
            Return GetCookie("thisConnectionName", "Test")
        End Get
        Set(ByVal Value As String)
            AddCookie("thisConnectionName", Value)
        End Set
    End Property

    Public Shared Property StudentID() As String
        Get
            Return GetCookie("studentId", 1)
        End Get
        Set(ByVal Value As String)
            AddCookie("studentId", Value)
        End Set
    End Property

    Public Shared Property ReportID() As Long
        Get
            Return GetCookie("ReportID", "0")
        End Get
        Set(ByVal Value As Long)
            AddCookie("ReportID", Value)
        End Set
    End Property

    Public Shared Property UserID() As Long
        Get
            Return GetCookie("id", 0)
        End Get
        Set(ByVal Value As Long)
            AddCookie("id", Value)
        End Set
    End Property


   
    Public Shared Property UserName() As String
        Get
            Return GetCookie("UserName", "")
        End Get
        Set(ByVal Value As String)
            AddCookie("UserName", Value)
        End Set
    End Property

    Public Shared Property UserGroup() As String
        Get
            Return GetCookie("UserGroup", "")
        End Get
        Set(ByVal Value As String)
            AddCookie("UserGroup", Value)
        End Set
    End Property

    Public Shared Property EmploymentNumber() As String
        Get
            Return GetCookie("EmploymentNumber", "")
        End Get
        Set(ByVal Value As String)
            AddCookie("EmploymentNumber", Value)
        End Set
    End Property

#Region "Private Methods"

    Shared Sub AddCookie(ByVal Key, ByVal Value)

        'Dim objCookie As New HttpCookie(Key, Value)

        'objCookie.Path = "/"

        'Dim rqCookies As HttpCookieCollection = HttpContext.Current.Request.Cookies
        'Dim rsCookies As HttpCookieCollection = HttpContext.Current.Response.Cookies

        'While rqCookies.Get(Key) IsNot Nothing : rqCookies.Remove(Key) : End While
        'rsCookies.Remove(Key)

        'If rqCookies.Get(Key) IsNot Nothing Then
        '    rqCookies.Set(objCookie)
        'Else
        '    rqCookies.Add(objCookie)
        'End If

        Dim objCookie As New HttpCookie(Key, Value)

        objCookie.Path = "/"

        Dim rqCookies As HttpCookieCollection = HttpContext.Current.Request.Cookies
        Dim rsCookies As HttpCookieCollection = HttpContext.Current.Response.Cookies

        While rqCookies.Get(Key) IsNot Nothing : rqCookies.Remove(Key) : End While
        rsCookies.Remove(Key)

        If rqCookies.Get(Key) IsNot Nothing Then
            rqCookies.Set(objCookie)
        Else
            rqCookies.Add(objCookie)
        End If

        If rsCookies.Get(Key) IsNot Nothing Then
            rsCookies.Set(objCookie)
        Else
            rsCookies.Add(objCookie)
        End If


    End Sub

    Shared Function GetCookie(ByVal Key, ByVal ValueIfNothing)

        If HttpContext.Current.Request.Cookies(Key) Is Nothing Then
            mGotNothing = True
            GetCookie = ValueIfNothing
        Else
            mGotNothing = False
            GetCookie = HttpContext.Current.Request.Cookies(Key).Value
        End If
    End Function

    Public Shared Sub ClearCookies()

        'For Each de As DictionaryEntry In HttpContext.Current.Cache
        '    HttpContext.Current.Cache.Remove(DirectCast(de.Key, String))
        'Next

        Try

            For Each objCookie As HttpCookie In HttpContext.Current.Request.Cookies
                If CanClearCookie(objCookie.Name) Then
                    HttpContext.Current.Request.Cookies.Remove(objCookie.Name)
                    HttpContext.Current.Response.Cookies.Remove(objCookie.Name)
                End If
            Next


        Catch ex As Exception

        End Try



        ' HttpResponse.RemoveOutputCacheItem("/MakePayment.aspx")




        HttpRuntime.Close()

    End Sub

    Private Shared Function CanClearCookie(ByVal CookieName As String) As Boolean

        Return Not Array.IndexOf(NON_CLEARABLE_COOKIES.Split(","), CookieName) >= 0

    End Function

#End Region
End Class
