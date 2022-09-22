Imports System
Imports System.Collections.Generic
Imports System.Text
Imports System.Data
Imports System.Data.SqlClient
Imports System.Collections
Imports System.Configuration
Imports System.Web
Imports Microsoft.Practices.EnterpriseLibrary.Data

Public Class LibraryBooks
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

    Private m_bookId As String
    Property bookId As String
        Get
            Return m_bookId
        End Get
        Set(ByVal value As String)
            m_bookId = value
        End Set
    End Property

    Private m_bookTitle As String
    Property bookTitle As String
        Get
            Return m_bookTitle
        End Get
        Set(ByVal value As String)
            m_bookTitle = value
        End Set
    End Property

    Private m_authorFirstName As String
    Property authorFirstName As String
        Get
            Return m_authorFirstName
        End Get
        Set(ByVal value As String)
            m_authorFirstName = value
        End Set
    End Property

    Private m_authorSurname As String
    Property authorSurname As String
        Get
            Return m_authorSurname
        End Get
        Set(ByVal value As String)
            m_authorSurname = value
        End Set
    End Property

    Private m_subjectId As String
    Property subjectId As String
        Get
            Return m_subjectId
        End Get
        Set(ByVal value As String)
            m_subjectId = value
        End Set
    End Property

    Private m_level1 As String
    Property level1 As String
        Get
            Return m_level1
        End Get
        Set(ByVal value As String)
            m_level1 = value
        End Set
    End Property

    Private m_level2 As String
    Property level2 As String
        Get
            Return m_level2
        End Get
        Set(ByVal value As String)
            m_level2 = value
        End Set
    End Property

    Private m_version As String
    Property version As String
        Get
            Return m_version
        End Get
        Set(ByVal value As String)
            m_version = value
        End Set
    End Property

    Private m_yearPublished As String
    Property yearPublished As String
        Get
            Return m_yearPublished
        End Get
        Set(ByVal value As String)
            m_yearPublished = value
        End Set
    End Property

    Private m_availability As String
    Property availability As String
        Get
            Return m_availability
        End Get
        Set(ByVal value As String)
            m_availability = value
        End Set
    End Property

    Private m_lendingDays As String
    Property lendingDays As String
        Get
            Return m_lendingDays
        End Get
        Set(ByVal value As String)
            m_lendingDays = value
        End Set
    End Property

    Private m_bookTypeId As String
    Property bookTypeId As String
        Get
            Return m_bookTypeId
        End Get
        Set(ByVal value As String)
            m_bookTypeId = value
        End Set
    End Property

    Private m_supplierId As String
    Property supplierId As String
        Get
            Return m_supplierId
        End Get
        Set(ByVal value As String)
            m_supplierId = value
        End Set
    End Property

    Private m_conditionId As String
    Property conditionId As String
        Get
            Return m_conditionId
        End Get
        Set(ByVal value As String)
            m_conditionId = value
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

    Private m_dateSupplied As String
    Property dateSupplied As Date
        Get
            Return m_dateSupplied
        End Get
        Set(ByVal value As Date)
            m_dateSupplied = value
        End Set
    End Property


    Public Sub Update()
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand("Update_tbl_libraryBooks", conn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@bookId", bookId)
        cmd.Parameters.AddWithValue("@availability", availability)

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
        Dim cmd As New SqlCommand("Insert_tbl_libraryBooks", conn)
        cmd.CommandType = CommandType.StoredProcedure
        'cmd.Parameters.AddWithValue("@ctr", ctr)
        cmd.Parameters.AddWithValue("@bookId", bookId)
        cmd.Parameters.AddWithValue("@bookTitle", bookTitle)
        cmd.Parameters.AddWithValue("@authorFirstName", authorFirstName)
        cmd.Parameters.AddWithValue("@authorSurname", authorSurname)
        cmd.Parameters.AddWithValue("@subjectId", subjectId)
        cmd.Parameters.AddWithValue("@level1", level1)
        cmd.Parameters.AddWithValue("@level2", level2)
        cmd.Parameters.AddWithValue("@version", version)
        cmd.Parameters.AddWithValue("@yearPublished", yearPublished)
        cmd.Parameters.AddWithValue("@availability", availability)
        cmd.Parameters.AddWithValue("@lendingDays", lendingDays)
        cmd.Parameters.AddWithValue("@bookTypeId", bookTypeId)
        cmd.Parameters.AddWithValue("@supplierId", supplierId)
        cmd.Parameters.AddWithValue("@conditionId", conditionId)
        cmd.Parameters.AddWithValue("@serialNumber", serialNumber)
        cmd.Parameters.AddWithValue("@dateSupplied", dateSupplied)

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
        Dim cmd As New SqlCommand("Delete_tbl_libraryBooks", conn)
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
        Dim sql As String = "  SELECT * FROM tbl_libraryBooks"
        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            Return db.ExecuteDataSet(CommandType.Text, sql)
        Catch ex As Exception
            log.Error(ex)
            Return Nothing
        End Try
    End Function
    Public Function SelectBooks() As DataSet
        Dim sql As String = " SELECT bookId, bookTitle [Book Title], authorFirstName [Author FirstName], authorSurname [Author Surname], [Subject], stream, BV.version, yearPublished [Year Published], availability, lendingDays, bookType, supplier,bookCondition, serialNumber [Serial Number], dateSupplied [Date Supplied] FROM tbl_libraryBooks LB left outer join tbl_streams S on LB.level1 = S.streamId left outer join tbl_subjects Su on LB.subjectId=Su.subjectId left outer join tbl_bookTypes BT on LB.bookTypeId = BT.bookTypeId left outer join tbl_bookVersions BV on LB.version = BV.versionId left outer join tbl_suppliers BS on LB.supplierId= BS.supplierId left outer join tbl_bookCondition BC on LB.conditionId = BC.bookConditionId where bookId like '%" & bookId & "%' and authorFirstName like '%" & authorFirstName & "%' and authorSurname like '%" & authorSurname & "%' and bookTitle like '%" & bookTitle & "%' and level1 like '%" & level1 & "%' and serialNumber like '%" & serialNumber & "%' and yearPublished like '%" & yearPublished & "%' and LB.subjectId like '%" & subjectId & "%' and LB.bookTypeId like '%%' "
        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            Return db.ExecuteDataSet(CommandType.Text, sql)
        Catch ex As Exception
            log.Error(ex)
            Return Nothing
        End Try
    End Function

End Class

