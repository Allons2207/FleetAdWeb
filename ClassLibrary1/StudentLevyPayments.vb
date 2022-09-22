Imports System
Imports System.Collections.Generic
Imports System.Text
Imports System.Data
Imports System.Data.SqlClient
Imports System.Collections
Imports System.Configuration
Imports System.Web
Imports Microsoft.Practices.EnterpriseLibrary.Data

Public Class StudentLevyPayments
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
    Private m_studentd As String
    Property studentd As String
        Get
            Return m_studentd
        End Get
        Set(ByVal value As String)
            m_studentd = value
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
    Property classid As String
        Get
            Return m_class
        End Get
        Set(ByVal value As String)
            m_class = value
        End Set
    End Property

    Private m_intYear As String
    Property intYear As String
        Get
            Return m_intYear
        End Get
        Set(ByVal value As String)
            m_intYear = value
        End Set
    End Property

    Private m_strTerm As String
    Property strTerm As String
        Get
            Return m_strTerm
        End Get
        Set(ByVal value As String)
            m_strTerm = value
        End Set
    End Property

    Private m_expectedAmt As String
    Property expectedAmt As String
        Get
            Return m_expectedAmt
        End Get
        Set(ByVal value As String)
            m_expectedAmt = value
        End Set
    End Property

    Private m_amountPaid As String
    Property amountPaid As String
        Get
            Return m_amountPaid
        End Get
        Set(ByVal value As String)
            m_amountPaid = value
        End Set
    End Property

    Private m_penalty As String
    Property penalty As String
        Get
            Return m_penalty
        End Get
        Set(ByVal value As String)
            m_penalty = value
        End Set
    End Property

    Private m_TermNumber As String
    Property TermNumber As String
        Get
            Return m_TermNumber
        End Get
        Set(ByVal value As String)
            m_TermNumber = value
        End Set
    End Property

    Private m_receiptNumber As String
    Property receiptNumber As String
        Get
            Return m_receiptNumber
        End Get
        Set(ByVal value As String)
            m_receiptNumber = value
        End Set
    End Property


    Public Sub Update(ByVal studentd As String, ByVal intYear As String, ByVal strTerm As String, ByVal expectedAmt As String, ByVal amountPaid As String, ByVal TermNumber As String)
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand("Update_tbl_LevyPayments", conn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@studentd", studentd)
        cmd.Parameters.AddWithValue("@intYear", intYear)
        cmd.Parameters.AddWithValue("@strTerm", strTerm)
        cmd.Parameters.AddWithValue("@expectedAmt", expectedAmt)
        cmd.Parameters.AddWithValue("@amountPaid", amountPaid)
        cmd.Parameters.AddWithValue("@TermNumber", TermNumber)
        cmd.Parameters.AddWithValue("@receiptNumber", receiptNumber)

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
        Dim cmd As New SqlCommand("Insert_tbl_LevyPayments", conn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@studentd", studentd)
        cmd.Parameters.AddWithValue("@intYear", intYear)
        cmd.Parameters.AddWithValue("@strTerm", strTerm)
        cmd.Parameters.AddWithValue("@expectedAmt", expectedAmt)
        cmd.Parameters.AddWithValue("@amountPaid", amountPaid)
        cmd.Parameters.AddWithValue("@TermNumber", TermNumber)
        cmd.Parameters.AddWithValue("@penalty", penalty)
        cmd.Parameters.AddWithValue("@receiptNumber", receiptNumber)

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
        Dim cmd As New SqlCommand("Delete_tbl_LevyPayments", conn)
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

    Public Function SelectRecords(ByVal Id As String) As DataSet
        Dim sql As String = "select * from tbl_LevyPayments where studentd = '" & Id & "'"

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            Return db.ExecuteDataSet(CommandType.Text, sql)
        Catch ex As Exception
            log.Error(ex)
            Return Nothing
        End Try

    End Function


    Public Function selectLastScheduledPaymentEntry(ByVal Id As String) As DataSet
        Dim sql As String = "SELECT TOP 1 * FROM [dbo].[tbl_LevyPayments] WHERE [studentd] = '" & Id & "' AND [intYear] = year(getdate()) ORDER BY [levyPaymentId]  DESC, [termNumber] DESC"

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            Return db.ExecuteDataSet(CommandType.Text, sql)
        Catch ex As Exception
            log.Error(ex)
            Return Nothing
        End Try

    End Function


End Class

