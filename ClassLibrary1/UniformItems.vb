Imports System
Imports System.Collections.Generic
Imports System.Text
Imports System.Data
Imports System.Data.SqlClient
Imports System.Collections
Imports System.Configuration
Imports System.Web
Imports Microsoft.Practices.EnterpriseLibrary.Data

Public Class UniformItems

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


    Private m_ConnectionString As String

    Property ConnectionString As String
        Get
            Return m_ConnectionString
        End Get
        Set(ByVal value As String)
            m_ConnectionString = value
        End Set
    End Property

    Private m_uniformItemId As String
    Property uniformItemId As String
        Get
            Return m_uniformItemId
        End Get
        Set(ByVal value As String)
            m_uniformItemId = value
        End Set
    End Property

    Private m_itemCode As String
    Property itemCode As String
        Get
            Return m_itemCode
        End Get
        Set(ByVal value As String)
            m_itemCode = value
        End Set
    End Property

    Private m_uniformItem As String
    Property uniformItem As String
        Get
            Return m_uniformItem
        End Get
        Set(ByVal value As String)
            m_uniformItem = value
        End Set
    End Property

    Private m_price As String
    Property price As String
        Get
            Return m_price
        End Get
        Set(ByVal value As String)
            m_price = value
        End Set
    End Property


    Public Sub Update(ByVal uniformItemId As String, ByVal uniformItem As String, ByVal price As String)
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand("Update_tbl_uniformItems", conn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@uniformItemId", uniformItemId)
        cmd.Parameters.AddWithValue("@uniformItem", uniformItem)
        cmd.Parameters.AddWithValue("@price", price)

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
        Dim cmd As New SqlCommand("Insert_tbl_uniformItems", conn)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.AddWithValue("@uniformItem", uniformItem)
        cmd.Parameters.AddWithValue("@price", price)
        'cmd.Parameters.AddWithValue("@itemCode", itemCode)

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
        Dim cmd As New SqlCommand("Delete_tbl_uniformItems", conn)
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
        Dim sql As String = "select uniformItem, price from [dbo].[tbl_uniformItems]"

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            Return db.ExecuteDataSet(CommandType.Text, sql)
        Catch ex As Exception
            log.Error(ex)
            Return Nothing
        End Try
    End Function

    Public Function GetPrice(ByVal id As String) As DataSet
        Dim sql As String = "select * from [dbo].[tbl_uniformItems] where uniformItem = '" & id & "'"

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            Return db.ExecuteDataSet(CommandType.Text, sql)
        Catch ex As Exception
            log.Error(ex)
            Return Nothing
        End Try
    End Function

    Public Function GetSudentDetails(ByVal id As String) As DataSet
        Dim sql As String = "select * from [dbo].[tbl_students] where studentId = '" & id & "'"

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            Return db.ExecuteDataSet(CommandType.Text, sql)
        Catch ex As Exception
            log.Error(ex)
            Return Nothing
        End Try
    End Function

   
End Class

