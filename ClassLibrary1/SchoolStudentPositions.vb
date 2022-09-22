Imports System
Imports System.Collections.Generic
Imports System.Text
Imports System.Data
Imports System.Data.SqlClient
Imports System.Collections
Imports System.Configuration
Imports System.Web

Public Class SchoolStudentPositions

    Private ConnectionString As String

    Private m_schoolStudentPositionId As String
    Property schoolStudentPositionId As String
        Get
            Return m_schoolStudentPositionId
        End Get
        Set(ByVal value As String)
            m_schoolStudentPositionId = value
        End Set
    End Property

    Private m_schoolStudentPosition As String
    Property schoolStudentPosition As String
        Get
            Return m_schoolStudentPosition
        End Get
        Set(ByVal value As String)
            m_schoolStudentPosition = value
        End Set
    End Property


    Public Sub Update(ByVal schoolStudentPositionId As String, ByVal schoolStudentPosition As String)
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand("Update_tbl_schoolStudentPositions", conn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@schoolStudentPositionId", schoolStudentPositionId)
        cmd.Parameters.AddWithValue("@schoolStudentPosition", schoolStudentPosition)

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

    Public Sub Insert(ByVal schoolStudentPositionId As String, ByVal schoolStudentPosition As String)
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand("Insert_tbl_schoolStudentPositions", conn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@schoolStudentPositionId", schoolStudentPositionId)
        cmd.Parameters.AddWithValue("@schoolStudentPosition", schoolStudentPosition)

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
        Dim cmd As New SqlCommand("Delete_tbl_schoolStudentPositions", conn)
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
