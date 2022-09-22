Imports System
Imports System.Collections.Generic
Imports System.Text
Imports System.Data
Imports System.Data.SqlClient
Imports System.Collections
Imports System.Configuration
Imports System.Web
Imports Microsoft.Practices.EnterpriseLibrary.Data

Public Class studentTuitionPayments

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

    Private m_narrative As String
    Property narrative As String
        Get
            Return m_narrative
        End Get
        Set(ByVal value As String)
            m_narrative = value
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

    Private m_strMonth As String
    Property strMonth As String
        Get
            Return m_strMonth
        End Get
        Set(ByVal value As String)
            m_strMonth = value
        End Set
    End Property

    Private m_billingDate As Date
    Property billingDate As Date
        Get
            Return m_billingDate
        End Get
        Set(ByVal value As Date)
            m_billingDate = value
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

    Private m_stream As String
    Property stream As String
        Get
            Return m_stream
        End Get
        Set(ByVal value As String)
            m_stream = value
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



    Private m_class As String
    Property classid As String
        Get
            Return m_class
        End Get
        Set(ByVal value As String)
            m_class = value
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


    Public Sub Update(ByVal studentId As String, ByVal intYear As String, ByVal strMonth As String, ByVal expectedAmt As String, ByVal amountPaid As String, ByVal monthNumber As String)
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand("Update_tbl_tuitionPayments", conn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@studentId", studentId)
        cmd.Parameters.AddWithValue("@intYear", intYear)
        cmd.Parameters.AddWithValue("@strMonth", strMonth)
        cmd.Parameters.AddWithValue("@expectedAmt", expectedAmt)
        cmd.Parameters.AddWithValue("@amountPaid", amountPaid)
        cmd.Parameters.AddWithValue("@monthNumber", monthNumber)
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
        Dim cmd As New SqlCommand("Insert_tbl_tuitionPayments", conn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@studentId", studentId)
        cmd.Parameters.AddWithValue("@intYear", intYear)
        cmd.Parameters.AddWithValue("@strMonth", strMonth)
        cmd.Parameters.AddWithValue("@expectedAmt", expectedAmt)
        cmd.Parameters.AddWithValue("@amountPaid", amountPaid)
        cmd.Parameters.AddWithValue("@monthNumber", monthNumber)
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
        Dim cmd As New SqlCommand("Delete_tbl_tuitionPayments", conn)
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
        Dim sql As String = "select * from tbl_tuitionPayments where studentId = '" & Id & "'"

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            Return db.ExecuteDataSet(CommandType.Text, sql)
        Catch ex As Exception
            log.Error(ex)
            Return Nothing
        End Try
    End Function


    Public Function selectScheduledPaymentEntry(ByVal Id As String) As DataSet

        ' Dim sql As String = "SELECT TOP 1 * FROM [dbo].[tbl_tuitionPayments] WHERE [studentId] = '" & Id & "' AND [monthNumber] <= month(getdate()) ORDER BY  [monthNumber] DESC, [tuitionPaymentId] DESC"
        Dim sql As String = "SELECT TOP 1 * FROM [dbo].[tbl_tuitionPayments] WHERE [studentId] = '" & Id & "' ORDER BY [tuitionPaymentId] DESC"
        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            Return db.ExecuteDataSet(CommandType.Text, sql)
        Catch ex As Exception
            log.Error(ex)
            Return Nothing
        End Try
    End Function

    Public Function selectedTuitionReceiptDetails(ByVal receiptID As String) As DataSet
        Dim sql As String = "SELECT        dbo.tbl_tuitionPayments.studentId, dbo.tbl_streams.stream, dbo.tbl_schoolClasses.schoolClass, dbo.tbl_tuitionPayments.intYear, " & _
                        " dbo.tbl_tuitionPayments.strMonth, dbo.tbl_tuitionPayments.expectedAmt, dbo.tbl_tuitionPayments.amountPaid, " & _
                        " dbo.tbl_tuitionPayments.expectedAmt - dbo.tbl_tuitionPayments.amountPaid AS balance, dbo.tbl_tuitionPayments.monthNumber, " & _
                        " dbo.tbl_tuitionPayments.date, dbo.tbl_tuitionPayments.penalty, dbo.tbl_tuitionPayments.tuitionPaymentId, " & _
                        " dbo.tbl_students.firstName + ' ' + dbo.tbl_students.surname AS student, dbo.tbl_students.registrationDate, " & _
                        " dbo.tbl_students.dateOfBirth, dbo.tbl_students.homeAddress, dbo.tbl_tuitionPayments.receiptNumber, dbo.tbl_allPayments.cashier " & _
                        " FROM            dbo.tbl_tuitionPayments INNER JOIN " & _
                        "  dbo.tbl_students ON dbo.tbl_tuitionPayments.studentId = dbo.tbl_students.studentId INNER JOIN " & _
                        "  dbo.tbl_schoolClasses ON dbo.tbl_students.schoolClassId = dbo.tbl_schoolClasses.schoolClassId INNER JOIN " & _
                        "   dbo.tbl_streams ON dbo.tbl_schoolClasses.streamId = dbo.tbl_streams.streamId INNER JOIN " & _
                        "   dbo.tbl_allPayments ON dbo.tbl_tuitionPayments.receiptNumber = dbo.tbl_allPayments.receiptNumber " & _
                        " WHERE tbl_allPayments.receiptNumber = '" & receiptID & "' "
        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            Return db.ExecuteDataSet(CommandType.Text, sql)
        Catch ex As Exception
            log.Error(ex)
            Return Nothing
        End Try

    End Function

End Class