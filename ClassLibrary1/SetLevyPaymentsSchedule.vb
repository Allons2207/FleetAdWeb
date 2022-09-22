Imports System
Imports System.Collections.Generic
Imports System.Text
Imports System.Data
Imports System.Data.SqlClient
Imports System.Collections
Imports System.Configuration
Imports System.Web
Imports Microsoft.Practices.EnterpriseLibrary.Data

Public Class SetLevyPaymentsSchedule


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
    Private m_ConnectionString As String
    Property ConnectionString As String
        Get
            Return m_ConnectionString
        End Get
        Set(ByVal value As String)
            m_ConnectionString = value
        End Set
    End Property

 
    Private m_levyPaymentId As String
    Property levyPaymentId As String
        Get
            Return m_levyPaymentId
        End Get
        Set(ByVal value As String)
            m_levyPaymentId = value
        End Set
    End Property

    Private m_streamId As String
    Property streamId As String
        Get
            Return m_streamId
        End Get
        Set(ByVal value As String)
            m_streamId = value
        End Set
    End Property

    Private m_amountPerTerm As String
    Property amountPerTerm As String
        Get
            Return m_amountPerTerm
        End Get
        Set(ByVal value As String)
            m_amountPerTerm = value
        End Set
    End Property


    Public Sub Update(ByVal levyPaymentId As String, ByVal streamId As String, ByVal amountPerMonth As String)
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand("Update_tbl_setLevyPaymentsSchedule", conn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@levyPaymentId", levyPaymentId)
        cmd.Parameters.AddWithValue("@streamId", streamId)
        cmd.Parameters.AddWithValue("@amountPerMonth", amountPerMonth)

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
        Dim cmd As New SqlCommand("Insert_tbl_setLevyPaymentsSchedule", conn)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.AddWithValue("@streamId", streamId)
        cmd.Parameters.AddWithValue("@amountPerTerm", amountPerTerm)

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
        Dim cmd As New SqlCommand("Delete_tbl_setLevyPaymentsSchedule", conn)
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
        Dim sql As String = "select levyPaymentId, Stream, amountPerTerm from [dbo].[tbl_setLevyPaymentsSchedule] join tbl_streams on [tbl_setLevyPaymentsSchedule].streamId = tbl_streams.streamId"

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            Return db.ExecuteDataSet(CommandType.Text, sql)
        Catch ex As Exception
            log.Error(ex)
            Return Nothing
        End Try

    End Function

    Public Function GetLevy(ByVal Id As String) As DataSet

        Dim sql As String = "select * from [dbo].[tbl_setLevyPaymentsSchedule] join tbl_streams on [tbl_setLevyPaymentsSchedule].streamId = tbl_streams.streamId where [tbl_setLevyPaymentsSchedule].streamid = '" & Id & "'"
        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            Return db.ExecuteDataSet(CommandType.Text, sql)
        Catch ex As Exception
            log.Error(ex)
            Return Nothing
        End Try
    End Function
End Class

