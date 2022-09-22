Imports ClassLibrary1
Imports System.Math
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports System.Drawing

Public Class SchoolCoreDetails
    Inherits System.Web.UI.Page
    Dim insRec As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim objCBO As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)

    Dim db As Database = insRec.Database
    Dim con As String = db.ConnectionString
    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then
            If (CokkiesWrapper.UserID <= 0 AndAlso Not IsNumeric(CokkiesWrapper.UserID)) Then
                Response.Redirect("../Login.aspx")
                Exit Sub
            End If


            obj.ConnectionString = con
            Dim accessMode As String = obj.groupAccessPermissionsDs(CokkiesWrapper.UserGroup, 1)

            Select Case accessMode
                Case "AllowReadNRead"
                Case "ReadNReadOnly"
                    cmdSave.Enabled = False
                Case "DenyAcces"
                    Response.Redirect("~/AccessDenied.aspx")
                    Exit Sub
                Case Else
                    Response.Redirect("~/AccessDenied.aspx")
                    Exit Sub
            End Select

            objCBO.loadComboBox(cboSchoolType, "SELECT [schoolTypeId], [schoolType] FROM [tbl_schoolTypes]", "schoolType", "schoolTypeId")

            loadSchoolDetails()
        End If

    End Sub

    Private Sub cmdSave_Click(sender As Object, e As EventArgs) Handles cmdSave.Click


        Dim qry As String = "SELECT * FROM [dbo].[tbl_schoolCoreDetails] WHERE [schoolCode] = '" & txtCode.Text & "'"

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, qry)

            If ds.Tables(0).Rows.Count > 0 Then
                UpdateSchoolDetails()
            Else
                InsertSchoolDetails()
            End If
        Catch

        End Try

        loadSchoolDetails()


    End Sub


    Private Sub loadSchoolDetails()
        Dim qry As String = "SELECT * FROM [dbo].[tbl_schoolCoreDetails] WHERE [schoolCode] = 'svr'"

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, qry)

            If ds.Tables(0).Rows.Count > 0 Then
                txtCode.Text = ds.Tables(0).Rows(0)("schoolCode").ToString
                txtName.Text = ds.Tables(0).Rows(0)("schoolName").ToString
                cboSchoolType.Text = ds.Tables(0).Rows(0)("schoolTypeId").ToString
                txtPhysicalAddress.Text = ds.Tables(0).Rows(0)("physicalAddress").ToString
                txtPostalAddress.Text = ds.Tables(0).Rows(0)("postalAddress").ToString
                txtTelNumbers.Text = ds.Tables(0).Rows(0)("telephoneNumber").ToString
                txtEmailAddress.Text = ds.Tables(0).Rows(0)("emailAddress").ToString
                rdDtDate.SelectedDate = ds.Tables(0).Rows(0)("dateFounded").ToString
                txtHead.Text = ds.Tables(0).Rows(0)("schoolHeadName").ToString
                txtHeadContactNum.Text = ds.Tables(0).Rows(0)("schoolHeadContactNum").ToString
                txtContactPerson.Text = ds.Tables(0).Rows(0)("contactPersonName").ToString
                txtContactPersonPosition.Text = ds.Tables(0).Rows(0)("contactPersonPosition").ToString
                txtContactPersonNumber.Text = ds.Tables(0).Rows(0)("contactPersonNumber").ToString
            Else

            End If
        Catch

        End Try

    End Sub


    Private Sub InsertSchoolDetails()
        Dim qry As String = " INSERT INTO  [tbl_schoolCoreDetails]( [schoolCode] , [schoolName] , [schoolTypeId] , [physicalAddress] , " & _
                           " [postalAddress] , [telephoneNumber] , [cellNumber] , [emailAddress] , [webAddress] , " & _
                           " [dateFounded] , [responsibleAuthourityId], [schoolHeadName] , [schoolHeadContactNum] , " & _
                           " [contactPersonName] , [contactPersonPosition], [contactPersonNumber] ) " & _
                           " VALUES " & _
                           "  ('" & txtCode.Text & "','" & txtName.Text & "'," & cboSchoolType.SelectedValue & ",'" & txtPhysicalAddress.Text & "','" & _
                            txtPostalAddress.Text & "','" & txtTelNumbers.Text & "','" & txtTelNumbers.Text & "','" & txtEmailAddress.Text & "','www.herentals.co.zw','" & _
                            rdDtDate.SelectedDate.Value & "', 1,'" & txtHead.Text & "','" & txtHeadContactNum.Text & "','" & _
                            txtContactPerson.Text & "','" & txtContactPersonPosition.Text & "','" & txtContactPersonNumber.Text & "') "

        insRec.ConnectionString = con

        If insRec.ExecuteNonQRY(qry) = 1 Then
            lblMsg.Text = "School details have been saved successfully."
            loadSchoolDetails()
        Else
            lblMsg.Text = "School details have not been saved successfully."
        End If
    End Sub

    Private Sub UpdateSchoolDetails()
        '  Dim qry As String = ""
        Dim qry As String = "UPDATE tbl_schoolCoreDetails SET schoolName = '" & txtName.Text & "', schoolTypeId=" & cboSchoolType.SelectedValue & ", physicalAddress='" & txtPhysicalAddress.Text & "'," & _
        "postalAddress = '" & txtPostalAddress.Text & "',telephoneNumber = '" & txtTelNumbers.Text & "', cellNumber='" & txtTelNumbers.Text & "', emailAddress='" & txtEmailAddress.Text & "', webAddress='www.herentals.co.zw'," & _
        "[dateFounded] = '" & rdDtDate.SelectedDate.Value & "', [responsibleAuthourityId]=1, [schoolHeadName]='" & txtHead.Text & "', [schoolHeadContactNum]='" & txtHeadContactNum.Text & "'," & _
       " [contactPersonName] = '" & txtContactPerson.Text & "', [contactPersonPosition] = '" & txtContactPersonPosition.Text & "', [contactPersonNumber]='" & txtContactPersonNumber.Text & "'"

        insRec.ConnectionString = con

        If insRec.ExecuteNonQRY(qry) = 1 Then
            lblMsg.Text = "School details have been updated successfully."
            loadSchoolDetails()
        Else
            lblMsg.Text = "School details have not been updated successfully."
        End If

    End Sub



End Class