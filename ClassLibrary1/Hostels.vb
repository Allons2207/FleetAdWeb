Imports System
Imports System.Collections.Generic
Imports System.Text
Imports System.Data
Imports System.Data.SqlClient
Imports System.Collections
Imports System.Configuration
Imports System.Web
Imports Microsoft.Practices.EnterpriseLibrary.Data

Public Class Hostels
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

    Private m_hostelId As String
    Property hostelId As String
        Get
            Return m_hostelId
        End Get
        Set(ByVal value As String)
            m_hostelId = value
        End Set
    End Property

    Private m_hostel As String
    Property hostel As String
        Get
            Return m_hostel
        End Get
        Set(ByVal value As String)
            m_hostel = value
        End Set
    End Property

    Private m_superitendant As String
    Property superitendant As String
        Get
            Return m_superitendant
        End Get
        Set(ByVal value As String)
            m_superitendant = value
        End Set
    End Property

    Private m_numberOfRooms As String
    Property numberOfRooms As String
        Get
            Return m_numberOfRooms
        End Get
        Set(ByVal value As String)
            m_numberOfRooms = value
        End Set
    End Property

    Private m_numberOfBeds As String
    Property numberOfBeds As String
        Get
            Return m_numberOfBeds
        End Get
        Set(ByVal value As String)
            m_numberOfBeds = value
        End Set
    End Property

    Private m_numberOfToiletSeats As String
    Property numberOfToiletSeats As String
        Get
            Return m_numberOfToiletSeats
        End Get
        Set(ByVal value As String)
            m_numberOfToiletSeats = value
        End Set
    End Property

    Private m_numberOfShowers As String
    Property numberOfShowers As String
        Get
            Return m_numberOfShowers
        End Get
        Set(ByVal value As String)
            m_numberOfShowers = value
        End Set
    End Property

    Private m_numberOfBathTubs As String
    Property numberOfBathTubs As String
        Get
            Return m_numberOfBathTubs
        End Get
        Set(ByVal value As String)
            m_numberOfBathTubs = value
        End Set
    End Property


    Public Sub Update(ByVal hostelId As String, ByVal hostel As String, ByVal superitendant As String, ByVal numberOfRooms As String, ByVal numberOfBeds As String, ByVal numberOfToiletSeats As String, ByVal numberOfShowers As String, ByVal numberOfBathTubs As String)
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand("Update_tbl_hostels", conn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@hostelId", hostelId)
        cmd.Parameters.AddWithValue("@hostel", hostel)
        cmd.Parameters.AddWithValue("@superitendant", superitendant)
        cmd.Parameters.AddWithValue("@numberOfRooms", numberOfRooms)
        cmd.Parameters.AddWithValue("@numberOfBeds", numberOfBeds)
        cmd.Parameters.AddWithValue("@numberOfToiletSeats", numberOfToiletSeats)
        cmd.Parameters.AddWithValue("@numberOfShowers", numberOfShowers)
        cmd.Parameters.AddWithValue("@numberOfBathTubs", numberOfBathTubs)

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

    Public Sub Insert(ByVal hostelId As String, ByVal hostel As String, ByVal superitendant As String, ByVal numberOfRooms As String, ByVal numberOfBeds As String, ByVal numberOfToiletSeats As String, ByVal numberOfShowers As String, ByVal numberOfBathTubs As String)
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand("Insert_tbl_hostels", conn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@hostelId", hostelId)
        cmd.Parameters.AddWithValue("@hostel", hostel)
        cmd.Parameters.AddWithValue("@superitendant", superitendant)
        cmd.Parameters.AddWithValue("@numberOfRooms", numberOfRooms)
        cmd.Parameters.AddWithValue("@numberOfBeds", numberOfBeds)
        cmd.Parameters.AddWithValue("@numberOfToiletSeats", numberOfToiletSeats)
        cmd.Parameters.AddWithValue("@numberOfShowers", numberOfShowers)
        cmd.Parameters.AddWithValue("@numberOfBathTubs", numberOfBathTubs)

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
        Dim cmd As New SqlCommand("Delete_tbl_hostels", conn)
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

        Dim sql As String = "select * from [dbo].[tbl_hostels]"

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            Return db.ExecuteDataSet(CommandType.Text, sql)
        Catch ex As Exception
            log.Error(ex)
            Return Nothing
        End Try
    End Function

End Class

