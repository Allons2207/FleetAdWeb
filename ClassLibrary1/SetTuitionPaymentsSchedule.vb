Imports System
Imports System.Collections.Generic
Imports System.Text
Imports System.Data
Imports System.Data.SqlClient
Imports System.Collections
Imports System.Configuration
Imports System.Web
Imports Microsoft.Practices.EnterpriseLibrary.Data


Public Class SetTuitionPaymentsSchedule

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

    Private m_streamId As String
    Property streamId As String
        Get
            Return m_streamId
        End Get
        Set(ByVal value As String)
            m_streamId = value
        End Set
    End Property

    Private m_amountPerMonth As String
    Property amountPerMonth As String
        Get
            Return m_amountPerMonth
        End Get
        Set(ByVal value As String)
            m_amountPerMonth = value
        End Set
    End Property

    Private m_amountPerExtraSubject As String
    Property amountPerExtraSubject As String
        Get
            Return m_amountPerExtraSubject
        End Get
        Set(ByVal value As String)
            m_amountPerExtraSubject = value
        End Set
    End Property

    Private m_computersFee As String
    Property computersFee As String
        Get
            Return m_computersFee
        End Get
        Set(ByVal value As String)
            m_computersFee = value
        End Set
    End Property


    Public Sub Update(ByVal streamId As String, ByVal amountPerMonth As String, ByVal amountPerExtraSubject As String, ByVal computersFee As String)
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand("Update_tbl_setTuitionPaymentsSchedule", conn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@streamId", streamId)
        cmd.Parameters.AddWithValue("@amountPerMonth", amountPerMonth)
        cmd.Parameters.AddWithValue("@amountPerExtraSubject", amountPerExtraSubject)
        cmd.Parameters.AddWithValue("@computersFee", computersFee)

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
        Dim cmd As New SqlCommand("Insert_tbl_setTuitionPaymentsSchedule", conn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@streamId", streamId)
        cmd.Parameters.AddWithValue("@amountPerMonth", amountPerMonth)
        cmd.Parameters.AddWithValue("@amountPerExtraSubject", amountPerExtraSubject)
        cmd.Parameters.AddWithValue("@computersFee", computersFee)

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
        Dim cmd As New SqlCommand("Delete_tbl_setTuitionPaymentsSchedule", conn)
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
        Dim sql As String = "select tuitionPaymentId,tbl_streams.stream, amountPerMonth, amountPerExtraSubject from [dbo].[tbl_setTuitionPaymentsSchedule] join tbl_streams on [tbl_setTuitionPaymentsSchedule].streamId = tbl_streams.streamId"

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            Return db.ExecuteDataSet(CommandType.Text, sql)
        Catch ex As Exception
            log.Error(ex)
            Return Nothing
        End Try
    End Function

    Public Function GetTuition(ByVal Id As String) As DataSet

        Dim sql As String = "select * from [dbo].[tbl_setTuitionPaymentsSchedule] join tbl_streams on [tbl_setTuitionPaymentsSchedule].streamId = tbl_streams.streamId where [tbl_setTuitionPaymentsSchedule].streamid = '" & Id & "'"
        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            Return db.ExecuteDataSet(CommandType.Text, sql)
        Catch ex As Exception
            log.Error(ex)
            Return Nothing
        End Try
    End Function


    Public Function GetTuitionByClass(ByVal streamId As Integer, ByVal classId As Integer) As DataSet
        ' Dim sql As String = "select * from [dbo].[tbl_setTuitionPaymentsSchedule] join tbl_streams on [tbl_setTuitionPaymentsSchedule].streamId = tbl_streams.streamId where [tbl_setTuitionPaymentsSchedule].streamid = '" & Id & "'"
        Dim strQry As String = "SELECT amountPerMonth FROM dbo.tbl_setTuitionPaymentsScheduleByClass WHERE (streamId = " & streamId & ") AND (classId = " & classId & ")"

        Try
            ' Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, strQry)
            Return db.ExecuteDataSet(CommandType.Text, strQry)
        Catch ex As Exception
            log.Error(ex)
            Return Nothing
        End Try


    End Function




End Class
