﻿Imports System
Imports System.Collections.Generic
Imports System.Text
Imports System.Data
Imports System.Data.SqlClient
Imports System.Collections
Imports System.Configuration
Imports System.Web
Imports Microsoft.Practices.EnterpriseLibrary.Data


Public Class SetExaminationFees

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

    'Private ConnectionString As String
    Private m_ConnectionString As String
    Property ConnectionString As String
        Get
            Return m_ConnectionString
        End Get
        Set(ByVal value As String)
            m_ConnectionString = value
        End Set
    End Property
    Private m_streamId As String
    Property streamId As String
        Get
            Return m_streamId
        End Get
        Set(ByVal value As String)
            m_streamId = value
        End Set
    End Property

    Private m_examinationBoardId As String
    Property examinationBoardId As String
        Get
            Return m_examinationBoardId
        End Get
        Set(ByVal value As String)
            m_examinationBoardId = value
        End Set
    End Property

    Private m_centerFee As String
    Property centerFee As String
        Get
            Return m_centerFee
        End Get
        Set(ByVal value As String)
            m_centerFee = value
        End Set
    End Property

    Private m_stationeryFee As String
    Property stationeryFee As String
        Get
            Return m_stationeryFee
        End Get
        Set(ByVal value As String)
            m_stationeryFee = value
        End Set
    End Property

    Private m_subjectId As String
    Property subjectId As String
        Get
            Return m_subjectId
        End Get
        Set(ByVal value As String)
            m_subjectId = value
        End Set
    End Property

    Private m_setExamFee As String
    Property setExamFee As String
        Get
            Return m_setExamFee
        End Get
        Set(ByVal value As String)
            m_setExamFee = value
        End Set
    End Property


    Public Sub Update(ByVal streamId As String, ByVal examinationBoardId As String, ByVal centerFee As String, ByVal stationeryFee As String, ByVal subjectId As String, ByVal setExamFee As String)
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand("Update_tbl_setExaminationFees", conn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@streamId", streamId)
        cmd.Parameters.AddWithValue("@examinationBoardId", examinationBoardId)
        cmd.Parameters.AddWithValue("@centerFee", centerFee)
        cmd.Parameters.AddWithValue("@stationeryFee", stationeryFee)
        cmd.Parameters.AddWithValue("@subjectId", subjectId)
        cmd.Parameters.AddWithValue("@setExamFee", setExamFee)

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
        Dim cmd As New SqlCommand("Insert_tbl_setExaminationFees", conn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@streamId", streamId)
        cmd.Parameters.AddWithValue("@examinationBoardId", examinationBoardId)
        cmd.Parameters.AddWithValue("@centerFee", centerFee)
        cmd.Parameters.AddWithValue("@stationeryFee", stationeryFee)
        cmd.Parameters.AddWithValue("@subjectId", subjectId)
        cmd.Parameters.AddWithValue("@setExamFee", setExamFee)

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
        Dim cmd As New SqlCommand("Delete_tbl_setExaminationFees", conn)
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
        Dim sql As String = "select * from [dbo].[tbl_setExaminationFees]"

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            Return db.ExecuteDataSet(CommandType.Text, sql)
        Catch ex As Exception
            log.Error(ex)
            Return Nothing
        End Try
    End Function

End Class

