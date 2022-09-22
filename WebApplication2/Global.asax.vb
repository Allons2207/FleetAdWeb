Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.Security.Principal
Imports System.Threading
Imports System.Net
Imports System.Diagnostics
Imports System.Collections
Imports System.ComponentModel
Imports System.Web
Imports ClassLibrary1
Imports System.Web.Mail
Imports System.Web.Caching
Imports System.Web.SessionState
Imports System.IO
Imports System.Messaging
Imports Microsoft.Practices.EnterpriseLibrary.Data

Public Class Global_asax
        Inherits System.Web.HttpApplication

    Private Const DummyPageUrl As String = "http://192.168.2.211:100/WebForm1.aspx"
    Private Const CONNECTION_STRING As String = "Data Source=DEV-ONEBOX;Initial Catalog=AXDB;User ID=fleetad;Password=@Mimosa123"
        Private Const LOG_FILE As String = "C:\inetpub\wwwroot\FleetAdDash\FleetAd\Cache.txt"
        Private Const MSMQ_NAME As String = ".\private$\ASPNET"
        Private Const DummyCacheItemKey As String = "GagaGuguGigi"
        Public Shared _JobQueue As ArrayList = New ArrayList()
        Private components As System.ComponentModel.IContainer = Nothing

        Public Sub New()
            InitializeComponent()
        End Sub

        Protected Sub Application_Start(ByVal sender As Object, ByVal e As EventArgs)
            RegisterCacheEntry()
        End Sub

    Private Sub RegisterCacheEntry()
        If HttpContext.Current.Cache(DummyCacheItemKey) IsNot Nothing Then Return
        HttpContext.Current.Cache.Add(DummyCacheItemKey, "Test", Nothing, DateTime.MaxValue, TimeSpan.FromMinutes(1), CacheItemPriority.NotRemovable, New CacheItemRemovedCallback(AddressOf CacheItemRemovedCallback))
    End Sub

    Public Sub CacheItemRemovedCallback(ByVal key As String, ByVal value As Object, ByVal reason As CacheItemRemovedReason)
            Debug.WriteLine("Cache item callback: " & DateTime.Now.ToString())
            DoWork()
            HitPage()
        End Sub

        Private Sub HitPage()
            Dim client As WebClient = New WebClient()
            client.DownloadData(DummyPageUrl)
        End Sub

        Private Sub DoWork()
            Debug.WriteLine("Begin DoWork...")
            Debug.WriteLine("Running as: " & WindowsIdentity.GetCurrent().Name)
            DoSomeFileWritingStuff()
            DoSomeDatabaseOperation()
            DoSomeEmailSendStuff()
            DoSomeMSMQStuff()
            ExecuteQueuedJobs()
            Debug.WriteLine("End DoWork...")
        End Sub

        Private Sub ExecuteQueuedJobs()
            Dim jobs As ArrayList = New ArrayList()

            For Each job In _JobQueue
                If job.ExecutionTime <= DateTime.Now Then jobs.Add(job)
            Next

            For Each job In jobs

                SyncLock _JobQueue
                    _JobQueue.Remove(job)
                End SyncLock

                job.Execute()
            Next
        End Sub

        Private Sub DoSomeFileWritingStuff()
            Debug.WriteLine("Writing to file...")

            Try

                Using writer As StreamWriter = New StreamWriter(LOG_FILE, True)
                    writer.WriteLine("Cache Callback: {0}", DateTime.Now)
                    writer.Close()
                End Using

            Catch x As Exception
                Debug.WriteLine(x)
            End Try

            Debug.WriteLine("File write successful")
        End Sub

        Private Sub DoSomeDatabaseOperation()
            Debug.WriteLine("Connecting to database...")

            Using con As SqlConnection = New SqlConnection(CONNECTION_STRING)
                con.Open()

                Using cmd As SqlCommand = New SqlCommand("INSERT INTO ASPNETServiceLog VALUES (@Message, @DateTime)", con)
                    cmd.Parameters.Add("@Message", SqlDbType.VarChar, 1024).Value = "Hi I'm the ASP NET Service"
                    cmd.Parameters.Add("@DateTime", SqlDbType.DateTime).Value = DateTime.Now
                    cmd.ExecuteNonQuery()
                End Using

                con.Close()
            End Using

            Debug.WriteLine("Database connection successful")
        End Sub

    Private Sub DoSomeEmailSendStuff()



        Using con As SqlConnection = New SqlConnection(CONNECTION_STRING)
            con.Open()
            Dim users As List(Of String) = New List(Of String)

            Dim cmd As SqlCommand = New SqlCommand("select * from tblBUSSCHEEDULE")
            Dim cmd1 As SqlCommand = New SqlCommand("SELECT DISTINCT i.ID, i.Username, k.Description, dbo.tblUsers.Mail
FROM            dbo.tbluserrole AS i INNER JOIN
                         dbo.tblROLES AS k ON i.ROLE = k.ID INNER JOIN
                         dbo.tblUsers ON i.Username = dbo.tblUsers.Description
WHERE        (k.Description = 'Traffic Controller')")
            cmd1.Connection = con
            cmd.Connection = con
            Try

                Dim adapter As SqlDataAdapter = New SqlDataAdapter(cmd)
                Dim adapter1 As SqlDataAdapter = New SqlDataAdapter(cmd1)
                Dim ds As New DataSet
                Dim sd As New DataSet
                adapter1.Fill(sd)
                adapter.Fill(ds)

                If sd IsNot Nothing And sd.Tables.Count > 0 And sd.Tables(0).Rows.Count > 0 Then
                    For Each row As DataRow In sd.Tables(0).Rows
                        'add the mail address
                        users.Add(row("Mail"))
                    Next row
                Else

                End If
                Dim dt As DataTable = ds.Tables(0)
                For i As Integer = 0 To dt.Rows.Count - 1
                    Dim starttime As String = dt.Rows(i)("SCESTAT").ToString

                    Dim splitcheck = Split(starttime, ":")
                    Dim ax = TimeOfDay
                    Dim axc = ax.ToString("hh:mm:ss")

                    Dim nowtime = Split(axc, ":")

                    Dim checkMinutes, currentMinutes As Integer

                    checkMinutes = CDbl(splitcheck(0)) * 60 + CDbl(splitcheck(1)) + CDbl(splitcheck(2)) / 60
                    currentMinutes = CDbl(nowtime(0)) * 60 + CDbl(nowtime(1)) + CDbl(nowtime(2)) / 60

                    Dim balance = checkMinutes - currentMinutes

                    If balance = 15 Then
                        Dim user As String = "mazanit@mimosa.co.zw"
                        Dim subject As String = "Bus Schedule Alert"
                        Dim body As String = "The is a bus scheduled to go to the Mine in 15 minutes"
                        Dim mailSender As MailSender = New MailSender()
                        mailSender.sendMailWithBody(users, "", "", body, subject)
                    ElseIf balance < 15 And balance > 0 Then
                        Dim user As String = "mazanit@mimosa.co.zw"
                        Dim subject As String = "Bus Schedule Alert"
                        Dim body As String = "The is a bus scheduled to go to the Mine in  '" & balance & "' minutes"
                        Dim mailSender As MailSender = New MailSender()
                        mailSender.sendMailWithBody(users, "", "", body, subject)


                    End If
                Next
            Catch ex As Exception

            End Try


            con.Close()
        End Using


    End Sub

    Private Sub DoSomeMSMQStuff()
            Using queue As MessageQueue = New MessageQueue(MSMQ_NAME)
                queue.Send(DateTime.Now)
                queue.Close()
            End Using
        End Sub

        Protected Sub Session_Start(ByVal sender As Object, ByVal e As EventArgs)
        End Sub

        Protected Sub Application_BeginRequest(ByVal sender As Object, ByVal e As EventArgs)
            If HttpContext.Current.Request.Url.ToString() = DummyPageUrl Then
                RegisterCacheEntry()
            End If
        End Sub

        Protected Sub Application_EndRequest(ByVal sender As Object, ByVal e As EventArgs)
        End Sub

        Protected Sub Application_AuthenticateRequest(ByVal sender As Object, ByVal e As EventArgs)
        End Sub

        Protected Sub Application_Error(ByVal sender As Object, ByVal e As EventArgs)
            Debug.WriteLine(Server.GetLastError())
        End Sub

        Protected Sub Session_End(ByVal sender As Object, ByVal e As EventArgs)
        End Sub

        Protected Sub Application_End(ByVal sender As Object, ByVal e As EventArgs)
        End Sub

        Private Sub InitializeComponent()
            Me.components = New System.ComponentModel.Container()
        End Sub
    End Class

