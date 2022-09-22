Imports System
Imports System.Collections.Generic
Imports System.Text
Imports System.Data
Imports System.Data.SqlClient
Imports System.Collections
Imports System.Configuration
Imports System.Web
Imports Microsoft.Practices.EnterpriseLibrary.Data

Public Class SchoolAssetsDisposed

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

    Private m_assetType As String
    Property assetType As String
        Get
            Return m_assetType
        End Get
        Set(ByVal value As String)
            m_assetType = value
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

    Private m_functionalState As String
    Property functionalState As String
        Get
            Return m_functionalState
        End Get
        Set(ByVal value As String)
            m_functionalState = value
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

    Private m_supplier As String
    Property supplier As String
        Get
            Return m_supplier
        End Get
        Set(ByVal value As String)
            m_supplier = value
        End Set
    End Property

    Private m_quantityDisposed As String
    Property quantityDisposed As String
        Get
            Return m_quantityDisposed
        End Get
        Set(ByVal value As String)
            m_quantityDisposed = value
        End Set
    End Property

    Private m_valueOfDisposedAssets As String
    Property valueOfDisposedAssets As String
        Get
            Return m_valueOfDisposedAssets
        End Get
        Set(ByVal value As String)
            m_valueOfDisposedAssets = value
        End Set
    End Property

    Private m_reasonForDisposal As String
    Property reasonForDisposal As String
        Get
            Return m_reasonForDisposal
        End Get
        Set(ByVal value As String)
            m_reasonForDisposal = value
        End Set
    End Property

    Private m_dateDisposed As Date
    Property dateDisposed As Date
        Get
            Return m_dateDisposed
        End Get
        Set(ByVal value As Date)
            m_dateDisposed = value
        End Set
    End Property


    Public Sub Update(ByVal assetType As String, ByVal assetName As String, ByVal assetNumber As String, ByVal serialNumber As String, ByVal functionalState As String, ByVal description As String, ByVal dateBought As String, ByVal supplier As String, ByVal quantityDisposed As String, ByVal valueOfDisposedAssets As String, ByVal reasonForDisposal As String, ByVal dateDisposed As String)
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand("Update_tbl_schoolAssetsDisposed", conn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@assetType", assetType)
        cmd.Parameters.AddWithValue("@assetName", assetName)
        cmd.Parameters.AddWithValue("@assetNumber", assetNumber)
        cmd.Parameters.AddWithValue("@serialNumber", serialNumber)
        cmd.Parameters.AddWithValue("@functionalState", functionalState)
        cmd.Parameters.AddWithValue("@description", description)
        cmd.Parameters.AddWithValue("@dateBought", dateBought)
        cmd.Parameters.AddWithValue("@supplier", supplier)
        cmd.Parameters.AddWithValue("@quantityDisposed", quantityDisposed)
        cmd.Parameters.AddWithValue("@valueOfDisposedAssets", valueOfDisposedAssets)
        cmd.Parameters.AddWithValue("@reasonForDisposal", reasonForDisposal)
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
        Dim cmd As New SqlCommand("Insert_tbl_schoolAssetsDisposed", conn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@assetType", assetType)
        cmd.Parameters.AddWithValue("@assetName", assetName)
        cmd.Parameters.AddWithValue("@assetNumber", assetNumber)
        cmd.Parameters.AddWithValue("@serialNumber", serialNumber)
        cmd.Parameters.AddWithValue("@functionalState", functionalState)
        cmd.Parameters.AddWithValue("@description", description)
        cmd.Parameters.AddWithValue("@dateBought", dateBought)
        cmd.Parameters.AddWithValue("@supplier", supplier)
        cmd.Parameters.AddWithValue("@quantityDisposed", quantityDisposed)
        cmd.Parameters.AddWithValue("@valueOfDisposedAssets", valueOfDisposedAssets)
        cmd.Parameters.AddWithValue("@reasonForDisposal", reasonForDisposal)
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

    Public Sub Delete(ByVal ID As String)
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand("Delete_tbl_schoolAssetsDisposed", conn)
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
        Dim sql As String = "  SELECT * FROM tbl_schoolAssetsDisposed"
        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            Return db.ExecuteDataSet(CommandType.Text, sql)
        Catch ex As Exception
            log.Error(ex)
            Return Nothing
        End Try
    End Function
End Class

