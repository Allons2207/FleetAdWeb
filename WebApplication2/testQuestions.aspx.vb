Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports ClassLibrary1

Public Class testQuestions
    Inherits System.Web.UI.Page

    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub cmdSave_Click(sender As Object, e As EventArgs) Handles cmdSave.Click

        Dim qry As String = "INSERT  tbl_testQuestions([testId], [qtnNumber],[question] , [mcAnswerA], [mcAnswerB], [mcAnswerC]," & _
                         " [mcAnswerD], [mcAnswerE], [answer], [qtnMarks],[qtnCounter]) " & _
                         " VALUES ('" & txtTestCode.Text & "','" & txtQuestionNum.Text & "','" & txtQuestion.Text & "','" & txtA.Text & _
                         "','" & txtB.Text & "','" & txtC.Text & "','" & txtD.Text & "','" & txtE.Text & "','" & cboAnswer.Text & "'," & _
                         txtQuestionMarks.Text & "," & txtOrderNumber.Text & ")"

        If obj.ExecuteNonQRY(qry) = 1 Then
            lblMsg.Text = "Test/Assignment Question entry has been saved successfully."
            ' loadDataGrid()
        Else
            lblMsg.Text = "Test/Assignment Question entry has not been saved successfully."
        End If






    End Sub
End Class