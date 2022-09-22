Imports System
Imports System.Collections.Generic
Imports System.Text
Imports System.Data
Imports System.Data.SqlClient
Imports System.Collections
Imports System.Configuration
Imports System.Web

Public Class OrphanhoodStatuses

    Private ConnectionString As String

    Private m_orphanhoodStatusId As String
    Property orphanhoodStatusId As String
        Get
            Return m_orphanhoodStatusId
        End Get
        Set(ByVal value As String)
            m_orphanhoodStatusId = value
        End Set
    End Property

    Private m_orphanhoodStatus As String
    Property orphanhoodStatus As String
        Get
            Return m_orphanhoodStatus
        End Get
        Set(ByVal value As String)
            m_orphanhoodStatus = value
        End Set
    End Property


    Public Sub Update(ByVal orphanhoodStatusId As String, ByVal orphanhoodStatus As String)
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand("Update_tbl_orphanhoodStatuses", conn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@orphanhoodStatusId", orphanhoodStatusId)
        cmd.Parameters.AddWithValue("@orphanhoodStatus", orphanhoodStatus)

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

    Public Sub Insert(ByVal orphanhoodStatusId As String, ByVal orphanhoodStatus As String)
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand("Insert_tbl_orphanhoodStatuses", conn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@orphanhoodStatusId", orphanhoodStatusId)
        cmd.Parameters.AddWithValue("@orphanhoodStatus", orphanhoodStatus)

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
        Dim cmd As New SqlCommand("Delete_tbl_orphanhoodStatuses", conn)
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


End Class

