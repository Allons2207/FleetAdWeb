Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data

Public Class StudentsPortalPersonalDetails
    Inherits System.Web.UI.Page

    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        loadStudentDetails()
    End Sub

    Private Sub loadStudentDetails()
        Dim sql As String = " SELECT dbo.tbl_students.studentId, dbo.tbl_students.firstName, dbo.tbl_students.secondName, " & _
                            " dbo.tbl_students.surname, dbo.tbl_students.registrationDate, dbo.tbl_students.dateOfBirth, " & _
                            " dbo.tbl_students.birthNumber, dbo.tbl_students.nationalIdNumber, dbo.tbl_sex.sex, dbo.tbl_students.homeAddress, " & _
                            " dbo.tbl_hostels.hostel, dbo.tbl_schoolClasses.schoolClass, dbo.tbl_students.guardianFirstname, " & _
                            " dbo.tbl_students.guardianSurname, dbo.tbl_relationships.relationship, dbo.tbl_titles.title, " & _
                            " dbo.tbl_students.guardianAddress, dbo.tbl_students.guardianContactNumber, dbo.tbl_students.emailAddress, " & _
                            " dbo.tbl_students.guardianEmailAddress, dbo.tbl_students.studentContactNumber, dbo.tbl_students.city, " & _
                            " dbo.tbl_students.suburb, dbo.tbl_students.unitSection, dbo.tbl_students.registeredBy " & _
                            " FROM            dbo.tbl_students INNER JOIN " & _
                            " dbo.tbl_sex ON dbo.tbl_students.sexId = dbo.tbl_sex.sexId INNER JOIN " & _
                            " dbo.tbl_hostels ON dbo.tbl_students.hostelId = dbo.tbl_hostels.hostelId INNER JOIN " & _
                            "  dbo.tbl_schoolClasses ON dbo.tbl_students.schoolClassId = dbo.tbl_schoolClasses.schoolClassId INNER JOIN " & _
                            "  dbo.tbl_relationships ON dbo.tbl_students.guardianTitleId = dbo.tbl_relationships.relationshipId INNER JOIN " & _
                            "  dbo.tbl_titles ON dbo.tbl_students.guardianTitleId = dbo.tbl_titles.titleId INNER JOIN " & _
                            "  dbo.tbl_occupations ON dbo.tbl_students.guardianOccupationId = dbo.tbl_occupations.occupationId INNER JOIN " & _
                            "  dbo.tbl_sportHouses ON dbo.tbl_students.sportsHouseId = dbo.tbl_sportHouses.sportsHouseId WHERE " & _
                            " dbo.tbl_students.studentId = '" & CokkiesWrapper.StudentID & "'"

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            db.ExecuteDataSet(CommandType.Text, sql)

            If ds.Tables.Count > 0 Then
                If ds.Tables(0).Rows.Count > 0 Then
                    txtFName.Text = ds.Tables(0).Rows(0)("firstName").ToString
                    txtSecName.Text = ds.Tables(0).Rows(0)("secondName").ToString
                    txtSurname.Text = ds.Tables(0).Rows(0)("surname").ToString
                    '  txtStream.Text = ds.Tables(0).Rows(0)("examDate").ToString
                    txtClass.Text = ds.Tables(0).Rows(0)("schoolClass").ToString
                    txtStudentNo.Text = ds.Tables(0).Rows(0)("studentId").ToString
                    txtRegNum.Text = ds.Tables(0).Rows(0)("registrationDate").ToString
                    ' txtStudentContactNum.Text = ds.Tables(0).Rows(0)("examDate").ToString
                    ' txtStudentEmail.Text = ds.Tables(0).Rows(0)("examDate").ToString
                    txtDOB.Text = ds.Tables(0).Rows(0)("dateOfBirth").ToString
                    txtBirthNo.Text = ds.Tables(0).Rows(0)("birthNumber").ToString
                    txtIDNo.Text = ds.Tables(0).Rows(0)("nationalIdNumber").ToString
                    txtSex.Text = ds.Tables(0).Rows(0)("sex").ToString
                    txtCity.Text = ds.Tables(0).Rows(0)("city").ToString
                    txtSuburb.Text = ds.Tables(0).Rows(0)("suburb").ToString
                    txtSection.Text = ds.Tables(0).Rows(0)("unitSection").ToString
                    txtStreetAddress.Text = ds.Tables(0).Rows(0)("homeAddress").ToString
                    txtGuardianTitle.Text = ds.Tables(0).Rows(0)("title").ToString
                    txtGuardianFName.Text = ds.Tables(0).Rows(0)("guardianFirstname").ToString
                    txtGuardianSurname.Text = ds.Tables(0).Rows(0)("guardianSurname").ToString
                    txtGuardianToStudentRelationshp.Text = ds.Tables(0).Rows(0)("relationship").ToString
                    '  txtGuardianOccupation.Text = ds.Tables(0).Rows(0)("examDate").ToString
                    txtGContactNo.Text = ds.Tables(0).Rows(0)("guardianContactNumber").ToString
                    txtGAddress.Text = ds.Tables(0).Rows(0)("guardianAddress").ToString
                    txtGEmail.Text = ds.Tables(0).Rows(0)("guardianEmailAddress").ToString
                End If
            End If

        Catch ex As Exception
            ' log.Error(ex)
        End Try








    End Sub






End Class