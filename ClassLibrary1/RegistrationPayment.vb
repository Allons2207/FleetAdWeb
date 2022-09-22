Imports System
Imports System.Collections.Generic
Imports System.Text
Imports System.Data
Imports System.Data.SqlClient
Imports System.Collections
Imports System.Configuration
Imports System.Web
Imports Microsoft.Practices.EnterpriseLibrary.Data

Public Class RegistrationPayment

    Public Property ErrorMessage As String = String.Empty
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

    Private m_ctr As String
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

    Private m_studentId As String
    Property studentId As String
        Get
            Return m_studentId
        End Get
        Set(ByVal value As String)
            m_studentId = value
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

    Private m_monthNumber As String
    Property monthNumber As String
        Get
            Return m_monthNumber
        End Get
        Set(ByVal value As String)
            m_monthNumber = value
        End Set
    End Property

    Private m_Regdate As String
    Property Regdate As String
        Get
            Return m_Regdate
        End Get
        Set(ByVal value As String)
            m_Regdate = value
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

    Private m_registrationPaymentID As String
    Property registrationPaymentID As String
        Get
            Return m_registrationPaymentID
        End Get
        Set(ByVal value As String)
            m_registrationPaymentID = value
        End Set
    End Property


    Public Sub Update(ByVal studentId As String, ByVal intYear As String, ByVal expectedAmt As String, ByVal amountPaid As String, ByVal monthNumber As String, ByVal Regdate As String, ByVal penalty As String, ByVal registrationPaymentID As String)
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand("Update_tbl_RegistrationPayments", conn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@studentId", studentId)
        cmd.Parameters.AddWithValue("@intYear", intYear)
        cmd.Parameters.AddWithValue("@expectedAmt", expectedAmt)
        cmd.Parameters.AddWithValue("@amountPaid", amountPaid)
        cmd.Parameters.AddWithValue("@monthNumber", monthNumber)
        cmd.Parameters.AddWithValue("@date", Regdate)
        cmd.Parameters.AddWithValue("@penalty", penalty)
        cmd.Parameters.AddWithValue("@registrationPaymentID", registrationPaymentID)

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
        Dim cmd As New SqlCommand("Insert_tbl_RegistrationPayments", conn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@studentId", studentId)
        cmd.Parameters.AddWithValue("@intYear", intYear)
        cmd.Parameters.AddWithValue("@expectedAmt", expectedAmt)
        cmd.Parameters.AddWithValue("@amountPaid", amountPaid)
        cmd.Parameters.AddWithValue("@monthNumber", monthNumber)
        cmd.Parameters.AddWithValue("@date", m_Regdate)
        cmd.Parameters.AddWithValue("@penalty", penalty)
        cmd.Parameters.AddWithValue("@registrationPaymentID", registrationPaymentID)

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
        Dim cmd As New SqlCommand("Delete_tbl_RegistrationPayments", conn)
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
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlDataAdapter("SELECT * FROM Select_tbl_RegistrationPayments", conn)
        Dim dts As New DataSet()

        Try
            conn.Open()
            cmd.Fill(dts)
            Return dts
        Catch
            Return Nothing
        Finally
            If conn.State = ConnectionState.Open Then conn.Close()
            conn.Dispose()
            cmd.Dispose()
        End Try
    End Function
End Class

