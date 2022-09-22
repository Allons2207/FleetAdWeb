Imports ClassLibrary1
Imports Telerik.Web.UI
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing

Public Class TutionBilling
    Inherits System.Web.UI.Page
    Dim objStudentTutionPayments As New studentTuitionPayments(CokkiesWrapper.thisConnectionName)
    Dim dsStudents As DataSet
    Dim objPaymentsSchedule As New SetTuitionPaymentsSchedule(CokkiesWrapper.thisConnectionName)
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = objStudentTutionPayments.Database
    Dim con As String = db.ConnectionString
    Dim dsMain As DataSet
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then
            If (CokkiesWrapper.UserID <= 0 AndAlso Not IsNumeric(CokkiesWrapper.UserID)) Then
                Response.Redirect("../Login.aspx")
                Exit Sub
            End If

            obj.ConnectionString = con
            Dim accessMode As String = obj.groupAccessPermissionsDs(CokkiesWrapper.UserGroup, 4)

            Select Case accessMode
                Case "AllowReadNRead"
                Case "ReadNReadOnly"
                    ' cmdSave.Enabled = False
                Case "DenyAcces"
                    Response.Redirect("~/AccessDenied.aspx")
                    Exit Sub
                Case Else
                    Response.Redirect("~/AccessDenied.aspx")
                    Exit Sub
            End Select

            'DropDownListClass_Load()
            DropDownListStreams_Load()
        End If
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
        End If
    End Sub
    Protected Sub cmdBill_Click(sender As Object, e As EventArgs) Handles cmdBill.Click
        Try
            With objStudentTutionPayments

                .ConnectionString = con
                .billingDate = RadDatePickerBillingDate.SelectedDate
                .strMonth = RadComboBoxBillingMonth.Text
                .monthNumber = RadComboBoxBillingMonth.SelectedValue
                .intYear = Year(RadDatePickerBillingDate.SelectedDate)
                .stream = RadComboBoxStream.SelectedValue
                ' .classid = RadComboBoxClass.SelectedValue
                .amountPaid = 0
                .penalty = 0

                Dim sql As String = ""

                If chkClassSpecificBilling.Checked = False Then
                    Dim dsTuition As DataSet = objPaymentsSchedule.GetTuition(.stream)
                    .expectedAmt = dsTuition.Tables(0).Rows(0)("amountPerMonth")

                    sql = "select * from tbl_students join tbl_schoolclasses on tbl_students.schoolClassId =  tbl_schoolclasses.schoolClassId " & _
                                   " WHERE  streamId = " & .stream & " AND tbl_students.studentId NOT IN (SELECT  studentId FROM dbo.tbl_tuitionPayments WHERE  intYear = " & .intYear & " AND strMonth = '" & .strMonth & "')"

                Else
                    Dim dsTuition As DataSet = objPaymentsSchedule.GetTuitionByClass(.stream, RadComboClass.SelectedValue)
                    .expectedAmt = dsTuition.Tables(0).Rows(0)("amountPerMonth")

                    sql = "select * from tbl_students join tbl_schoolclasses on tbl_students.schoolClassId =  tbl_schoolclasses.schoolClassId " & _
                                  " WHERE  streamId = " & .stream & " AND tbl_students.schoolClassId = " & RadComboClass.SelectedValue & "   AND tbl_students.studentId NOT IN (SELECT  studentId FROM dbo.tbl_tuitionPayments WHERE  intYear = " & .intYear & " AND strMonth = '" & .strMonth & "')"
                End If




                Try
                    dsStudents = db.ExecuteDataSet(CommandType.Text, sql)
                    db.ExecuteDataSet(CommandType.Text, sql)

                    Dim i As Integer = 0
                    For Each row As DataRow In dsStudents.Tables(0).Rows

                        If i < dsStudents.Tables(0).Rows.Count Then

                            .studentId = dsStudents.Tables(0).Rows(i)("studentId")

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

        Catch ex As Exception
            lblMsg.BackColor = Color.Red
            lblMsg.ForeColor = Color.White
            lblMsg.Text = "Students were not billed successfully!!!"
        End Try

    End Sub

    Protected Sub btnShowBillingGrid_Click(sender As Object, e As EventArgs) Handles btnShowBillingGrid.Click
        loadDataInGrid()
    End Sub

    Private Sub loadSelectedStreamClasses()

        Dim sql As String = "SELECT schoolClass, schoolClassId FROM  dbo.tbl_schoolClasses"
        '  Dim sql As String = "SELECT schoolClass, schoolClassId FROM  dbo.tbl_schoolClasses WHERE (streamId = " & radCboStream.SelectedValue & ") "
        obj.loadComboBox(RadComboClass, sql, "schoolClass", "schoolClassId")
    End Sub


    Protected Sub chkClassSpecificBilling_CheckedChanged(sender As Object, e As EventArgs) Handles chkClassSpecificBilling.CheckedChanged
        If chkClassSpecificBilling.Checked = True Then
            Dim sql As String = "SELECT schoolClass, schoolClassId FROM  dbo.tbl_schoolClasses WHERE (streamId = " & RadComboBoxStream.SelectedValue & ") "
            obj.loadComboBox(RadComboClass, sql, "schoolClass", "schoolClassId")
        Else
            RadComboClass.DataSource = String.Empty
            RadComboClass.DataBind()
        End If
    End Sub

    Protected Sub gwBilling_NeedDataSource(sender As Object, e As GridNeedDataSourceEventArgs) Handles gwBilling.NeedDataSource

    End Sub

    Private Sub gwBilling_PageIndexChanged(sender As Object, e As GridPageChangedEventArgs) Handles gwBilling.PageIndexChanged
        loadDataInGrid()
    End Sub

    Private Sub gwBilling_PageSizeChanged(sender As Object, e As GridPageSizeChangedEventArgs) Handles gwBilling.PageSizeChanged
        loadDataInGrid()
    End Sub

    Private Sub loadDataInGrid()
        With gwBilling
            Try
                Dim sql As String = "SELECT  dbo.tbl_streams.stream AS [Stream], dbo.tbl_schoolClasses.schoolClass AS [Class], dbo.tbl_students.studentId AS [Student ID], dbo.tbl_students.firstName AS [First Name]," & _
                    " dbo.tbl_students.secondName AS [Second Name], dbo.tbl_students.surname AS [Surname], dbo.tbl_tuitionPayments.intYear AS [Year], dbo.tbl_tuitionPayments.strMonth AS [Month], " & _
                    " dbo.tbl_tuitionPayments.expectedAmt AS [Expected Amount], dbo.tbl_tuitionPayments.amountPaid AS [Amount Paid] FROM            dbo.tbl_tuitionPayments INNER JOIN " & _
                           " dbo.tbl_students ON dbo.tbl_tuitionPayments.studentId = dbo.tbl_students.studentId INNER JOIN " & _
                    "     dbo.tbl_schoolClasses ON dbo.tbl_students.schoolClassId = dbo.tbl_schoolClasses.schoolClassId INNER JOIN " & _
                    "     dbo.tbl_streams ON dbo.tbl_schoolClasses.streamId = dbo.tbl_streams.streamId " & _
                   " WHERE  (dbo.tbl_tuitionPayments.intYear = Year(getdate())) AND (dbo.tbl_tuitionPayments.strMonth = '" & cboMonths.Text & "') AND (dbo.tbl_streams.stream = '" & radCboStream.Text & "') " & _
                    " ORDER BY dbo.tbl_schoolClasses.schoolClass, dbo.tbl_students.firstName, dbo.tbl_students.secondName, dbo.tbl_students.surname "
                Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
                dsMain = ds
                .DataSource = ds
                .DataBind()
            Catch ex As Exception
                'log.Error(ex.Message)
            End Try
        End With
    End Sub
End Class