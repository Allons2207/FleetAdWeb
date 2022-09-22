Imports System
Imports System.Collections.Generic
Imports System.Text
Imports System.Data
Imports System.Data.SqlClient
Imports System.Collections
Imports System.Configuration
Imports System.Web
Imports Microsoft.Practices.EnterpriseLibrary.Data

Public Class TransportPayments

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

    Private m_yYear As String
    Property yYear As String
        Get
            Return m_yYear
        End Get
        Set(ByVal value As String)
            m_yYear = value
        End Set
    End Property

    Private m_mMonth As String
    Property mMonth As String
        Get
            Return m_mMonth
        End Get
        Set(ByVal value As String)
            m_mMonth = value
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

    Private m_setAmount As String
    Property setAmount As String
        Get
            Return m_setAmount
        End Get
        Set(ByVal value As String)
            m_setAmount = value
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

    Private m_receiptNumber As String
    Property receiptNumber As String
        Get
            Return m_receiptNumber
        End Get
        Set(ByVal value As String)
            m_receiptNumber = value
        End Set
    End Property


    Public Sub Update(ByVal yYear As String, ByVal mMonth As String, ByVal studentId As String, ByVal setAmount As String, ByVal amountPaid As String, ByVal receiptNumber As String)
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand("Update_tbl_transportPayments", conn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@yYear", yYear)
        cmd.Parameters.AddWithValue("@mMonth", mMonth)
        cmd.Parameters.AddWithValue("@studentId", studentId)
        cmd.Parameters.AddWithValue("@setAmount", setAmount)
        cmd.Parameters.AddWithValue("@amountPaid", amountPaid)
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
        Dim cmd As New SqlCommand("Insert_tbl_transportPayments", conn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@yYear", yYear)
        cmd.Parameters.AddWithValue("@mMonth", mMonth)
        cmd.Parameters.AddWithValue("@studentId", studentId)
        cmd.Parameters.AddWithValue("@setAmount", setAmount)
        cmd.Parameters.AddWithValue("@amountPaid", amountPaid)
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

    Public Function InsertAmountPaid() As Integer

        InsertAmountPaid = 0

        Dim qrySTR As String = "Update tbl_transportPayments SET [amountPaid] =  " & amountPaid & ",  receiptNumber = '" & receiptNumber & "'" & _
                                " WHERE ([studentId] = '" & studentId & "' AND [yYear] = " & yYear & " AND [mMonth] = '" & mMonth & "') "

        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand(qrySTR, conn)
        cmd.CommandType = CommandType.Text

        Try
            conn.Open()
            cmd.ExecuteNonQuery()
            Return 1
        Catch
            Return 0
        Finally
            If conn.State = ConnectionState.Open Then conn.Close()
            conn.Dispose()
            cmd.Dispose()
        End Try

    End Function

    Public Sub Delete(ByVal ID As String)
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand("Delete_tbl_transportPayments", conn)
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

        Dim sql As String = "select * from [dbo].[tbl_transportPayments] where studentId = '" & Id & "'"

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            Return db.ExecuteDataSet(CommandType.Text, sql)
        Catch ex As Exception
            log.Error(ex)
            Return Nothing
        End Try

    End Function

End Class

