Imports System
Imports System.Collections.Generic
Imports System.Text
Imports System.Data
Imports System.Data.SqlClient
Imports System.Collections
Imports System.Configuration
Imports System.Web
Imports Microsoft.Practices.EnterpriseLibrary.Data

Public Class AttendanceRegister
    Private Shared ReadOnly log As log4net.ILog = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType)
    Protected db As Database
    Public ReadOnly Property Database() As Database
        Get
            Return db
        End Get
    End Property
    Protected mConnectionName As String
    Public ReadOnly Property ConnectionName() As String
        Get
            Return mConnectionName
        End Get
    End Property

    Public Sub New(ByVal ConnectionName As String)

        mConnectionName = ConnectionName
        Dim factory As DatabaseProviderFactory = New DatabaseProviderFactory()
        db = factory.Create(ConnectionName)

    End Sub

    Private mConnectionString As String
    Property ConnectionString As String
        Get
            Return mConnectionString
        End Get
        Set(ByVal value As String)
            mConnectionString = value
        End Set
    End Property

    Private m_dtDate As Date
    Property dtDate As Date
        Get
            Return m_dtDate
        End Get
        Set(ByVal value As Date)
            m_dtDate = value
        End Set
    End Property

    Private m_stream As String
    Property stream As String
        Get
            Return m_stream
        End Get
        Set(ByVal value As String)
            m_stream = value
        End Set
    End Property

    Private m_schClass As String
    Property schClass As String
        Get
            Return m_schClass
        End Get
        Set(ByVal value As String)
            m_schClass = value
        End Set
    End Property

    Private m_studentId As String
    Property studentId As String
        Get
            Return m_studentId
        End Get
        Set(ByVal value As String)
            m_studentId = value
        End Set
    End Property

    Private m_attendance As Boolean
    Property attendance As Boolean
        Get
            Return m_attendance
        End Get
        Set(ByVal value As Boolean)
            m_attendance = value
        End Set
    End Property

    Private m_comments As String
    Property comments As String
        Get
            Return m_comments
        End Get
        Set(ByVal value As String)
            m_comments = value
        End Set
    End Property


    Public Sub Update(ByVal dtDate As String, ByVal stream As String, ByVal schClass As String, ByVal studentId As String, ByVal attendance As String, ByVal comments As String)
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand("Update_tbl_classAttendanceRegister", conn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@dtDate", dtDate)
        cmd.Parameters.AddWithValue("@stream", stream)
        cmd.Parameters.AddWithValue("@schClass", schClass)
        cmd.Parameters.AddWithValue("@studentId", studentId)
        cmd.Parameters.AddWithValue("@attendance", attendance)
        cmd.Parameters.AddWithValue("@comments", comments)

        Try
            conn.Open()
            cmd.ExecuteNonQuery()
        Catch
        Finally
            If conn.State = ConnectionState.Open Then conn.Close()
            conn.Dispose()
            cmd.Dispose()
        End Try
    End Sub

    Public Sub Insert()
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand("Insert_tbl_classAttendanceRegister", conn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@dtDate", dtDate)
        cmd.Parameters.AddWithValue("@stream", stream)
        cmd.Parameters.AddWithValue("@schClass", schClass)
        cmd.Parameters.AddWithValue("@studentId", studentId)
        cmd.Parameters.AddWithValue("@attendance", attendance)
        cmd.Parameters.AddWithValue("@comments", comments)

        Try
            conn.Open()
            cmd.ExecuteNonQuery()
        Catch ex As Exception

        Finally
            If conn.State = ConnectionState.Open Then conn.Close()
            conn.Dispose()
            cmd.Dispose()
        End Try
    End Sub

    Public Function SelectRecords() As DataSet

        Dim sql As String = "select * from [dbo].[classAttendanceRegister] where studentId = '" & schClass & "'"

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            Return db.ExecuteDataSet(CommandType.Text, sql)
        Catch ex As Exception
            log.Error(ex)
            Return Nothing
        End Try
    End Function
End Class

