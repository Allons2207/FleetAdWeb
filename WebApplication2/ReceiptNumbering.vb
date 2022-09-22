Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing
Imports System.Data.SqlClient

Public Class ReceiptNumbering

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


    Private m_receiptNumber As String
    Property receiptNumber As String
        Get
            Return m_receiptNumber
        End Get
        Set(ByVal value As String)
            m_receiptNumber = value
        End Set
    End Property

    Public Function fnReceiptNumber() As String
        Dim conn As New SqlConnection(ConnectionString)

        ' cmd.CommandType = CommandType.StoredProcedure
       

        Try
            conn.Open()
            ' cmd.ExecuteNonQuery()
        Catch
        Finally
            If conn.State = ConnectionState.Open Then conn.Close()
            conn.Dispose()
            ' cmd.Dispose()
        End Try

    End Function









End Class
