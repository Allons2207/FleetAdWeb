Imports System
Imports System.Collections.Generic
Imports System.Text
Imports System.Data
Imports System.Data.SqlClient
Imports System.Collections
Imports System.Configuration
Imports System.Web
Imports Microsoft.Practices.EnterpriseLibrary.Data

Public Class ClassPeriods

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


    Private m_ctr As String
    Property ctr As String
        Get
            Return m_ctr
        End Get
        Set(ByVal value As String)
            m_ctr = value
        End Set
    End Property

    Private m_period As String
    Property period As String
        Get
            Return m_period
        End Get
        Set(ByVal value As String)
            m_period = value
        End Set
    End Property

    Private m_fromTime As String
    Property fromTime As String
        Get
            Return m_fromTime
        End Get
        Set(ByVal value As String)
            m_fromTime = value
        End Set
    End Property

    Private m_toTime As String
    Property toTime As String
        Get
            Return m_toTime
        End Get
        Set(ByVal value As String)
            m_toTime = value
        End Set
    End Property


    Public Sub Update(ByVal ctr As String, ByVal period As String, ByVal fromTime As String, ByVal toTime As String)
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand("Update_tbl_classPeriods", conn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@ctr", ctr)
        cmd.Parameters.AddWithValue("@period", period)
        cmd.Parameters.AddWithValue("@fromTime", fromTime)
        cmd.Parameters.AddWithValue("@toTime", toTime)

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

    Public Sub Insert(ByVal ctr As String, ByVal period As String, ByVal fromTime As String, ByVal toTime As String)
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand("Insert_tbl_classPeriods", conn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@ctr", ctr)
        cmd.Parameters.AddWithValue("@period", period)
        cmd.Parameters.AddWithValue("@fromTime", fromTime)
        cmd.Parameters.AddWithValue("@toTime", toTime)

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
        Dim cmd As New SqlCommand("Delete_tbl_classPeriods", conn)
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

        Dim sql As String = "select * from [dbo].[tbl_classPeriods]"

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            Return db.ExecuteDataSet(CommandType.Text, sql)
        Catch ex As Exception
            log.Error(ex)
            Return Nothing
        End Try

    End Function
    Public Function SelectRecords(ByVal period As Integer) As DataSet

        Dim sql As String = "select * from [dbo].[tbl_classPeriods] where period = " & period

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            Return db.ExecuteDataSet(CommandType.Text, sql)
        Catch ex As Exception
            log.Error(ex)
            Return Nothing
        End Try

    End Function
End Class

