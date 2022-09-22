Imports ClassLibrary1
Imports Telerik.Web.UI
Imports Microsoft.Practices.EnterpriseLibrary.Data

Public Class ExamFeesSetUp
    Inherits System.Web.UI.Page
    Dim objSetExmFee As New SetExaminationFees(CokkiesWrapper.thisConnectionName)
    Dim db As Database = objSetExmFee.Database
    Dim con As String = db.ConnectionString

    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (CokkiesWrapper.UserID <= 0 AndAlso Not IsNumeric(CokkiesWrapper.UserID)) Then
            Response.Redirect("../Login.aspx")
            Exit Sub
        End If
    End Sub

    Private Sub RadComboBoxSubjects_Load(sender As Object, e As EventArgs) Handles RadComboBoxSubjects.Load
        If Not IsPostBack Then

            Dim objSubject As New Subjects(CokkiesWrapper.thisConnectionName)
            Dim dsSubjects As DataSet = objSubject.SelectRecords()


            With RadComboBoxSubjects

                .DataSource = dsSubjects
                .DataTextField = "subject"
                .DataValueField = "subjectId"
                .DataBind()

                .Items.Insert(0, New RadComboBoxItem("", ""))

            End With

        End If
    End Sub

    Private Sub cmdSave_Click(sender As Object, e As EventArgs) Handles cmdSave.Click

        With objSetExmFee
            .ConnectionString = con
            .centerFee = txtCenterFee.Text
            .stationeryFee = txtStationaryFee.Text
            .streamId = RadComboBoxStream.SelectedValue
            .examinationBoardId = RadComboBoxStream.SelectedValue
            .setExamFee = txtFees.Text
            .subjectId = RadComboBoxSubjects.SelectedValue
        End With

        objSetExmFee.Insert()
    End Sub

    Private Sub RadComboBoxStream_Load(sender As Object, e As EventArgs) Handles RadComboBoxStream.Load
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
        End If
    End Sub

    Private Sub RadComboBoxExamBoard_Load(sender As Object, e As EventArgs) Handles RadComboBoxExamBoard.Load
        If Not IsPostBack Then
            Dim objExamBoard As New ExaminationBoards(CokkiesWrapper.thisConnectionName)
            Dim ds As DataSet = objExamBoard.SelectRecords()

            With RadComboBoxExamBoard

                .DataSource = ds
                .DataTextField = "examinationBoard"
                .DataValueField = "examinationBoardId"
                .DataBind()

                .Items.Insert(0, New RadComboBoxItem("", "0"))

            End With
        End If
    End Sub
End Class