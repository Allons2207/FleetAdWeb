Imports System
Imports System.Collections.Generic
Imports System.Text
Imports System.Data
Imports System.Data.SqlClient
Imports System.Collections
Imports System.Configuration
Imports System.Web
Imports Microsoft.Practices.EnterpriseLibrary.Data

Public Class Incidents
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

    Private m_caseNumber As String
    Property caseNumber As String
        Get
            Return m_caseNumber
        End Get
        Set(ByVal value As String)
            m_caseNumber = value
        End Set
    End Property

    Private m_incidentNumber As String
    Property incidentNumber As String
        Get
            Return m_incidentNumber
        End Get
        Set(ByVal value As String)
            m_incidentNumber = value
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

    Private m_incidentTypeId As String
    Property incidentTypeId As String
        Get
            Return m_incidentTypeId
        End Get
        Set(ByVal value As String)
            m_incidentTypeId = value
        End Set
    End Property

    Private m_incidentLevelId As String
    Property incidentLevelId As String
        Get
            Return m_incidentLevelId
        End Get
        Set(ByVal value As String)
            m_incidentLevelId = value
        End Set
    End Property

    Private m_locationId As String
    Property locationId As String
        Get
            Return m_locationId
        End Get
        Set(ByVal value As String)
            m_locationId = value
        End Set
    End Property

    Private m_offenderCategoryId As String
    Property offenderCategoryId As String
        Get
            Return m_offenderCategoryId
        End Get
        Set(ByVal value As String)
            m_offenderCategoryId = value
        End Set
    End Property

    Private m_offenderId As String
    Property offenderId As String
        Get
            Return m_offenderId
        End Get
        Set(ByVal value As String)
            m_offenderId = value
        End Set
    End Property

    Private m_offender As String
    Property offender As String
        Get
            Return m_offender
        End Get
        Set(ByVal value As String)
            m_offender = value
        End Set
    End Property

    Private m_incidentDescription As String
    Property incidentDescription As String
        Get
            Return m_incidentDescription
        End Get
        Set(ByVal value As String)
            m_incidentDescription = value
        End Set
    End Property

    Private m_disciplinaryActionId As String
    Property disciplinaryActionId As String
        Get
            Return m_disciplinaryActionId
        End Get
        Set(ByVal value As String)
            m_disciplinaryActionId = value
        End Set
    End Property

    Private m_stream As String
    Property stream As String
        Get
            Return m_stream
        End Get
        Set(ByVal value As String)
            m_stream = value
        End Set
    End Property

    Private m_Schclass As String
    Property Schclass As String
        Get
            Return m_Schclass
        End Get
        Set(ByVal value As String)
            m_Schclass = value
        End Set
    End Property


    Public Sub Update(ByVal caseNumber As String, ByVal incidentNumber As String, ByVal dtDate As String, ByVal incidentTypeId As String, ByVal incidentLevelId As String, ByVal locationId As String, ByVal offenderCategoryId As String, ByVal offenderId As String, ByVal offender As String, ByVal incidentDescription As String, ByVal disciplinaryActionId As String, ByVal stream As String, ByVal Schclass As String)
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand("Update_tbl_incidents", conn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@caseNumber", caseNumber)
        cmd.Parameters.AddWithValue("@incidentNumber", incidentNumber)
        cmd.Parameters.AddWithValue("@dtDate", dtDate)
        cmd.Parameters.AddWithValue("@incidentTypeId", incidentTypeId)
        cmd.Parameters.AddWithValue("@incidentLevelId", incidentLevelId)
        cmd.Parameters.AddWithValue("@locationId", locationId)
        cmd.Parameters.AddWithValue("@offenderCategoryId", offenderCategoryId)
        cmd.Parameters.AddWithValue("@offenderId", offenderId)
        cmd.Parameters.AddWithValue("@offender", offender)
        cmd.Parameters.AddWithValue("@incidentDescription", incidentDescription)
        cmd.Parameters.AddWithValue("@disciplinaryActionId", disciplinaryActionId)
        cmd.Parameters.AddWithValue("@stream", stream)
        cmd.Parameters.AddWithValue("@class", Schclass)

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
        Dim cmd As New SqlCommand("insert_tbl_incidents", conn)
        cmd.CommandType = CommandType.StoredProcedure
        'cmd.Parameters.AddWithValue("@caseNumber", caseNumber)
        cmd.Parameters.AddWithValue("@incidentNumber", incidentNumber)
        cmd.Parameters.AddWithValue("@dtDate", dtDate)
        cmd.Parameters.AddWithValue("@incidentTypeId", incidentTypeId)
        cmd.Parameters.AddWithValue("@incidentLevelId", incidentLevelId)
        cmd.Parameters.AddWithValue("@location", locationId)
        cmd.Parameters.AddWithValue("@offenderCategoryId", offenderCategoryId)
        cmd.Parameters.AddWithValue("@offenderId", offenderId)
        cmd.Parameters.AddWithValue("@offender", offender)
        cmd.Parameters.AddWithValue("@incidentDescription", incidentDescription)
        cmd.Parameters.AddWithValue("@disciplinaryActionId", disciplinaryActionId)
        cmd.Parameters.AddWithValue("@stream", stream)
        cmd.Parameters.AddWithValue("@Schclass", Schclass)

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
        Dim cmd As New SqlCommand("Delete_tbl_incidents", conn)
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
        Dim cmd As New SqlDataAdapter("SELECT * FROM Select_tbl_incidents", conn)
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

    Public Function SearchBehaviour() As DataSet

        Dim sql As String = "  SELECT incidentNumber, dtDate [Incident Date],incidentType,incidentLevel,location, offenderId [Student Number], offender [Student Name], incidentDescription,action, stream, Schclass FROM tbl_incidents I left outer join tbl_incidentTypes IT on I.incidentTypeId = IT.incidentTypeId left outer join tbl_incidentLevels IL on I.incidentLevelId = IL.incidentLevelId left outer join tbl_disciplinaryActions DA on I.disciplinaryActionId = DA.actionId where incidentNumber like '%" + incidentNumber + "%' and I.incidentTypeId like '%" + incidentTypeId + "%' and I.incidentLevelId like '%" + incidentLevelId + "%' and offenderCategoryId  like '%" + offenderCategoryId + "%' and disciplinaryActionId like '%" + disciplinaryActionId + "%' and offenderId like '%" + offenderId + "%'"
        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            Return db.ExecuteDataSet(CommandType.Text, sql)
        Catch ex As Exception
            log.Error(ex)
            Return Nothing
        End Try

    End Function
End Class

