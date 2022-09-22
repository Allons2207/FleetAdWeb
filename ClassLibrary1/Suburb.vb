Imports System
Imports System.Collections.Generic
Imports System.Text
Imports System.Data
Imports System.Data.SqlClient
Imports System.Collections
Imports System.Configuration
Imports System.Web


Public Class suburbs

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

    Private m_cityId As String
    Property cityId As String
        Get
            Return m_cityId
        End Get
        Set(ByVal value As String)
            m_cityId = value
        End Set
    End Property

    Private m_Suburb As String
    Property Suburb As String
        Get
            Return m_Suburb
        End Get
        Set(ByVal value As String)
            m_Suburb = value
        End Set
    End Property

    Private m_sectionId As String
    Property sectionId As String
        Get
            Return m_sectionId
        End Get
        Set(ByVal value As String)
            m_sectionId = value
        End Set
    End Property


    Public Sub Update(ByVal suburbId As String, ByVal cityId As String, ByVal Suburb As String, ByVal sectionId As String)
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand("Update_suburbs", conn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@suburbId", suburbId)
        cmd.Parameters.AddWithValue("@cityId", cityId)
        cmd.Parameters.AddWithValue("@Suburb", Suburb)
        cmd.Parameters.AddWithValue("@sectionId", sectionId)

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

    Public Sub Insert(ByVal suburbId As String, ByVal cityId As String, ByVal Suburb As String, ByVal sectionId As String)
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand("Insert_suburbs", conn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@suburbId", suburbId)
        cmd.Parameters.AddWithValue("@cityId", cityId)
        cmd.Parameters.AddWithValue("@Suburb", Suburb)
        cmd.Parameters.AddWithValue("@sectionId", sectionId)

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
        Dim cmd As New SqlCommand("Delete_suburbs", conn)
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
