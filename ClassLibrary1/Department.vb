Imports System
Imports System.Collections.Generic
Imports System.Text
Imports System.Data
Imports System.Data.SqlClient
Imports System.Collections
Imports System.Configuration
Imports System.Web


Public Class Departments

    Private ConnectionString As String

    Private m_departmentId As String
    Property departmentId As String
        Get
            Return m_departmentId
        End Get
        Set(ByVal value As String)
            m_departmentId = value
        End Set
    End Property

    Private m_departmentName As String
    Property departmentName As String
        Get
            Return m_departmentName
        End Get
        Set(ByVal value As String)
            m_departmentName = value
        End Set
    End Property

    Private m_headOfDepartmentStaffId As String
    Property headOfDepartmentStaffId As String
        Get
            Return m_headOfDepartmentStaffId
        End Get
        Set(ByVal value As String)
            m_headOfDepartmentStaffId = value
        End Set
    End Property

    Private m_officePhoneNumber As String
    Property officePhoneNumber As String
        Get
            Return m_officePhoneNumber
        End Get
        Set(ByVal value As String)
            m_officePhoneNumber = value
        End Set
    End Property

    Private m_officeNumber As String
    Property officeNumber As String
        Get
            Return m_officeNumber
        End Get
        Set(ByVal value As String)
            m_officeNumber = value
        End Set
    End Property

    Private m_comments As String
    Property comments As String
        Get
            Return m_comments
        End Get
        Set(ByVal value As String)
            m_comments = value
        End Set
    End Property


    Public Sub Update(ByVal departmentId As String, ByVal departmentName As String, ByVal headOfDepartmentStaffId As String, ByVal officePhoneNumber As String, ByVal officeNumber As String, ByVal comments As String)
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand("Update_tbl_departments", conn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@departmentId", departmentId)
        cmd.Parameters.AddWithValue("@departmentName", departmentName)
        cmd.Parameters.AddWithValue("@headOfDepartmentStaffId", headOfDepartmentStaffId)
        cmd.Parameters.AddWithValue("@officePhoneNumber", officePhoneNumber)
        cmd.Parameters.AddWithValue("@officeNumber", officeNumber)
        cmd.Parameters.AddWithValue("@comments", comments)

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

    Public Sub Insert(ByVal departmentId As String, ByVal departmentName As String, ByVal headOfDepartmentStaffId As String, ByVal officePhoneNumber As String, ByVal officeNumber As String, ByVal comments As String)
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand("Insert_tbl_departments", conn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@departmentId", departmentId)
        cmd.Parameters.AddWithValue("@departmentName", departmentName)
        cmd.Parameters.AddWithValue("@headOfDepartmentStaffId", headOfDepartmentStaffId)
        cmd.Parameters.AddWithValue("@officePhoneNumber", officePhoneNumber)
        cmd.Parameters.AddWithValue("@officeNumber", officeNumber)
        cmd.Parameters.AddWithValue("@comments", comments)

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
        Dim cmd As New SqlCommand("Delete_tbl_departments", conn)
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

