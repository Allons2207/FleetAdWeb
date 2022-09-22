Imports System
Imports System.Collections.Generic
Imports System.Text
Imports System.Data
Imports System.Data.SqlClient
Imports System.Collections
Imports System.Configuration
Imports System.Web
Imports Microsoft.Practices.EnterpriseLibrary.Data

Public Class SystemUsers

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
        Try
            mConnectionName = ConnectionName
            Dim factory As DatabaseProviderFactory = New DatabaseProviderFactory()
            db = factory.Create(ConnectionName)
        Catch ex As Exception

        End Try


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

    Private m_userId As String
    Property userId As String
        Get
            Return m_userId
        End Get
        Set(ByVal value As String)
            m_userId = value
        End Set
    End Property

    Private m_firstName As String
    Property firstName As String
        Get
            Return m_firstName
        End Get
        Set(ByVal value As String)
            m_firstName = value
        End Set
    End Property

    Private m_lastName As String
    Property lastName As String
        Get
            Return m_lastName
        End Get
        Set(ByVal value As String)
            m_lastName = value
        End Set
    End Property

    Private m_active As String
    Property active As String
        Get
            Return m_active
        End Get
        Set(ByVal value As String)
            m_active = value
        End Set
    End Property

    Private m_password As String
    Property password As String
        Get
            Return m_password
        End Get
        Set(ByVal value As String)
            m_password = value
        End Set
    End Property

    Private m_userGroupId As String
    Property userGroupId As String
        Get
            Return m_userGroupId
        End Get
        Set(ByVal value As String)
            m_userGroupId = value
        End Set
    End Property


    Public Sub Update(ByVal userId As String, ByVal firstName As String, ByVal lastName As String, ByVal active As String, ByVal password As String, ByVal userGroupId As String)
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand("Update_tbl_systemUsers", conn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@userId", userId)
        cmd.Parameters.AddWithValue("@firstName", firstName)
        cmd.Parameters.AddWithValue("@lastName", lastName)
        cmd.Parameters.AddWithValue("@active", active)
        cmd.Parameters.AddWithValue("@password", password)
        cmd.Parameters.AddWithValue("@userGroupId", userGroupId)

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
        Dim cmd As New SqlCommand("Insert_tbl_systemUsers", conn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@userId", userId)
        cmd.Parameters.AddWithValue("@firstName", firstName)
        cmd.Parameters.AddWithValue("@lastName", lastName)
        cmd.Parameters.AddWithValue("@active", active)
        cmd.Parameters.AddWithValue("@password", password)
        cmd.Parameters.AddWithValue("@userGroupId", userGroupId)

        Try
            conn.Open()
            cmd.ExecuteNonQuery()
        Catch ex As Exception
        Finally
            If conn.State = ConnectionState.Open Then conn.Close()
            conn.Dispose()
            cmd.Dispose()
        End Try
    End Sub

    Public Sub Delete(ByVal ID As String)
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand("Delete_tbl_systemUsers", conn)
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

        '  Dim sql As String = "select * from [dbo].[tbl_systemUsers]"
        Dim sql As String = "SELECT [userId], [firstName], [lastName], [active], [password], [userGroupId], [id], [firstName] + ' ' + [lastName] AS [fullName] FROM tbl_systemUsers"

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            Return db.ExecuteDataSet(CommandType.Text, sql)
        Catch ex As Exception
            log.Error(ex)
            Return Nothing
        End Try
    End Function
    Public Overridable Function GetUser(ByVal IuserID As String) As DataSet
        Try
            Dim sql As String = "select * from tbl_systemUsers where userid ='" & IuserID & "'"
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            If (ds.Tables.Count > 0 AndAlso ds.Tables(0).Rows.Count > 0) Then
                Return ds
            Else
                Return Nothing
            End If
        Catch ex As Exception

        End Try
    End Function

    Public Overridable Function GetUser(ByVal IuserID As Integer) As DataSet
        Try
            Dim sql As String = "select * from tbl_systemUsers where id=" & IuserID
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            If (ds.Tables.Count > 0 AndAlso ds.Tables(0).Rows.Count > 0) Then
                Return ds
            Else
                Return Nothing
            End If
        Catch ex As Exception

        End Try
    End Function

    'Public Function SelectRecords() As DataSet
    '    Dim conn As New SqlConnection(ConnectionString)
    '    Dim cmd As New SqlDataAdapter("SELECT * FROM Select_tbl_systemUsers", conn)
    '    Dim dts As New DataSet()

    '    Try
    '        conn.Open()
    '        cmd.Fill(dts)
    '        Return dts
    '    Catch
    '        Return Nothing
    '    Finally
    '        If conn.State = ConnectionState.Open Then conn.Close()
    '        conn.Dispose()
    '        cmd.Dispose()
    '    End Try

End Class

