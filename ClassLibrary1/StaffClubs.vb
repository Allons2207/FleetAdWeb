Imports System
Imports System.Collections.Generic
Imports System.Text
Imports System.Data
Imports System.Data.SqlClient
Imports System.Collections
Imports System.Configuration
Imports System.Web

Public Class StaffClubs

    Private ConnectionString As String

    Private m_club As String
    Property club As String
        Get
            Return m_club
        End Get
        Set(ByVal value As String)
            m_club = value
        End Set
    End Property

    Private m_employmentNumber As String
    Property employmentNumber As String
        Get
            Return m_employmentNumber
        End Get
        Set(ByVal value As String)
            m_employmentNumber = value
        End Set
    End Property


    Public Sub Update(ByVal club As String, ByVal employmentNumber As String)
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand("Update_tbl_staffClubs", conn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@club", club)
        cmd.Parameters.AddWithValue("@employmentNumber", employmentNumber)

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

    Public Sub Insert(ByVal club As String, ByVal employmentNumber As String)
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand("Insert_tbl_staffClubs", conn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@club", club)
        cmd.Parameters.AddWithValue("@employmentNumber", employmentNumber)

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
        Dim cmd As New SqlCommand("Delete_tbl_staffClubs", conn)
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
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlDataAdapter("SELECT * FROM Select_tbl_staffClubs", conn)
        Dim dts As New DataSet()

        Try
            conn.Open()
            cmd.Fill(dts)
            Return dts
        Catch
            Return Nothing
        Finally
            If conn.State = ConnectionState.Open Then conn.Close()
            conn.Dispose()
            cmd.Dispose()
        End Try
    End Function
End Class
