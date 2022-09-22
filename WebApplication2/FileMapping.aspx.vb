
Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Telerik.Web.UI
Public Class FileMapping
    Inherits System.Web.UI.Page

    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then
            If (CokkiesWrapper.UserID <= 0 AndAlso Not IsNumeric(CokkiesWrapper.UserID)) Then
                Response.Redirect("../Login.aspx")
                Exit Sub
            End If

            obj.loadComboBox(cboSchoolFileType, "SELECT [fileTypeId], [fileType] FROM [dbo].[tbl_schoolFileType]", "fileType", "fileTypeId")
            obj.loadComboBox(cboObjectTypes, "SELECT [ObjectTypeId], [ObjectType] FROM [dbo].[luObjectType]", "ObjectType", "ObjectTypeId")

        End If

    End Sub

    Protected Sub cboObjectTypes_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboObjectTypes.SelectedIndexChanged
        Dim qry As String = ""
        Select Case cboObjectTypes.Text
            Case "Staff Member"
                qry = "SELECT 0 as [Select], [employmentNumber] AS [ObjectID] , [firstName] + ' ' + [secondName] + ' ' + [surname] AS Details FROM [dbo].[tbl_staffDetails] ORDER BY [employmentNumber]"
            Case "Student"
                qry = "SELECT 0 as [Select], [studentId] AS [ObjectID],[surname] + ' ' +  [firstName] + ' ' + [secondName] AS Details FROM [tbl_students] ORDER BY Surname, firstName"
            Case "Stream"
                qry = "SELECT 0 as [Select], [streamId] AS [ObjectID], [stream] AS Details FROM [dbo].[tbl_streams]"
            Case "Class"
                qry = "SELECT 0 as [Select], [schoolClassId] AS [ObjectID], [schoolClass] AS Details FROM [dbo].[tbl_schoolClasses]"
            Case "Parent/Guardian"

            Case ""
            Case ""
            Case ""
        End Select

        If qry <> "" Then
            With gwMapping
                Try
                    Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, qry)
                    .DataSource = ds
                    .DataBind()
                Catch ex As Exception
                    'log.Error(ex.Message)
                End Try
            End With
        End If


    End Sub

    Protected Sub cmdMap_Click(sender As Object, e As EventArgs) Handles cmdMap.Click

        Dim qry As String = ""

        For Each gridRow As GridDataItem In gwMapping.Items
            qry = ""
            If gridRow.Selected Then

                qry = "INSERT tbl_FileMapping (objectTypeID,objectID,fileID ) VALUES ( " & cboObjectTypes.SelectedValue & ",'" & gridRow.Item("ObjectID").Text & "'," & txtFileID.Text & ")"

                Try
                    obj.ConnectionString = con
                    obj.ExecuteNonQRY(qry)
                Catch
                End Try

            End If
        Next
    End Sub
End Class