
Imports ClassLibrary1
Imports Telerik.Web.UI
Imports System.Drawing
Imports Microsoft.Practices.EnterpriseLibrary.Data

Public Class InternalStudentFeesPayment
    Inherits System.Web.UI.Page

    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim objStudent As New Student(CokkiesWrapper.thisConnectionName)
    Dim objAllPayments As New AllPayments(CokkiesWrapper.thisConnectionName)

    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then
            gwBillPayments.DataSource = String.Empty
            gwBillPayments.DataBind()

            obj.ConnectionString = con
            obj.loadComboBox(cboLevel, "SELECT [streamId], [stream] FROM [dbo].[tbl_streams]", "stream", "streamId")
            cboLevel.Items.Insert(0, New RadComboBoxItem("", "0"))

            obj.loadComboBox(cboExamBoard, "SELECT [examinationBoardId], [examinationBoard] FROM [tbl_examinationBoards]", "examinationBoard", "examinationBoardId")
            cboExamBoard.Items.Insert(0, New RadComboBoxItem("", "0"))

            obj.loadComboBox(cboSession, "SELECT [examSessionId], [examSession] FROM [luExaminationSessions]", "examSession", "examSessionId")
            cboExamBoard.Items.Insert(0, New RadComboBoxItem("", "0"))
        End If

    End Sub

    Protected Sub cmdFind_Click(sender As Object, e As EventArgs) Handles cmdFind.Click
        Dim ds As DataSet = objStudent.selectRecords(txtStudentNo.Text)
        If ds.Tables.Count > 0 Then
            txtFirstName.Text = ds.Tables(0).Rows(0)("firstName")
            txtSurname.Text = ds.Tables(0).Rows(0)("surname")
            txtStream.Text = ds.Tables(0).Rows(0)("stream")
            txtClass.Text = ds.Tables(0).Rows(0)("schoolClass")
        End If

        centerAndStationeryFees()

    End Sub

    Private Sub centerAndStationeryFees()
        Dim qryStr As String = "SELECT DISTINCT  [centerFee] ,  [stationeryFee]  FROM   tbl_examinationFeeBySubjectSetUp " & _
                               " WHERE [examBoardId] = " & cboExamBoard.SelectedValue & " AND [examLevelId] = " & cboLevel.SelectedValue

        obj.ConnectionString = con

        Dim ds As DataSet = obj.ExecuteDsQRY(qryStr)
        If ds.Tables.Count > 0 Then
            If ds.Tables(0).Rows.Count > 0 Then
                txtCentreFee.Text = Val(ds.Tables(0).Rows(0)("centerFee"))
                txtStationeryFee.Text = Val(ds.Tables(0).Rows(0)("stationeryFee"))
            End If
        End If



    End Sub

    Protected Sub cboLevel_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboLevel.SelectedIndexChanged
        centerAndStationeryFees()
    End Sub

    Protected Sub cboExamBoard_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboExamBoard.SelectedIndexChanged
        centerAndStationeryFees()
    End Sub

    Protected Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click

        Dim qryStr As String = "INSERT [tbl_examinationFeesPayments]([yYear], [examSessionId], [levelId], [examBoardId], [studentId]," & _
            " [centerFee], [numberOfSubjects], [stationeryFee],otherFeesDesc,otherFeesAmt, [amountDue], [amountPaid]) " & _
            " VALUES(" & txtYear.Text & "," & cboLevel.SelectedValue & "," & cboLevel.SelectedValue & "," & cboExamBoard.SelectedValue & ",'" & txtStudentNo.Text & "'," & txtCentreFee.Text & "," & _
             txtNumberOfSubjectsRegistered.Text & "," & txtStationeryFee.Text & ",'" & txtOtherFeesDesc.Text & "'," & txtOtherFeesAmt.Text & "," & txtAmountDue.Text & "," & txtAmountPaid.Text & ")"

        Try
            obj.ConnectionString = con

            If obj.ExecuteNonQRY(qryStr) = 1 Then
                lblMsg.Text = "Examination Fees payment has been captured successfully."
            Else
                lblMsg.Text = "Examination Fees payment has not been saved successfully."
            End If
        Catch ex As Exception

        End Try

    End Sub

End Class