Imports System
Imports System.Collections.Generic
Imports System.Text
Imports System.Data
Imports System.Data.SqlClient
Imports System.Collections
Imports System.Configuration
Imports System.Web
Imports Microsoft.Practices.EnterpriseLibrary.Data

Public Class LibraryBookLending

    Private Shared ReadOnly log As log4net.ILog = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType)
    Protected db As Database
    Public ReadOnly Property Database() As Microsoft.Practices.EnterpriseLibrary.Data.Database
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

    Private m_bookId As String
    Property bookId As String
        Get
            Return m_bookId
        End Get
        Set(ByVal value As String)
            m_bookId = value
        End Set
    End Property

    Private m_title As String
    Property title As String
        Get
            Return m_title
        End Get
        Set(ByVal value As String)
            m_title = value
        End Set
    End Property

    Private m_authour As String
    Property authour As String
        Get
            Return m_authour
        End Get
        Set(ByVal value As String)
            m_authour = value
        End Set
    End Property

    Private m_serialNumber As String
    Property serialNumber As String
        Get
            Return m_serialNumber
        End Get
        Set(ByVal value As String)
            m_serialNumber = value
        End Set
    End Property

    Private m_bookType As String
    Property bookType As String
        Get
            Return m_bookType
        End Get
        Set(ByVal value As String)
            m_bookType = value
        End Set
    End Property

    Private m_borrowerName As String
    Property borrowerName As String
        Get
            Return m_borrowerName
        End Get
        Set(ByVal value As String)
            m_borrowerName = value
        End Set
    End Property

    Private m_borrowerType As String
    Property borrowerType As String
        Get
            Return m_borrowerType
        End Get
        Set(ByVal value As String)
            m_borrowerType = value
        End Set
    End Property

    Private m_borrowerIdNumber As String
    Property borrowerIdNumber As String
        Get
            Return m_borrowerIdNumber
        End Get
        Set(ByVal value As String)
            m_borrowerIdNumber = value
        End Set
    End Property

    Private m_dateLoanedOut As String
    Property dateLoanedOut As String
        Get
            Return m_dateLoanedOut
        End Get
        Set(ByVal value As String)
            m_dateLoanedOut = value
        End Set
    End Property

    Private m_loanDays As String
    Property loanDays As String
        Get
            Return m_loanDays
        End Get
        Set(ByVal value As String)
            m_loanDays = value
        End Set
    End Property

    Private m_dueDate As Date
    Property dueDate As Date
        Get
            Return m_dueDate
        End Get
        Set(ByVal value As Date)
            m_dueDate = value
        End Set
    End Property

    Private m_returnDate As Date
    Property returnDate As Date
        Get
            Return m_returnDate
        End Get
        Set(ByVal value As Date)
            m_returnDate = value
        End Set
    End Property

    Private m_returnStatus As String
    Property returnStatus As String
        Get
            Return m_returnStatus
        End Get
        Set(ByVal value As String)
            m_returnStatus = value
        End Set
    End Property

    Private m_penaltyAmt As String
    Property penaltyAmt As String
        Get
            Return m_penaltyAmt
        End Get
        Set(ByVal value As String)
            m_penaltyAmt = value
        End Set
    End Property

    Private m_numberOfBooks As String
    Property numberOfBooks As String
        Get
            Return m_numberOfBooks
        End Get
        Set(ByVal value As String)
            m_numberOfBooks = value
        End Set
    End Property

    Private m_comments As String
    Property comments As String
        Get
            Return m_comments
        End Get
        Set(ByVal value As String)
            m_comments = value
        End Set
    End Property

    Private m_penaltyPaid As String
    Property penaltyPaid As String
        Get
            Return m_penaltyPaid
        End Get
        Set(ByVal value As String)
            m_penaltyPaid = value
        End Set
    End Property


    Public Sub Update()
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand("Update_tbl_libraryBookLending", conn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@bookId", bookId)
        cmd.Parameters.AddWithValue("@returnDate", returnDate)
        cmd.Parameters.AddWithValue("@returnStatus", returnStatus)
        cmd.Parameters.AddWithValue("@penaltyPaid", penaltyPaid)

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
        Dim cmd As New SqlCommand("Insert_tbl_libraryBookLending", conn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@bookId", bookId)
        cmd.Parameters.AddWithValue("@title", title)
        cmd.Parameters.AddWithValue("@authour", authour)
        cmd.Parameters.AddWithValue("@serialNumber", serialNumber)
        cmd.Parameters.AddWithValue("@bookType", bookType)
        cmd.Parameters.AddWithValue("@borrowerName", borrowerName)
        cmd.Parameters.AddWithValue("@borrowerType", borrowerType)
        cmd.Parameters.AddWithValue("@borrowerIdNumber", borrowerIdNumber)
        cmd.Parameters.AddWithValue("@dateLoanedOut", dateLoanedOut)
        cmd.Parameters.AddWithValue("@loanDays", loanDays)
        cmd.Parameters.AddWithValue("@dueDate", dueDate)
        '  cmd.Parameters.AddWithValue("@returnDate", returnDate)
        cmd.Parameters.AddWithValue("@returnStatus", returnStatus)
        cmd.Parameters.AddWithValue("@penaltyAmt", penaltyAmt)
        ' cmd.Parameters.AddWithValue("@numberOfBooks", numberOfBooks)
        cmd.Parameters.AddWithValue("@comments", comments)
        'cmd.Parameters.AddWithValue("@penaltyPaid", penaltyPaid)

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
        Dim cmd As New SqlCommand("Delete_tbl_libraryBookLending", conn)
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
        Dim sql As String = "  SELECT * FROM tbl_libraryBookLending"
        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            Return db.ExecuteDataSet(CommandType.Text, sql)
        Catch ex As Exception
            log.Error(ex)
            Return Nothing
        End Try
    End Function
End Class
