Imports Microsoft.Practices.EnterpriseLibrary.Common
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System
Imports System.Collections.Generic
Imports System.Text
Imports System.Data
Imports System.Data.SqlClient
Imports System.Collections
Imports System.Configuration
Imports System.Web


Public Class Student
    Public Property ErrorMessage As String = String.Empty
    Private Shared ReadOnly log As log4net.ILog = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType)

    Private mConnectionString As String
    Property ConnectionString As String
        Get
            Return mConnectionString
        End Get
        Set(ByVal value As String)
            mConnectionString = value
        End Set
    End Property

    Private m_ctr As String
    Protected db As Database
    Public ReadOnly Property Database() As Database
        Get
            Return db
        End Get
    End Property
    Property ctr As String
        Get
            Return m_ctr
        End Get
        Set(ByVal value As String)
            m_ctr = value
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
    Private m_stream As String
    Property stream As String
        Get
            Return m_stream
        End Get
        Set(ByVal value As String)
            m_stream = value
        End Set
    End Property
    Private m_class As String
    Property classes As String
        Get
            Return m_class
        End Get
        Set(ByVal value As String)
            m_class = value
        End Set
    End Property
    Private m_sex As String
    Property sex As String
        Get
            Return m_sex
        End Get
        Set(ByVal value As String)
            m_sex = value
        End Set
    End Property
    Private m_mstatus As String
    Property mstatus As String
        Get
            Return m_mstatus
        End Get
        Set(ByVal value As String)
            m_mstatus = value
        End Set
    End Property

    Private m_ostatus As String
    Property ostatus As String
        Get
            Return m_ostatus
        End Get
        Set(ByVal value As String)
            m_ostatus = value
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

    Private m_registrationDate As String
    Property registrationDate As String
        Get
            Return m_registrationDate
        End Get
        Set(ByVal value As String)
            m_registrationDate = value
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

    Private m_birthNumber As String
    Property birthNumber As String
        Get
            Return m_birthNumber
        End Get
        Set(ByVal value As String)
            m_birthNumber = value
        End Set
    End Property

    Private m_nationalIdNumber As String
    Property nationalIdNumber As String
        Get
            Return m_nationalIdNumber
        End Get
        Set(ByVal value As String)
            m_nationalIdNumber = value
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

    Private m_status As String
    Property status As String
        Get
            Return m_status
        End Get
        Set(ByVal value As String)
            m_status = value
        End Set
    End Property

    Private m_studentPicture As String
    Property studentPicture As String
        Get
            Return m_studentPicture
        End Get
        Set(ByVal value As String)
            m_studentPicture = value
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

    Private m_unitSectionId As String
    Property unitSectionId As String
        Get
            Return m_unitSectionId
        End Get
        Set(ByVal value As String)
            m_unitSectionId = value
        End Set
    End Property

    Private m_hostelId As String
    Property hostelId As String
        Get
            Return m_hostelId
        End Get
        Set(ByVal value As String)
            m_hostelId = value
        End Set
    End Property

    Private m_schoolClassId As String
    Property schoolClassId As String
        Get
            Return m_schoolClassId
        End Get
        Set(ByVal value As String)
            m_schoolClassId = value
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

    Private m_allergy1Id As String
    Property allergy1Id As String
        Get
            Return m_allergy1Id
        End Get
        Set(ByVal value As String)
            m_allergy1Id = value
        End Set
    End Property

    Private m_allergy2Id As String
    Property allergy2Id As String
        Get
            Return m_allergy2Id
        End Get
        Set(ByVal value As String)
            m_allergy2Id = value
        End Set
    End Property

    Private m_religionId As String
    Property religionId As String
        Get
            Return m_religionId
        End Get
        Set(ByVal value As String)
            m_religionId = value
        End Set
    End Property

    Private m_schoolPositionId As String
    Property schoolPositionId As String
        Get
            Return m_schoolPositionId
        End Get
        Set(ByVal value As String)
            m_schoolPositionId = value
        End Set
    End Property

    Private m_boardingStatusId As String
    Property boardingStatusId As String
        Get
            Return m_boardingStatusId
        End Get
        Set(ByVal value As String)
            m_boardingStatusId = value
        End Set
    End Property

    Private m_disabilityId As String
    Property disabilityId As String
        Get
            Return m_disabilityId
        End Get
        Set(ByVal value As String)
            m_disabilityId = value
        End Set
    End Property

    Private m_orphanhoodStatusId As String
    Property orphanhoodStatusId As String
        Get
            Return m_orphanhoodStatusId
        End Get
        Set(ByVal value As String)
            m_orphanhoodStatusId = value
        End Set
    End Property

    Private m_guardianFirstname As String
    Property guardianFirstname As String
        Get
            Return m_guardianFirstname
        End Get
        Set(ByVal value As String)
            m_guardianFirstname = value
        End Set
    End Property

    Private m_guardianSurname As String
    Property guardianSurname As String
        Get
            Return m_guardianSurname
        End Get
        Set(ByVal value As String)
            m_guardianSurname = value
        End Set
    End Property

    Private m_relationshipToStudentId As String
    Property relationshipToStudentId As String
        Get
            Return m_relationshipToStudentId
        End Get
        Set(ByVal value As String)
            m_relationshipToStudentId = value
        End Set
    End Property

    Private m_guardianTitleId As String
    Property guardianTitleId As String
        Get
            Return m_guardianTitleId
        End Get
        Set(ByVal value As String)
            m_guardianTitleId = value
        End Set
    End Property

    Private m_guardianOccupationId As String
    Property guardianOccupationId As String
        Get
            Return m_guardianOccupationId
        End Get
        Set(ByVal value As String)
            m_guardianOccupationId = value
        End Set
    End Property

    Private m_guardianAddress As String
    Property guardianAddress As String
        Get
            Return m_guardianAddress
        End Get
        Set(ByVal value As String)
            m_guardianAddress = value
        End Set
    End Property

    Private m_guardianContactNumber As String
    Property guardianContactNumber As String
        Get
            Return m_guardianContactNumber
        End Get
        Set(ByVal value As String)
            m_guardianContactNumber = value
        End Set
    End Property

    Private m_sportsHouseId As String
    Property sportsHouseId As String
        Get
            Return m_sportsHouseId
        End Get
        Set(ByVal value As String)
            m_sportsHouseId = value
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

    Private m_reasonForStudentLeavingId As String
    Property reasonForStudentLeavingId As String
        Get
            Return m_reasonForStudentLeavingId
        End Get
        Set(ByVal value As String)
            m_reasonForStudentLeavingId = value
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

    Private m_guardianEmailAddress As String
    Property guardianEmailAddress As String
        Get
            Return m_guardianEmailAddress
        End Get
        Set(ByVal value As String)
            m_guardianEmailAddress = value
        End Set
    End Property

    Private m_studentMaritalStatusId As String
    Property studentMaritalStatusId As String
        Get
            Return m_studentMaritalStatusId
        End Get
        Set(ByVal value As String)
            m_studentMaritalStatusId = value
        End Set
    End Property

    Private m_guardianMaritalStatusId As String
    Property guardianMaritalStatusId As String
        Get
            Return m_guardianMaritalStatusId
        End Get
        Set(ByVal value As String)
            m_guardianMaritalStatusId = value
        End Set
    End Property

    Private m_requiresTransportation As String
    Property requiresTransportation As String
        Get
            Return m_requiresTransportation
        End Get
        Set(ByVal value As String)
            m_requiresTransportation = value
        End Set
    End Property

    Private m_studentContactNumber As String
    Property studentContactNumber As String
        Get
            Return m_studentContactNumber
        End Get
        Set(ByVal value As String)
            m_studentContactNumber = value
        End Set
    End Property

    Private m_contractEndDate As String
    Property contractEndDate As String
        Get
            Return m_contractEndDate
        End Get
        Set(ByVal value As String)
            m_contractEndDate = value
        End Set
    End Property

    Private m_paymentFrequencyId As String
    Property paymentFrequencyId As String
        Get
            Return m_paymentFrequencyId
        End Get
        Set(ByVal value As String)
            m_paymentFrequencyId = value
        End Set
    End Property

    Private m_registeredBy As String
    Property registeredBy As String
        Get
            Return m_registeredBy
        End Get
        Set(ByVal value As String)
            m_registeredBy = value
        End Set
    End Property

    Private m_studentUnitSection As String
    Property studentUnitSection As String
        Get
            Return m_studentUnitSection
        End Get
        Set(ByVal value As String)
            m_studentUnitSection = value
        End Set
    End Property

    Private m_studentSuburb As String
    Property studentSuburb As String
        Get
            Return m_studentSuburb
        End Get
        Set(ByVal value As String)
            m_studentSuburb = value
        End Set
    End Property


    Private m_studentCity As String
    Property studentCity As String
        Get
            Return m_studentCity
        End Get
        Set(ByVal value As String)
            m_studentCity = value
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
    Public Function SearchStudents() As DataSet

        Dim sql As String = "SELECT [studentId],[firstName]+ ' ' +[secondName] AS Name,[surname],j.sex,[homeAddress],SC.schoolClass,tbl_religions.religion,[guardianFirstname] AS GuardianName,tbl_relationships.relationship,[guardianContactNumber] AS GuardianContact,tbl_sportHouses.sportsHouse FROM [dbo].[tbl_students] S left outer join tbl_orphanhoodStatuses on tbl_orphanhoodStatuses.orphanhoodStatusId = S.orphanhoodStatusId left outer join tbl_sportHouses on tbl_sportHouses.sportsHouseId = s.sportsHouseId left outer join tbl_religions on tbl_religions.religionId = s.religionId left outer join tbl_relationships on tbl_relationships.relationshipId = s.relationshipToStudentId left outer join tbl_titles on tbl_titles.titleId = s.guardianTitleId left outer join tbl_occupations on tbl_occupations.occupationId = s.guardianOccupationId left outer join tbl_sex J on J.sexId = S.sexId left outer Join tbl_schoolClasses SC on s.schoolClassId=sc.schoolClassId left outer join tbl_streams st on st.streamId = sc.streamId left outer JOIN tbl_maritalStatuses MS on MS.maritalStatusId=s.studentMaritalStatusId  left outer JOIN tbl_maritalStatuses on tbl_maritalStatuses.maritalStatusId=guardianMaritalStatusId left outer join [dbo].[tbl_healthConditions] ON [dbo].[tbl_healthConditions].healthConditionId = S.healthConditionId left outer join tbl_disabilities on tbl_disabilities.disabilityId = s.disabilityId left outer join tbl_boardingStatus on tbl_boardingStatus.boardingStatusId = s.boardingStatusId where firstName like '%" & firstName & "%' and surname like '%" & surname & "%' and studentId like '%" & studentId & "%' and S.sexId like '%" & sexId & "%' and  SC.schoolClass like '%" & classes & "%' and  s.studentMaritalStatusId like '%" & mstatus & "%' and s.orphanhoodStatusId like '%" & orphanhoodStatusId & "%' "
        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            Return db.ExecuteDataSet(CommandType.Text, sql)
        Catch ex As Exception
            log.Error(ex)
            Return Nothing
        End Try

    End Function
    Public Function selectRecords(ByRef studentNumber As String) As DataSet

        Dim sql As String = "SELECT * FROM [dbo].[tbl_students] S left outer join tbl_orphanhoodStatuses on tbl_orphanhoodStatuses.orphanhoodStatusId = S.orphanhoodStatusId left outer join tbl_sportHouses on tbl_sportHouses.sportsHouseId = s.sportsHouseId left outer join tbl_religions on tbl_religions.religionId = s.religionId left outer join tbl_relationships on tbl_relationships.relationshipId = s.relationshipToStudentId left outer join tbl_titles on tbl_titles.titleId = s.guardianTitleId left outer join tbl_occupations on tbl_occupations.occupationId = s.guardianOccupationId left outer join tbl_sex J on J.sexId = S.sexId left outer Join tbl_schoolClasses SC on s.schoolClassId=sc.schoolClassId inner join tbl_streams st on st.streamId = sc.streamId left outer JOIN tbl_maritalStatuses MS on MS.maritalStatusId=s.studentMaritalStatusId where studentId = '" & studentNumber & "'"

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            Return db.ExecuteDataSet(CommandType.Text, sql)
        Catch ex As Exception
            log.Error(ex)
            Return Nothing
        End Try

    End Function


    Public Function GetData(ByVal IstudentID As String) As DataSet
        Try
            ' Dim sql As String = "SELECT * FROM [dbo].[tbl_students] S left outer join tbl_orphanhoodStatuses on tbl_orphanhoodStatuses.orphanhoodStatusId = S.orphanhoodStatusId left outer join tbl_sportHouses on tbl_sportHouses.sportsHouseId = s.sportsHouseId left outer join tbl_religions on tbl_religions.religionId = s.religionId left outer join tbl_relationships on tbl_relationships.relationshipId = s.relationshipToStudentId left outer join tbl_titles on tbl_titles.titleId = s.guardianTitleId left outer join tbl_occupations on tbl_occupations.occupationId = s.guardianOccupationId left outer join tbl_sex J on J.sexId = S.sexId left outer Join tbl_schoolClasses SC on s.schoolClassId=sc.schoolClassId left outer join tbl_streams st on st.streamId = sc.streamId left outer JOIN tbl_maritalStatuses MS on MS.maritalStatusId=s.studentMaritalStatusId  left outer JOIN tbl_maritalStatuses on tbl_maritalStatuses.maritalStatusId=guardianMaritalStatusId left outer join [dbo].[tbl_healthConditions] ON [dbo].[tbl_healthConditions].healthConditionId = S.healthConditionId left outer join tbl_disabilities on tbl_disabilities.disabilityId = s.disabilityId left outer join tbl_boardingStatus on tbl_boardingStatus.boardingStatusId = s.boardingStatusId  where studentid='" & IstudentID & "'"

            Dim sql As String = " SELECT dbo.tbl_students.ctr, dbo.tbl_students.studentId, dbo.tbl_students.firstName, dbo.tbl_students.secondName, " & _
                        " dbo.tbl_students.surname, dbo.tbl_students.registrationDate, dbo.tbl_students.dateOfBirth, " & _
                        "  dbo.tbl_students.birthNumber, dbo.tbl_students.nationalIdNumber, dbo.tbl_students.studentPicture, " & _
                        " dbo.tbl_students.homeAddress, dbo.tbl_students.boardingStatusId, dbo.tbl_students.disabilityId, " & _
                        " dbo.tbl_students.orphanhoodStatusId, dbo.tbl_students.guardianFirstname, dbo.tbl_students.guardianSurname, " & _
                        "  dbo.tbl_students.relationshipToStudentId, dbo.tbl_students.guardianTitleId, " & _
                        "  dbo.tbl_students.guardianOccupationId, dbo.tbl_students.guardianAddress, dbo.tbl_students.guardianContactNumber, " & _
                        " dbo.tbl_students.sportsHouseId, dbo.tbl_students.dateLeft, dbo.tbl_students.reasonForStudentLeavingId, " & _
                        " dbo.tbl_students.emailAddress, dbo.tbl_students.guardianEmailAddress, dbo.tbl_students.studentMaritalStatusId, " & _
                        "  dbo.tbl_students.guardianMaritalStatusId, dbo.tbl_students.requiresTransportation, dbo.tbl_students.studentContactNumber, " & _
                        " dbo.tbl_students.contractEndDate, dbo.tbl_students.registeredBy, dbo.tbl_students.status, dbo.tbl_sex.sexId, dbo.tbl_sex.sex, " & _
                        "  dbo.tbl_hostels.hostelId, dbo.tbl_hostels.hostel, dbo.tbl_schoolClasses.schoolClassId, dbo.tbl_schoolClasses.schoolClass, " & _
                        "  dbo.tbl_streams.streamId, dbo.tbl_streams.stream, dbo.tbl_healthConditions.healthCondition, " & _
                        "  dbo.tbl_healthConditions.healthConditionId, dbo.tbl_students.schoolPositionId, " & _
                        "  dbo.tbl_schoolStudentPositions.schoolStudentPosition, dbo.tbl_boardingStatus.boardingStatus, " & _
                        "  dbo.tbl_disabilities.disability, dbo.tbl_orphanhoodStatuses.orphanhoodStatus, dbo.tbl_maritalStatuses.maritalStatusId, " & _
                        "  dbo.tbl_maritalStatuses.maritalStatus, dbo.tbl_sportHouses.sportsHouse, dbo.tbl_occupations.occupation, dbo.tbl_titles.title, " & _
                        " dbo.tbl_relationships.relationship, dbo.tbl_religions.religion, dbo.tbl_students.religionId,  " & _
                        " dbo.tbl_students.unitSection, dbo.tbl_students.suburb, dbo.tbl_students.city " & _
          " FROM    dbo.tbl_occupations RIGHT OUTER JOIN dbo.tbl_students ON dbo.tbl_occupations.occupationId = dbo.tbl_students.guardianOccupationId LEFT OUTER JOIN " & _
                        "  dbo.tbl_maritalStatuses ON dbo.tbl_maritalStatuses.maritalStatusId = dbo.tbl_students.studentMaritalStatusId LEFT OUTER JOIN " & _
                        "  dbo.tbl_orphanhoodStatuses ON dbo.tbl_students.orphanhoodStatusId = dbo.tbl_orphanhoodStatuses.orphanhoodStatusId LEFT OUTER JOIN " & _
                        "  dbo.tbl_sportHouses ON dbo.tbl_students.sportsHouseId = dbo.tbl_sportHouses.sportsHouseId LEFT OUTER JOIN " & _
                        "  dbo.tbl_disabilities ON dbo.tbl_students.disabilityId = dbo.tbl_disabilities.disabilityId LEFT OUTER JOIN " & _
                        "  dbo.tbl_boardingStatus ON dbo.tbl_students.boardingStatusId = dbo.tbl_boardingStatus.boardingStatusId LEFT OUTER JOIN " & _
                        "  dbo.tbl_schoolStudentPositions ON dbo.tbl_students.schoolPositionId = dbo.tbl_schoolStudentPositions.schoolStudentPositionId LEFT OUTER JOIN " & _
                        "  dbo.tbl_healthConditions ON dbo.tbl_students.healthConditionId = dbo.tbl_healthConditions.healthConditionId LEFT OUTER JOIN " & _
                        "  dbo.tbl_streams INNER JOIN dbo.tbl_schoolClasses ON dbo.tbl_streams.streamId = dbo.tbl_schoolClasses.streamId " & _
                        "  ON dbo.tbl_students.schoolClassId = dbo.tbl_schoolClasses.schoolClassId LEFT OUTER JOIN " & _
                        "  dbo.tbl_sex ON dbo.tbl_students.sexId = dbo.tbl_sex.sexId LEFT OUTER JOIN " & _
                        "  dbo.tbl_hostels ON dbo.tbl_students.hostelId = dbo.tbl_hostels.hostelId LEFT OUTER JOIN " & _
                        "  dbo.tbl_titles ON dbo.tbl_students.guardianTitleId = dbo.tbl_titles.titleId LEFT OUTER JOIN " & _
                        "  dbo.tbl_relationships ON dbo.tbl_students.relationshipToStudentId = dbo.tbl_relationships.relationshipId LEFT OUTER JOIN " & _
                        "  dbo.tbl_religions ON dbo.tbl_students.religionId = dbo.tbl_religions.religionId " & _
                        " WHERE dbo.tbl_students.studentid='" & IstudentID & "'"

            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            If (ds.Tables.Count > 0 AndAlso ds.Tables(0).Rows.Count > 0) Then
                Return ds
            Else
                Return Nothing
            End If
        Catch ex As Exception

        End Try
    End Function

    Public Sub Update(ByVal ctr As String, ByVal studentId As String, ByVal firstName As String, ByVal secondName As String, ByVal surname As String, ByVal registrationDate As String, ByVal dateOfBirth As String, ByVal birthNumber As String, ByVal nationalIdNumber As String, ByVal sexId As String, ByVal studentPicture As String, ByVal homeAddress As String, ByVal unitSectionId As String, ByVal hostelId As String, ByVal schoolClassId As String, ByVal healthConditionId As String, ByVal allergy1Id As String, ByVal allergy2Id As String, ByVal religionId As String, ByVal schoolPositionId As String, ByVal boardingStatusId As String, ByVal disabilityId As String, ByVal orphanhoodStatusId As String, ByVal guardianFirstname As String, ByVal guardianSurname As String, ByVal relationshipToStudentId As String, ByVal guardianTitleId As String, ByVal guardianOccupationId As String, ByVal guardianAddress As String, ByVal guardianContactNumber As String, ByVal sportsHouseId As String, ByVal dateLeft As String, ByVal reasonForStudentLeavingId As String, ByVal emailAddress As String, ByVal guardianEmailAddress As String, ByVal studentMaritalStatusId As String, ByVal guardianMaritalStatusId As String, ByVal requiresTransportation As String, ByVal studentContactNumber As String, ByVal contractEndDate As String, ByVal paymentFrequencyId As String, ByVal registeredBy As String)
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand("Update_tbl_students", conn)
        cmd.CommandType = CommandType.StoredProcedure
        'cmd.Parameters.AddWithValue("@ctr", ctr)
        cmd.Parameters.AddWithValue("@studentId", studentId)
        cmd.Parameters.AddWithValue("@firstName", firstName)
        cmd.Parameters.AddWithValue("@secondName", secondName)
        cmd.Parameters.AddWithValue("@surname", surname)
        cmd.Parameters.AddWithValue("@registrationDate", registrationDate)
        cmd.Parameters.AddWithValue("@dateOfBirth", dateOfBirth)
        cmd.Parameters.AddWithValue("@birthNumber", birthNumber)
        cmd.Parameters.AddWithValue("@nationalIdNumber", nationalIdNumber)
        cmd.Parameters.AddWithValue("@sexId", sexId)
        cmd.Parameters.AddWithValue("@studentPicture", studentPicture)
        cmd.Parameters.AddWithValue("@homeAddress", homeAddress)
        cmd.Parameters.AddWithValue("@unitSectionId", unitSectionId)
        cmd.Parameters.AddWithValue("@hostelId", hostelId)
        cmd.Parameters.AddWithValue("@schoolClassId", schoolClassId)
        cmd.Parameters.AddWithValue("@healthConditionId", healthConditionId)
        cmd.Parameters.AddWithValue("@allergy1Id", allergy1Id)
        cmd.Parameters.AddWithValue("@allergy2Id", allergy2Id)
        cmd.Parameters.AddWithValue("@religionId", religionId)
        cmd.Parameters.AddWithValue("@schoolPositionId", schoolPositionId)
        cmd.Parameters.AddWithValue("@boardingStatusId", boardingStatusId)
        cmd.Parameters.AddWithValue("@disabilityId", disabilityId)
        cmd.Parameters.AddWithValue("@orphanhoodStatusId", orphanhoodStatusId)
        cmd.Parameters.AddWithValue("@guardianFirstname", guardianFirstname)
        cmd.Parameters.AddWithValue("@guardianSurname", guardianSurname)
        cmd.Parameters.AddWithValue("@relationshipToStudentId", relationshipToStudentId)
        cmd.Parameters.AddWithValue("@guardianTitleId", guardianTitleId)
        cmd.Parameters.AddWithValue("@guardianOccupationId", guardianOccupationId)
        cmd.Parameters.AddWithValue("@guardianAddress", guardianAddress)
        cmd.Parameters.AddWithValue("@guardianContactNumber", guardianContactNumber)
        cmd.Parameters.AddWithValue("@sportsHouseId", sportsHouseId)
        cmd.Parameters.AddWithValue("@dateLeft", dateLeft)
        cmd.Parameters.AddWithValue("@reasonForStudentLeavingId", reasonForStudentLeavingId)
        cmd.Parameters.AddWithValue("@emailAddress", emailAddress)
        cmd.Parameters.AddWithValue("@guardianEmailAddress", guardianEmailAddress)
        cmd.Parameters.AddWithValue("@studentMaritalStatusId", studentMaritalStatusId)
        cmd.Parameters.AddWithValue("@guardianMaritalStatusId", guardianMaritalStatusId)
        cmd.Parameters.AddWithValue("@requiresTransportation", requiresTransportation)
        cmd.Parameters.AddWithValue("@studentContactNumber", studentContactNumber)
        cmd.Parameters.AddWithValue("@contractEndDate", contractEndDate)
        cmd.Parameters.AddWithValue("@paymentFrequencyId", paymentFrequencyId)
        cmd.Parameters.AddWithValue("@registeredBy", registeredBy)
        cmd.Parameters.AddWithValue("@status", status)
        cmd.Parameters.AddWithValue("@unitSection", studentUnitSection)
        cmd.Parameters.AddWithValue("@suburb", studentSuburb)
        cmd.Parameters.AddWithValue("@city", studentCity)

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

    Public Sub UpdateStatus()
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand("sp_updateStudentStatus", conn)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.AddWithValue("@studentId", studentId)
        cmd.Parameters.AddWithValue("@status", status)

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
        Dim cmd As New SqlCommand("Insert_tbl_students", conn)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.AddWithValue("@studentId", studentId)
        cmd.Parameters.AddWithValue("@firstName", firstName)
        cmd.Parameters.AddWithValue("@secondName", secondName)
        cmd.Parameters.AddWithValue("@surname", surname)
        cmd.Parameters.AddWithValue("@registrationDate", registrationDate)
        cmd.Parameters.AddWithValue("@dateOfBirth", dateOfBirth)
        cmd.Parameters.AddWithValue("@birthNumber", birthNumber)
        cmd.Parameters.AddWithValue("@nationalIdNumber", nationalIdNumber)
        cmd.Parameters.AddWithValue("@sexId", sexId)
        cmd.Parameters.AddWithValue("@studentPicture", studentPicture)
        cmd.Parameters.AddWithValue("@homeAddress", homeAddress)

        cmd.Parameters.AddWithValue("@religionId", religionId)

        cmd.Parameters.AddWithValue("@hostelId", hostelId)
        cmd.Parameters.AddWithValue("@schoolClassId", schoolClassId)
        cmd.Parameters.AddWithValue("@healthConditionId", healthConditionId)
        cmd.Parameters.AddWithValue("@status", status)
        cmd.Parameters.AddWithValue("@schoolPositionId", schoolPositionId)
        cmd.Parameters.AddWithValue("@boardingStatusId", boardingStatusId)
        cmd.Parameters.AddWithValue("@disabilityId", disabilityId)
        cmd.Parameters.AddWithValue("@orphanhoodStatusId", orphanhoodStatusId)
        cmd.Parameters.AddWithValue("@guardianFirstname", guardianFirstname)
        cmd.Parameters.AddWithValue("@guardianSurname", guardianSurname)
        cmd.Parameters.AddWithValue("@relationshipToStudentId", relationshipToStudentId)
        cmd.Parameters.AddWithValue("@guardianTitleId", guardianTitleId)
        cmd.Parameters.AddWithValue("@guardianOccupationId", guardianOccupationId)
        cmd.Parameters.AddWithValue("@guardianAddress", guardianAddress)
        cmd.Parameters.AddWithValue("@guardianContactNumber", guardianContactNumber)
        cmd.Parameters.AddWithValue("@sportsHouseId", sportsHouseId)
        cmd.Parameters.AddWithValue("@dateLeft", dateLeft)
        cmd.Parameters.AddWithValue("@reasonForStudentLeavingId", reasonForStudentLeavingId)
        cmd.Parameters.AddWithValue("@emailAddress", emailAddress)
        cmd.Parameters.AddWithValue("@guardianEmailAddress", guardianEmailAddress)
        cmd.Parameters.AddWithValue("@studentMaritalStatusId", studentMaritalStatusId)
        cmd.Parameters.AddWithValue("@guardianMaritalStatusId", guardianMaritalStatusId)
        cmd.Parameters.AddWithValue("@requiresTransportation", requiresTransportation)
        cmd.Parameters.AddWithValue("@studentContactNumber", studentContactNumber)
        cmd.Parameters.AddWithValue("@contractEndDate", contractEndDate)
        cmd.Parameters.AddWithValue("@registeredBy", registeredBy)
        cmd.Parameters.AddWithValue("@unitSection", studentUnitSection)
        cmd.Parameters.AddWithValue("@suburb", studentSuburb)
        cmd.Parameters.AddWithValue("@city", studentCity)

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
        Dim cmd As New SqlCommand("Delete_tbl_students", conn)
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


End Class

