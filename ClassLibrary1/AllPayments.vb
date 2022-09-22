Imports System
Imports System.Collections.Generic
Imports System.Text
Imports System.Data
Imports System.Data.SqlClient
Imports System.Collections
Imports System.Configuration
Imports System.Web
Imports Microsoft.Practices.EnterpriseLibrary.Data

Public Class AllPayments

    Private Shared ReadOnly log As log4net.ILog = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType)

    Private mConnectionString As String
    Property ConnectionString As String
        Get
            Return mConnectionString
        End Get
        Set(ByVal value As String)
            mConnectionString = value
        End Set
    End Property

    Protected mConnectionName As String
    Public ReadOnly Property ConnectionName() As String
        Get
            Return mConnectionName
        End Get
    End Property
    Protected db As Database
    Public ReadOnly Property Database() As Database
        Get
            Return db
        End Get
    End Property

    Public Sub New(ByVal ConnectionName As String)

        mConnectionName = ConnectionName
        Dim factory As DatabaseProviderFactory = New DatabaseProviderFactory()
        db = factory.Create(ConnectionName)

    End Sub


    Private m_paymentId As String
    Property paymentId As String
        Get
            Return m_paymentId
        End Get
        Set(ByVal value As String)
            m_paymentId = value
        End Set
    End Property

    Private m_payment As String
    Property payment As String
        Get
            Return m_payment
        End Get
        Set(ByVal value As String)
            m_payment = value
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

    Private m_studentId As String
    Property studentId As String
        Get
            Return m_studentId
        End Get
        Set(ByVal value As String)
            m_studentId = value
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

    Private m_dtDate As String
    Property dtDate As String
        Get
            Return m_dtDate
        End Get
        Set(ByVal value As String)
            m_dtDate = value
        End Set
    End Property

    Private m_details As String
    Property details As String
        Get
            Return m_details
        End Get
        Set(ByVal value As String)
            m_details = value
        End Set
    End Property

    Private m_cashier As String
    Property cashier As String
        Get
            Return m_cashier
        End Get
        Set(ByVal value As String)
            m_cashier = value
        End Set
    End Property

    Private m_paymentMethod As String
    Property paymentMethod As String
        Get
            Return m_paymentMethod
        End Get
        Set(ByVal value As String)
            m_paymentMethod = value
        End Set
    End Property

    Public Sub Update()
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand("Update_tbl_allPayments", conn)
        cmd.CommandType = CommandType.StoredProcedure
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
        Dim cmd As New SqlCommand("Insert_tbl_allPayments", conn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@payment", payment)
        cmd.Parameters.AddWithValue("@amountPaid", amountPaid)
        cmd.Parameters.AddWithValue("@studentId", studentId)
        cmd.Parameters.AddWithValue("@dtDate", dtDate)
        cmd.Parameters.AddWithValue("@details", details)
        cmd.Parameters.AddWithValue("@cashier", cashier)
        cmd.Parameters.AddWithValue("@receiptNumber", receiptNumber)
        cmd.Parameters.AddWithValue("@paymentMethod", paymentMethod)

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
        Dim cmd As New SqlCommand("Delete_tbl_allPayments", conn)
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

    Public Function GetReceipt(ByVal id As Integer) As DataSet

        Dim sql As String = "select * from [dbo].[tbl_allPayments] where receiptNumber =" & id & ""

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            Return db.ExecuteDataSet(CommandType.Text, sql)
        Catch ex As Exception
            log.Error(ex)
            Return Nothing
        End Try

    End Function

    Public Function SelectRecords() As DataSet

        Dim sql As String = "select * from [dbo].[tbl_allPayments]"

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            Return db.ExecuteDataSet(CommandType.Text, sql)
        Catch ex As Exception
            log.Error(ex)
            Return Nothing
        End Try

    End Function


End Class

