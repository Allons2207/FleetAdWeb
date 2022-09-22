Imports ClassLibrary1
Imports Telerik.Web.UI
Imports System.Drawing
Imports Microsoft.Practices.EnterpriseLibrary.Data

Public Class LevyBilling
    Inherits System.Web.UI.Page
    Dim objStudentLevyPayments As New StudentLevyPayments(CokkiesWrapper.thisConnectionName)
    Dim objPaymentsSchedule As New SetLevyPaymentsSchedule(CokkiesWrapper.thisConnectionName)
    Dim objCBO As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim dsStudents As DataSet
    Dim db As Database = objStudentLevyPayments.Database
    Dim con As String = db.ConnectionString
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (CokkiesWrapper.UserID <= 0 AndAlso Not IsNumeric(CokkiesWrapper.UserID)) Then
            Response.Redirect("../Login.aspx")
            Exit Sub
        End If


        obj.ConnectionString = con
        Dim accessMode As String = obj.groupAccessPermissionsDs(CokkiesWrapper.UserGroup, 4)

        Select Case accessMode
            Case "AllowReadNRead"
            Case "ReadNReadOnly"
                cmdBill.Enabled = False
            Case "DenyAcces"
                Response.Redirect("~/AccessDenied.aspx")
                Exit Sub
            Case Else
                Response.Redirect("~/AccessDenied.aspx")
                Exit Sub
        End Select


        DropDownListStreams_Load()
        'DropDownListClass_Load()
    End Sub
    Private Sub DropDownListStreams_Load()
        If Not IsPostBack Then
            Dim objStream As New Streams(CokkiesWrapper.thisConnectionName)
            Dim ds As DataSet = objStream.SelectRecords()

            With RadComboBoxStream
                .DataSource = ds
                .DataTextField = "stream"
                .DataValueField = "streamid"
                .DataBind()
                .Items.Insert(0, New RadComboBoxItem("", "0"))
            End With

            With radCboStream
                .DataSource = ds
                .DataTextField = "stream"
                .DataValueField = "streamid"
                .DataBind()
                .Items.Insert(0, New RadComboBoxItem("", "0"))
            End With

            objCBO.loadComboBox(radCboTerm, "SELECT [termId], [term] FROM [tbl_schoolTerms]", "term", "termId")
            radCboTerm.Items.Insert(0, New RadComboBoxItem("", "0"))

        End If
    End Sub
    'Private Sub DropDownListClass_Load()
    '    If Not IsPostBack Then
    '        Dim objSchooolClass As New SchoolClasses(CokkiesWrapper.thisConnectionName)
    '        Dim ds As DataSet = objSchooolClass.SelectRecords()

    '        With RadComboBoxClass

    '            .DataSource = ds
    '            .DataTextField = "schoolClass"
    '            .DataValueField = "schoolClassId"
    '            .DataBind()

    '            .Items.Insert(0, New RadComboBoxItem("", "0"))

    '        End With
    '    End If
    'End Sub


    Private Sub cmdBill_Click(sender As Object, e As EventArgs) Handles cmdBill.Click

        With objStudentLevyPayments

            .ConnectionString = con
            .strTerm = RadComboBoxBillingTerm.Text
            .TermNumber = RadComboBoxBillingTerm.SelectedValue
            .intYear = Year(RadDatePickerBillingDate.SelectedDate)
            .stream = RadComboBoxStream.SelectedValue
            '.classid = RadComboBoxClass.SelectedValue
            .amountPaid = 0
            .penalty = 0

            Dim dsLevy As DataSet = objPaymentsSchedule.GetLevy(.stream)
            .expectedAmt = dsLevy.Tables(0).Rows(0)("amountPerTerm")

            Dim sql As String = "select * from tbl_students join tbl_schoolclasses on tbl_students.schoolClassId =  tbl_schoolclasses.schoolClassId " & _
                " where streamId = '" & .stream & "'  AND tbl_students.studentId NOT IN (SELECT [studentd] FROM [tbl_LevyPayments] WHERE [intYear] = " & .intYear & " AND [termNumber] = " & .TermNumber & ") "

            Try
                dsStudents = db.ExecuteDataSet(CommandType.Text, sql)
                db.ExecuteDataSet(CommandType.Text, sql)
                Dim i As Integer = 0

                For Each row As DataRow In dsStudents.Tables(0).Rows
                    If i < dsStudents.Tables(0).Rows.Count Then
                        .studentd = dsStudents.Tables(0).Rows(i)("studentId")
                        .Insert()
                        i = i + 1
                    End If
                Next

                lblMsg.BackColor = Color.Green
                lblMsg.ForeColor = Color.White
                lblMsg.Text = "Students were billed successfully!!!"

            Catch ex As Exception

                lblMsg.BackColor = Color.Red
                lblMsg.ForeColor = Color.White
                lblMsg.Text = "Students were not billed successfully!!!"

            End Try


        End With

    End Sub

    Protected Sub btnShowBillingGrid_Click(sender As Object, e As EventArgs) Handles btnShowBillingGrid.Click
        With gwBilling
            Try
                'Dim sql As String = "SELECT  dbo.tbl_streams.stream, dbo.tbl_schoolClasses.schoolClass, dbo.tbl_students.studentId, dbo.tbl_students.firstName," & _
                '    " dbo.tbl_students.secondName, dbo.tbl_students.surname, dbo.tbl_tuitionPayments.intYear, dbo.tbl_tuitionPayments.strMonth, " & _
                '    " dbo.tbl_tuitionPayments.expectedAmt, dbo.tbl_tuitionPayments.amountPaid FROM            dbo.tbl_tuitionPayments INNER JOIN " & _
                '           " dbo.tbl_students ON dbo.tbl_tuitionPayments.studentId = dbo.tbl_students.studentId INNER JOIN " & _
                '    "     dbo.tbl_schoolClasses ON dbo.tbl_students.schoolClassId = dbo.tbl_schoolClasses.schoolClassId INNER JOIN " & _
                '    "     dbo.tbl_streams ON dbo.tbl_schoolClasses.streamId = dbo.tbl_streams.streamId " & _
                '   " WHERE  (dbo.tbl_tuitionPayments.intYear = Year(getdate())) AND (dbo.tbl_tuitionPayments.strMonth = '" & cboMonths.Text & "') AND (dbo.tbl_streams.stream = '" & radCboStream.Text & "') " & _
                '    " ORDER BY dbo.tbl_schoolClasses.schoolClass, dbo.tbl_students.firstName, dbo.tbl_students.secondName, dbo.tbl_students.surname "


                Dim sql As String = " SELECT dbo.tbl_streams.stream AS Stream, dbo.tbl_schoolClasses.schoolClass AS Class, dbo.tbl_students.studentId AS StudentID, dbo.tbl_students.firstName AS FirstName, " & _
                                    " dbo.tbl_students.secondName AS SecondName, dbo.tbl_students.surname AS Surname, dbo.tbl_LevyPayments.intYear AS Year, dbo.tbl_LevyPayments.strTerm AS Term, " & _
                                    " dbo.tbl_LevyPayments.termNumber AS [Term #], dbo.tbl_LevyPayments.expectedAmt AS [Amount Expected], dbo.tbl_LevyPayments.amountPaid AS [Amount Paid] " & _
                                    " FROM dbo.tbl_students INNER JOIN " & _
                                    " dbo.tbl_LevyPayments ON dbo.tbl_students.studentId = dbo.tbl_LevyPayments.studentd INNER JOIN " & _
                                    " dbo.tbl_schoolClasses ON dbo.tbl_students.schoolClassId = dbo.tbl_schoolClasses.schoolClassId INNER JOIN " & _
                                    " dbo.tbl_streams ON dbo.tbl_schoolClasses.streamId = dbo.tbl_streams.streamId " & _
                                    " WHERE  (dbo.tbl_LevyPayments.intYear = Year(getdate())) AND (dbo.tbl_LevyPayments.termNumber = " & radCboTerm.SelectedValue & ") AND tbl_schoolClasses.streamId = " & radCboStream.SelectedValue & "" & _
                                    " ORDER BY Stream, Class, Surname, FirstName, SecondName "







                Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
                .DataSource = ds
                .DataBind()
            Catch ex As Exception
                'log.Error(ex.Message)
            End Try
        End With
    End Sub

End Class