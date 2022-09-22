
Imports CrystalDecisions.CrystalReports.Engine
Imports CrystalDecisions.Shared
Imports System.Reflection
Imports System.Security
Imports System.Xml
Imports System.IO
Imports Universal.CommonFunctions
Imports System.Drawing.Printing
Imports CrystalDecisions.Web
Imports System.Drawing

Public Class receipt
    Inherits System.Web.UI.Page

    Private Shared ReadOnly log As log4net.ILog = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType)


    Dim recieptNum As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim con As String = recieptNum.ConnectionString
    ' Dim db As Database = recieptNum.Database
    ' Dim con As String = db.ConnectionString


    Public ReportCriteria As String = ""
    Public ReportCriteriaSummary As String = ""

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ' pp()
    End Sub

    Private Function GetConnectionString() As String

        Return ConfigurationManager.ConnectionStrings(CokkiesWrapper.thisConnectionName).ConnectionString

    End Function
    Private Sub pp()
        Try
            crvReports1.Visible = True
            Dim con As String = ConfigurationManager.ConnectionStrings(CokkiesWrapper.thisConnectionName).ConnectionString
            Dim db As Microsoft.Practices.EnterpriseLibrary.Data.Database = New Microsoft.Practices.EnterpriseLibrary.Data.DatabaseProviderFactory().Create(CokkiesWrapper.thisConnectionName)
            Dim builder As New SqlClient.SqlConnectionStringBuilder(GetConnectionString())

            builder.ConnectionString = con
            builder.AsynchronousProcessing = True

            Dim ReportPath As String = System.AppDomain.CurrentDomain.BaseDirectory() & "Settings\SchoolAd\Reports\rptBillPayments.rpt"
            Dim reportfilename As String = ""

            If Not System.IO.File.Exists(ReportPath) Then


                Exit Sub

            End If

            Dim crReportDocument As New ReportDocument
            Dim xx As New commonFunction(CokkiesWrapper.thisConnectionName)
            Dim qry As String = "SELECT  dbo.tbl_tuitionPayments.studentId, dbo.tbl_streams.stream, dbo.tbl_schoolClasses.schoolClass, dbo.tbl_tuitionPayments.intYear, dbo.tbl_tuitionPayments.strMonth, dbo.tbl_tuitionPayments.expectedAmt, " & _
                      "   dbo.tbl_tuitionPayments.amountPaid, dbo.tbl_tuitionPayments.expectedAmt - dbo.tbl_tuitionPayments.amountPaid AS balance, dbo.tbl_tuitionPayments.monthNumber, dbo.tbl_tuitionPayments.date, " & _
                      "   dbo.tbl_tuitionPayments.penalty, dbo.tbl_tuitionPayments.tuitionPaymentId, dbo.tbl_students.firstName + ' ' + dbo.tbl_students.surname AS student, dbo.tbl_students.registrationDate, " & _
          "  dbo.tbl_students.dateOfBirth, dbo.tbl_students.homeAddress, dbo.tbl_tuitionPayments.receiptNumber, dbo.tbl_allPayments.cashier " & _
             " FROM            dbo.tbl_tuitionPayments INNER JOIN dbo.tbl_students ON dbo.tbl_tuitionPayments.studentId = dbo.tbl_students.studentId INNER JOIN " & _
               "          dbo.tbl_schoolClasses ON dbo.tbl_students.schoolClassId = dbo.tbl_schoolClasses.schoolClassId INNER JOIN " & _
                "         dbo.tbl_streams ON dbo.tbl_schoolClasses.streamId = dbo.tbl_streams.streamId INNER JOIN " & _
                 "        dbo.tbl_allPayments ON dbo.tbl_tuitionPayments.receiptNumber = dbo.tbl_allPayments.receiptNumber " 

            xx.ConnectionString = con
            Dim ds As DataSet = xx.ExecuteDsQRY(qry)

            crReportDocument.Load(ReportPath)

            crReportDocument.SetDataSource(ds)

            Session.Add("REPORT_KEY", crReportDocument)
            crvReports1.ReportSource = crReportDocument



        Catch ex As Exception
            MsgBox(ex.Message, MsgBoxStyle.Critical + MsgBoxStyle.OkOnly)
        End Try
    End Sub
    Private Sub ConfigureCrystalReports(Optional ByVal MemberID As Integer = 0, Optional ByVal rptPath As String = "", Optional ByRef crReportDocument As ReportDocument = Nothing, Optional ByVal Criteria As String = "", Optional ByRef Parameters As Hashtable = Nothing, Optional ByVal CriteriaSummary As String = "")
        '   Try
        '      crReportDocument.Dispose()
        '   Catch ex As Exception

        '  End Try
        crvReports1.Visible = True

        Try

            Dim con As String = ConfigurationManager.ConnectionStrings(CokkiesWrapper.thisConnectionName).ConnectionString
            Dim db As Microsoft.Practices.EnterpriseLibrary.Data.Database = New Microsoft.Practices.EnterpriseLibrary.Data.DatabaseProviderFactory().Create(CokkiesWrapper.thisConnectionName)
            Dim builder As New SqlClient.SqlConnectionStringBuilder(GetConnectionString())

            builder.ConnectionString = con
            builder.AsynchronousProcessing = True

            Dim ReportPath As String = ""
            Dim reportfilename As String = ""

            CacheWrapper.ReportsCache.Tables(0).DefaultView.RowFilter = "ReportName IS NOT NULL"

            If CacheWrapper.ReportsCache.Tables(0).DefaultView.Count > 0 Then

                ' IMPORTANT!!: make sure you have added the BlankReport.rpt file - flanagan
                'ReportPath = System.AppDomain.CurrentDomain.BaseDirectory() & "Settings\" & "ConnectionString" & "\Reports\BlankReport.rpt"

            End If

            If txtReportName.Text <> "" Then

                'ReportPath = System.AppDomain.CurrentDomain.BaseDirectory() & "Settings\" & "SchoolAd" & "\" & txtReportName.Text & ".rpt"
                'reportfilename = txtReportName.Text

                ReportPath = System.AppDomain.CurrentDomain.BaseDirectory() & "Settings\SchoolAd\Receipt.rpt"
                reportfilename = "Receipt.rpt"

            Else
                ReportPath = System.AppDomain.CurrentDomain.BaseDirectory() & "Settings\SchoolAd\Receipt.rpt"
                'NOTE:we need to check if we are loading a black ReportDoc. if we are proceed and show it. If not exit the sub and display error msg - flanagan

                If Not ReportPath.Contains("\BlankReport.rpt") Then

                    'no report will be displayed so we need to hide the reports filter before we exit the sub here - flanagan
                    ' ucReportsFilterControl.Visible = False
                    radpCriteria.Visible = False
                    reportfilename = ""
                    Exit Sub

                End If

            End If

            'we just need to make sure that the filter is not shown if we are showing BlankReport
            ' ucReportsFilterControl.Visible = Not ReportPath.Contains("\BlankReport.rpt")
            radpCriteria.Visible = Not ReportPath.Contains("\BlankReport.rpt")

            If Not System.IO.File.Exists(ReportPath) Then


                Exit Sub

            End If


            If IsNothing(crReportDocument) Then
                Dim cReportDocument As New ReportDocument
                crReportDocument = cReportDocument
            End If

            crReportDocument.Load(ReportPath)

            'If we have cookie based criteria, we can immediately filter and display
            If IsNumeric(txtReportID.Text) Then

                '  Dim CookiesCriteria As String = GetCookieBasedCriteria(txtReportID.Text)
                '  txtUserReportFilter.Text &= CookiesCriteria

            End If

            Dim myConnectionInfo As ConnectionInfo = New ConnectionInfo()

            With myConnectionInfo
                .ServerName = builder.DataSource
                .DatabaseName = builder.InitialCatalog
                .UserID = builder.UserID
                .Password = builder.Password
            End With

            crReportDocument.RecordSelectionFormula = Criteria
            crReportDocument.SummaryInfo.ReportComments = CriteriaSummary
            crReportDocument.SummaryInfo.ReportAuthor = CokkiesWrapper.UserName
            crReportDocument.DataDefinition.RecordSelectionFormula = txtUserReportFilter.Text
            crReportDocument.SummaryInfo.ReportTitle = txtReportTitle.Text

            If Not IsNothing(Parameters) AndAlso Parameters.Count > 0 Then

                For Each de As DictionaryEntry In Parameters

                    crReportDocument.SetParameterValue(de.Key, de.Value)

                Next
            Else
                If Session("Parameters") IsNot Nothing Then

                    Parameters = Session("Parameters")

                    For Each de As DictionaryEntry In Parameters

                        crReportDocument.SetParameterValue(de.Key, de.Value)

                    Next

                End If

            End If

            '   SetDBLogonForReport(myConnectionInfo, crReportDocument)
            ' SetDBLogonForSubreports(myConnectionInfo, crReportDocument)

            Session.Add("REPORT_KEY", crReportDocument)
            crvReports1.ReportSource = crReportDocument
            '   crReportDocument.Dispose()
            'If Not IsNothing(crReportDocument) Then
            '    crReportDocument.Dispose()
            'End If
        Catch ex As Exception

            'ShowMessage(ex, MessageTypeEnum.Error)
            log.Error(ex)

        End Try

    End Sub


    Protected Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        'ConfigureCrystalReports()
        pp()
    End Sub
End Class