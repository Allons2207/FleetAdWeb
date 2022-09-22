Imports System
Imports System.Collections.Generic
Imports System.Text
Imports System.Data
Imports System.Data.SqlClient
Imports System.Collections
Imports System.Configuration
Imports System.Web
Imports Microsoft.Practices.EnterpriseLibrary.Data

Public Class Suppliers


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

    Private m_supplierId As String
    Property supplierId As String
        Get
            Return m_supplierId
        End Get
        Set(ByVal value As String)
            m_supplierId = value
        End Set
    End Property

    Private m_supplier As String
    Property supplier As String
        Get
            Return m_supplier
        End Get
        Set(ByVal value As String)
            m_supplier = value
        End Set
    End Property

    Private m_address As String
    Property address As String
        Get
            Return m_address
        End Get
        Set(ByVal value As String)
            m_address = value
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

    Private m_contactPerson As String
    Property contactPerson As String
        Get
            Return m_contactPerson
        End Get
        Set(ByVal value As String)
            m_contactPerson = value
        End Set
    End Property


    Public Sub Update(ByVal supplierId As String, ByVal supplier As String, ByVal address As String, ByVal contactNumber As String, ByVal contactPerson As String)
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand("Update_tbl_suppliers", conn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@supplierId", supplierId)
        cmd.Parameters.AddWithValue("@supplier", supplier)
        cmd.Parameters.AddWithValue("@address", address)
        cmd.Parameters.AddWithValue("@contactNumber", contactNumber)
        cmd.Parameters.AddWithValue("@contactPerson", contactPerson)

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

    Public Sub Insert(ByVal supplierId As String, ByVal supplier As String, ByVal address As String, ByVal contactNumber As String, ByVal contactPerson As String)
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand("Insert_tbl_suppliers", conn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@supplierId", supplierId)
        cmd.Parameters.AddWithValue("@supplier", supplier)
        cmd.Parameters.AddWithValue("@address", address)
        cmd.Parameters.AddWithValue("@contactNumber", contactNumber)
        cmd.Parameters.AddWithValue("@contactPerson", contactPerson)

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
        Dim cmd As New SqlCommand("Delete_tbl_suppliers", conn)
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
        Dim sql As String = "  SELECT * FROM tbl_suppliers"
        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            Return db.ExecuteDataSet(CommandType.Text, sql)
        Catch ex As Exception
            log.Error(ex)
            Return Nothing
        End Try
    End Function
End Class
