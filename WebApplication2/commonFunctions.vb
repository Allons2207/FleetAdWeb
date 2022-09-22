Imports System
Imports System.Collections.Generic
Imports System.Text
Imports System.Data
Imports System.Data.SqlClient
Imports System.Collections
Imports System.Configuration
Imports System.Web
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Telerik.Web.UI

Public Class commonFunction

    Private Shared ReadOnly log As log4net.ILog = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType)
    Protected db As Database
    Public ReadOnly Property Database() As Database
        Get
            Return db
        End Get
    End Property
    Protected mConnectionName As String
    Public ReadOnly Property ConnectionName() As String
        Get
            Return mConnectionName
        End Get
    End Property

    Public Sub New(ByVal ConnectionName As String)
        Try
            mConnectionName = ConnectionName
            Dim factory As DatabaseProviderFactory = New DatabaseProviderFactory()
            db = factory.Create(ConnectionName)
        Catch ex As Exception

        End Try


    End Sub
    Private mConnectionString As String
    Property ConnectionString As String
        Get
            Return mConnectionString
        End Get
        Set(ByVal value As String)
            mConnectionString = value
        End Set
    End Property


    Public Function Catchnull(objOld As Object, objNew As Object, Optional CheckEmptyString As Boolean = False) As Object
        objNew = objOld
        Return objNew
    End Function

    Public Function ExecuteNonQRY(qrySTR As String) As Integer
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand(qrySTR, conn)
        cmd.CommandType = CommandType.Text

        Try
            conn.Open()
            cmd.ExecuteNonQuery()
            Return 1
        Catch ex As Exception
            Return 0
        Finally
            If conn.State = ConnectionState.Open Then conn.Close()
            conn.Dispose()
            cmd.Dispose()

        End Try
    End Function

    Public Function ExecuteDsQRY(qrySTR As String) As DataSet
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand(qrySTR, conn)
        cmd.CommandType = CommandType.Text

        Try
            conn.Open()

            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, qrySTR)
            Return ds

        Catch
            Return Nothing
        Finally
            If conn.State = ConnectionState.Open Then conn.Close()
            conn.Dispose()
            cmd.Dispose()
        End Try
    End Function

    Public Function groupAccessPermissionsDs(groupId As Integer, moduleId As Integer) As String
        Dim qrySTR As String = "SELECT readMode, writeMode FROM tbl_groupPageAccessPermissions WHERE groupId =" & groupId & " AND moduleId =" & moduleId
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand(qrySTR, conn)
        cmd.CommandType = CommandType.Text

        groupAccessPermissionsDs = Nothing

        Try
            conn.Open()

            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, qrySTR)
            Dim dt As DataTable = ds.Tables(0)

            If dt.Rows.Count > 0 Then
                Dim readMode As String = dt.Rows(0).Item("readMode")
                Dim writeMode As String = dt.Rows(0).Item("writeMode")

                If readMode = 1 And writeMode = 1 Then
                    groupAccessPermissionsDs = "AllowReadNRead"
                ElseIf readMode = 1 And writeMode = 0 Then
                    groupAccessPermissionsDs = "ReadNReadOnly"
                Else
                    groupAccessPermissionsDs = "DenyAcces"
                End If
            End If
        Catch
            Return Nothing
        Finally
            If conn.State = ConnectionState.Open Then conn.Close()
            conn.Dispose()
            cmd.Dispose()
        End Try
    End Function


    Public Function transportFee(strMonth As String) As Integer
        Dim qrySTR As String = "SELECT amount FROM tbl_transportSetAmounts WHERE mmonth = '" & strMonth & "'"
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand(qrySTR, conn)
        cmd.CommandType = CommandType.Text

        transportFee = 0

        Try
            conn.Open()
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, qrySTR)
            Dim dt As DataTable = ds.Tables(0)

            If dt.Rows.Count > 0 Then
                Return dt.Rows(0).Item("amount")
            End If
        Catch
            Return Nothing
        Finally
            If conn.State = ConnectionState.Open Then conn.Close()
            conn.Dispose()
            cmd.Dispose()
        End Try

    End Function
    Public Function fnReceiptNumber() As String

        ExecuteNonQRY("UPDATE tbl_receiptCounter SET ctr = ctr + 1")

        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand("SELECT ctr FROM tbl_receiptCounter", conn)
        Dim receiptNum As String
        cmd.CommandType = CommandType.Text

        Try
            conn.Open()

            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, cmd.CommandText)
            If ds.Tables.Count > 0 Then
                If ds.Tables(0).Rows.Count > 0 Then
                    receiptNum = CStr(Val(ds.Tables(0).Rows(0)("ctr")))
                    Select Case Len(receiptNum)
                        Case 1
                            'CStr(DatePart(DateInterval.Year, Today)) & 
                            fnReceiptNumber = "H" & "000000" & receiptNum
                        Case 2
                            fnReceiptNumber = "H" & "00000" & receiptNum
                        Case 3
                            fnReceiptNumber = "H" & "0000" & receiptNum
                        Case 4
                            fnReceiptNumber = "H" & "000" & receiptNum
                        Case 5
                            fnReceiptNumber = "H" & "00" & receiptNum
                        Case 6
                            fnReceiptNumber = "H" & "0" & receiptNum
                        Case 7
                            fnReceiptNumber = "H" & receiptNum
                        Case Else
                            fnReceiptNumber = ""
                    End Select
                Else
                    fnReceiptNumber = ""
                End If
            Else
                fnReceiptNumber = ""
            End If

        Catch
            Return Nothing
        Finally
            If conn.State = ConnectionState.Open Then conn.Close()
            conn.Dispose()
            cmd.Dispose()
        End Try
    End Function

    Public Sub loadComboBox(cbo As RadComboBox, qry As String, textField As String, valueField As String)
        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, qry)

            With cbo
                Try
                    .DataSource = ds
                    .DataTextField = textField
                    .DataValueField = valueField
                    .DataBind()
                    .Items.Insert(0, New RadComboBoxItem("--Select--", ""))
                Catch ex As Exception
                    log.Error(ex.Message)
                End Try
            End With
        Catch ex As Exception
            log.Error(ex)
        End Try



    End Sub


    Public Function monthNameFromMonthNumber(ByVal monthnum As Integer) As String

        monthNameFromMonthNumber = ""

        Select Case monthnum
            Case 1
                monthNameFromMonthNumber = "January"
            Case 2
                monthNameFromMonthNumber = "February"
            Case 3
                monthNameFromMonthNumber = "March"
            Case 4
                monthNameFromMonthNumber = "April"
            Case 5
                monthNameFromMonthNumber = "May"
            Case 6
                monthNameFromMonthNumber = "June"
            Case 7
                monthNameFromMonthNumber = "July"
            Case 8
                monthNameFromMonthNumber = "August"
            Case 9
                monthNameFromMonthNumber = "September"
            Case 10
                monthNameFromMonthNumber = "October"
            Case 11
                monthNameFromMonthNumber = "November"
            Case 12
                monthNameFromMonthNumber = "December"
        End Select

    End Function


    Public Sub MessageLabel(lblLabel As Label, ByVal msg As String, ByVal strCase As String)
        With lblLabel
            .Text = msg
            Select Case strCase
                Case "Red"
                    .BackColor = Drawing.Color.Red
                    .ForeColor = Drawing.Color.White
                    .BorderStyle = BorderStyle.Solid
                '.BorderWidth = 1
                '.BorderColor = Drawing.Color.Black
                Case "Green"
                    .BackColor = Drawing.Color.Green
                    .ForeColor = Drawing.Color.White
                    .BorderStyle = BorderStyle.Solid
                '.BorderColor = Drawing.Color.Black
                '.BorderWidth = 1
                Case "Yellow"
                    .BackColor = Drawing.Color.Yellow
                    .ForeColor = Drawing.Color.Black
                ' .BorderStyle = BorderStyle.Solid
                '  .BorderColor = Drawing.Color.Black
                ' .BorderWidth = 1
                Case Else
                    .BackColor = Drawing.Color.White
                    .ForeColor = Drawing.Color.White
                    .Text = ""
                    .BorderStyle = BorderStyle.NotSet

            End Select
        End With
    End Sub

    Public Function fnComboBoxValidText(ByVal comboBoxText As String) As String
        If comboBoxText = "--Select--" Then
            Return ""
        Else
            Return comboBoxText
        End If
    End Function
    'SELECT [registrationNumber] FROM [dbo].[tbl_vehicleData] WHERE [fleetId] = ?


    Public Function fnVehicleRegNumFromFleetID(ByVal FleetID As String) As String
        fnVehicleRegNumFromFleetID = ""

        Dim qrySTR As String = "SELECT [registrationNumber] FROM [dbo].[tbl_vehicleData] WHERE [fleetId] = '" & FleetID & "'"
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand(qrySTR, conn)
        cmd.CommandType = CommandType.Text

        Try
            conn.Open()
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, qrySTR)
            Dim dt As DataTable = ds.Tables(0)

            If dt.Rows.Count > 0 Then
                fnVehicleRegNumFromFleetID = dt.Rows(0).Item("registrationNumber")
            End If
        Catch ex As Exception
            Return Nothing
        Finally
            If conn.State = ConnectionState.Open Then conn.Close()
            conn.Dispose()
            cmd.Dispose()
        End Try

    End Function


    Public Function fnVehicleFleetIDNumFromRegNum(ByVal RegNum As String) As String
        fnVehicleFleetIDNumFromRegNum = ""

        Dim qrySTR As String = "SELECT [FleetId] FROM [dbo].[tbl_vehicleData] WHERE [registrationNumber] = '" & RegNum & "'"
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand(qrySTR, conn)
        cmd.CommandType = CommandType.Text

        Try
            conn.Open()
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, qrySTR)
            Dim dt As DataTable = ds.Tables(0)

            If dt.Rows.Count > 0 Then
                fnVehicleFleetIDNumFromRegNum = dt.Rows(0).Item("FleetId")
            End If
        Catch ex As Exception
            Return Nothing
        Finally
            If conn.State = ConnectionState.Open Then conn.Close()
            conn.Dispose()
            cmd.Dispose()
        End Try

    End Function

    Public Function fnVehicleExists(ByVal FleetID As String) As Boolean
        fnVehicleExists = False

        Dim qrySTR As String = "SELECT * FROM [dbo].[tbl_vehicleData] WHERE [FleetId] = '" & FleetID & "'"
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand(qrySTR, conn)
        cmd.CommandType = CommandType.Text

        Try
            conn.Open()
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, qrySTR)
            Dim dt As DataTable = ds.Tables(0)

            If dt.Rows.Count > 0 Then
                Return True
            End If
        Catch
            Return Nothing
        Finally
            If conn.State = ConnectionState.Open Then conn.Close()
            conn.Dispose()
            cmd.Dispose()
        End Try

    End Function

    Public Function fnVehicleUserExists(ByVal LicenseNumber As String) As Boolean
        fnVehicleUserExists = False

        Dim qrySTR As String = "Select * From [dbo].[tbl_vehicleUsers] Where [LicenseNumber] = '" & LicenseNumber & "'"
        ' Dim qrySTR As String = "Select * FROM [dbo].[tbl_vehicleData] WHERE [registrationNumber] = '" & LicenseNumber & "'"
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand(qrySTR, conn)
        cmd.CommandType = CommandType.Text

        Try
            conn.Open()
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, qrySTR)
            Dim dt As DataTable = ds.Tables(0)

            If dt.Rows.Count > 0 Then
                Return True
            End If
        Catch
            Return Nothing
        Finally
            If conn.State = ConnectionState.Open Then conn.Close()
            conn.Dispose()
            cmd.Dispose()
        End Try

    End Function


    Public Function fnVehicleUserNationalIdFromLicenceNum(ByVal LicenseNumber As String) As String
        fnVehicleUserNationalIdFromLicenceNum = ""

        Dim qrySTR As String = "Select * From [dbo].[tbl_vehicleUsers] Where [LicenseNumber] = '" & LicenseNumber & "'"
        ' Dim qrySTR As String = "Select * FROM [dbo].[tbl_vehicleData] WHERE [registrationNumber] = '" & LicenseNumber & "'"
        Dim conn As New SqlConnection(ConnectionString)
        Dim cmd As New SqlCommand(qrySTR, conn)
        cmd.CommandType = CommandType.Text

        Try
            conn.Open()
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, qrySTR)
            Dim dt As DataTable = ds.Tables(0)

            If dt.Rows.Count > 0 Then
                Return ds.Tables(0).Rows(0).Item("nationalIDNo")
            End If

        Catch
            Return Nothing
        Finally
            If conn.State = ConnectionState.Open Then conn.Close()
            conn.Dispose()
            cmd.Dispose()
        End Try

    End Function


    'Public Function grantPageWriteCommandPermission(ByVal UserId As Integer, pageId As Integer) As Boolean
    '    grantPageWriteCommandPermission = False
    '    Dim qry As String = "SELECT * FROM [dbo].[tbl_userSysPermissions] WHERE [userId] = " & UserId & " AND [sysModuleSectionId] = " & pageId & " AND [sysWrite] = 1"

    '    Dim conn As New SqlConnection(ConnectionString)
    '    Dim cmd As New SqlCommand(qry, conn)
    '    cmd.CommandType = CommandType.Text

    '    Try
    '        conn.Open()

    '        Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, cmd.CommandText)
    '        If ds.Tables.Count > 0 Then
    '            If ds.Tables(0).Rows.Count > 0 Then
    '                grantPageWriteCommandPermission = True
    '            End If
    '        End If
    '    Catch ex As Exception

    '    End Try

    'End Function

    Public Function recordExists(ByVal qrySTR As String) As Boolean
        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, qrySTR)

            If ds.Tables(0).Rows.Count > 0 Then
                Return True
            Else
                Return False
            End If

        Catch
            Return Nothing
        End Try
    End Function

End Class
