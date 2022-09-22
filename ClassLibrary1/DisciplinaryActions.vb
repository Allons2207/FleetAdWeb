Imports System
Imports System.Collections.Generic
Imports System.Text
Imports System.Data
Imports System.Data.SqlClient
Imports System.Collections
Imports System.Configuration
Imports System.Web
Imports Microsoft.Practices.EnterpriseLibrary.Data

Public Class DisciplinaryActions

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

    Private m_actionId As String
    Property actionId As String
        Get
            Return m_actionId
        End Get
        Set(ByVal value As String)
            m_actionId = value
        End Set
    End Property

    Private m_action As String
    Property action As String
        Get
            Return m_action
        End Get
        Set(ByVal value As String)
            m_action = value
        End Set
    End Property


    Public Sub Update(ByVal actionId As String, ByVal action As String)
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand("Update_tbl_disciplinaryActions", conn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@actionId", actionId)
        cmd.Parameters.AddWithValue("@action", action)

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

    Public Sub Insert(ByVal actionId As String, ByVal action As String)
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand("Insert_tbl_disciplinaryActions", conn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@actionId", actionId)
        cmd.Parameters.AddWithValue("@action", action)

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
        Dim cmd As New SqlCommand("Delete_tbl_disciplinaryActions", conn)
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
        Dim sql As String = "select * from [dbo].[tbl_disciplinaryActions]"

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            Return db.ExecuteDataSet(CommandType.Text, sql)
        Catch ex As Exception
            log.Error(ex)
            Return Nothing
        End Try
    End Function
End Class

