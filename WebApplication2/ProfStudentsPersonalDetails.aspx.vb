
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports ClassLibrary1
Imports Telerik.Web.UI


Public Class ProfStudentsPersonalDetails
    Inherits System.Web.UI.Page
    Dim objStudent As New Student(CokkiesWrapper.thisConnectionName)
    Dim db As Database = objStudent.Database
    Dim con As String = db.ConnectionString
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (CokkiesWrapper.UserID <= 0 AndAlso Not IsNumeric(CokkiesWrapper.UserID)) Then
            Response.Redirect("../Login.aspx")
            Exit Sub
        End If

        obj.ConnectionString = con
        'Dim accessMode As String = obj.groupAccessPermissionsDs(CokkiesWrapper.UserGroup, 1010)

        'Select Case accessMode
        '    Case "AllowReadNRead"
        '    Case "ReadNReadOnly"
        '        cmdSave.Enabled = False
        '    Case "DenyAcces"
        '        Response.Redirect("~/AccessDenied.aspx")
        '        Exit Sub
        '    Case Else
        '        Response.Redirect("~/AccessDenied.aspx")
        '        Exit Sub
        'End Select

        If Not IsPostBack Then

            Dim str As String = "SELECT [ProfessionalCourseId], [ProfessionalCourse] FROM [luProfessionalCourses]"
            obj.loadComboBox(cbCourse, str, "ProfessionalCourse", "ProfessionalCourseId")
            cbCourse.Items.Insert(0, New RadComboBoxItem("--Select--", ""))

            str = "SELECT ProfessionalCourseLevelId, ProfessionalCourseLevel FROM luProfessionalCourseLevels"
            obj.loadComboBox(cbLevel, str, "ProfessionalCourseLevel", "ProfessionalCourseLevelId")
            cbLevel.Items.Insert(0, New RadComboBoxItem("--Select--", ""))

            str = "SELECT [ProfessionalStudentStatusId], [ProfessionalStudentStatus] FROM [luProfessionalStudentStatuses]"
            obj.loadComboBox(cbStatus, str, "ProfessionalStudentStatus", "ProfessionalStudentStatusId")
            cbStatus.Items.Insert(0, New RadComboBoxItem("--Select--", ""))


        End If


    End Sub

    Protected Sub cmdSave_Click(sender As Object, e As EventArgs) Handles cmdSave.Click

        Dim qryx As String = "INSERT  tbl_profStudentDetails ([studentNumber], [regDate], [firstName], [secondName], [surname], " & _
            " [nationalIDNumber], [sex], [courseId], [levelId], [statusId], [emailAddress], " & _
        " [contactNo], [studentPwd], [resetPwd], [physicalAddress], [nextOfKinName], [nextOfKinContactNum], [nextOfKinAddress] ) " & _
        " VALUES ('" & txtStudentNumber.Text & "','" & RadDatePicker.SelectedDate & "','" & txtFirstName.Text & "','" & txtSecondName.Text & "','" & _
          txtSurname.Text & "','" & txtNationalIDNumber.Text & "','" & cbSex.Text & "'," & cbCourse.SelectedValue & "," & cbLevel.SelectedValue & "," & _
          cbStatus.SelectedValue & ",'" & txtEmailAddress.Text & "','" & txtContactNum.Text & "','" & txtStudentNumber.Text & "', 1 , '" & txtAddress.Text & "','" & _
         txtNextOfKin.Text & "','" & txtNextOfKinContactNum.Text & "','" & txtNextOfKinAddress.Text & "')"


        If obj.ExecuteNonQRY(qryx) = 1 Then
            lblMsg.Text = "Record saved successfully."
            clearControls()
        Else
            lblMsg.Text = "Error while trying to save record"
        End If

    End Sub

    Private Sub clearControls()

        txtStudentNumber.Text = ""
        RadDatePicker.SelectedDate = Now
        txtFirstName.Text = ""
        txtSecondName.Text = ""
        txtSurname.Text = ""
        txtNationalIDNumber.Text = ""
        cbSex.Text = ""
        cbCourse.SelectedValue = 0
        cbLevel.SelectedValue = 0
        cbStatus.SelectedValue = 0
        txtEmailAddress.Text = ""
        txtContactNum.Text = ""
        txtStudentNumber.Text = ""
        txtAddress.Text = ""
        txtNextOfKin.Text = ""
        txtNextOfKinContactNum.Text = ""
        txtNextOfKinAddress.Text = ""
    End Sub

End Class