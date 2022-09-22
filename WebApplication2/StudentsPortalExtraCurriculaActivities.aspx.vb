Imports ClassLibrary1
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Telerik.Web.UI

Public Class StudentsPortalExtraCurriculaActivities
    Inherits System.Web.UI.Page

    Dim obj As New commonFunction(CokkiesWrapper.thisConnectionName)
    Dim db As Database = obj.Database
    Dim con As String = db.ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        LoadTreeViewClubsData()
        LoadTreeViewStudentClubsData(CokkiesWrapper.StudentID)

        LoadTreeViewSportsData()
        LoadTreeViewStudentSportsData(CokkiesWrapper.StudentID)

        LoadTreeViewExtraCurriculaData()
        LoadTreeViewStudentExtraCurriculaData(CokkiesWrapper.StudentID)

    End Sub



    Public Sub LoadTreeViewClubsData()
        Dim objClubs As New Clubs(CokkiesWrapper.thisConnectionName)
        Dim ds As DataSet = objClubs.SelectRecords()

        Try
            With RadTreeClubs

                .DataFieldID = "clubId"
                ' .DataFieldParentID = "ParentID"
                .DataTextField = "club"
                .DataValueField = "clubId"
                .DataSource = ds
                .DataBind()
            End With

        Catch ex As Exception
            '  log.Error(ex)

        End Try

    End Sub
    Public Sub LoadTreeViewStudentClubsData(ByVal IstudentId As String)

        Try
            Dim strNodeText As String = ""

            For Each Node As RadTreeNode In RadTreeClubs.Nodes
                strNodeText = Node.Text
                If StudentClubParticipation(IstudentId, strNodeText) = 1 Then
                    Node.Checked = True
                End If
            Next Node

        Catch ex As Exception
            '  log.Error(ex)
        End Try

    End Sub

    Private Function StudentClubParticipation(ByVal studentId As String, ByVal club As String) As Integer
        Dim qry As String = "select * from [dbo].[tbl_studentclubs] where studentId = '" & studentId & "' AND club = '" & club & "' "

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, qry)

            If ds.Tables(0).Rows.Count > 0 Then
                Return 1
                Exit Function
            Else
                Return 0
                Exit Function
            End If
        Catch ex As Exception
        End Try

        Return 0
    End Function

    Private Function StudentSportParticipation(ByVal studentId As String, ByVal sport As String) As Integer

        Dim qry As String = "SELECT * FROM tbl_studentSports WHERE studentId = '" & studentId & "' AND sport = '" & sport & "' "

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, qry)

            If ds.Tables(0).Rows.Count > 0 Then
                Return 1
                Exit Function
            Else
                Return 0
                Exit Function
            End If
        Catch ex As Exception
        End Try

        Return 0
    End Function

    Private Function StudentExtraCurriculaParticipation(ByVal studentId As String, ByVal activity As String) As Integer

        Dim qry As String = "SELECT * FROM [dbo].[tbl_studentExtraCurriculaActivities] WHERE studentId = '" & studentId & "' AND activity = '" & activity & "' "

        Try
            Dim ds As DataSet = db.ExecuteDataSet(CommandType.Text, qry)

            If ds.Tables(0).Rows.Count > 0 Then
                Return 1
                Exit Function
            Else
                Return 0
                Exit Function
            End If
        Catch ex As Exception
        End Try

        Return 0
    End Function

    Public Sub LoadTreeViewSportsData()
        Dim objSports As New Sports(CokkiesWrapper.thisConnectionName)
        Dim ds As DataSet = objSports.SelectRecords()

        Try
            With RadTreeSports

                .DataFieldID = "sportId"
                ' .DataFieldParentID = "ParentID"
                .DataTextField = "sport"
                .DataValueField = "sportId"
                .DataSource = ds
                .DataBind()
            End With

        Catch ex As Exception
            '  log.Error(ex)

        End Try

    End Sub

    Public Sub LoadTreeViewStudentSportsData(ByVal IstudentId As String)

        Try
            Dim strNodeText As String = ""

            For Each Node As RadTreeNode In RadTreeSports.Nodes
                strNodeText = Node.Text
                If StudentSportParticipation(IstudentId, strNodeText) = 1 Then
                    Node.Checked = True
                End If
            Next Node

        Catch ex As Exception
            '  log.Error(ex)
        End Try

    End Sub
    Public Sub LoadTreeViewExtraCurriculaData()
        Dim objXtra As New ExtraCurriculaActivities(CokkiesWrapper.thisConnectionName)
        Dim ds As DataSet = objXtra.SelectRecords()

        Try
            With RadTreeOtherActivities

                .DataFieldID = "activityId"
                ' .DataFieldParentID = "ParentID"
                .DataTextField = "activityName"
                .DataValueField = "activityId"
                .DataSource = ds
                .DataBind()
            End With

        Catch ex As Exception
            '  log.Error(ex)

        End Try

    End Sub

    Public Sub LoadTreeViewStudentExtraCurriculaData(ByVal IstudentId As String)
        Try
            Dim strNodeText As String = ""

            For Each Node As RadTreeNode In RadTreeOtherActivities.Nodes
                strNodeText = Node.Text
                If StudentExtraCurriculaParticipation(IstudentId, strNodeText) = 1 Then
                    Node.Checked = True
                End If
            Next Node

        Catch ex As Exception
            '  log.Error(ex)
        End Try
    End Sub

End Class