Imports System
Imports System.Collections.Generic
Imports System.Text
Imports System.Data
Imports System.Data.SqlClient
Imports System.Collections
Imports System.Configuration
Imports System.Web
Imports Microsoft.Practices.EnterpriseLibrary.Data

Public Class ClassTimeTable

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
    Private m_dDay As String
    Property dDay As String
        Get
            Return m_dDay
        End Get
        Set(ByVal value As String)
            m_dDay = value
        End Set
    End Property

    Private m_periodNumber As String
    Property periodNumber As String
        Get
            Return m_periodNumber
        End Get
        Set(ByVal value As String)
            m_periodNumber = value
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

    Private m_class As String
    Property schClass As String
        Get
            Return m_class
        End Get
        Set(ByVal value As String)
            m_class = value
        End Set
    End Property

    Private m_subject As String
    Property subject As String
        Get
            Return m_subject
        End Get
        Set(ByVal value As String)
            m_subject = value
        End Set
    End Property

    Private m_dayNumba As String
    Property dayNumba As String
        Get
            Return m_dayNumba
        End Get
        Set(ByVal value As String)
            m_dayNumba = value
        End Set
    End Property
    Private m_TeacherCode As String
    Property TeacherCode As String
        Get
            Return m_TeacherCode
        End Get
        Set(ByVal value As String)
            m_TeacherCode = value
        End Set
    End Property

    Public Sub Update(ByVal dDay As String, ByVal periodNumber As String, ByVal stream As String, ByVal schClass As String, ByVal subject As String, ByVal dayNumba As String)
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand("Update_tbl_classTimeTable", conn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@dDay", dDay)
        cmd.Parameters.AddWithValue("@periodNumber", periodNumber)
        cmd.Parameters.AddWithValue("@stream", stream)
        cmd.Parameters.AddWithValue("@class", schClass)
        cmd.Parameters.AddWithValue("@subject", subject)
        cmd.Parameters.AddWithValue("@dayNumba", dayNumba)
        cmd.Parameters.AddWithValue("@TeacherCode", TeacherCode)
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
        Dim cmd As New SqlCommand("Insert_tbl_classTimeTable", conn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@dDay", dDay)
        cmd.Parameters.AddWithValue("@periodNumber", periodNumber)
        cmd.Parameters.AddWithValue("@stream", stream)
        cmd.Parameters.AddWithValue("@class", schClass)
        cmd.Parameters.AddWithValue("@subject", subject)
        cmd.Parameters.AddWithValue("@dayNumba", dayNumba)
        cmd.Parameters.AddWithValue("@TeacherCode", TeacherCode)

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

    Public Sub Delete(ByVal ID As String)
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand("Delete_tbl_classTimeTable", conn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@ID", ID)

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

    Public Function SelectRecords() As DataSet

        Dim sql As String = "select * from tbl_classTimeTable"

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            Return db.ExecuteDataSet(CommandType.Text, sql)
        Catch ex As Exception
            log.Error(ex)
            Return Nothing
        End Try
    End Function
End Class
