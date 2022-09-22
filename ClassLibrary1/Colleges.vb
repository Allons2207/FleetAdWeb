Imports System
Imports System.Collections.Generic
Imports System.Text
Imports System.Data
Imports System.Data.SqlClient
Imports System.Collections
Imports System.Configuration
Imports System.Web
Imports Microsoft.Practices.EnterpriseLibrary.Data

Public Class Colleges

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

    Private ConnectionString As String

    Private m_collegeId As String
    Property collegeId As String
        Get
            Return m_collegeId
        End Get
        Set(ByVal value As String)
            m_collegeId = value
        End Set
    End Property

    Private m_college As String
    Property college As String
        Get
            Return m_college
        End Get
        Set(ByVal value As String)
            m_college = value
        End Set
    End Property

    Private m_contactNumber As String
    Property contactNumber As String
        Get
            Return m_contactNumber
        End Get
        Set(ByVal value As String)
            m_contactNumber = value
        End Set
    End Property

    Private m_collegeAddress As String
    Property collegeAddress As String
        Get
            Return m_collegeAddress
        End Get
        Set(ByVal value As String)
            m_collegeAddress = value
        End Set
    End Property


    Public Sub Update(ByVal collegeId As String, ByVal college As String, ByVal contactNumber As String, ByVal collegeAddress As String)
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand("Update_tbl_colleges", conn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@collegeId", collegeId)
        cmd.Parameters.AddWithValue("@college", college)
        cmd.Parameters.AddWithValue("@contactNumber", contactNumber)
        cmd.Parameters.AddWithValue("@collegeAddress", collegeAddress)

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

    Public Sub Insert(ByVal collegeId As String, ByVal college As String, ByVal contactNumber As String, ByVal collegeAddress As String)
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand("Insert_tbl_colleges", conn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@collegeId", collegeId)
        cmd.Parameters.AddWithValue("@college", college)
        cmd.Parameters.AddWithValue("@contactNumber", contactNumber)
        cmd.Parameters.AddWithValue("@collegeAddress", collegeAddress)

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
        Dim cmd As New SqlCommand("Delete_tbl_colleges", conn)
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

        Dim sql As String = "select * from [dbo].[tbl_colleges]"

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            Return db.ExecuteDataSet(CommandType.Text, sql)
        Catch ex As Exception
            log.Error(ex)
            Return Nothing
        End Try

    End Function
End Class
