Imports System
Imports System.Collections.Generic
Imports System.Text
Imports System.Data
Imports System.Data.SqlClient
Imports System.Collections
Imports System.Configuration
Imports System.Web
Imports Microsoft.Practices.EnterpriseLibrary.Data

Public Class CashBookEntries
    Private Shared ReadOnly log As log4net.ILog = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType)
    Protected db As Database

    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)

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




    Private m_CashBookEntryId As String
    Property CashBookEntryId As String
        Get
            Return m_CashBookEntryId
        End Get
        Set(ByVal value As String)
            m_CashBookEntryId = value
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

    Private m_opening As Double
    Property opening As Double
        Get
            Return m_opening
        End Get
        Set(ByVal value As Double)
            m_opening = value
        End Set
    End Property

    Private m_closing As Double
    Property closing As Double
        Get
            Return m_closing
        End Get
        Set(ByVal value As Double)
            m_closing = value
        End Set
    End Property


    Private m_incoming As Double
    Property incoming As Double
        Get
            Return m_incoming
        End Get
        Set(ByVal value As Double)
            m_incoming = value
        End Set
    End Property

    Private m_outgoing As Double
    Property outgoing As Double
        Get
            Return m_outgoing
        End Get
        Set(ByVal value As Double)
            m_outgoing = value
        End Set
    End Property
    Private m_balance As Double
    Property balance As Double
        Get
            Return m_balance
        End Get
        Set(ByVal value As Double)
            m_balance = value
        End Set
    End Property


    Private m_narration As String
    Property narration As String
        Get
            Return m_narration
        End Get
        Set(ByVal value As String)
            m_narration = value
        End Set
    End Property

    Private m_capturedBy As String
    Property capturedBy As String
        Get
            Return m_capturedBy
        End Get
        Set(ByVal value As String)
            m_capturedBy = value
        End Set
    End Property

    Public Sub InsertOpening()
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand("insert_tbl_cashBook_opening", conn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@entryNumber", 0)
        cmd.Parameters.AddWithValue("@dtDate", CDate(dtDate))
        cmd.Parameters.AddWithValue("@opening", opening)
        cmd.Parameters.AddWithValue("@balance", balance)
        cmd.Parameters.AddWithValue("@narration", narration)
        cmd.Parameters.AddWithValue("@capturedBy", capturedBy)

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


    Public Sub InsertClosing()
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand("insert_tbl_cashBook_closing", conn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@entryNumber", 0)
        cmd.Parameters.AddWithValue("@dtDate", CDate(dtDate))
        cmd.Parameters.AddWithValue("@closing", closing)
        cmd.Parameters.AddWithValue("@balance", balance)
        cmd.Parameters.AddWithValue("@narration", narration)
        cmd.Parameters.AddWithValue("@capturedBy", capturedBy)

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


    Public Sub InsertIncoming()
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand("insert_tbl_cashBook_incoming", conn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@entryNumber", 0)
        cmd.Parameters.AddWithValue("@dtDate", CDate(dtDate))
        cmd.Parameters.AddWithValue("@incoming", incoming)
        cmd.Parameters.AddWithValue("@balance", balance)
        cmd.Parameters.AddWithValue("@narration", narration)
        cmd.Parameters.AddWithValue("@capturedBy", capturedBy)

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


    Public Sub InsertOutgoing()
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand("insert_tbl_cashBook_outgoing", conn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@entryNumber", 0)
        cmd.Parameters.AddWithValue("@dtDate", CDate(dtDate))
        cmd.Parameters.AddWithValue("@outgoing", outgoing)
        cmd.Parameters.AddWithValue("@balance", balance)
        cmd.Parameters.AddWithValue("@narration", narration)
        cmd.Parameters.AddWithValue("@capturedBy", capturedBy)

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
    Public Function fnGetCashBookBalance() As Long
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand("SELECT TOP 1 balance FROM tbl_CashBook ORDER BY entryNumber DESC", conn)
        Dim dt As DataTable
        Dim bal As Long
        ' Dim queryString = "SELECT TOP 1 balance FROM tbl_CashBook ORDER BY entryNumber DESC"

        'Using conn As OdbcConnection = New OdbcConnection(queryString)

        cmd.CommandType = CommandType.Text


        Dim sql As String = "SELECT TOP 1 balance FROM tbl_CashBook ORDER BY entryNumber DESC"

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            ' Return db.ExecuteDataSet(CommandType.Text, sql)
            dt = ds.Tables(0)
            If dt.Rows.Count > 0 Then
                fnGetCashBookBalance = Val(dt.Rows(0).Item("balance").ToString)
            Else
                fnGetCashBookBalance = 0
            End If
        Catch ex As Exception
            log.Error(ex)
            Return Nothing
        End Try

    End Function

    Public Function fnGetCashBookOpening(dtDate As Date) As Long

        Dim conn As New SqlConnection(ConnectionString)
        Dim dtDet As String

        'Dim sql = "SELECT TOP 1 opening FROM tbl_CashBook WHERE opening > 0 AND (" & _
        '   " datepart('yyyy',dtDate) =" & DatePart(DateInterval.Year, dtDate) & _
        '   " AND datepart('m',dtDate) = " & DatePart(DateInterval.Month, dtDate) & _
        '   " AND datepart('d',dtDate) = " & DatePart(DateInterval.Day, dtDate) & ")  ORDER BY entryNumber DESC"

        dtDet = DatePart(DateInterval.Year, dtDate) & "/" & DatePart(DateInterval.Month, dtDate) & "/" & DatePart(DateInterval.Day, dtDate)

        Dim sql = "SELECT TOP 1 opening FROM tbl_CashBook WHERE opening > 0 AND dtDate = '" & dtDet & "'  ORDER BY entryNumber DESC"

        Dim cmd As New SqlCommand(sql, conn)

        Dim dt As DataTable
        ' Dim bal As Long
        ' Dim queryString = "SELECT TOP 1 balance FROM tbl_CashBook ORDER BY entryNumber DESC"

        'Using conn As OdbcConnection = New OdbcConnection(queryString)

        cmd.CommandType = CommandType.Text

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            ' Return db.ExecuteDataSet(CommandType.Text, sql)
            dt = ds.Tables(0)
            If dt.Rows.Count > 0 Then
                fnGetCashBookOpening = Val(dt.Rows(0).Item("opening").ToString)
            Else
                fnGetCashBookOpening = 0
            End If
        Catch ex As Exception
            log.Error(ex)
            Return Nothing
        End Try

    End Function

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
