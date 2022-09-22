Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Telerik.Web.UI
Imports System.Drawing


Public Class StaffPortalPersonalDetails
    Inherits System.Web.UI.Page

    Private Shared ReadOnly log As log4net.ILog = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType)

    Dim objStuffDetails As New StaffDetails(CokkiesWrapper.thisConnectionName)
    Dim objTitle As New Titles(CokkiesWrapper.thisConnectionName)
    Dim dsTitle As DataSet = objTitle.SelectRecords()
    Dim objStaffQualification As New StaffQualifications(CokkiesWrapper.thisConnectionName)
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = objStaffQualification.Database
    Dim con As String = db.ConnectionString

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        '    If Not IsNothing(Request.QueryString("op")) Then

        If (CokkiesWrapper.UserID <= 0 AndAlso Not IsNumeric(CokkiesWrapper.UserID)) Then
            Response.Redirect("../Login.aspx")
            Exit Sub
        End If

        obj.ConnectionString = con
        Dim accessMode As String = obj.groupAccessPermissionsDs(CokkiesWrapper.UserGroup, 3)

        'Select Case accessMode
        '    Case "AllowReadNRead"
        '    Case "ReadNReadOnly"
        '        ' cmdSave.Enabled = False
        '    Case "DenyAcces"
        '        Response.Redirect("~/AccessDenied.aspx")
        '        Exit Sub
        '    Case Else
        '        Response.Redirect("~/AccessDenied.aspx")
        '        Exit Sub
        'End Select

        ' loadStuffValues(Request.QueryString("op"))
        loadStuffValues(CokkiesWrapper.EmploymentNumber)
        ' ListQualifications(Request.QueryString("op"))
        ListQualifications(CokkiesWrapper.EmploymentNumber)

        lblMsg.BackColor = Color.Green
        lblMsg.ForeColor = Color.White
        lblMsg.Text = "Staff Details were loaded successlly!!!"


        ' End If
    End Sub

    Private Sub disableControls()

    End Sub
    Private Sub DropDownMStatus_Load(sender As Object, e As EventArgs) Handles DropDownMStatus.Load
        If Not IsPostBack Then

            Dim objMaritalStatus As New MaritalStatuses(CokkiesWrapper.thisConnectionName)
            Dim ds As DataSet = objMaritalStatus.luStatuses()

            With DropDownMStatus

                .DataSource = ds
                .DataTextField = "maritalStatus"
                .DataValueField = "maritalStatusId"
                .DataBind()

                .Items.Insert(0, New ListItem("", ""))

            End With
        End If
    End Sub

    Private Sub DropDownSex_Load(sender As Object, e As EventArgs) Handles DropDownSex.Load
        If Not IsPostBack Then

            Dim objSex As New Sex(CokkiesWrapper.thisConnectionName)
            Dim ds As DataSet = objSex.SelectRecords()

            With DropDownSex

                .DataSource = ds
                .DataTextField = "sex"
                .DataValueField = "sexId"
                .DataBind()

                .Items.Insert(0, New ListItem("", ""))

            End With

        End If
    End Sub

    Private Sub DropDownTitle_Load(sender As Object, e As EventArgs) Handles DropDownTitle.Load
        If Not IsPostBack Then

            Dim objTitles As New Titles(CokkiesWrapper.thisConnectionName)
            Dim ds As DataSet = objTitles.SelectRecords()


            With DropDownTitle

                .DataSource = dsTitle
                .DataTextField = "title"
                .DataValueField = "titleId"
                .DataBind()

                .Items.Insert(0, New ListItem("--Select--", ""))

            End With

        End If
    End Sub

    Sub Save()

        Try
            With objStuffDetails

                .firstName = txtFirstname.Text
                .surname = txtSurname.Text
                .secondName = txtSecondName.Text
                .sex = DropDownSex.SelectedItem.Text
                '.title = DropDownTitle.SelectedItem.Text
                .salary = txtSalary.Text
                .officeNumber = txtOfficeNum.Text
                .numberOfDependants = txtDependantsNo.Text
                .nextOfKinAddress = txtGuardianContactAddress.Text
                .nextOfKinContactNumber = txtGuardianContactNum.Text
                .nextOfKinName = txtGuardianFirstName.Text
                .nextOfKinSurname = txtGuardianSurname.Text
                .natIdNumber = txtNatIDNo.Text
                .mStatus = DropDownMStatus.SelectedItem.Text
                .homeAddress = txtContactAddress.Text
                .employmentNumber = txtEmploymentNo.Text
                .emailAddress = txtEmailAddress.Text
                .dateOfInitiation = RadDatePickerInitDate.SelectedDate
                .dateOfBirth = RadDatePickerDOB.SelectedDate
                .dateAppointedToSchool = RadDatePickerADate.SelectedDate
                .contactNumber = txtContactNumber.Text
                .sexId = DropDownSex.SelectedValue
                .titleId = DropDownTitle.SelectedValue
                .maritalStatusId = DropDownMStatus.SelectedValue
                '.healthConditionId
                '.unitSectionId
                '.schoolStaffPositionId
                '.relationshipId
                '.reasonForLeavingId

                ' Dim row As DataRow = dsTitle.Tables(0).Rows(DropDownSex.SelectedValue)

                .Save()

            End With

            lblMsg.BackColor = Color.Green
            lblMsg.ForeColor = Color.White
            lblMsg.Text = "Stuff details were saved successlly!!!"

        Catch ex As Exception
            log.Error(ex)
            lblMsg.BackColor = Color.Red
            lblMsg.ForeColor = Color.White
            lblMsg.Text = "Stuff details were not saved successlly!!!"

        End Try

    End Sub
    '6
    Public Sub loadStuffValues(ByVal stuffNumber As String)

        Dim dsStuffDetails As DataSet = objStuffDetails.load(stuffNumber)

        Try
            If Not IsNothing(dsStuffDetails) AndAlso dsStuffDetails.Tables.Count > 0 AndAlso dsStuffDetails.Tables(0).Rows.Count > 0 Then

                txtFirstname.Text = dsStuffDetails.Tables(0).Rows(0)("firstName")
                txtSurname.Text = dsStuffDetails.Tables(0).Rows(0)("surname")
                txtSecondName.Text = dsStuffDetails.Tables(0).Rows(0)("secondName")
                DropDownSex.SelectedValue = dsStuffDetails.Tables(0).Rows(0)("sexId")
                DropDownTitle.SelectedValue = dsStuffDetails.Tables(0).Rows(0)("titleId")
                txtSalary.Text = dsStuffDetails.Tables(0).Rows(0)("salary")
                txtOfficeNum.Text = dsStuffDetails.Tables(0).Rows(0)("officeNumber")
                txtDependantsNo.Text = dsStuffDetails.Tables(0).Rows(0)("numberOfDependants")
                txtGuardianContactAddress.Text = dsStuffDetails.Tables(0).Rows(0)("nextOfKinAddress")
                txtGuardianContactNum.Text = dsStuffDetails.Tables(0).Rows(0)("nextOfKinContactNumber")
                txtGuardianFirstName.Text = dsStuffDetails.Tables(0).Rows(0)("nextOfKinName")
                ' txtGuardianSurname.Text = dsStuffDetails.Tables(0).Rows(0)("nextOfKinSurname")
                txtNatIDNo.Text = dsStuffDetails.Tables(0).Rows(0)("natIdNumber")
                DropDownMStatus.SelectedValue = dsStuffDetails.Tables(0).Rows(0)("maritalStatusId")
                txtContactAddress.Text = dsStuffDetails.Tables(0).Rows(0)("homeAddress")
                txtEmploymentNo.Text = dsStuffDetails.Tables(0).Rows(0)("employmentNumber")
                txtEmailAddress.Text = dsStuffDetails.Tables(0).Rows(0)("emailAddress")
                RadDatePickerInitDate.SelectedDate = dsStuffDetails.Tables(0).Rows(0)("dateOfInitiation")
                RadDatePickerDOB.SelectedDate = dsStuffDetails.Tables(0).Rows(0)("dateOfBirth")
                RadDatePickerADate.SelectedDate = dsStuffDetails.Tables(0).Rows(0)("dateAppointedToSchool")
                txtContactNumber.Text = dsStuffDetails.Tables(0).Rows(0)("contactNumber")
                ' DropDownSex.SelectedItem.Text = dsStuffDetails.Tables(0).Rows(0)("sex")
                '.titleId = DropDownTitle.SelectedItem.Text = dsStuffDetails.Tables(0).Rows(0)("titleId")
                '.maritalStatusId = DropDownMStatus.SelectedItem.Text = dsStuffDetails.Tables(0).Rows(0)("maritalStatusId")
                '.healthConditionId
                '.unitSectionId
                '.schoolStaffPositionId
                '.relationshipId
                '.reasonForLeavingId

                ' Dim row As DataRow = dsTitle.Tables(0).Rows(DropDownSex.SelectedValue)

            End If

        Catch ex As Exception
            log.Error(ex)

            lblMsg.BackColor = Color.Red
            lblMsg.ForeColor = Color.White
            lblMsg.Text = "Stuff details were not loaded successlly!!!"

        End Try
    End Sub
    Sub ListQualifications(ByVal StaffId As String)

        Dim ds As DataSet = objStaffQualification.SelectRecords(StaffId)
        Try
            With RadListViewStaffQualifications

                .DataSource = ds
                .DataBind()

            End With
        Catch ex As Exception


            log.Error(ex)
        End Try

    End Sub

End Class