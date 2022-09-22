Imports System
Imports System.Collections.Generic
Imports System.Text
Imports System.Data
Imports System.Data.SqlClient
Imports System.Collections
Imports System.Configuration
Imports System.Web
Imports Microsoft.Practices.EnterpriseLibrary.Data

Public Class StaffQualifications

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

    Private m_employmentNumber As String
    Property employmentNumber As String
        Get
            Return m_employmentNumber
        End Get
        Set(ByVal value As String)
            m_employmentNumber = value
        End Set
    End Property

    Private m_qualificationId As String
    Property qualificationId As String
        Get
            Return m_qualificationId
        End Get
        Set(ByVal value As String)
            m_qualificationId = value
        End Set
    End Property

    Private m_qualificationLevelId As String
    Property qualificationLevelId As String
        Get
            Return m_qualificationLevelId
        End Get
        Set(ByVal value As String)
            m_qualificationLevelId = value
        End Set
    End Property

    Private m_collegeId As String
    Property collegeId As String
        Get
            Return m_collegeId
        End Get
        Set(ByVal value As String)
            m_collegeId = value
        End Set
    End Property

    Private m_yearAttained As String
    Property yearAttained As String
        Get
            Return m_yearAttained
        End Get
        Set(ByVal value As String)
            m_yearAttained = value
        End Set
    End Property


    Public Sub Update(ByVal employmentNumber As String, ByVal qualificationId As String, ByVal qualificationLevelId As String, ByVal collegeId As String, ByVal yearAttained As String)
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand("Update_tbl_staffQualifications", conn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@employmentNumber", employmentNumber)
        cmd.Parameters.AddWithValue("@qualificationId", qualificationId)
        cmd.Parameters.AddWithValue("@qualificationLevelId", qualificationLevelId)
        cmd.Parameters.AddWithValue("@collegeId", collegeId)
        cmd.Parameters.AddWithValue("@yearAttained", yearAttained)

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
        Dim cmd As New SqlCommand("Insert_tbl_staffQualifications", conn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@employmentNumber", employmentNumber)
        cmd.Parameters.AddWithValue("@qualificationId", qualificationId)
        cmd.Parameters.AddWithValue("@qualificationLevelId", qualificationLevelId)
        cmd.Parameters.AddWithValue("@collegeId", collegeId)
        cmd.Parameters.AddWithValue("@yearAttained", yearAttained)

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
        Dim cmd As New SqlCommand("Delete_tbl_staffQualifications", conn)
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

    Public Function SelectRecords(ByVal StuffId As String) As DataSet

        Dim sql As String = "select SQ.employmentNumber, Q.qualification, QL.qualificationLevel, C.college, sq.yearAttained from [dbo].[tbl_staffQualifications] SQ inner join tbl_qualificationLevels QL on QL.qualificationLevelId = SQ.qualificationLevelId inner join tbl_qualifications Q on Q.qualificationId = SQ.qualificationId inner join tbl_colleges C on C.collegeId = SQ.collegeId   where employmentNumber = '" & StuffId & "'"

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            Return db.ExecuteDataSet(CommandType.Text, sql)
        Catch ex As Exception
            log.Error(ex)
            Return Nothing
        End Try

    End Function

End Class

