Imports System.Drawing
Imports Telerik.Web.UI
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data

Public Class OwingPayments
    Inherits System.Web.UI.Page
    Private Shared log As log4net.ILog = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType)
    Dim insRec As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim objCBO As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)

    Dim ds As DataSet

    Dim db As Database = insRec.Database
    Dim con As String = db.ConnectionString

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
                'cmdSave.Enabled = False
            Case "DenyAcces"
                Response.Redirect("~/AccessDenied.aspx")
                Exit Sub
            Case Else
                Response.Redirect("~/AccessDenied.aspx")
                Exit Sub
        End Select


        If Not IsPostBack Then
            objCBO.loadComboBox(cbStream, "SELECT [streamId], [stream]  FROM [tbl_streams]", "stream", "streamId")
        End If


    End Sub


    Public Sub LoadOutCome()

        If cbPaymentType.Text = "" Then
            lblMsg.BackColor = Color.Red
            lblMsg.ForeColor = Color.White
            lblMsg.Text = "Please specify the type of Payment"
            Exit Sub
        End If

        Dim sql As String = " SELECT dbo.tbl_streams.stream, dbo.tbl_schoolClasses.schoolClass, dbo.tbl_tuitionPayments.studentId, dbo.tbl_students.surname, dbo.tbl_students.firstName, dbo.tbl_students.secondName, " & _
              " SUM(dbo.tbl_tuitionPayments.expectedAmt) AS TotalExpected, SUM(dbo.tbl_tuitionPayments.amountPaid) AS TotalPaid " & _
              " FROM dbo.tbl_tuitionPayments INNER JOIN " & _
              " dbo.tbl_students ON dbo.tbl_tuitionPayments.studentId = dbo.tbl_students.studentId INNER JOIN " & _
              " dbo.tbl_schoolClasses ON dbo.tbl_students.schoolClassId = dbo.tbl_schoolClasses.schoolClassId INNER JOIN " & _
              " dbo.tbl_streams ON dbo.tbl_schoolClasses.streamId = dbo.tbl_streams.streamId " & _
              " GROUP BY dbo.tbl_tuitionPayments.studentId, dbo.tbl_students.firstName, dbo.tbl_students.secondName, dbo.tbl_students.surname, dbo.tbl_schoolClasses.schoolClass, dbo.tbl_streams.stream " & _
              " HAVING ((SUM(dbo.tbl_tuitionPayments.expectedAmt) > SUM(dbo.tbl_tuitionPayments.amountPaid)) " & _
              " AND  tbl_streams.stream LIKE '%" & cbStream.Text & "%' AND tbl_schoolClasses.schoolClass LIKE '%" & cbClass.Text & "%') " & _
              " ORDER BY dbo.tbl_streams.stream, dbo.tbl_schoolClasses.schoolClass, dbo.tbl_students.surname "

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, sql)
            db.ExecuteDataSet(CommandType.Text, sql)

            With gwArrears
                Try
                    .DataSource = ds
                    .DataBind()
                Catch ex As Exception
                    log.Error(ex.Message)
                    lblMsg.BackColor = Color.Red
                    lblMsg.ForeColor = Color.White
                    lblMsg.Text = "Grid not loaded successfully, Please check your searching criteria"

                    log.Error(ex.Message)
                End Try
            End With
        Catch ex As Exception
            log.Error(ex)
        End Try

    End Sub

    Protected Sub cmdSearch_Click(sender As Object, e As EventArgs) Handles cmdSearch.Click
        LoadOutCome()
    End Sub


    Protected Sub cbStream_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cbStream.SelectedIndexChanged
        Dim str As String = "SELECT [schoolClassId], [schoolClass] FROM [tbl_schoolClasses] WHERE [streamId] = " & cbStream.SelectedValue.ToString
        objCBO.loadComboBox(cbClass, str, "schoolClass", "schoolClassId")
    End Sub

    Protected Sub gwArrears_NeedDataSource(sender As Object, e As GridNeedDataSourceEventArgs) Handles gwArrears.NeedDataSource
        LoadOutCome()
    End Sub

    Private Sub gwArrears_PageIndexChanged(sender As Object, e As GridPageChangedEventArgs) Handles gwArrears.PageIndexChanged
        LoadOutCome()
    End Sub



End Class