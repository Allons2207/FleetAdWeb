Imports System
Imports System.Collections.Generic
Imports System.Text
Imports System.Data
Imports System.Data.SqlClient
Imports System.Collections
Imports System.Configuration
Imports System.Web
Imports Microsoft.Practices.EnterpriseLibrary.Common
Imports Microsoft.Practices.EnterpriseLibrary.Data

Public Class StaffDetails

    Public Property ErrorMessage As String = String.Empty
    Private Shared ReadOnly log As log4net.ILog = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType)


    Private ConnectionString As String


    Protected db As Database
    Public ReadOnly Property Database() As Database
        Get
            Return db
        End Get
    End Property

    Private m_titleId As String
    Property titleId As String
        Get
            Return m_titleId
        End Get
        Set(ByVal value As String)
            m_titleId = value
        End Set
    End Property

    Private m_firstName As String
    Property firstName As String
        Get
            Return m_firstName
        End Get
        Set(ByVal value As String)
            m_firstName = value
        End Set
    End Property

    Private m_secondName As String
    Property secondName As String
        Get
            Return m_secondName
        End Get
        Set(ByVal value As String)
            m_secondName = value
        End Set
    End Property

    Private m_surname As String
    Property surname As String
        Get
            Return m_surname
        End Get
        Set(ByVal value As String)
            m_surname = value
        End Set
    End Property

    Private m_natIdNumber As String
    Property natIdNumber As String
        Get
            Return m_natIdNumber
        End Get
        Set(ByVal value As String)
            m_natIdNumber = value
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

    Private m_sexId As String
    Property sexId As String
        Get
            Return m_sexId
        End Get
        Set(ByVal value As String)
            m_sexId = value
        End Set
    End Property

    Private m_dateOfBirth As String
    Property dateOfBirth As String
        Get
            Return m_dateOfBirth
        End Get
        Set(ByVal value As String)
            m_dateOfBirth = value
        End Set
    End Property

    Private m_jobTitleId As String
    Property jobTitleId As String
        Get
            Return m_jobTitleId
        End Get
        Set(ByVal value As String)
            m_jobTitleId = value
        End Set
    End Property

    Private m_schoolStaffPositionId As String
    Property schoolStaffPositionId As String
        Get
            Return m_schoolStaffPositionId
        End Get
        Set(ByVal value As String)
            m_schoolStaffPositionId = value
        End Set
    End Property

    Private m_dateOfInitiation As String
    Property dateOfInitiation As String
        Get
            Return m_dateOfInitiation
        End Get
        Set(ByVal value As String)
            m_dateOfInitiation = value
        End Set
    End Property

    Private m_dateAppointedToSchool As String
    Property dateAppointedToSchool As String
        Get
            Return m_dateAppointedToSchool
        End Get
        Set(ByVal value As String)
            m_dateAppointedToSchool = value
        End Set
    End Property

    Private m_contactNumber As String
    Property contactNumber As String
        Get
            Return m_contactNumber
        End Get
        Set(ByVal value As String)
            m_contactNumber = value
        End Set
    End Property

    Private m_homeAddress As String
    Property homeAddress As String
        Get
            Return m_homeAddress
        End Get
        Set(ByVal value As String)
            m_homeAddress = value
        End Set
    End Property

    Private m_maritalStatusId As String
    Property maritalStatusId As String
        Get
            Return m_maritalStatusId
        End Get
        Set(ByVal value As String)
            m_maritalStatusId = value
        End Set
    End Property

    Private m_numberOfDependants As String
    Property numberOfDependants As String
        Get
            Return m_numberOfDependants
        End Get
        Set(ByVal value As String)
            m_numberOfDependants = value
        End Set
    End Property

    Private m_nextOfKinName As String
    Property nextOfKinName As String
        Get
            Return m_nextOfKinName
        End Get
        Set(ByVal value As String)
            m_nextOfKinName = value
        End Set
    End Property
    Private m_nextOfKinSurname As String
    Property nextOfKinSurname As String
        Get
            Return m_nextOfKinSurname
        End Get
        Set(ByVal value As String)
            m_nextOfKinSurname = value
        End Set
    End Property

    Private m_relationshipId As String
    Property relationshipId As String
        Get
            Return m_relationshipId
        End Get
        Set(ByVal value As String)
            m_relationshipId = value
        End Set
    End Property

    Private m_nextOfKinContactNumber As String
    Property nextOfKinContactNumber As String
        Get
            Return m_nextOfKinContactNumber
        End Get
        Set(ByVal value As String)
            m_nextOfKinContactNumber = value
        End Set
    End Property

    Private m_nextOfKinAddress As String
    Property nextOfKinAddress As String
        Get
            Return m_nextOfKinAddress
        End Get
        Set(ByVal value As String)
            m_nextOfKinAddress = value
        End Set
    End Property

    Private m_salary As String
    Property salary As String
        Get
            Return m_salary
        End Get
        Set(ByVal value As String)
            m_salary = value
        End Set
    End Property

    Private m_officeNumber As String
    Property officeNumber As String
        Get
            Return m_officeNumber
        End Get
        Set(ByVal value As String)
            m_officeNumber = value
        End Set
    End Property

    Private m_dateLeft As String
    Property dateLeft As String
        Get
            Return m_dateLeft
        End Get
        Set(ByVal value As String)
            m_dateLeft = value
        End Set
    End Property

    Private m_reasonForLeavingId As String
    Property reasonForLeavingId As String
        Get
            Return m_reasonForLeavingId
        End Get
        Set(ByVal value As String)
            m_reasonForLeavingId = value
        End Set
    End Property

    Private m_healthConditionId As String
    Property healthConditionId As String
        Get
            Return m_healthConditionId
        End Get
        Set(ByVal value As String)
            m_healthConditionId = value
        End Set
    End Property

    Private m_emailAddress As String
    Property emailAddress As String
        Get
            Return m_emailAddress
        End Get
        Set(ByVal value As String)
            m_emailAddress = value
        End Set
    End Property

    Private m_title As String
    Property title As String
        Get
            Return m_title
        End Get
        Set(ByVal value As String)
            m_title = value
        End Set
    End Property

    Private m_Sex As String
    Property sex As String
        Get
            Return m_Sex
        End Get
        Set(ByVal value As String)
            m_Sex = value
        End Set
    End Property

    Private m_mStatus As String
    Property mStatus As String
        Get
            Return m_mStatus
        End Get
        Set(ByVal value As String)
            m_mStatus = value
        End Set
    End Property


    Private m_unitSectionId As String
    Property unitSectionId As String
        Get
            Return m_unitSectionId
        End Get
        Set(ByVal value As String)
            m_unitSectionId = value
        End Set
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

    Public Function SearchStaff() As DataSet

        Dim sql As String = "select T.title, firstName, secondName, Surname, natIdNumber,employmentNumber, J.sex,contactNumber,emailAddress from   tbl_staffDetails S join tbl_titles T on S.titleId=T.titleId join tbl_sex J on J.sexId = S.sexId join tbl_maritalStatuses MS on MS.maritalStatusId = S.maritalStatusId where S.titleId like '%" & titleId & "%'and firstname like'%" & firstName & "%'and surname like '%" & surname & "%' and employmentNumber like '%" & employmentNumber & "%' and S.sexId like '%" & sexId & "%' and S.maritalStatusId like '%" & maritalStatusId & "%'"

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            Return db.ExecuteDataSet(CommandType.Text, sql)
        Catch ex As Exception
            log.Error(ex)
            Return Nothing
        End Try

    End Function

    Public Sub Save()

        Dim sql As String = "insert into tbl_staffDetails (titleId,firstName, secondName,surname,natIdNumber, employmentNumber, sexId, dateOfBirth,dateOfInitiation,dateAppointedToSchool, contactNumber, homeAddress, maritalStatusId, numberOfDependants, nextOfKinName, nextOfKinContactNumber, nextOfKinAddress, salary, officeNumber,emailAddress ) values('" & titleId & "','" & firstName & "','" & secondName & "','" & surname & "','" & natIdNumber & "','" & employmentNumber & "','" & sexId & "','" & dateOfBirth & "','" & dateOfInitiation & "','" & dateAppointedToSchool & "','" & contactNumber & "','" & homeAddress & "','" & maritalStatusId & "','" & numberOfDependants & "','" & nextOfKinName & "','" & nextOfKinContactNumber & "','" & nextOfKinAddress & "','" & salary & "','" & officeNumber & "','" & emailAddress & "')"


        Try
            db.ExecuteNonQuery(CommandType.Text, sql)
        Catch ex As Exception
            log.Error(ex)

        End Try


    End Sub

    Public Function load(ByRef stuffNumber As String) As DataSet

        Dim sql As String = "select * from   tbl_staffDetails S join tbl_titles T on S.titleId=T.titleId join tbl_sex J on J.sexId = S.sexId join tbl_maritalStatuses MS on MS.maritalStatusId = S.maritalStatusId where employmentNumber = '" + stuffNumber + "'"

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            Return db.ExecuteDataSet(CommandType.Text, sql)
        Catch ex As Exception
            log.Error(ex)
            Return Nothing
        End Try

    End Function


    Public Sub Update(ByVal titleId As String, ByVal firstName As String, ByVal secondName As String, ByVal surname As String, ByVal natIdNumber As String, ByVal employmentNumber As String, ByVal sexId As String, ByVal dateOfBirth As String, ByVal jobTitleId As String, ByVal schoolStaffPositionId As String, ByVal dateOfInitiation As String, ByVal dateAppointedToSchool As String, ByVal contactNumber As String, ByVal homeAddress As String, ByVal maritalStatusId As String, ByVal numberOfDependants As String, ByVal nextOfKinName As String, ByVal relationshipId As String, ByVal nextOfKinContactNumber As String, ByVal nextOfKinAddress As String, ByVal salary As String, ByVal officeNumber As String, ByVal dateLeft As String, ByVal reasonForLeavingId As String, ByVal healthConditionId As String, ByVal emailAddress As String, ByVal unitSectionId As String)
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand("Update_tbl_staffDetails", conn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@titleId", titleId)
        cmd.Parameters.AddWithValue("@firstName", firstName)
        cmd.Parameters.AddWithValue("@secondName", secondName)
        cmd.Parameters.AddWithValue("@surname", surname)
        cmd.Parameters.AddWithValue("@natIdNumber", natIdNumber)
        cmd.Parameters.AddWithValue("@employmentNumber", employmentNumber)
        cmd.Parameters.AddWithValue("@sexId", sexId)
        cmd.Parameters.AddWithValue("@dateOfBirth", dateOfBirth)
        cmd.Parameters.AddWithValue("@jobTitleId", jobTitleId)
        cmd.Parameters.AddWithValue("@schoolStaffPositionId", schoolStaffPositionId)
        cmd.Parameters.AddWithValue("@dateOfInitiation", dateOfInitiation)
        cmd.Parameters.AddWithValue("@dateAppointedToSchool", dateAppointedToSchool)
        cmd.Parameters.AddWithValue("@contactNumber", contactNumber)
        cmd.Parameters.AddWithValue("@homeAddress", homeAddress)
        cmd.Parameters.AddWithValue("@maritalStatusId", maritalStatusId)
        cmd.Parameters.AddWithValue("@numberOfDependants", numberOfDependants)
        cmd.Parameters.AddWithValue("@nextOfKinName", nextOfKinName)
        cmd.Parameters.AddWithValue("@relationshipId", relationshipId)
        cmd.Parameters.AddWithValue("@nextOfKinContactNumber", nextOfKinContactNumber)
        cmd.Parameters.AddWithValue("@nextOfKinAddress", nextOfKinAddress)
        cmd.Parameters.AddWithValue("@salary", salary)
        cmd.Parameters.AddWithValue("@officeNumber", officeNumber)
        cmd.Parameters.AddWithValue("@dateLeft", dateLeft)
        cmd.Parameters.AddWithValue("@reasonForLeavingId", reasonForLeavingId)
        cmd.Parameters.AddWithValue("@healthConditionId", healthConditionId)
        cmd.Parameters.AddWithValue("@emailAddress", emailAddress)
        cmd.Parameters.AddWithValue("@unitSectionId", unitSectionId)

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

    Public Sub Insert(ByVal titleId As String, ByVal firstName As String, ByVal secondName As String, ByVal surname As String, ByVal natIdNumber As String, ByVal employmentNumber As String, ByVal sexId As String, ByVal dateOfBirth As String, ByVal jobTitleId As String, ByVal schoolStaffPositionId As String, ByVal dateOfInitiation As String, ByVal dateAppointedToSchool As String, ByVal contactNumber As String, ByVal homeAddress As String, ByVal maritalStatusId As String, ByVal numberOfDependants As String, ByVal nextOfKinName As String, ByVal relationshipId As String, ByVal nextOfKinContactNumber As String, ByVal nextOfKinAddress As String, ByVal salary As String, ByVal officeNumber As String, ByVal dateLeft As String, ByVal reasonForLeavingId As String, ByVal healthConditionId As String, ByVal emailAddress As String, ByVal unitSectionId As String)
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand("Insert_tbl_staffDetails", conn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@titleId", titleId)
        cmd.Parameters.AddWithValue("@firstName", firstName)
        cmd.Parameters.AddWithValue("@secondName", secondName)
        cmd.Parameters.AddWithValue("@surname", surname)
        cmd.Parameters.AddWithValue("@natIdNumber", natIdNumber)
        cmd.Parameters.AddWithValue("@employmentNumber", employmentNumber)
        cmd.Parameters.AddWithValue("@sexId", sexId)
        cmd.Parameters.AddWithValue("@dateOfBirth", dateOfBirth)
        cmd.Parameters.AddWithValue("@jobTitleId", jobTitleId)
        cmd.Parameters.AddWithValue("@schoolStaffPositionId", schoolStaffPositionId)
        cmd.Parameters.AddWithValue("@dateOfInitiation", dateOfInitiation)
        cmd.Parameters.AddWithValue("@dateAppointedToSchool", dateAppointedToSchool)
        cmd.Parameters.AddWithValue("@contactNumber", contactNumber)
        cmd.Parameters.AddWithValue("@homeAddress", homeAddress)
        cmd.Parameters.AddWithValue("@maritalStatusId", maritalStatusId)
        cmd.Parameters.AddWithValue("@numberOfDependants", numberOfDependants)
        cmd.Parameters.AddWithValue("@nextOfKinName", nextOfKinName)
        cmd.Parameters.AddWithValue("@relationshipId", relationshipId)
        cmd.Parameters.AddWithValue("@nextOfKinContactNumber", nextOfKinContactNumber)
        cmd.Parameters.AddWithValue("@nextOfKinAddress", nextOfKinAddress)
        cmd.Parameters.AddWithValue("@salary", salary)
        cmd.Parameters.AddWithValue("@officeNumber", officeNumber)
        cmd.Parameters.AddWithValue("@dateLeft", dateLeft)
        cmd.Parameters.AddWithValue("@reasonForLeavingId", reasonForLeavingId)
        cmd.Parameters.AddWithValue("@healthConditionId", healthConditionId)
        cmd.Parameters.AddWithValue("@emailAddress", emailAddress)
        cmd.Parameters.AddWithValue("@unitSectionId", unitSectionId)

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
        Dim cmd As New SqlCommand("Delete_tbl_staffDetails", conn)
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

        Dim sql As String = "select * from tbl_staffDetails"

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            Return db.ExecuteDataSet(CommandType.Text, sql)
        Catch ex As Exception
            log.Error(ex)
            Return Nothing
        End Try
    End Function
End Class


