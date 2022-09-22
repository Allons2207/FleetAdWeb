Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Telerik.Web.UI
Imports System.Drawing

Public Class StudentDetails
    Inherits System.Web.UI.Page
    Private Shared ReadOnly log As log4net.ILog = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType)
    Dim objStudentDetails As New Student(CokkiesWrapper.thisConnectionName)
    Dim objStudentSubject As New StudentsSubjects(CokkiesWrapper.thisConnectionName)
    Dim objStudentClubs As New StudentClubs(CokkiesWrapper.thisConnectionName)
    Dim objStudentSports As New StudentSports(CokkiesWrapper.thisConnectionName)
    Dim objStudentExtraCurricula As New StudentExtraCurriculaActivities(CokkiesWrapper.thisConnectionName)
    Dim objExtraCurricula As New ExtraCurriculaActivities(CokkiesWrapper.thisConnectionName)
    Dim objRegistrationPayment As New RegistrationPayment(CokkiesWrapper.thisConnectionName)
    Dim objClubs As New Clubs(CokkiesWrapper.thisConnectionName)
    Dim objSports As New Sports(CokkiesWrapper.thisConnectionName)
    Dim objSubjects As New Subjects(CokkiesWrapper.thisConnectionName)
    Dim insRec As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim ds As DataSet
    Dim db As Database = objStudentDetails.Database
    Dim con As String = db.ConnectionString

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If (CokkiesWrapper.UserID <= 0 AndAlso Not IsNumeric(CokkiesWrapper.UserID)) Then
            Response.Redirect("../Login.aspx")
            Exit Sub
        End If

        obj.ConnectionString = con
        Dim accessMode As String = obj.groupAccessPermissionsDs(CokkiesWrapper.UserGroup, 2)

        Select Case accessMode
            Case "AllowReadNRead"
            Case "ReadNReadOnly"
                radtlbrMemberActions.Enabled = False
                ' cmdSave.Enabled = False
            Case "DenyAcces"
                Response.Redirect("~/AccessDenied.aspx")
                Exit Sub
            Case Else
                Response.Redirect("~/AccessDenied.aspx")
                Exit Sub
        End Select

        If Not IsPostBack Then

            LoadTreeViewData()
            LoadTreeViewClubsData()
            LoadTreeViewSportsData()
            LoadTreeViewExtraCurriculaData()
            DropDownListClass_Load()
            drpdwnGuardianMarital_Load()
            drpdwnGuardianRelationshp_Load()
            drpdwnSex_Load()
            drpdwnMaritalStatus_Load()
            drpdwnOpharnStatus_Load()
            drpdwnStudentTranspt_Load()
            txtGuardianTitle_Load()
            txtGuardianOccupation_Load()
            drpdwnBoardingStatus_Load()
            DropDownListDisability_Load()
            DropDownListHealthCndtn_Load()
            DropDownListHostel_Load()
            DropDownListReligion_Load()
            DropDownListSportHse_Load()
            DropDownListStreams_Load()

            DropDownListStudentPositions_Load()

            If Not IsNothing(Request.QueryString("op")) Then
                CokkiesWrapper.StudentID = Request.QueryString("op")
                loadStudentDetails(Request.QueryString("op"))
                LoadSubjectsTreeViewData(Request.QueryString("op"))
                LoadTreeViewStudentClubsData(Request.QueryString("op"))
                LoadTreeViewStudentSportsData(Request.QueryString("op"))
                LoadTreeViewStudentExtraCurriculaData(Request.QueryString("op"))
                gwBehaviourSearchLoad(Request.QueryString("op"))
                LibraryHistory(Request.QueryString("op"))
                LoadStudentAttendance(Request.QueryString("op"))
                loadStudentCourseWork(Request.QueryString("op"))
                loadStudentExaminationResults(Request.QueryString("op"))


                loadStudentFiles()


                lblMsg.BackColor = Color.Green
                lblMsg.ForeColor = Color.White
                lblMsg.Text = "Member Details were loaded successfully"


            End If
        End If
    End Sub

    Public Sub LoadTreeViewData()

        ds = objSubjects.SelectRecords()
        Try
            With RadTreeSubjects

                .DataFieldID = "subjectId"
                ' .DataFieldParentID = "ParentID"
                .DataTextField = "subject"
                .DataValueField = "subjectId"
                .DataSource = ds
                .DataBind()
            End With

        Catch ex As Exception
            log.Error(ex)

        End Try



    End Sub

    Public Sub LoadSubjectsTreeViewData(ByVal IstudeId As String)

        Try
            With RadTreeSubjects

                .DataFieldID = "subject"
                ' .DataFieldParentID = "ParentID"
                .DataTextField = "subject"
                .DataValueField = "subject"
                .DataSource = objSubjects.SelectRecords()
                .DataBind()
            End With


            lblMsg.BackColor = Color.Green
            lblMsg.ForeColor = Color.White
            lblMsg.Text = "Student subjects were loaded successlly!!!"

        Catch ex As Exception

            lblMsg.BackColor = Color.Red
            lblMsg.ForeColor = Color.White
            lblMsg.Text = "Student subjects were not loaded successlly!!!"

        End Try

    End Sub

    Private Sub RadTreeSubjects_NodeDataBound(sender As Object, e As RadTreeNodeEventArgs) Handles RadTreeSubjects.NodeDataBound
        Try
            If Not IsNothing(CokkiesWrapper.StudentID = Request.QueryString("op")) Then
                ds = objStudentSubject.GetRecords(CokkiesWrapper.StudentID)
            Else : ds = objSubjects.SelectRecords()

            End If

            ' Dim dsSubjects As DataSet = objSubjects.SelectRecords()

            Dim dr As DataRowView = e.Node.DataItem

            If Not dr Is Nothing Then

                If e.Node.Enabled Then e.Node.CollapseParentNodes()

                If ds.Tables.Count > 0 AndAlso ds.Tables(0).Rows.Count > 0 Then

                    For Each row As DataRow In ds.Tables(0).Rows

                        If e.Node.Value = row("subjectId") Then
                            e.Node.Checked = True

                        End If

                    Next

                End If

            End If

        Catch ex As Exception
            log.Error(ex)

        End Try
    End Sub
    Protected Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click

        'revoke

        objStudentSubject.ConnectionString = db.ConnectionString

        If RadTreeSubjects.CheckedNodes.Count > 0 Then
            If RadTreeSubjectsSaveUsercheckedNodes(RadTreeSubjects) Then

            Else
               

            End If
        End If

    End Sub

    Protected Function RadTreeSubjectsSaveUsercheckedNodes(ByVal RadTreeSubjects As Telerik.Web.UI.RadTreeView) As Boolean

        Dim NodeFullPath As String = ""
        Dim Subject As String

        Try

            'revoke existing user rights

            If RadTreeSubjects.CheckedNodes.Count > 0 Then

                Dim ds As DataSet = CreateErrorDataset()

                For Each Node As RadTreeNode In RadTreeSubjects.CheckedNodes

                    NodeFullPath = Node.FullPath
                    Subject = Node.Text
                    objStudentSubject.Insert(txtStudentNo.Text, Subject)

                Next Node
                DisplayErrors(ds)

                lblMsg.BackColor = Color.Green
                lblMsg.ForeColor = Color.White
                lblMsg.Text = "Student subjects were saved successfully!!!"
                Return True

            End If

        Catch ex As Exception

            lblMsg.BackColor = Color.Red
            lblMsg.ForeColor = Color.White
            lblMsg.Text = "Student subjects were not saved successfully!!!"
            Return False

        End Try


    End Function

    Public Sub Save()
        Try

            With objStudentDetails
                .ConnectionString = db.ConnectionString
                .firstName = txtFName.Text
                .secondName = txtSecName.Text
                .surname = txtSurname.Text
                .dateOfBirth = dateDOB.SelectedDate
                .emailAddress = txtGEmail.Text
                .guardianAddress = txtGAddress.Text
                .guardianContactNumber = txtGContactNo.Text
                .guardianEmailAddress = txtGEmail.Text
                .guardianFirstname = txtGuardianFName.Text
                .guardianMaritalStatusId = drpdwnGuardianMarital.SelectedValue
                .guardianOccupationId = txtGuardianOccupation.SelectedValue
                .guardianSurname = txtGuardianSurname.Text
                .guardianTitleId = txtGuardianTitle.SelectedValue
                .healthConditionId = DropDownListHealthCndtn.SelectedValue
                .homeAddress = txtStreetAddress.Text
                .studentMaritalStatusId = drpdwnMaritalStatus.SelectedValue
                .nationalIdNumber = txtIDNo.Text
                .orphanhoodStatusId = drpdwnOpharnStatus.SelectedValue
                '.ostatus = drpdwnOpharnStatus.SelectedItem.Text
                '.orphanhoodStatusId = drpdwnOpharnStatus.SelectedValue
                .registrationDate = dateRegistration.SelectedDate
                .relationshipToStudentId = drpdwnGuardianRelationshp.SelectedValue
                .sex = drpdwnSex.SelectedItem.Text
                .sexId = drpdwnSex.SelectedValue
                .requiresTransportation = drpdwnStudentTranspt.SelectedValue
                .schoolClassId = DropDownListClass.SelectedValue
                .registeredBy = CokkiesWrapper.UserName
                .schoolPositionId = DropDownListStudentPosition.SelectedValue
                .religionId = DropDownListReligion.SelectedValue
                .sportsHouseId = DropDownListSportHse.SelectedValue
                .hostelId = DropDownListHostel.SelectedValue
                .boardingStatusId = drpdwnBoardingStatus.SelectedValue
                .disabilityId = DropDownListDisability.SelectedValue
                .stream = DropDownListStreams.SelectedValue
                .studentContactNumber = txtContactno.Text
                .studentId = txtStudentNo.Text
                .studentMaritalStatusId = drpdwnMaritalStatus.SelectedValue
                .unitSectionId = txtSection.Text
                .birthNumber = txtBirthNo.Text
                .status = cbStudentStatus.Text
                .studentUnitSection = txtSection.Text
                .studentSuburb = txtSuburb.Text
                .studentCity = txtCity.Text

                .Insert()

            End With

            With objRegistrationPayment

                .amountPaid = 0
                .ConnectionString = con
                .intYear = Year(Today)
                .monthNumber = Month(Today)
                .studentId = txtStudentID.Text
                .expectedAmt = 20
                .Regdate = Today

                .Insert()

            End With

            lblMsg.BackColor = Color.Green
            lblMsg.ForeColor = Color.White
            lblMsg.Text = "Student Details were saved successfully!!!"

        Catch ex As Exception

            log.Error(ex)
            lblMsg.BackColor = Color.Red
            lblMsg.ForeColor = Color.White
            lblMsg.Text = "Student Details were not saved successfully!!!"

        End Try
    End Sub

    Public Sub loadStudentDetails(ByVal studentNumber As String)

        Dim dsStudentDetails As DataSet = objStudentDetails.GetData(studentNumber)

        '  Try
        If Not IsNothing(dsStudentDetails) AndAlso dsStudentDetails.Tables.Count > 0 AndAlso dsStudentDetails.Tables(0).Rows.Count > 0 Then

            'con = objStudentDetails.ConnectionString
            txtFName.Text = dsStudentDetails.Tables(0).Rows(0)("firstName")
            txtSecName.Text = dsStudentDetails.Tables(0).Rows(0)("secondName")
            txtSurname.Text = dsStudentDetails.Tables(0).Rows(0)("surname")
            dateDOB.SelectedDate = dsStudentDetails.Tables(0).Rows(0)("dateOfBirth")

            If Not IsDBNull(dsStudentDetails.Tables(0).Rows(0)("birthNumber")) Then
                txtBirthNo.Text = dsStudentDetails.Tables(0).Rows(0)("birthNumber")
            End If

            'txtGEmail.Text = dsStudentDetails.Tables(0).Rows(0)("emailAddress")

            If Not IsDBNull(dsStudentDetails.Tables(0).Rows(0)("guardianAddress")) Then
                txtGAddress.Text = dsStudentDetails.Tables(0).Rows(0)("guardianAddress")
            End If
            If Not IsDBNull(dsStudentDetails.Tables(0).Rows(0)("guardianContactNumber")) Then
                txtGContactNo.Text = dsStudentDetails.Tables(0).Rows(0)("guardianContactNumber")
            End If
            If Not IsDBNull(dsStudentDetails.Tables(0).Rows(0)("guardianEmailAddress")) Then
                txtGEmail.Text = dsStudentDetails.Tables(0).Rows(0)("guardianEmailAddress")
            End If
            If Not IsDBNull(dsStudentDetails.Tables(0).Rows(0)("guardianFirstname")) Then
                txtGuardianFName.Text = dsStudentDetails.Tables(0).Rows(0)("guardianFirstname")
            End If
            Dim gmid As Long = CInt(dsStudentDetails.Tables(0).Rows(0)("guardianMaritalStatusId"))
            'drpdwnGuardianMarital.SelectedValue = CInt(dsStudentDetails.Tables(0).Rows(0)("guardianMaritalStatusId"))
            drpdwnGuardianMarital.SelectedValue = gmid
            'drpdwnGuardianMarital.Text = dsStudentDetails.Tables(0).Rows(0)("MaritalStatus")
            If Not IsDBNull(dsStudentDetails.Tables(0).Rows(0)("Occupation")) Then
                txtGuardianOccupation.SelectedValue = dsStudentDetails.Tables(0).Rows(0)("guardianOccupationId")
                txtGuardianOccupation.Text = dsStudentDetails.Tables(0).Rows(0)("Occupation")
            End If

            If Not IsDBNull(dsStudentDetails.Tables(0).Rows(0)("schoolStudentPosition")) Then
                DropDownListStudentPosition.SelectedValue = dsStudentDetails.Tables(0).Rows(0)("schoolPositionId")
                DropDownListStudentPosition.Text = dsStudentDetails.Tables(0).Rows(0)("schoolStudentPosition")
            End If

            If Not IsDBNull(dsStudentDetails.Tables(0).Rows(0)("hostel")) Then
                DropDownListHostel.SelectedValue = dsStudentDetails.Tables(0).Rows(0)("hostelId")
                DropDownListHostel.Text = dsStudentDetails.Tables(0).Rows(0)("hostel")
            End If

            If Not IsDBNull(dsStudentDetails.Tables(0).Rows(0)("guardianSurname")) Then
                txtGuardianSurname.Text = dsStudentDetails.Tables(0).Rows(0)("guardianSurname")
            End If

            If Not IsDBNull(dsStudentDetails.Tables(0).Rows(0)("Title")) Then
                txtGuardianTitle.SelectedValue = dsStudentDetails.Tables(0).Rows(0)("guardianTitleId")
                txtGuardianTitle.Text = dsStudentDetails.Tables(0).Rows(0)("Title")
            End If
            If Not IsDBNull(dsStudentDetails.Tables(0).Rows(0)("healthCondition")) Then
                DropDownListHealthCndtn.SelectedValue = dsStudentDetails.Tables(0).Rows(0)("healthConditionId")
                DropDownListHealthCndtn.Text = dsStudentDetails.Tables(0).Rows(0)("healthCondition")
            End If
            If Not IsDBNull(dsStudentDetails.Tables(0).Rows(0)("homeAddress")) Then
                txtStreetAddress.Text = dsStudentDetails.Tables(0).Rows(0)("homeAddress")
            End If
            If Not IsDBNull(dsStudentDetails.Tables(0).Rows(0)("MaritalStatus")) Then
                drpdwnMaritalStatus.SelectedValue = dsStudentDetails.Tables(0).Rows(0)("studentMaritalStatusId")
                drpdwnMaritalStatus.Text = dsStudentDetails.Tables(0).Rows(0)("MaritalStatus")
            End If
            If Not IsDBNull(dsStudentDetails.Tables(0).Rows(0)("nationalIdNumber")) Then
                txtIDNo.Text = dsStudentDetails.Tables(0).Rows(0)("nationalIdNumber")
            End If

            drpdwnOpharnStatus.SelectedValue = dsStudentDetails.Tables(0).Rows(0)("orphanhoodStatusId")
            drpdwnOpharnStatus.Text = dsStudentDetails.Tables(0).Rows(0)("orphanhoodStatus")
            If Not IsDBNull(dsStudentDetails.Tables(0).Rows(0)("registrationDate")) Then
                dateRegistration.SelectedDate = dsStudentDetails.Tables(0).Rows(0)("registrationDate")
            End If

            If Not IsDBNull(dsStudentDetails.Tables(0).Rows(0)("relationship")) Then
                drpdwnGuardianRelationshp.SelectedValue = dsStudentDetails.Tables(0).Rows(0)("relationshipToStudentId")
                drpdwnGuardianRelationshp.Text = dsStudentDetails.Tables(0).Rows(0)("relationship")
            End If

            If Not IsDBNull(dsStudentDetails.Tables(0).Rows(0)("sex")) Then
                drpdwnSex.SelectedValue = dsStudentDetails.Tables(0).Rows(0)("sexId")
                drpdwnSex.Text = dsStudentDetails.Tables(0).Rows(0)("sex")
            End If
            '.sexId = drpdwnSex.SelectedValue = dsStudentDetails.Tables(0).Rows(0)("firstName")

            If Not IsDBNull(dsStudentDetails.Tables(0).Rows(0)("requiresTransportation")) Then
                If dsStudentDetails.Tables(0).Rows(0)("requiresTransportation") = 1 Then
                    drpdwnStudentTranspt.Text = "Require Transport"
                    drpdwnStudentTranspt.SelectedValue = 1
                ElseIf dsStudentDetails.Tables(0).Rows(0)("requiresTransportation") = 0 Then
                    drpdwnStudentTranspt.Text = "No Transport"
                    drpdwnStudentTranspt.SelectedValue = 0
                End If
            End If


            If Not IsDBNull(dsStudentDetails.Tables(0).Rows(0)("stream")) Then
                DropDownListStreams.SelectedValue = dsStudentDetails.Tables(0).Rows(0)("streamId")
                DropDownListStreams.Text = dsStudentDetails.Tables(0).Rows(0)("stream")
            End If

            If Not IsDBNull(dsStudentDetails.Tables(0).Rows(0)("schoolClass")) Then
                DropDownListClass.SelectedValue = dsStudentDetails.Tables(0).Rows(0)("schoolClassId")
                DropDownListClass.Text = dsStudentDetails.Tables(0).Rows(0)("schoolClass")
            End If
            '.registeredBy
            '.schoolPositionId
            If Not IsDBNull(dsStudentDetails.Tables(0).Rows(0)("religion")) Then
                DropDownListReligion.SelectedValue = dsStudentDetails.Tables(0).Rows(0)("religionId")
                DropDownListReligion.Text = dsStudentDetails.Tables(0).Rows(0)("religion")
            End If

            If Not IsDBNull(dsStudentDetails.Tables(0).Rows(0)("sportsHouse")) Then
                DropDownListSportHse.SelectedValue = dsStudentDetails.Tables(0).Rows(0)("sportsHouseId")
                DropDownListSportHse.Text = dsStudentDetails.Tables(0).Rows(0)("sportsHouse")
            End If

            'DropDownListHostel.SelectedItem.Text = dsStudentDetails.Tables(0).Rows(0)("hostel")

            If Not IsDBNull(dsStudentDetails.Tables(0).Rows(0)("status")) Then
                cbStudentStatus.SelectedValue = dsStudentDetails.Tables(0).Rows(0)("status")
                cbStudentStatus.Text = dsStudentDetails.Tables(0).Rows(0)("status")
            End If

            If Not IsDBNull(dsStudentDetails.Tables(0).Rows(0)("boardingStatus")) Then
                drpdwnBoardingStatus.SelectedValue = dsStudentDetails.Tables(0).Rows(0)("boardingStatusId")
                drpdwnBoardingStatus.Text = dsStudentDetails.Tables(0).Rows(0)("boardingStatus")
            End If

            If Not IsDBNull(dsStudentDetails.Tables(0).Rows(0)("disability")) Then
                DropDownListDisability.SelectedValue = dsStudentDetails.Tables(0).Rows(0)("disabilityId")
                DropDownListDisability.Text = dsStudentDetails.Tables(0).Rows(0)("disability")
            End If

           

            If Not IsDBNull(dsStudentDetails.Tables(0).Rows(0)("studentContactNumber")) Then
                txtContactno.Text = dsStudentDetails.Tables(0).Rows(0)("studentContactNumber")
            End If

            If Not IsDBNull(dsStudentDetails.Tables(0).Rows(0)("studentId")) Then
                txtStudentNo.Text = dsStudentDetails.Tables(0).Rows(0)("studentId")
            End If


            If Not IsDBNull(dsStudentDetails.Tables(0).Rows(0)("unitSection")) Then
                txtSection.Text = dsStudentDetails.Tables(0).Rows(0)("unitSection")
            End If

            If Not IsDBNull(dsStudentDetails.Tables(0).Rows(0)("suburb")) Then
                txtSuburb.Text = dsStudentDetails.Tables(0).Rows(0)("suburb")
            End If

            If Not IsDBNull(dsStudentDetails.Tables(0).Rows(0)("city")) Then
                txtCity.Text = dsStudentDetails.Tables(0).Rows(0)("city")
            End If

            'drpdwnMaritalStatus.SelectedItem.Text = dsStudentDetails.Tables(0).Rows(0)("studentMaritalStatus")
            'If Not IsDBNull(dsStudentDetails.Tables(0).Rows(0)("unitSectionId")) Then
            '    txtSection.Text = dsStudentDetails.Tables(0).Rows(0)("unitSectionId")
            'End If

        End If

        'Catch ex As Exception
        '    log.Error(ex)
        '    lblMsg.BackColor = Color.Red
        '    lblMsg.ForeColor = Color.White
        '    lblMsg.Text = "Student Details were not loaded successfully!!!"
        'End Try

    End Sub
    Private Sub drpdwnGuardianMarital_Load()
        If Not IsPostBack Then
            Dim objMaritalStatus As New MaritalStatuses(CokkiesWrapper.thisConnectionName)
            Dim ds As DataSet = objMaritalStatus.luStatuses()

            With drpdwnGuardianMarital

                .DataSource = ds
                .DataTextField = "maritalStatus"
                .DataValueField = "maritalStatusId"
                .DataBind()

                .Items.Insert(0, New RadComboBoxItem("", "0"))

            End With
        End If
    End Sub

    Private Sub drpdwnGuardianRelationshp_Load()
        If Not IsPostBack Then
            Dim objRelationships As New Relationships(CokkiesWrapper.thisConnectionName)
            Dim ds As DataSet = objRelationships.luRelationship

            With drpdwnGuardianRelationshp

                .DataSource = ds
                .DataTextField = "relationship"
                .DataValueField = "relationshipId"
                .DataBind()

                .Items.Insert(0, New RadComboBoxItem("", "0"))
            End With
        End If
    End Sub

    Private Sub drpdwnSex_Load()
        If Not IsPostBack Then
            Dim objSex As New Sex(CokkiesWrapper.thisConnectionName)
            Dim ds As DataSet = objSex.SelectRecords()

            With drpdwnSex

                .DataSource = ds
                .DataTextField = "sex"
                .DataValueField = "sexId"
                .DataBind()

                .Items.Insert(0, New RadComboBoxItem("", "0"))
            End With
        End If
    End Sub

    Private Sub drpdwnMaritalStatus_Load()
        If Not IsPostBack Then
            Dim objMaritalStatus As New MaritalStatuses(CokkiesWrapper.thisConnectionName)
            Dim ds As DataSet = objMaritalStatus.luStatuses()

            With drpdwnMaritalStatus

                .DataSource = ds
                .DataTextField = "maritalStatus"
                .DataValueField = "maritalStatusId"
                .DataBind()

                .Items.Insert(0, New RadComboBoxItem("", "0"))

            End With

        End If
    End Sub

    Private Sub drpdwnOpharnStatus_Load()
        If Not IsPostBack Then

            Dim objOpharnHoodStatus As New OpharnHoodStatus(CokkiesWrapper.thisConnectionName)
            Dim ds As DataSet = objOpharnHoodStatus.SelectRecords()

            With drpdwnOpharnStatus

                .DataSource = ds
                .DataTextField = "orphanhoodStatus"
                .DataValueField = "orphanhoodStatusId"
                .DataBind()

                .Items.Insert(0, New RadComboBoxItem("", "0"))

            End With

        End If

    End Sub

    Private Sub drpdwnStudentTranspt_Load()
        If Not IsPostBack Then


            'drpdwnStudentTranspt
            'drpdwnStudentTranspt.Items.Add("1")
            'drpdwnStudentTranspt.Items.Add("0")

        End If
    End Sub

    Private Sub txtGuardianTitle_Load()

        If Not IsPostBack Then
            Dim objTitle As New Titles(CokkiesWrapper.thisConnectionName)
            Dim ds As DataSet = objTitle.SelectRecords()

            With txtGuardianTitle

                .DataSource = ds
                .DataTextField = "title"
                .DataValueField = "titleId"
                .DataBind()

                .Items.Insert(0, New RadComboBoxItem("", "0"))

            End With
        End If
    End Sub

    Private Sub txtGuardianOccupation_Load()
        If Not IsPostBack Then
            Dim objOccupation As New Occupations(CokkiesWrapper.thisConnectionName)
            Dim ds As DataSet = objOccupation.SelectRecords()

            With txtGuardianOccupation

                .DataSource = ds
                .DataTextField = "occupation"
                .DataValueField = "occupationId"
                .DataBind()

                .Items.Insert(0, New RadComboBoxItem("", "0"))

            End With

        End If
    End Sub

    Private Sub drpdwnBoardingStatus_Load()
        If Not IsPostBack Then
            Dim objBoardingStatus As New BoardingStatus(CokkiesWrapper.thisConnectionName)
            Dim ds As DataSet = objBoardingStatus.SelectRecords()

            With drpdwnBoardingStatus

                .DataSource = ds
                .DataTextField = "boardingStatus"
                .DataValueField = "boardingStatusId"
                .DataBind()

                .Items.Insert(0, New RadComboBoxItem("", "0"))

            End With
        End If
    End Sub

    Protected Sub radtlbrMemberActions_ButtonClick(sender As Object, e As Telerik.Web.UI.RadToolBarEventArgs) Handles radtlbrMemberActions.ButtonClick
        Save()
    End Sub

    Private Sub DropDownListDisability_Load()
        If Not IsPostBack Then
            Dim objDisability As New Disabilities(CokkiesWrapper.thisConnectionName)
            Dim ds As DataSet = objDisability.SelectRecords()

            With DropDownListDisability

                .DataSource = ds
                .DataTextField = "disability"
                .DataValueField = "disabilityId"
                .DataBind()

                .Items.Insert(0, New RadComboBoxItem("", "0"))

            End With
        End If
    End Sub

    Private Sub DropDownListHealthCndtn_Load()
        If Not IsPostBack Then
            Dim objHealthCndtn As New HealthConditions(CokkiesWrapper.thisConnectionName)
            Dim ds As DataSet = objHealthCndtn.SelectRecords()

            With DropDownListHealthCndtn

                .DataSource = ds
                .DataTextField = "healthCondition"
                .DataValueField = "healthConditionId"
                .DataBind()

                .Items.Insert(0, New RadComboBoxItem("", "0"))

            End With
        End If
    End Sub

    Private Sub DropDownListHostel_Load()
        If Not IsPostBack Then
            Dim objHostels As New Hostels(CokkiesWrapper.thisConnectionName)
            Dim ds As DataSet = objHostels.SelectRecords()

            With DropDownListHostel

                .DataSource = ds
                .DataTextField = "hostel"
                .DataValueField = "hostelId"
                .DataBind()

                .Items.Insert(0, New RadComboBoxItem("", "0"))

            End With
        End If
    End Sub

    Private Sub DropDownListReligion_Load()
        If Not IsPostBack Then
            Dim objReligion As New Religions(CokkiesWrapper.thisConnectionName)
            Dim ds As DataSet = objReligion.SelectRecords()

            With DropDownListReligion

                .DataSource = ds
                .DataTextField = "religion"
                .DataValueField = "religionId"
                .DataBind()

                .Items.Insert(0, New RadComboBoxItem("", "0"))

            End With
        End If
    End Sub

    Private Sub DropDownListSportHse_Load()
        If Not IsPostBack Then

            Dim objSportHse As New SportHouses(CokkiesWrapper.thisConnectionName)
            Dim ds As DataSet = objSportHse.SelectRecords()

            With DropDownListSportHse

                .DataSource = ds
                .DataTextField = "sportsHouse"
                .DataValueField = "sportsHouseId"
                .DataBind()

                .Items.Insert(0, New RadComboBoxItem("", "0"))

            End With
        End If
    End Sub

    Private Sub DropDownListStreams_Load()
        If Not IsPostBack Then
            Dim objStream As New Streams(CokkiesWrapper.thisConnectionName)
            Dim ds As DataSet = objStream.SelectRecords()

            With DropDownListStreams

                .DataSource = ds
                .DataTextField = "stream"
                .DataValueField = "streamid"
                .DataBind()

                .Items.Insert(0, New RadComboBoxItem("", "0"))

            End With
        End If
    End Sub


    Private Sub DropDownListStudentPositions_Load()
        If Not IsPostBack Then
            Dim qry As String = "SELECT [schoolStudentPositionId], [schoolStudentPosition] FROM [dbo].[tbl_schoolStudentPositions]"

            insRec.ConnectionString = con

            Dim ds As DataSet = insRec.ExecuteDsQRY(qry)
            With DropDownListStudentPosition
                .DataValueField = "schoolStudentPositionId"
                .DataTextField = "schoolStudentPosition"
                .DataSource = ds
                .DataBind()

                .Items.Insert(0, New RadComboBoxItem("", "0"))

            End With
        End If
    End Sub

    Private Sub DropDownListStudentStatus_Load()
        'If Not IsPostBack Then
        '    Dim qry As String = "SELECT [schoolStudentPositionId], [schoolStudentPosition] FROM [dbo].[tbl_schoolStudentPositions]"

        '    insRec.ConnectionString = con

        '    Dim ds As DataSet = insRec.ExecuteDsQRY(qry)
        '    With DropDownListStudentPosition
        '        .DataValueField = "schoolStudentPositionId"
        '        .DataTextField = "schoolStudentPosition"
        '        .DataSource = ds
        '        .DataBind()

        '        .Items.Insert(0, New RadComboBoxItem("", "0"))

        '    End With
        'End If
    End Sub

    Private Sub DropDownListClass_Load()
        If Not IsPostBack Then
            Dim objSchooolClass As New SchoolClasses(CokkiesWrapper.thisConnectionName)
            Dim ds As DataSet = objSchooolClass.SelectRecords()

            With DropDownListClass

                .DataSource = ds
                .DataTextField = "schoolClass"
                .DataValueField = "schoolClassId"
                .DataBind()

                .Items.Insert(0, New RadComboBoxItem("", "0"))

            End With
        End If
    End Sub

    Public Sub LoadTreeViewClubsData()
        Dim objClubs As New Clubs(CokkiesWrapper.thisConnectionName)
        Dim ds As DataSet = objClubs.SelectRecords()

        Try
            With RadTreeClubs

                .DataFieldID = "clubId"
                ' .DataFieldParentID = "ParentID"
                .DataTextField = "club"
                .DataValueField = "clubId"
                .DataSource = ds
                .DataBind()
            End With

        Catch ex As Exception
            log.Error(ex)

        End Try

    End Sub
    Public Sub LoadTreeViewStudentClubsData(ByVal IstudentId As String)

        Dim objClubs As New Clubs(CokkiesWrapper.thisConnectionName)
        Dim ds As DataSet = objClubs.SelectRecords()

        Try
            With RadTreeClubs

                .DataFieldID = "clubId"
                ' .DataFieldParentID = "ParentID"
                .DataTextField = "club"
                .DataValueField = "clubId"
                .DataSource = ds
                .DataBind()
            End With

        Catch ex As Exception
            log.Error(ex)

        End Try

    End Sub
    Public Sub LoadTreeViewSportsData()
        Dim objSports As New Sports(CokkiesWrapper.thisConnectionName)
        Dim ds As DataSet = objSports.SelectRecords()

        Try
            With RadTreeSports

                .DataFieldID = "sportId"
                ' .DataFieldParentID = "ParentID"
                .DataTextField = "sport"
                .DataValueField = "sportId"
                .DataSource = ds
                .DataBind()
            End With

        Catch ex As Exception
            log.Error(ex)

        End Try

    End Sub

    Public Sub LoadTreeViewStudentSportsData(ByVal IstudentId As String)

        Dim objSports As New Sports(CokkiesWrapper.thisConnectionName)
        Dim ds As DataSet = objSports.SelectRecords()

        Try
            With RadTreeSports

                .DataFieldID = "sportId"
                ' .DataFieldParentID = "ParentID"
                .DataTextField = "sport"
                .DataValueField = "sportId"
                .DataSource = ds
                .DataBind()
            End With

        Catch ex As Exception
            log.Error(ex)

        End Try

    End Sub
    Public Sub LoadTreeViewExtraCurriculaData()
        Dim objXtra As New ExtraCurriculaActivities(CokkiesWrapper.thisConnectionName)
        Dim ds As DataSet = objXtra.SelectRecords()

        Try
            With RadTreeOtherActivities

                .DataFieldID = "activityId"
                ' .DataFieldParentID = "ParentID"
                .DataTextField = "activityName"
                .DataValueField = "activityId"
                .DataSource = ds
                .DataBind()
            End With

        Catch ex As Exception
            log.Error(ex)

        End Try

    End Sub

    Public Sub LoadTreeViewStudentExtraCurriculaData(ByVal IstudentId As String)

        Dim objXtra As New ExtraCurriculaActivities(CokkiesWrapper.thisConnectionName)
        Dim ds As DataSet = objXtra.SelectRecords()

        Try
            With RadTreeOtherActivities

                .DataFieldID = "activityId"
                ' .DataFieldParentID = "ParentID"
                .DataTextField = "activityName"
                .DataValueField = "activityId"
                .DataSource = ds
                .DataBind()
            End With

        Catch ex As Exception
            log.Error(ex)

        End Try

    End Sub
    Private Sub RadTreeClubs_NodeDataBound(sender As Object, e As RadTreeNodeEventArgs) Handles RadTreeClubs.NodeDataBound



        Try
            If Not IsNothing(CokkiesWrapper.StudentID = Request.QueryString("op")) Then
                ds = objClubs.GetRecords(CokkiesWrapper.StudentID)
            Else : ds = objClubs.SelectRecords()

            End If

            Dim dr As DataRowView = e.Node.DataItem

            If Not dr Is Nothing Then

                If e.Node.Enabled Then e.Node.CollapseParentNodes()

                If ds.Tables.Count > 0 AndAlso ds.Tables(0).Rows.Count > 0 Then

                    For Each row As DataRow In ds.Tables(0).Rows

                        If e.Node.Value = row("club") Then
                            e.Node.Checked = True
                        End If

                    Next

                End If

            End If

        Catch ex As Exception
            log.Error(ex)

        End Try
    End Sub

    Private Sub RadTreeSports_NodeDataBound(sender As Object, e As RadTreeNodeEventArgs) Handles RadTreeSports.NodeDataBound

        Try
            If Not IsNothing(CokkiesWrapper.StudentID = Request.QueryString("op")) Then
                ds = objSports.GetRecords(CokkiesWrapper.StudentID)
            Else : ds = objSports.SelectRecords()

            End If

            Dim dr As DataRowView = e.Node.DataItem

            If Not dr Is Nothing Then

                If e.Node.Enabled Then e.Node.CollapseParentNodes()

                If ds.Tables.Count > 0 AndAlso ds.Tables(0).Rows.Count > 0 Then

                    For Each row As DataRow In ds.Tables(0).Rows

                        If e.Node.Value = row("sport") Then
                            e.Node.Checked = True
                        End If

                    Next

                End If

            End If

        Catch ex As Exception
            log.Error(ex)

        End Try
    End Sub

    Private Sub RadTreeOtherActivities_NodeDataBound(sender As Object, e As RadTreeNodeEventArgs) Handles RadTreeOtherActivities.NodeDataBound


        Try
            If Not IsNothing(CokkiesWrapper.StudentID = Request.QueryString("op")) Then
                ds = objStudentExtraCurricula.GetRecords(CokkiesWrapper.StudentID)
            Else : ds = objExtraCurricula.SelectRecords()

            End If

            Dim dr As DataRowView = e.Node.DataItem

            If Not dr Is Nothing Then

                If e.Node.Enabled Then e.Node.CollapseParentNodes()

                If ds.Tables.Count > 0 AndAlso ds.Tables(0).Rows.Count > 0 Then

                    For Each row As DataRow In ds.Tables(0).Rows

                        If e.Node.Value = row("activity") Then
                            e.Node.Checked = True
                        End If

                    Next

                End If

            End If

        Catch ex As Exception
            log.Error(ex)

        End Try
    End Sub

    Protected Sub SaveClubs_Click(sender As Object, e As EventArgs) Handles SaveClubs.Click
        objStudentClubs.ConnectionString = con

        If RadTreeClubs.CheckedNodes.Count > 0 Then
            If RadTreeClubsSaveUsercheckedNodes(RadTreeClubs) Then

            Else


            End If
        End If

    End Sub
    Protected Function RadTreeClubsSaveUsercheckedNodes(ByVal RadTreeClubs As Telerik.Web.UI.RadTreeView) As Boolean

        Dim NodeFullPath As String = ""
        Dim Subject As String

        Try

            'revoke existing user rights

            If RadTreeClubs.CheckedNodes.Count > 0 Then

                Dim ds As DataSet = CreateErrorDataset()

                For Each Node As RadTreeNode In RadTreeClubs.CheckedNodes


                    NodeFullPath = Node.FullPath
                    Subject = Node.Text
                    objStudentClubs.Insert(txtStudentNo.Text, Subject)

                Next Node
                DisplayErrors(ds)

                lblMsg.BackColor = Color.Green
                lblMsg.ForeColor = Color.White
                lblMsg.Text = "Student Clubs were saved successfully!!!"

                Return True

            End If

        Catch ex As Exception

            lblMsg.BackColor = Color.Green
            lblMsg.ForeColor = Color.White
            lblMsg.Text = "Student Clubs were not saved successfully!!!"
            Return False

        End Try


    End Function
    Private Function CreateErrorDataset() As DataSet

        Dim ds As New DataSet
        ds.Tables.Add("Errors")

        With ds.Tables("Errors").Columns

            .Add(New DataColumn("Error", GetType(String)))
            .Add(New DataColumn("Details", GetType(String)))

        End With

        Return ds

    End Function
    Private Function DisplayErrors(ByVal dsErrors As DataSet) As Boolean

        If dsErrors.Tables(0).Rows.Count > 0 Then

            Dim msg As String = ""

            For Each row As DataRow In dsErrors.Tables(0).Rows

                msg = "<span class = 'Error'>" & row("Details") & " </span> <br/>"

            Next

        End If

    End Function

    Protected Sub SaveSports_Click(sender As Object, e As EventArgs) Handles SaveSports.Click
        objStudentSports.ConnectionString = con

        If RadTreeSports.CheckedNodes.Count > 0 Then

            If RadTreeSportsSaveUsercheckedNodes(RadTreeSports) Then

            Else


            End If
        End If
    End Sub
    Protected Function RadTreeSportsSaveUsercheckedNodes(ByVal RadTreeSports As Telerik.Web.UI.RadTreeView) As Boolean

        Dim NodeFullPath As String = ""
        Dim Subject As String

        Try

            'revoke existing user rights

            If RadTreeSports.CheckedNodes.Count > 0 Then

                Dim ds As DataSet = CreateErrorDataset()

                For Each Node As RadTreeNode In RadTreeSports.CheckedNodes


                    NodeFullPath = Node.FullPath
                    Subject = Node.Text
                    objStudentSports.Insert(txtStudentNo.Text, Subject)

                Next Node

                DisplayErrors(ds)

                lblMsg.BackColor = Color.Green
                lblMsg.ForeColor = Color.White
                lblMsg.Text = "Student Sports were saved successfully!!!"
                Return True

            End If

        Catch ex As Exception

            lblMsg.BackColor = Color.Red
            lblMsg.ForeColor = Color.White
            lblMsg.Text = "Student Sports were not saved successfully!!!"
            Return False
           

        End Try
    End Function

    Protected Sub cmdSaveOtherActivitiesNum_Click(sender As Object, e As EventArgs) Handles cmdSaveOtherActivitiesNum.Click
        objStudentExtraCurricula.ConnectionString = con

        If RadTreeOtherActivities.CheckedNodes.Count > 0 Then
            If RadTreeOtherActivitiesSaveUsercheckedNodes(RadTreeOtherActivities) Then

            Else

            End If
        End If
    End Sub
    Protected Function RadTreeOtherActivitiesSaveUsercheckedNodes(ByVal RadTreeOtherActivities As Telerik.Web.UI.RadTreeView) As Boolean

        Dim NodeFullPath As String = ""
        Dim ActivityId As String

        Try

            'revoke existing user rights

            If RadTreeOtherActivities.CheckedNodes.Count > 0 Then

                Dim ds As DataSet = CreateErrorDataset()

                For Each Node As RadTreeNode In RadTreeOtherActivities.CheckedNodes


                    NodeFullPath = Node.FullPath
                    ActivityId = Node.Text
                    objStudentExtraCurricula.Insert(txtStudentNo.Text, ActivityId)

                Next Node
                DisplayErrors(ds)

                lblMsg.BackColor = Color.Green
                lblMsg.ForeColor = Color.White
                lblMsg.Text = "Student Activities were saved successfully!!!"
                Return True

            End If

        Catch ex As Exception

            lblMsg.BackColor = Color.Red
            lblMsg.ForeColor = Color.White
            lblMsg.Text = "Student Acivities were not saved successfully!!!"
            Return False

        End Try
    End Function

    Private Sub radComboPaymentsHistory_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles radComboPaymentsHistory.SelectedIndexChanged

        Dim sql As String

        Try

            If radComboPaymentsHistory.SelectedValue = 1 Then

                sql = "select studentId, strMonth Month, intYear Year, expectedAmt [Amount Billed],amountPaid [Amount Paid], Date [Payment Date]  from tbl_tuitionPayments where studentId = '" & CokkiesWrapper.StudentID & " '"

            ElseIf radComboPaymentsHistory.SelectedValue = 2 Then

                sql = "select studentd, strTerm Term, intYear Year, expectedAmt [Amount Billed],amountPaid [Amount Paid]  from tbl_LevyPayments where studentd = '" & CokkiesWrapper.StudentID & " '"

            ElseIf radComboPaymentsHistory.SelectedValue = 3 Then

                sql = "select studentId, mMonth Month, yYear Year, setAmount [Amount Billed],amountPaid [Amount Paid] from tbl_transportPayments where studentId = '" & CokkiesWrapper.StudentID & " '"

            ElseIf radComboPaymentsHistory.SelectedValue = 4 Then

                sql = "select studentId, intYear Year, Regdate [Registration Date], expectedAmt [Amount Billed],amountPaid [Amount Paid], regDate [Payment Date]  from tbl_registrationPayments where studentId = '" & CokkiesWrapper.StudentID & " '"

            ElseIf radComboPaymentsHistory.SelectedValue = 5 Then

                sql = "select studentId, dtDate [Sale Date], uniformItem, unitPrice, quantity, totalPrice  from tbl_uniformSales where studentId = '" & CokkiesWrapper.StudentID & " '"

            End If

            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            db.ExecuteDataSet(CommandType.Text, sql)

            With gwStudentPaymentHistory

                .DataSource = ds
                .DataBind()

            End With


        Catch ex As Exception
            log.Error(ex)

        End Try

    End Sub

    Private Sub gwBehaviourSearchLoad(ByVal StudentId As String)

        Dim sql As String = "  SELECT incidentNumber, dtDate [Incident Date],incidentType,incidentLevel,location, offenderId [Student Number], offender [Student Name], incidentDescription,action, stream, Schclass FROM tbl_incidents I left outer join tbl_incidentTypes IT on I.incidentTypeId = IT.incidentTypeId left outer join tbl_incidentLevels IL on I.incidentLevelId = IL.incidentLevelId left outer join tbl_disciplinaryActions DA on I.disciplinaryActionId = DA.actionId where offenderId = '" + StudentId + "'"
        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            db.ExecuteDataSet(CommandType.Text, sql)

            With gwBehaviourSearch

                .DataSource = ds
                .DataBind()

            End With


        Catch ex As Exception
            log.Error(ex)

        End Try

    End Sub

    Sub LibraryHistory(ByVal id As String)

        Dim sql As String = "SELECT [bookId],[title],[authour],[serialNumber],[bookType],[borrowerName],[borrowerType],[borrowerIdNumber],[dateLoanedOut],[loanDays] ,[dueDate] ,[returnDate],[returnStatus],[penaltyAmt],[comments],[penaltyPaid] FROM [SchoolAd].[dbo].[tbl_libraryBookLending] where borrowerIdNumber = '" & id & "'"

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            If ds.Tables.Count > 0 Then

                With gwLibrary

                    .DataSource = ds
                    .DataBind()

                End With
            End If
        Catch ex As Exception

            log.Error(ex)
        End Try

    End Sub

    Sub loadStudentCourseWork(ByVal id As String)

        Dim sql As String = "SELECT stream_ AS Stream, class_ AS Class, studentId AS [Student ID], subject AS Subject, intYear AS Year, term AS Term, " & _
                            " markObtained AS Mark, percentage AS Percentage, grade AS Grade, " & _
                            "  classPosition AS [Class Position], streamPosition AS [Stream Position], positionDeviation AS [Position Difference] " & _
                            " FROM dbo.tbl_testMarkAggregatesBySubject WHERE (studentId = '" & id & "')"

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            If ds.Tables.Count > 0 Then

                With gwCoursework

                    .DataSource = ds
                    .DataBind()

                End With
            End If
        Catch ex As Exception

            log.Error(ex)
        End Try
    End Sub


    Sub loadStudentExaminationResults(ByVal id As String)

        Dim sql As String = " SELECT studentId AS [Student ID], intYear AS Year, term AS Term, stream AS Stream, schClass AS Class, subject AS Subject, " & _
                            " percentMarkObtained AS [Mark Obtained], grade AS Grade, classPosition AS [Class Position], " & _
                            " streamPosition AS [Stream Position] FROM dbo.tbl_examinationMarksAggregatedBySubject " & _
                            " WHERE        (studentId = '" & id & "')"

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            If ds.Tables.Count > 0 Then

                With gwExams

                    .DataSource = ds
                    .DataBind()

                End With
            End If
        Catch ex As Exception

            log.Error(ex)
        End Try
    End Sub


    Private Sub loadStudentFiles()
         Dim qry As String = "SELECT dbo.tbl_Files.FileID, dbo.tbl_Files.FileTypeID, dbo.tbl_Files.Author, dbo.tbl_Files.Title, " & _
                          " dbo.tbl_Files.Description, dbo.tbl_Files.Date, dbo.tbl_Files.FilePath, dbo.tbl_Files.FileExtension, " & _
                          " dbo.tbl_Files.AuthorOrganization, dbo.tbl_Files.CreatedBy, dbo.tbl_Files.CreatedDate, dbo.tbl_Files.UpdatedBy, " & _
                          " dbo.tbl_Files.UpdatedDate, dbo.tbl_Files.ApplySecurity, dbo.tbl_schoolFileType.fileType " & _
                          " FROM dbo.tbl_Files INNER JOIN dbo.tbl_schoolFileType ON dbo.tbl_Files.FileTypeID = dbo.tbl_schoolFileType.fileTypeId " & _
                          " ORDER BY dbo.tbl_Files.Date DESC "

        With gwFiles
            Try
                Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, qry)
                .DataSource = ds
                .DataBind()
            Catch ex As Exception
                'log.Error(ex.Message)
            End Try
        End With



    End Sub

    Sub LoadStudentAttendance(ByVal id As String)

        Dim sql As String = "SELECT  dtDate AS Date, stream AS Stream, schClass AS Class, attendance AS Attendance, comments AS Comments FROM tbl_classAttendanceRegister WHERE  studentId = '" & id & "'"

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            If ds.Tables.Count > 0 Then

                With gwAttendance

                    .DataSource = ds
                    .DataBind()

                End With
            End If
        Catch ex As Exception

            log.Error(ex)
        End Try

    End Sub

    Private Sub cbStudentStatus_Load(sender As Object, e As EventArgs) Handles cbStudentStatus.Load
        If Not IsPostBack Then

            Dim objStatuses As New Statuses(CokkiesWrapper.thisConnectionName)
            Dim ds As DataSet = objStatuses.SelectRecords()

            With cbStudentStatus

                .DataSource = ds
                .DataTextField = "status"
                .DataValueField = "status"
                .DataBind()

                .Items.Insert(0, New RadComboBoxItem("", "0"))

            End With
        End If
    End Sub
End Class