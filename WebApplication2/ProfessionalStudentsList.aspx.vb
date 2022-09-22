Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports ClassLibrary1
Imports Telerik.Web.UI

Public Class ProfessionalStudentsList
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
            cbCourse.Items.Insert(0, New RadComboBoxItem("", ""))

            str = "SELECT ProfessionalCourseLevelId, ProfessionalCourseLevel FROM luProfessionalCourseLevels"
            obj.loadComboBox(cbLevel, str, "ProfessionalCourseLevel", "ProfessionalCourseLevelId")
            cbLevel.Items.Insert(0, New RadComboBoxItem("", ""))

            str = "SELECT [ProfessionalStudentStatusId], [ProfessionalStudentStatus] FROM [luProfessionalStudentStatuses]"
            obj.loadComboBox(cbStatus, str, "ProfessionalStudentStatus", "ProfessionalStudentStatusId")
            cbStatus.Items.Insert(0, New RadComboBoxItem("", ""))

        End If
    End Sub



    Protected Sub btnSearch_Click(sender As Object, e As EventArgs) Handles btnSearch.Click



        Dim sqrQry As String = "SELECT dbo.luProfessionalCourses.ProfessionalCourse AS Course, dbo.luProfessionalCourseLevels.ProfessionalCourseLevel AS [Level], " & _
                                " dbo.luProfessionalStudentStatuses.ProfessionalStudentStatus AS Status, dbo.tbl_profStudentDetails.studentNumber AS [Student Number], " & _
                                " dbo.tbl_profStudentDetails.regDate AS [Reg Date], dbo.tbl_profStudentDetails.surname AS Surname, " & _
                                " dbo.tbl_profStudentDetails.firstName AS Firstname, dbo.tbl_profStudentDetails.secondName AS [Second Name], " & _
                                " dbo.tbl_profStudentDetails.nationalIDNumber AS [National ID Num], dbo.tbl_profStudentDetails.sex AS Sex, " & _
                                " dbo.tbl_profStudentDetails.contactNo AS [Contact Num] " & _
                                " FROM            dbo.tbl_profStudentDetails INNER JOIN " & _
                         " dbo.luProfessionalCourseLevels ON dbo.tbl_profStudentDetails.levelId = dbo.luProfessionalCourseLevels.ProfessionalCourseLevelId INNER JOIN " & _
                         " dbo.luProfessionalCourses ON dbo.tbl_profStudentDetails.courseId = dbo.luProfessionalCourses.ProfessionalCourseId INNER JOIN " & _
                         " dbo.luProfessionalStudentStatuses ON dbo.tbl_profStudentDetails.statusId = dbo.luProfessionalStudentStatuses.ProfessionalStudentStatusId " & _
                       " WHERE        (dbo.luProfessionalCourses.ProfessionalCourse LIKE '%" & cbCourse.Text & "%') AND (dbo.luProfessionalCourseLevels.ProfessionalCourseLevel LIKE '%" & cbLevel.Text & "%') AND " & _
                       " (dbo.luProfessionalStudentStatuses.ProfessionalStudentStatus LIKE '%" & cbStatus.Text & "%') AND (dbo.tbl_profStudentDetails.studentNumber LIKE '%" & txtStudentNo.Text & "%') AND " & _
                       " (dbo.tbl_profStudentDetails.surname LIKE '%" & txtSurname.Text & "%') AND (dbo.tbl_profStudentDetails.firstName LIKE '%" & txtFName.Text & "%') " & _
                       " ORDER BY Course, [Level], Surname, Firstname "

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sqrQry)
            db.ExecuteDataSet(CommandType.Text, sqrQry)

            With gwBillPayments

                .DataSource = ds
                .DataBind()

            End With
        Catch ex As Exception
            ' log.Error(ex)
        End Try

    End Sub









End Class