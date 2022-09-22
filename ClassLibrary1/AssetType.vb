Imports System
Imports System.Collections.Generic
Imports System.Text
Imports System.Data
Imports System.Data.SqlClient
Imports System.Collections
Imports System.Configuration
Imports System.Web



Public Class AssetType

    Private ConnectionString As String

    Private m_assetTypeId As String
    Property assetTypeId As String
        Get
            Return m_assetTypeId
        End Get
        Set(ByVal value As String)
            m_assetTypeId = value
        End Set
    End Property

    Private m_assetType As String
    Property assetType As String
        Get
            Return m_assetType
        End Get
        Set(ByVal value As String)
            m_assetType = value
        End Set
    End Property


    Public Sub Update(ByVal assetTypeId As String, ByVal assetType As String)
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand("Update_tbl_assetTypes", conn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@assetTypeId", assetTypeId)
        cmd.Parameters.AddWithValue("@assetType", assetType)

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

    Public Sub Insert(ByVal assetTypeId As String, ByVal assetType As String)
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand("Insert_tbl_assetTypes", conn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@assetTypeId", assetTypeId)
        cmd.Parameters.AddWithValue("@assetType", assetType)

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
        Dim cmd As New SqlCommand("Delete_tbl_assetTypes", conn)
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

