Imports System
Imports System.Collections.Generic
Imports System.Text
Imports System.Data
Imports System.Data.SqlClient
Imports System.Collections
Imports System.Configuration
Imports System.Web
Imports Microsoft.Practices.EnterpriseLibrary.Data

Public Class UniformSales

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

    Private m_saleId As String
    Property saleId As String
        Get
            Return m_saleId
        End Get
        Set(ByVal value As String)
            m_saleId = value
        End Set
    End Property

    Private m_dtDate As String
    Property dtDate As String
        Get
            Return m_dtDate
        End Get
        Set(ByVal value As String)
            m_dtDate = value
        End Set
    End Property

    Private m_receiptNumber As String
    Property receiptNumber As String
        Get
            Return m_receiptNumber
        End Get
        Set(ByVal value As String)
            m_receiptNumber = value
        End Set
    End Property

    Private m_studentId As String
    Property studentId As String
        Get
            Return m_studentId
        End Get
        Set(ByVal value As String)
            m_studentId = value
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

    Private m_unitPrice As String
    Property unitPrice As String
        Get
            Return m_unitPrice
        End Get
        Set(ByVal value As String)
            m_unitPrice = value
        End Set
    End Property

    Private m_quantity As String
    Property quantity As String
        Get
            Return m_quantity
        End Get
        Set(ByVal value As String)
            m_quantity = value
        End Set
    End Property

    Private m_totalPrice As String
    Property totalPrice As String
        Get
            Return m_totalPrice
        End Get
        Set(ByVal value As String)
            m_totalPrice = value
        End Set
    End Property


    Public Sub Update(ByVal saleId As String, ByVal dtDate As String, ByVal receiptNumber As String, ByVal studentId As String, ByVal uniformItem As String, ByVal unitPrice As String, ByVal quantity As String, ByVal totalPrice As String)
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand("Update_tbl_uniformSales", conn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@saleId", saleId)
        cmd.Parameters.AddWithValue("@dtDate", dtDate)
        cmd.Parameters.AddWithValue("@receiptNumber", receiptNumber)
        cmd.Parameters.AddWithValue("@studentId", studentId)
        cmd.Parameters.AddWithValue("@uniformItem", uniformItem)
        cmd.Parameters.AddWithValue("@unitPrice", unitPrice)
        cmd.Parameters.AddWithValue("@quantity", quantity)
        cmd.Parameters.AddWithValue("@totalPrice", totalPrice)

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
        Dim cmd As New SqlCommand("Insert_tbl_uniformSales", conn)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.AddWithValue("@dtDate", dtDate)
        cmd.Parameters.AddWithValue("@receiptNumber", receiptNumber)
        cmd.Parameters.AddWithValue("@studentId", studentId)
        cmd.Parameters.AddWithValue("@uniformItem", uniformItem)
        cmd.Parameters.AddWithValue("@unitPrice", unitPrice)
        cmd.Parameters.AddWithValue("@quantity", quantity)
        cmd.Parameters.AddWithValue("@totalPrice", totalPrice)

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
        Dim cmd As New SqlCommand("Delete_tbl_uniformSales", conn)
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
        Dim sql As String = "select * from [dbo].[tbl_uniformSales]"

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            Return db.ExecuteDataSet(CommandType.Text, sql)
        Catch ex As Exception
            log.Error(ex)
            Return Nothing
        End Try
    End Function

   
End Class

