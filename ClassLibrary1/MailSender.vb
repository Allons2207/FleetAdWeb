Imports System.Net
Imports System.Net.Mail
Imports System.Net.Security
Imports System.Security.Cryptography.X509Certificates

Public Class MailSender
    Public Sub sendMailWithBody(ByVal addresses As List(Of String), ByVal name As String, ByVal sname As String, ByVal body As String, ByVal subject As String)
        Try
            Dim m As MailModel = New MailModel()
            Dim fullname As String = name & " " & sname
            Dim mail As MailMessage = New MailMessage()
            mail.IsBodyHtml = True
            Dim SmtpServer As SmtpClient = New SmtpClient(m.smtp_server)
            mail.From = New MailAddress(m.sending_mail)
            For Each address As String In addresses
                mail.[To].Add(address.ToString())
            Next
            mail.Subject = subject
            'mail.Body = "Dear " & fullname & body & vbLf & vbLf & "Regards"
            mail.Body = "Dear Sir/Madam <br>" & body & "<br> Regards"

            Dim state As Object = mail

            SmtpServer.Port = m.smtp_port
            SmtpServer.Credentials = New System.Net.NetworkCredential(m.sending_mail, m.sender_pass)
            SmtpServer.EnableSsl = m.enable_ssl
            NEVER_EAT_POISON_Disable_CertificateValidation()
            SmtpServer.Send(mail)
            'SmtpServer.SendAsync(mail, state)
        Catch ex As Exception
            Console.Write(ex)
        End Try
    End Sub
    Private Shared Sub NEVER_EAT_POISON_Disable_CertificateValidation()
        ServicePointManager.ServerCertificateValidationCallback = Function(ByVal s As Object, ByVal certificate As X509Certificate, ByVal chain As X509Chain, ByVal sslPolicyErrors As SslPolicyErrors) True
    End Sub

    Private Sub smtpClient_SendCompleted(ByVal sender As Object, ByVal e As System.ComponentModel.AsyncCompletedEventArgs)
        Dim mail As MailMessage = TryCast(e.UserState, MailMessage)

        If Not e.Cancelled AndAlso e.[Error] IsNot Nothing Then
            'Message.Text = "Mail sent successfully"
            Console.WriteLine("Mail Send")
        End If
    End Sub

    Private Sub sendSingleMail()

    End Sub
End Class
