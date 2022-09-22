Imports System
Imports System.Collections.Generic
Imports System.Text
Imports System.Data
Imports System.Data.SqlClient
Imports System.Collections
Imports System.Configuration
Imports System.Web
Imports Microsoft.Practices.EnterpriseLibrary.Data

Public Class SportHouses

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


    Private ConnectionString As String

    Private m_sportsHouseId As String
    Property sportsHouseId As String
        Get
            Return m_sportsHouseId
        End Get
        Set(ByVal value As String)
            m_sportsHouseId = value
        End Set
    End Property

    Private m_sportsHouse As String
    Property sportsHouse As String
        Get
            Return m_sportsHouse
        End Get
        Set(ByVal value As String)
            m_sportsHouse = value
        End Set
    End Property

    Private m_sportsHouseColor As String
    Property sportsHouseColor As String
        Get
            Return m_sportsHouseColor
        End Get
        Set(ByVal value As String)
            m_sportsHouseColor = value
        End Set
    End Property


    Public Sub Update(ByVal sportsHouseId As String, ByVal sportsHouse As String, ByVal sportsHouseColor As String)
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand("Update_tbl_sportHouses", conn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@sportsHouseId", sportsHouseId)
        cmd.Parameters.AddWithValue("@sportsHouse", sportsHouse)
        cmd.Parameters.AddWithValue("@sportsHouseColor", sportsHouseColor)

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

    Public Sub Insert(ByVal sportsHouseId As String, ByVal sportsHouse As String, ByVal sportsHouseColor As String)
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand("Insert_tbl_sportHouses", conn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@sportsHouseId", sportsHouseId)
        cmd.Parameters.AddWithValue("@sportsHouse", sportsHouse)
        cmd.Parameters.AddWithValue("@sportsHouseColor", sportsHouseColor)

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
        Dim cmd As New SqlCommand("Delete_tbl_sportHouses", conn)
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
        Dim sql As String = "select * from [dbo].[tbl_sportHouses]"

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            Return db.ExecuteDataSet(CommandType.Text, sql)
        Catch ex As Exception
            log.Error(ex)
            Return Nothing
        End Try
    End Function
End Class


