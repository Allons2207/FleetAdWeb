Imports System
Imports System.Collections.Generic
Imports System.Text
Imports System.Data
Imports System.Data.SqlClient
Imports System.Collections
Imports System.Configuration
Imports System.Web
Imports Microsoft.Practices.EnterpriseLibrary.Data

Public Class SchoolAssets
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

    Private m_assetName As String
    Property assetName As String
        Get
            Return m_assetName
        End Get
        Set(ByVal value As String)
            m_assetName = value
        End Set
    End Property

    Private m_assetNumber As String
    Property assetNumber As String
        Get
            Return m_assetNumber
        End Get
        Set(ByVal value As String)
            m_assetNumber = value
        End Set
    End Property

    Private m_serialNumber As String
    Property serialNumber As String
        Get
            Return m_serialNumber
        End Get
        Set(ByVal value As String)
            m_serialNumber = value
        End Set
    End Property

    Private m_functionalStateId As String
    Property functionalStateId As String
        Get
            Return m_functionalStateId
        End Get
        Set(ByVal value As String)
            m_functionalStateId = value
        End Set
    End Property

    Private m_description As String
    Property description As String
        Get
            Return m_description
        End Get
        Set(ByVal value As String)
            m_description = value
        End Set
    End Property

    Private m_dateBought As Date
    Property dateBought As Date
        Get
            Return m_dateBought
        End Get
        Set(ByVal value As Date)
            m_dateBought = value
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

    Private m_quantity As String
    Property quantity As String
        Get
            Return m_quantity
        End Get
        Set(ByVal value As String)
            m_quantity = value
        End Set
    End Property

    Private m_totalValue As String
    Property totalValue As String
        Get
            Return m_totalValue
        End Get
        Set(ByVal value As String)
            m_totalValue = value
        End Set
    End Property

    Private m_assetLocation As String
    Property assetLocation As String
        Get
            Return m_assetLocation
        End Get
        Set(ByVal value As String)
            m_assetLocation = value
        End Set
    End Property

    Private m_assetUser As String
    Property assetUser As String
        Get
            Return m_assetUser
        End Get
        Set(ByVal value As String)
            m_assetUser = value
        End Set
    End Property

    Private m_dateDisposed As String
    Property dateDisposed As String
        Get
            Return m_dateDisposed
        End Get
        Set(ByVal value As String)
            m_dateDisposed = value
        End Set
    End Property


    Public Sub Update(ByVal assetId As String, ByVal assetName As String, ByVal assetNumber As String, ByVal serialNumber As String, ByVal functionalStateId As String, ByVal description As String, ByVal dateBought As String, ByVal supplierId As String, ByVal quantity As String, ByVal totalValue As String, ByVal assetLocation As String, ByVal assetUser As String, ByVal assetUserType As String, ByVal disposalStatus As String, ByVal dateDisposed As String)
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand("Update_tbl_schoolAssets", conn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@assetId", assetId)
        cmd.Parameters.AddWithValue("@assetName", assetName)
        cmd.Parameters.AddWithValue("@assetNumber", assetNumber)
        cmd.Parameters.AddWithValue("@serialNumber", serialNumber)
        cmd.Parameters.AddWithValue("@functionalStateId", functionalStateId)
        cmd.Parameters.AddWithValue("@description", description)
        cmd.Parameters.AddWithValue("@dateBought", dateBought)
        cmd.Parameters.AddWithValue("@supplierId", supplierId)
        cmd.Parameters.AddWithValue("@quantity", quantity)
        cmd.Parameters.AddWithValue("@totalValue", totalValue)
        cmd.Parameters.AddWithValue("@assetLocation", assetLocation)
        cmd.Parameters.AddWithValue("@assetUser", assetUser)
        cmd.Parameters.AddWithValue("@assetUserType", assetUserType)
        cmd.Parameters.AddWithValue("@disposalStatus", disposalStatus)
        cmd.Parameters.AddWithValue("@dateDisposed", dateDisposed)

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
        Dim cmd As New SqlCommand("Insert_tbl_schoolAssets", conn)
        cmd.CommandType = CommandType.StoredProcedure
        'cmd.Parameters.AddWithValue("@assetId", assetId)
        cmd.Parameters.AddWithValue("@assetName", assetName)
        cmd.Parameters.AddWithValue("@assetNumber", assetNumber)
        cmd.Parameters.AddWithValue("@serialNumber", serialNumber)
        cmd.Parameters.AddWithValue("@functionalStateId", functionalStateId)
        cmd.Parameters.AddWithValue("@description", description)
        cmd.Parameters.AddWithValue("@dateBought", dateBought)
        cmd.Parameters.AddWithValue("@supplierId", supplierId)
        cmd.Parameters.AddWithValue("@quantity", quantity)
        cmd.Parameters.AddWithValue("@totalValue", totalValue)
        cmd.Parameters.AddWithValue("@assetLocation", assetLocation)
        cmd.Parameters.AddWithValue("@assetUser", assetUser)
        'cmd.Parameters.AddWithValue("@dateDisposed", dateDisposed)

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
        Dim cmd As New SqlCommand("Delete_tbl_schoolAssets", conn)
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

        Dim sql As String = "SELECT * FROM tbl_schoolAssets where assetName like '%" & assetName & "%' and assetNumber like '%" & assetNumber & "%' and serialNumber like '%" & serialNumber & "%' and supplierId like '%" & supplierId & "%'  and assetUser like '%" & assetUser & "%'"
        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            Return db.ExecuteDataSet(CommandType.Text, sql)
        Catch ex As Exception
            log.Error(ex)
            Return Nothing
        End Try
    End Function
End Class

