Imports System
Imports System.Collections.Generic
Imports System.Text
Imports System.Data
Imports System.Data.SqlClient
Imports System.Collections
Imports System.Configuration
Imports System.Web

Public Class SectionUnits

    Private ConnectionString As String

    Private m_suburbId As String
    Property suburbId As String
        Get
            Return m_suburbId
        End Get
        Set(ByVal value As String)
            m_suburbId = value
        End Set
    End Property

    Private m_sectionUnitId As String
    Property sectionUnitId As String
        Get
            Return m_sectionUnitId
        End Get
        Set(ByVal value As String)
            m_sectionUnitId = value
        End Set
    End Property

    Private m_sectionUnit As String
    Property sectionUnit As String
        Get
            Return m_sectionUnit
        End Get
        Set(ByVal value As String)
            m_sectionUnit = value
        End Set
    End Property


    Public Sub Update(ByVal suburbId As String, ByVal sectionUnitId As String, ByVal sectionUnit As String)
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand("Update_tbl_sectionUnits", conn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@suburbId", suburbId)
        cmd.Parameters.AddWithValue("@sectionUnitId", sectionUnitId)
        cmd.Parameters.AddWithValue("@sectionUnit", sectionUnit)

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

    Public Sub Insert(ByVal suburbId As String, ByVal sectionUnitId As String, ByVal sectionUnit As String)
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand("Insert_tbl_sectionUnits", conn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@suburbId", suburbId)
        cmd.Parameters.AddWithValue("@sectionUnitId", sectionUnitId)
        cmd.Parameters.AddWithValue("@sectionUnit", sectionUnit)

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
        Dim cmd As New SqlCommand("Delete_tbl_sectionUnits", conn)
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

