Imports System.Xml
Imports System.IO
Imports Telerik.Web.UI

Imports System.Web.UI.ControlCollection
Imports Microsoft.Practices.EnterpriseLibrary.Data
Public Class CustomFields

    Inherits System.Web.UI.UserControl

    Private Shared ReadOnly log As log4net.ILog = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType)

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub radmpFilterTabs_PageViewCreated(sender As Object, e As Telerik.Web.UI.RadMultiPageEventArgs) Handles radmpFilterTabs.PageViewCreated

    End Sub

    Public Function GetControlsTable(ByVal XMLData As String, Optional ByVal ControlGroup As String = "") As Table

        Return GetControlsTable(XMLData, ControlsTable, ControlGroup)

    End Function

    Public Function GetControlsTable(ByVal XMLData As String, ByVal ControlsTable As Table, Optional ByVal ControlGroup As String = "") As Table

        With ControlsTable

            .BorderWidth = New Unit(0, UnitType.Pixel)
            .CellSpacing = 0
            .CellPadding = 2

            .Rows.Clear()
            .Controls.Clear()

            .Width = New Unit(100, UnitType.Percentage)

        End With

        Dim CurrentColumn As Byte = 0

        Dim tr As TableRow = New TableRow
        Dim tcLabel As TableCell
        Dim tcControl As TableCell

        Dim db As Database = New DatabaseProviderFactory().Create(CokkiesWrapper.thisConnectionName)

        Try

            Dim XMLDoc As New System.Xml.XmlDocument
            XMLDoc.LoadXml(XMLData)

            Dim Columns As Long = 2 'default to 2 columns
            Dim LabelCellWidth As Unit = Unit.Percentage(100 / (2 * Columns))
            Dim ControlCellWidth As Unit = Unit.Percentage(100 / (2 * Columns))

            Try

                Dim UserInputFieldsNode As XmlNodeList = XMLDoc.SelectNodes("//UserInputFields")

                If UserInputFieldsNode.Count > 0 Then

                    Dim node As XmlNode = UserInputFieldsNode(0)

                    If node.Attributes("NumberOfColumns") IsNot Nothing AndAlso IsNumeric(node.Attributes("NumberOfColumns").InnerText) AndAlso CInt(node.Attributes("NumberOfColumns").InnerText) > 0 Then
                        Columns = node.Attributes("NumberOfColumns").InnerText
                    End If

                    If node.Attributes("CriteriaTableWidth") IsNot Nothing AndAlso IsNumeric(node.Attributes("CriteriaTableWidth").InnerText) AndAlso CInt(node.Attributes("CriteriaTableWidth").InnerText) > 0 Then
                        ControlsTable.Width = New Unit(node.Attributes("CriteriaTableWidth").InnerText, UnitType.Percentage)
                    End If

                    If node.Attributes("LabelCellWidth") IsNot Nothing Then LabelCellWidth = Unit.Parse(node.Attributes("LabelCellWidth").InnerText)

                    If node.Attributes("ControlCellWidth") IsNot Nothing Then ControlCellWidth = Unit.Parse(node.Attributes("ControlCellWidth").InnerText)

                End If

            Catch ex As Exception
                Log.Error(ex)
            End Try 'ignore any errors here

            Dim XmlNodeList As System.Xml.XmlNodeList

            If ControlGroup.Trim = "" Then
                XmlNodeList = XMLDoc.SelectNodes("//UserInputFields/*")
            Else

                Dim ControlGroupsNode As XmlNode = XMLDoc.SelectSingleNode("//UserInputFields/ControlGroups")
                If ControlGroupsNode IsNot Nothing AndAlso ControlGroupsNode.Attributes("DefaultControlGroup") IsNot Nothing AndAlso ControlGroupsNode.Attributes("DefaultControlGroup").Value = ControlGroup Then
                    XmlNodeList = XMLDoc.SelectNodes("//UserInputFields/UserInputField[not(ControlGroup) or ControlGroup='" & ControlGroup & "']") 'All UserInputFields without a ControlGroup child element
                Else
                    XmlNodeList = XMLDoc.SelectNodes("//UserInputFields/*[ControlGroup='" & ControlGroup & "']")
                End If

            End If

            txtDBFields.Text = ""

            For i As Integer = 0 To XmlNodeList.Count - 1

                Dim objXmlNode As XmlNode = XmlNodeList(i)

                Dim DBField As String = objXmlNode("DBField").InnerText
                Dim UseQuotes As String = ""
                If objXmlNode("UseQuotes") IsNot Nothing Then
                    UseQuotes = objXmlNode("UseQuotes").InnerText
                End If

                Dim JoinTable As String = ""
                If objXmlNode("JoinTable") IsNot Nothing Then

                    JoinTable = objXmlNode("JoinTable").InnerText

                End If

                Dim ControlName As String = ""
                If objXmlNode("ControlName") IsNot Nothing Then

                    ControlName = objXmlNode("ControlName").InnerText

                Else

                    ControlName = ControlsTable.UniqueID & String.Format("_{0}_{1}", DBField, i)

                End If

                txtDBFields.Text &= IIf(txtDBFields.Text = "", "", ",") & DBField

                tcLabel = New TableCell
                tcControl = New TableCell

                tcLabel.ID = IIf(ControlGroup.Trim = "", "", ControlGroup & "_") & "labelcell_" & i
                tcControl.ID = IIf(ControlGroup.Trim = "", "", ControlGroup & "_") & "ctrlcell_" & i

                'set the widths of the cells
                If objXmlNode.Attributes("LabelCellWidth") Is Nothing Then
                    tcLabel.Width = LabelCellWidth
                Else
                    Try : tcLabel.Width = Unit.Parse(objXmlNode.Attributes("LabelCellWidth").InnerText) : Catch : tcLabel.Width = LabelCellWidth : End Try
                End If

                If objXmlNode.Attributes("ControlCellWidth") Is Nothing Then
                    tcControl.Width = ControlCellWidth
                Else
                    Try : tcControl.Width = Unit.Parse(objXmlNode.Attributes("ControlCellWidth").InnerText) : Catch : tcControl.Width = ControlCellWidth : End Try
                End If

                'set the colspans of the cells
                Dim CurrentColumnSpan As Long = 1

                'TODO: Work out the effect of the colspans on the rows and stuff
                If Not objXmlNode.Attributes("LabelColSpan") Is Nothing AndAlso IsNumeric(objXmlNode.Attributes("LabelColSpan").InnerText) Then
                    Try : tcLabel.ColumnSpan = objXmlNode.Attributes("LabelColSpan").InnerText : CurrentColumnSpan = tcLabel.ColumnSpan : Catch : End Try
                End If

                If Not objXmlNode.Attributes("ControlColSpan") Is Nothing AndAlso IsNumeric(objXmlNode.Attributes("ControlColSpan").InnerText) Then
                    Try : tcControl.ColumnSpan = objXmlNode.Attributes("ControlColSpan").InnerText : CurrentColumnSpan = tcControl.ColumnSpan : Catch : End Try
                End If

                'We need to calculate whether to wrap to the next row or otherwise
                If CurrentColumn >= Columns Then
                    CurrentColumn = 1
                    tr = New TableRow
                Else
                    CurrentColumn += CurrentColumnSpan
                End If

                Dim ControlLabel As Label = New Label
                Dim ValidationControl As System.Web.UI.Control = Nothing
                Dim ValidationContainer As System.Web.UI.Control = Nothing

                ControlLabel.Text = objXmlNode("Label").InnerText
                ControlLabel.Attributes.Add("runat", "Server")

                Select Case objXmlNode("ControlType").InnerText

                    Case "listbox"

                        Dim ListboxControl As WebControls.ListBox = New WebControls.ListBox

                        With ListboxControl

                            .Attributes.Add("ControlType", objXmlNode("ControlType").InnerText)
                            .Attributes.Add("ControlName", ControlName)
                            .Attributes.Add("DBField", DBField)
                            .Attributes.Add("Label", ControlLabel.Text)
                            .Attributes.Add("runat", "Server")
                            If UseQuotes <> "" Then .Attributes.Add("UseQuotes", UseQuotes)

                            .ID = ControlName

                        End With

                        With ListboxControl

                            Dim mDs As DataSet = db.ExecuteDataSet(CommandType.Text, objXmlNode("DBQuery").InnerText)

                            If mDs.Tables(0).Columns.Count > 1 Then
                                .DataValueField = mDs.Tables(0).Columns(0).ColumnName
                                .DataTextField = mDs.Tables(0).Columns(1).ColumnName
                            Else
                                .DataValueField = mDs.Tables(0).Columns(0).ColumnName
                                .DataTextField = mDs.Tables(0).Columns(0).ColumnName
                            End If

                            .DataSource = mDs
                            .DataBind()

                            .SelectionMode = ListSelectionMode.Multiple
                            .Rows = 4

                        End With

                        tcControl.Controls.Add(ListboxControl)

                        ValidationControl = ListboxControl 'Set the control to use when we are configuring the custom validators

                    Case "combo"

                        Dim DropListControl As DropDownList = New DropDownList

                        With DropListControl

                            .Attributes.Add("ControlType", objXmlNode("ControlType").InnerText)
                            .Attributes.Add("ControlName", ControlName)
                            .Attributes.Add("DBField", DBField)
                            .Attributes.Add("Label", ControlLabel.Text)
                            .Attributes.Add("runat", "Server")
                            If UseQuotes <> "" Then .Attributes.Add("UseQuotes", UseQuotes)

                            .ID = ControlName

                        End With

                        With DropListControl

                            Dim dbQuery As String = objXmlNode("DBQuery").InnerText
                            dbQuery = String.Format(dbQuery, CokkiesWrapper.StudentID)

                            Dim mDs As DataSet = db.ExecuteDataSet(CommandType.Text, dbQuery)

                            If mDs.Tables(0).Columns.Count > 1 Then
                                .DataValueField = mDs.Tables(0).Columns(0).ColumnName
                                .DataTextField = mDs.Tables(0).Columns(1).ColumnName
                            Else
                                .DataValueField = mDs.Tables(0).Columns(0).ColumnName
                                .DataTextField = mDs.Tables(0).Columns(0).ColumnName
                            End If

                            .DataSource = mDs
                            .DataBind()

                            If objXmlNode.LastChild.Name = "AddNullValue" Then

                                .SelectedIndex = .Items.Count - 1
                                .Enabled = False
                                .BackColor = Drawing.Color.MistyRose
                            Else
                                .Items.Add("")
                                .SelectedIndex = .Items.Count - 1

                            End If

                        End With

                        tcControl.Controls.Add(DropListControl)

                        ValidationControl = DropListControl 'Set the control to use when we are configuring the custom validators

                    Case "radiobuttonlist"

                        Dim RadioButtonListControl As RadioButtonList = New RadioButtonList

                        With RadioButtonListControl

                            .Attributes.Add("ControlType", objXmlNode("ControlType").InnerText)
                            .Attributes.Add("ControlName", ControlName)
                            .Attributes.Add("DBField", DBField)
                            .Attributes.Add("Label", ControlLabel.Text)
                            .Attributes.Add("runat", "Server")
                            If UseQuotes <> "" Then .Attributes.Add("UseQuotes", UseQuotes)

                            .RepeatLayout = RepeatLayout.Table
                            .RepeatDirection = RepeatDirection.Horizontal

                            .ID = ControlName

                        End With

                        With RadioButtonListControl

                            Dim mDs As DataSet = db.ExecuteDataSet(CommandType.Text, objXmlNode("DBQuery").InnerText)

                            If mDs.Tables(0).Columns.Count > 1 Then
                                .DataValueField = mDs.Tables(0).Columns(0).ColumnName
                                .DataTextField = mDs.Tables(0).Columns(1).ColumnName
                            Else
                                .DataValueField = mDs.Tables(0).Columns(0).ColumnName
                                .DataTextField = mDs.Tables(0).Columns(0).ColumnName
                            End If

                            .DataSource = mDs
                            .DataBind()

                        End With

                        tcControl.Controls.Add(RadioButtonListControl)

                        ValidationControl = RadioButtonListControl 'Set the control to use when we are configuring the custom validators

                    Case "checkboxlist"

                        Dim CheckBoxListControl As CheckBoxList = New CheckBoxList

                        With CheckBoxListControl

                            .Attributes.Add("ControlType", objXmlNode("ControlType").InnerText)
                            .Attributes.Add("ControlName", ControlName)
                            .Attributes.Add("DBField", DBField)
                            .Attributes.Add("Label", ControlLabel.Text)
                            .Attributes.Add("runat", "Server")
                            If UseQuotes <> "" Then .Attributes.Add("UseQuotes", UseQuotes)

                            .RepeatLayout = RepeatLayout.Table
                            .RepeatDirection = RepeatDirection.Horizontal

                            .ID = ControlName

                        End With

                        With CheckBoxListControl

                            Dim mDs As DataSet = db.ExecuteDataSet(CommandType.Text, objXmlNode("DBQuery").InnerText)

                            If mDs.Tables(0).Columns.Count > 1 Then
                                .DataValueField = mDs.Tables(0).Columns(0).ColumnName
                                .DataTextField = mDs.Tables(0).Columns(1).ColumnName
                            Else
                                .DataValueField = mDs.Tables(0).Columns(0).ColumnName
                                .DataTextField = mDs.Tables(0).Columns(0).ColumnName
                            End If

                            .DataSource = mDs
                            .DataBind()

                        End With

                        tcControl.Controls.Add(CheckBoxListControl)

                        ValidationControl = CheckBoxListControl 'Set the control to use when we are configuring the custom validators

                    Case "daterange"

                        Dim DateControl As DatePickerControl
                        DateControl = LoadControl("~/DynamicControls/DatePickerControl.ascx")

                        With DateControl

                            .Attributes.Add("ControlType", objXmlNode("ControlType").InnerText)
                            .Attributes.Add("ControlName", ControlName)
                            .Attributes.Add("DBField", DBField)
                            .Attributes.Add("Label", ControlLabel.Text)
                            .Attributes.Add("runat", "Server")
                            If UseQuotes <> "" Then .Attributes.Add("UseQuotes", UseQuotes)

                            .ID = ControlName

                        End With

                        tcControl.Wrap = False
                        tcControl.Controls.Add(DateControl)

                        'TODO: Special treatment for the validation of these types of controls: DateControl User Control
                        'ValidationControl = DateControl 'Set the control to use when we are configuring the custom validators

                    Case "date"

                        Dim RadDatePickerControl As RadDatePicker = New RadDatePicker

                        With RadDatePickerControl

                            .Attributes.Add("ControlType", objXmlNode("ControlType").InnerText)
                            .Attributes.Add("ControlName", ControlName)
                            .Attributes.Add("DBField", DBField)
                            .Attributes.Add("Label", ControlLabel.Text)
                            .Attributes.Add("runat", "Server")
                            If UseQuotes <> "" Then .Attributes.Add("UseQuotes", UseQuotes)

                            .ID = ControlName

                        End With

                        tcControl.Wrap = False
                        tcControl.Controls.Add(RadDatePickerControl)

                        ValidationControl = RadDatePickerControl 'Set the control to use when we are configuring the custom validators

                    Case "ajaxdate"

                        Dim TextBoxControl As TextBox = New TextBox

                        With TextBoxControl

                            .Attributes.Add("ControlType", objXmlNode("ControlType").InnerText)
                            .Attributes.Add("ControlName", ControlName)
                            .Attributes.Add("DBField", DBField)
                            .Attributes.Add("Label", ControlLabel.Text)
                            .Attributes.Add("runat", "Server")
                            If UseQuotes <> "" Then .Attributes.Add("UseQuotes", UseQuotes)

                            .ID = ControlName

                        End With

                        If objXmlNode.LastChild.Name = "Editable" Then

                            TextBoxControl.Enabled = objXmlNode("Editable").InnerText
                            TextBoxControl.BackColor = Drawing.Color.MistyRose

                        End If

                        TextBoxControl.Attributes.Add("Purpose", "AjaxDate")

                        ' Page.ClientScript.RegisterClientScriptInclude("jQuery", My.Settings.jQueryScriptFile)
                        Page.ClientScript.RegisterClientScriptInclude("ui.datepicker.js", "Frameworks/jQuery/ui.datepicker.js")
                        Page.ClientScript.RegisterClientScriptInclude("custom.datepicker.js", "Scripts/CustomAjaxDatePicker.js")

                        'UserInterfaceHelper.CSSHelper.AddCSSToPage(Page, "~/Frameworks/jQuery/ui.datepicker.css")

                        tcControl.Controls.Add(TextBoxControl)

                        ValidationControl = TextBoxControl 'Set the control to use when we are configuring the custom validators

                    Case "text"

                        Dim TextBoxControl As TextBox = New TextBox

                        With TextBoxControl

                            .Attributes.Add("ControlType", objXmlNode("ControlType").InnerText)
                            .Attributes.Add("ControlName", ControlName)
                            .Attributes.Add("DBField", DBField)
                            .Attributes.Add("Label", ControlLabel.Text)
                            .Attributes.Add("runat", "Server")
                            If UseQuotes <> "" Then .Attributes.Add("UseQuotes", UseQuotes)

                            .ID = ControlName

                        End With

                        If objXmlNode.LastChild.Name = "Editable" Then

                            TextBoxControl.Enabled = objXmlNode("Editable").InnerText
                            TextBoxControl.BackColor = Drawing.Color.MistyRose

                        End If

                        tcControl.Controls.Add(TextBoxControl)

                        ValidationControl = TextBoxControl 'Set the control to use when we are configuring the custom validators

                    Case "multilinetext"

                        Dim TextBoxControl As TextBox = New TextBox

                        With TextBoxControl

                            .Attributes.Add("ControlType", objXmlNode("ControlType").InnerText)
                            .Attributes.Add("ControlName", ControlName)
                            .Attributes.Add("DBField", DBField)
                            .Attributes.Add("Label", ControlLabel.Text)
                            .Attributes.Add("runat", "Server")
                            If UseQuotes <> "" Then .Attributes.Add("UseQuotes", UseQuotes)

                            .ID = ControlName
                            .TextMode = TextBoxMode.MultiLine

                        End With

                        If objXmlNode.LastChild.Name = "Editable" Then

                            TextBoxControl.Enabled = objXmlNode("Editable").InnerText
                            TextBoxControl.BackColor = Drawing.Color.MistyRose

                        End If

                        tcControl.Controls.Add(TextBoxControl)

                        ValidationControl = TextBoxControl 'Set the control to use when we are configuring the custom validators

                    Case "numerictext"

                        Dim TextBoxControl As TextBox = New TextBox

                        With TextBoxControl

                            .Attributes.Add("ControlType", objXmlNode("ControlType").InnerText)
                            .Attributes.Add("ControlName", ControlName)
                            .Attributes.Add("DBField", DBField)
                            .Attributes.Add("Label", ControlLabel.Text)
                            .Attributes.Add("runat", "Server")
                            If UseQuotes <> "" Then .Attributes.Add("UseQuotes", UseQuotes)

                            .ID = ControlName

                        End With
                        If objXmlNode.LastChild.Name = "Editable" Then

                            TextBoxControl.Enabled = objXmlNode("Editable").InnerText
                            TextBoxControl.BackColor = Drawing.Color.MistyRose

                        End If

                        tcControl.Controls.Add(TextBoxControl)

                        ValidationControl = TextBoxControl 'Set the control to use when we are configuring the custom validators

                    Case "checkbox"

                        Dim CheckBoxControl As CheckBox = New CheckBox

                        With CheckBoxControl

                            .Attributes.Add("ControlType", objXmlNode("ControlType").InnerText)
                            .Attributes.Add("ControlName", ControlName)
                            .Attributes.Add("DBField", DBField)
                            .Attributes.Add("Label", ControlLabel.Text)
                            .Attributes.Add("runat", "Server")
                            If UseQuotes <> "" Then .Attributes.Add("UseQuotes", UseQuotes)

                            If objXmlNode("ValueIfChecked") IsNot Nothing AndAlso objXmlNode("ValueIfNotChecked") IsNot Nothing Then

                                .Attributes("ValueIfChecked") = objXmlNode("ValueIfChecked").InnerText
                                .Attributes("ValueIfNotChecked") = objXmlNode("ValueIfNotChecked").InnerText

                            End If

                            .ID = ControlName

                        End With

                        tcControl.Controls.Add(CheckBoxControl)

                        ValidationControl = CheckBoxControl 'Set the control to use when we are configuring the custom validators

                    Case "autocompletelookup"

                        Dim AutoCompleteControl As autocomplete
                        AutoCompleteControl = LoadControl("~/DynamicControls/AutoCompleteControl.ascx")

                        With AutoCompleteControl

                            .Attributes.Add("ControlType", objXmlNode("ControlType").InnerText)
                            .Attributes.Add("ControlName", ControlName)
                            .Attributes.Add("DBField", DBField)
                            .Attributes.Add("Label", ControlLabel.Text)
                            .Attributes.Add("runat", "Server")
                            If UseQuotes <> "" Then .Attributes.Add("UseQuotes", UseQuotes)

                            .ID = ControlName

                        End With

                        tcControl.Controls.Add(AutoCompleteControl)

                    Case "lookup"

                        Try

                            Dim LookupPanel As New Panel

                            With LookupPanel

                                .Attributes.Add("ControlType", objXmlNode("ControlType").InnerText)
                                .Attributes.Add("ControlName", ControlName)
                                .Attributes.Add("DBField", DBField)
                                .Attributes.Add("Label", ControlLabel.Text)
                                .Attributes.Add("runat", "Server")
                                If UseQuotes <> "" Then .Attributes.Add("UseQuotes", UseQuotes)

                                .ID = ControlName

                            End With

                            Dim cmd As New Web.UI.HtmlControls.HtmlAnchor

                            'add the radWindowManager and the custom Helper Script file
                            ucRadWindowManager.Visible = True

                            Page.ClientScript.RegisterClientScriptInclude("radWindowingHelper", "../Scripts/radWindowingHelper.js")

                            LookupPanel.Attributes.Add("ControlType", objXmlNode("ControlType").InnerText)
                            LookupPanel.Attributes.Add("ControlName", ControlName)

                            LookupPanel.Controls.Add(cmd)

                            Dim Url As String = ""
                            Dim CommandText As String = ""
                            Dim ValuePairs As String = ""

                            Dim objQueryStringElements As XmlNodeList = objXmlNode("Lookup").ChildNodes

                            For Each QueryString As XmlNode In objQueryStringElements

                                Select Case QueryString.Name

                                    Case "DBRestoreQuery"

                                        LookupPanel.Attributes.Add("DBRestoreQuery", QueryString.InnerText)

                                    Case "Url"

                                        Url = QueryString.InnerText

                                    Case "CommandText"

                                        CommandText = HttpUtility.HtmlDecode(QueryString.InnerText)

                                    Case "QueryString"

                                        Dim ctrl As WebControl

                                        Select Case QueryString.Attributes("ControlType").InnerText

                                            Case "label"

                                                ctrl = New Label
                                                ctrl.ID = QueryString.Attributes("ID").Value

                                                'rewrite the value for labels.
                                                If Page.IsPostBack AndAlso Not IsNothing(Request.Form(Me.ClientID & Me.ClientIDSeparator & ctrl.ClientID)) Then

                                                    CType(ctrl, Label).Text = Request.Form(Me.ClientID & Me.ClientIDSeparator & ctrl.ClientID)

                                                End If

                                            Case Else '"text"

                                                ctrl = New TextBox
                                                ctrl.ID = QueryString.Attributes("ID").Value

                                                If QueryString.Attributes("ReadOnly") IsNot Nothing Then

                                                    Try : CType(ctrl, TextBox).ReadOnly = CBool(QueryString.Attributes("ReadOnly").Value) : Catch : End Try

                                                End If

                                                If QueryString.Attributes("PrimaryValue").Value = "True" Then

                                                    ValidationControl = ctrl 'Set the control to use when we are configuring the custom validators

                                                End If

                                        End Select

                                        ctrl.Attributes.Add("Variable", QueryString.Attributes("Variable").Value)
                                        ctrl.Attributes.Add("PrimaryValue", QueryString.Attributes("PrimaryValue").Value)

                                        If Not IsNothing(QueryString.Attributes("CssClass")) Then ctrl.CssClass = QueryString.Attributes("CssClass").Value
                                        If Not IsNothing(QueryString.Attributes("Width")) Then ctrl.Width = New Unit(QueryString.Attributes("Width").Value)

                                        LookupPanel.Controls.Add(ctrl)

                                        ValuePairs &= IIf(ValuePairs = "", "", "&") & QueryString.Attributes("Variable").Value & "=" & Me.ClientID & Me.ClientIDSeparator & ctrl.ClientID

                                End Select

                            Next

                            'the dimensions of the lookup could possible have been specified. just check and apply the appropriate
                            Dim dimensions As String = ""
                            If Not IsNothing(objXmlNode("LookupHeight")) AndAlso IsNumeric(objXmlNode("LookupHeight").InnerText) Then

                                dimensions &= objXmlNode("LookupHeight").InnerText

                                If IsNumeric(dimensions) AndAlso Not IsNothing(objXmlNode("LookupWidth")) AndAlso IsNumeric(objXmlNode("LookupWidth").InnerText) Then dimensions &= ", " & objXmlNode("LookupWidth").InnerText

                                dimensions = ", " & dimensions

                            End If

                            cmd.InnerText = CommandText
                            cmd.Attributes.Add("class", "LookupCommandText")
                            cmd.Attributes.Add("onclick", "if(OpenRadWindowLookup)OpenRadWindowLookup('" & Trim(Url) & IIf(Url.Contains("?"), IIf(Trim(Url).EndsWith("&"), "", "&"), "?") & ValuePairs & "','" & objXmlNode("ControlType").InnerText & "'" & dimensions & ");return false;")

                            tcControl.Wrap = False
                            tcControl.Controls.Add(LookupPanel)

                            ValidationContainer = LookupPanel

                        Catch ex As Exception
                            Log.Error(ex)
                        End Try



                End Select

                tcControl.Attributes("JoinTable") = JoinTable

                tcControl.VerticalAlign = VerticalAlign.Top

                tcLabel.Wrap = False

                tcLabel.Controls.Add(ControlLabel)
                tcLabel.VerticalAlign = VerticalAlign.Top

                'Dim ControlCellHighlight As String = "border-right: #cc0066 1px solid; border-top: #cc0066 1px solid; border-left: palegoldenrod 1px solid; border-bottom: #cc0066 1px solid; background-color: palegoldenrod;"
                'Dim LabelCellHighlight As String = "border-right: palegoldenrod 1px solid; border-top: #cc0066 1px solid; border-left: #cc0066 1px solid; border-bottom: #cc0066 1px solid; background-color: palegoldenrod;"

                'tcControl.Attributes.Add("onmouseover", "this.style.cssText = '" & ControlCellHighlight & "'; document.getElementById('" & ControlsTable.Parent.ClientID & "_" & tcLabel.ClientID & "').style.cssText = '" & LabelCellHighlight & "';")
                'tcControl.Attributes.Add("onmouseout", "this.style.cssText = ''; document.getElementById('" & ControlsTable.Parent.ClientID & "_" & tcLabel.ClientID & "').style.cssText = '';")
                'tcLabel.Attributes.Add("onmouseover", "this.style.cssText = '" & LabelCellHighlight & "'; document.getElementById('" & ControlsTable.Parent.ClientID & "_" & tcControl.ClientID & "').style.cssText = '" & ControlCellHighlight & "';")
                'tcLabel.Attributes.Add("onmouseout", "this.style.cssText = ''; document.getElementById('" & ControlsTable.Parent.ClientID & "_" & tcControl.ClientID & "').style.cssText = '';")

                tr.Cells.Add(tcLabel)
                tr.Cells.Add(tcControl)

                ControlsTable.Rows.Add(tr)

                If ValidationControl IsNot Nothing Then

                    If ValidationContainer Is Nothing Then ValidationContainer = tcControl

                    'add validators to the tControl here
                    If objXmlNode("RequiredFieldValidator") IsNot Nothing Then

                        Dim rqfValidator As New RequiredFieldValidator

                        If objXmlNode("RequiredFieldValidator").Attributes("Text") IsNot Nothing Then rqfValidator.Text = objXmlNode("RequiredFieldValidator").Attributes("Text").Value
                        If objXmlNode("RequiredFieldValidator").Attributes("ErrorMessage") IsNot Nothing Then rqfValidator.ErrorMessage = objXmlNode("RequiredFieldValidator").Attributes("ErrorMessage").Value
                        If objXmlNode("RequiredFieldValidator").Attributes("InitialValue") IsNot Nothing Then rqfValidator.InitialValue = objXmlNode("RequiredFieldValidator").Attributes("InitialValue").Value

                        rqfValidator.ControlToValidate = ValidationControl.ID

                        ValidationContainer.Controls.Add(rqfValidator)

                    End If

                    If objXmlNode("RangeValidator") IsNot Nothing Then

                        Dim rngValidator As New RangeValidator

                        If objXmlNode("RangeValidator").Attributes("Text") IsNot Nothing Then rngValidator.Text = objXmlNode("RangeValidator").Attributes("Text").Value
                        If objXmlNode("RangeValidator").Attributes("ErrorMessage") IsNot Nothing Then rngValidator.ErrorMessage = objXmlNode("RangeValidator").Attributes("ErrorMessage").Value
                        If objXmlNode("RangeValidator").Attributes("MinimumValue") IsNot Nothing Then rngValidator.MinimumValue = objXmlNode("RangeValidator").Attributes("MinimumValue").Value
                        If objXmlNode("RangeValidator").Attributes("MaximumValue") IsNot Nothing Then rngValidator.MaximumValue = objXmlNode("RangeValidator").Attributes("MaximumValue").Value
                        If objXmlNode("RangeValidator").Attributes("Type") IsNot Nothing Then rngValidator.Type = objXmlNode("RangeValidator").Attributes("Type").Value

                        rngValidator.ControlToValidate = ValidationControl.ID

                        ValidationContainer.Controls.Add(rngValidator)

                    End If

                    If objXmlNode("RegularExpressionValidator") IsNot Nothing Then

                        Dim regexValidator As New RegularExpressionValidator

                        If objXmlNode("RegularExpressionValidator").Attributes("Text") IsNot Nothing Then regexValidator.Text = objXmlNode("RangeValidator").Attributes("Text").Value
                        If objXmlNode("RegularExpressionValidator").Attributes("ErrorMessage") IsNot Nothing Then regexValidator.ErrorMessage = objXmlNode("RangeValidator").Attributes("ErrorMessage").Value
                        If objXmlNode("RegularExpressionValidator").Attributes("ValidationExpression") IsNot Nothing Then regexValidator.ValidationExpression = HttpUtility.HtmlDecode(objXmlNode("RangeValidator").Attributes("ValidationExpression").Value)

                        regexValidator.ControlToValidate = ValidationControl.ID

                        ValidationContainer.Controls.Add(regexValidator)

                    End If

                End If

            Next

            Return ControlsTable

        Catch ex As Exception

            Log.Error(ex)
            Return Nothing

        End Try

    End Function

    Public ReadOnly Property ControlsLoaded() As Boolean
        Get
            Return ControlsTable.Rows.Count > 0
        End Get
    End Property


    Public Function BuildCriteriaSummary() As String

        Dim Criteria As String = ""

        For Each row As TableRow In ControlsTable.Rows

            For Each cell As TableCell In row.Cells

                For Each ctrl As Control In cell.Controls

                    If TypeOf ctrl Is WebControl Then 'for those which load webcontrols

                        If CType(ctrl, WebControl).Attributes.Item("Label") IsNot Nothing Then

                            Dim DBField As String = CType(ctrl, WebControl).Attributes.Item("DBField")
                            Dim Label As String = CType(ctrl, WebControl).Attributes.Item("Label")
                            Dim AllowBlankCriteria As Boolean = Universal.CommonFunctions.StringToBoolean(IIf(IsNothing(CType(ctrl, WebControl).Attributes.Item("AllowBlankCriteria")), False, CType(ctrl, WebControl).Attributes.Item("AllowBlankCriteria")))
                            Dim ControlType As String = CType(ctrl, WebControl).Attributes.Item("ControlType")
                            Dim Value As String = GetValue(ctrl, ControlType, DBField, True)
                            Dim UseQuotes As String = CType(ctrl, WebControl).Attributes.Item("UseQuotes")

                            Dim Quotes As String
                            If UseQuotes Is Nothing Then
                                Quotes = IIf(IsNumeric(Value), "", IIf(IsDate(Value), "'", "'"))
                            Else
                                Select Case UseQuotes.ToLower
                                    Case "true", "t", "1", "y", "yes"
                                        Quotes = """"
                                    Case Else
                                        Quotes = ""
                                End Select
                            End If

                            If CType(ctrl, WebControl).Attributes("CrystalFieldValueType") IsNot Nothing AndAlso IsNumeric(CType(ctrl, WebControl).Attributes.Item("CrystalFieldValueType")) Then

                                Quotes = GetCrystalFieldQuotes(CInt(CType(ctrl, WebControl).Attributes.Item("CrystalFieldValueType")))

                            End If

                            If (Trim(Value) = "" And AllowBlankCriteria) Or (Value <> "") Then

                                If ControlType = "text" Then 'special treatment for textbox

                                    If Value.IndexOfAny("%*") >= 0 Then

                                        Criteria &= IIf(Criteria.Trim = "", "", ", ") & Label & " contains " & String.Format(Value.Replace("%", "*"), Quotes)     'contains search"

                                    Else

                                        Criteria &= IIf(Criteria.Trim = "", "", ", ") & Label & " is " & String.Format(Value.Replace("%", "*"), Quotes)   'contains search

                                    End If

                                ElseIf ControlType = "numerictext" Then 'special treatment for textbox

                                    Criteria &= IIf(Criteria.Trim = "", "", ", ") & Label & " = " & String.Format(Value.Replace("%", "*"), "")  'contains search

                                ElseIf ControlType = "date" Then 'special treatment for textbox

                                    If IsDate(Value) Then Criteria &= IIf(Criteria.Trim = "", "", ", ") & Label & " on " & CDate(Value).ToString("dd-MMM-yyyy") & "'" 'contains search"

                                ElseIf ControlType = "combo" Then

                                    Dim dropdownlist As DropDownList = CType(ctrl, WebControl)
                                    Value = dropdownlist.SelectedItem.Text

                                    Criteria &= IIf(Criteria = "", "", ", ") & Label & " is " & String.Format(Value, Quotes)

                                Else
                                    ' we need to exclude the categories field- the control name be "MemberCategory"
                                    If ControlType <> "lookup" Then

                                        Criteria &= IIf(Criteria = "", "", ", ") & Label & " is " & String.Format(Value, Quotes)

                                    End If

                                End If

                            End If

                        End If

                    ElseIf TypeOf ctrl Is UserControl Then 'for those which load an .ascx file

                        If CType(ctrl, UserControl).Attributes.Item("DBField") IsNot Nothing AndAlso Not CStr(CType(ctrl, UI.UserControl).Attributes.Item("DBField")).StartsWith("@") Then

                            Dim DBField As String = CType(ctrl, UserControl).Attributes.Item("DBField")
                            Dim Label As String = CType(ctrl, UserControl).Attributes.Item("Label")
                            Dim AllowBlankCriteria As Boolean = Universal.CommonFunctions.StringToBoolean(CType(ctrl, UserControl).Attributes.Item("AllowBlankCriteria"))
                            Dim Value As String = GetValue(ctrl, CType(ctrl, UserControl).Attributes.Item("ControlType"), DBField, True)
                            Dim ControlType As String = CType(ctrl, UserControl).Attributes.Item("ControlType")

                            If ControlType = "daterange" Then 'special treatment for textbox

                                If Value <> "" Then Criteria &= IIf(Criteria = "", "", ", ") & Replace(Replace(Value, "#", "'"), DBField, Label)

                            Else

                                Criteria &= IIf(Criteria = "", "", ", ") & Label & " is '" & String.Format(Value, "")

                            End If

                        End If

                    End If

                Next

            Next

        Next

        Return Criteria

    End Function

    Public Function GetCrystalFieldQuotes(ByVal FieldValueType As CrystalDecisions.Shared.FieldValueType)

        Select Case FieldValueType

            Case CrystalDecisions.Shared.FieldValueType.Int8sField, CrystalDecisions.Shared.FieldValueType.Int8uField, _
                 CrystalDecisions.Shared.FieldValueType.Int16sField, CrystalDecisions.Shared.FieldValueType.Int16uField, _
                 CrystalDecisions.Shared.FieldValueType.Int32sField, CrystalDecisions.Shared.FieldValueType.Int32uField, _
                 CrystalDecisions.Shared.FieldValueType.NumberField, CrystalDecisions.Shared.FieldValueType.CurrencyField

                Return "" 'Empty String - No Quotes

            Case CrystalDecisions.Shared.FieldValueType.BooleanField

                Return "" 'Nothing

            Case CrystalDecisions.Shared.FieldValueType.DateField, CrystalDecisions.Shared.FieldValueType.TimeField, _
                 CrystalDecisions.Shared.FieldValueType.DateTimeField

                Return "#" 'Hash

            Case CrystalDecisions.Shared.FieldValueType.StringField, CrystalDecisions.Shared.FieldValueType.TransientMemoField, _
                 CrystalDecisions.Shared.FieldValueType.PersistentMemoField

                Return "'" 'Single quote

                'These do not typically appear in our reports
            Case CrystalDecisions.Shared.FieldValueType.BlobField, CrystalDecisions.Shared.FieldValueType.BitmapField, _
                 CrystalDecisions.Shared.FieldValueType.IconField, CrystalDecisions.Shared.FieldValueType.PictureField, _
                 CrystalDecisions.Shared.FieldValueType.OleField, CrystalDecisions.Shared.FieldValueType.ChartField

                Return "" 'Empty String - No Quotes

            Case CrystalDecisions.Shared.FieldValueType.SameAsInputField, CrystalDecisions.Shared.FieldValueType.UnknownField

                Return "" 'Empty String - No Quotes

            Case Else

                Return "'" 'Single quote

        End Select

    End Function

    Public Function BuildCrystalParameters() As Hashtable

        Dim Criteria As String = ""
        Dim Parameters As New Hashtable

        For Each ControlsTable As Table In GetControlsTablesCollection()

            For Each row As TableRow In ControlsTable.Rows

                For Each cell As TableCell In row.Cells

                    For Each ctrl As Control In cell.Controls

                        If TypeOf ctrl Is WebControl Then 'for those which load webcontrols

                            If CType(ctrl, WebControl).Attributes.Item("DBField") IsNot Nothing AndAlso CStr(CType(ctrl, WebControl).Attributes.Item("DBField")).StartsWith("@") Then

                                Dim DBField As String = CType(ctrl, WebControl).Attributes.Item("DBField")
                                Dim AllowBlankCriteria As Boolean = Universal.CommonFunctions.StringToBoolean(IIf(IsNothing(CType(ctrl, WebControl).Attributes.Item("AllowBlankCriteria")), False, CType(ctrl, WebControl).Attributes.Item("AllowBlankCriteria")))
                                Dim ControlType As String = CType(ctrl, WebControl).Attributes.Item("ControlType")
                                Dim Value As String = GetValue(ctrl, ControlType, DBField, True)

                                If (Trim(Value) = "" And AllowBlankCriteria) Or (Value <> "") Then

                                    If ControlType = "text" Then 'special treatment for textbox

                                        Parameters.Add(DBField, Value)

                                    ElseIf ControlType = "numerictext" Then 'special treatment for textbox

                                        Parameters.Add(DBField, Value)


                                    ElseIf ControlType = "date" Then 'special treatment for textbox

                                        If IsDate(Value) Then Parameters.Add(DBField, Value)

                                    Else

                                        ' we need to exclude the categories field- the control name be "MemberCategory"
                                        If ControlType <> "lookup" Then

                                            Parameters.Add(DBField, Value)

                                        End If

                                    End If

                                End If

                            End If

                        ElseIf TypeOf ctrl Is UserControl Then 'for those which load an .ascx file

                            If CType(ctrl, UserControl).Attributes.Item("DBField") IsNot Nothing AndAlso CStr(CType(ctrl, UserControl).Attributes.Item("DBField")).StartsWith("@") Then

                                Dim DBField As String = CType(ctrl, UserControl).Attributes.Item("DBField")
                                Dim AllowBlankCriteria As Boolean = Universal.CommonFunctions.StringToBoolean(CType(ctrl, UserControl).Attributes.Item("AllowBlankCriteria"))
                                Dim Value As String = GetValue(ctrl, CType(ctrl, UserControl).Attributes.Item("ControlType"), DBField, True)
                                Dim ControlType As String = CType(ctrl, UserControl).Attributes.Item("ControlType")

                                If DBField.StartsWith("@") AndAlso ControlType = "daterange" Then 'special treatment for textbox

                                    If Value <> "" Then Parameters.Add(DBField, Value)

                                End If

                            End If

                        End If

                    Next

                Next

            Next

        Next

        Return Parameters

    End Function

    Public Function GetValue(ByVal Ctrl As Control, ByVal ControlType As String, ByVal DBField As String, ByVal IsCrystalReportsFilter As Boolean)

        Select Case ControlType

            Case "checkbox"

                Dim chk As CheckBox = CType(Ctrl, CheckBox)
                If chk.Attributes("ValueIfChecked") IsNot Nothing AndAlso chk.Attributes("ValueIfNotChecked") IsNot Nothing Then
                    Return IIf(chk.Checked, chk.Attributes("ValueIfChecked"), chk.Attributes("ValueIfNotChecked"))
                Else
                    Return chk.Checked
                End If

            Case "checkboxlist"
                If Not IsCrystalReportsFilter Then
                    Dim tmp As String = ""
                    For Each itm As ListItem In CType(Ctrl, CheckBoxList).Items

                        If itm.Selected Then tmp &= IIf(tmp = "", "", "','") & Trim(itm.Value)

                    Next

                    tmp = IIf(tmp = "", "", "'") & tmp & IIf(tmp = "", "", "'") 'Close the qoutes that have been added as the list was being generated.

                    Return tmp
                Else
                    Dim tmp As String = ""
                    For Each itm As ListItem In CType(Ctrl, CheckBoxList).Items

                        If itm.Selected Then tmp &= IIf(tmp = "", "", "{0},{0}") & Trim(itm.Value)

                    Next

                    tmp = IIf(tmp = "", "", "{0}") & tmp & IIf(tmp = "", "", "{0}") 'Close the qoutes that have been added as the list was being generated.

                    Return tmp
                End If


            Case "combo"

                Return CType(Ctrl, DropDownList).SelectedValue

                'Case "complementary"
                '    If Not IsCrystalReportsFilter Then
                '        Dim tmp As String = ""
                '        For Each selectedItem As String In CType(Ctrl, ComplementaryListboxes).SelectedValues

                '            tmp &= IIf(tmp = "", "", "','") & selectedItem

                '        Next

                '        tmp = IIf(tmp = "", "", "'") & tmp & IIf(tmp = "", "", "'")

                '        Return tmp
                '    Else
                '        Dim tmp As String = ""
                '        For Each selectedItem As String In CType(Ctrl, ComplementaryListboxes).SelectedValues


                '            tmp &= IIf(tmp = "", "", "{0},{0}") & selectedItem

                '        Next

                '        tmp = IIf(tmp = "", "", "{0}") & tmp & IIf(tmp = "", "", "{0}")

                '        Return tmp
                '    End If


            Case "jquerydatepicker"

                Return CType(Ctrl, TextBox).Text

            Case "date"

                Return IIf(CType(Ctrl, RadDatePicker).IsEmpty, Nothing, CType(Ctrl, RadDatePicker).SelectedDate)

            Case "daterange"

                'how should we return the value from this control
                'there should be single date selection items and ones that allow various date ranges to be selected

                If DBField.Contains("{") Then

                    Return CType(Ctrl, DatePickerControl).GenerateCrystalDate(DBField)

                Else
                    Return CType(Ctrl, DatePickerControl).GenerateDatabaseDate(DBField)


                End If

            Case "ajaxdate"

                Return CType(Ctrl, TextBox).Text

            Case "listbox"
                If Not IsCrystalReportsFilter Then
                    Dim tmp As String = ""
                    For Each itm As ListItem In CType(Ctrl, WebControls.ListBox).Items

                        If itm.Selected Then tmp &= IIf(tmp = "", "", "','") & Trim(itm.Value)

                    Next

                    'tmp = IIf(tmp = "", "", "'") & tmp & IIf(tmp = "", "", "'") 'Close the qoutes that have been added as the list was being generated.

                    Return tmp
                Else
                    Dim tmp As String = ""
                    For Each itm As ListItem In CType(Ctrl, WebControls.ListBox).Items

                        If itm.Selected Then tmp &= IIf(tmp = "", "", "{0},{0}") & Trim(itm.Value)

                    Next

                    tmp = IIf(tmp = "", "", "{0}") & tmp & IIf(tmp = "", "", "{0}") 'Close the qoutes that have been added as the list was being generated.

                    Return tmp
                End If


            Case "autocompletelookup"

                Return CType(Ctrl, autocomplete).Value

            Case "lookup"

                'need a way to pick just one fo the possible controls on a lookup
                'probably just specify on of the querystring items as the PrimaryValue
                'then look for the one with the PrimaryValue attribute set to "true"

                Dim LookupPanel As Panel = CType(Ctrl, Panel)

                For Each itm As Control In LookupPanel.Controls

                    If itm.GetType.FullName.Contains(".WebControls.") Then

                        Dim qryStringCtrl As WebControl = CType(itm, WebControl)

                        If Not IsNothing(qryStringCtrl.Attributes("PrimaryValue")) AndAlso qryStringCtrl.Attributes("PrimaryValue") = "True" Then

                            If qryStringCtrl.GetType.FullName.EndsWith("TextBox") Then

                                Return CType(qryStringCtrl, TextBox).Text

                            ElseIf qryStringCtrl.GetType.FullName.EndsWith("Label") Then

                                Return CType(qryStringCtrl, Label).Text

                            Else

                                Return ""

                            End If

                        End If

                    End If

                Next

                Return ""

            Case "radiobuttonlist"

                Return CType(Ctrl, RadioButtonList).SelectedValue

            Case "text"
                If Not IsCrystalReportsFilter Then

                    If CType(Ctrl, TextBox).Text.Contains(",") Then
                        Dim values As String() = CType(Ctrl, TextBox).Text.Split(",")
                        Dim tmp As String = ""
                        For Each value As String In values

                            tmp &= IIf(tmp = "", "", "','") & Trim(value)

                        Next

                        tmp = IIf(tmp = "", "", "'") & tmp & IIf(tmp = "", "", "'")

                        Return tmp
                    Else
                        Return CType(Ctrl, TextBox).Text
                    End If

                Else
                    Dim values As String() = CType(Ctrl, TextBox).Text.Split(",")

                    Dim tmp As String = ""

                    For Each value As String In values

                        tmp &= IIf(tmp = "", "", "{0},{0}") & Trim(value)

                    Next

                    If tmp.Contains(",") Then tmp = IIf(tmp = "", "", "{0}") & tmp & IIf(tmp = "", "", "{0}")

                    Return tmp

                End If


            Case "multilinetext"

                If Not IsCrystalReportsFilter Then

                    If CType(Ctrl, TextBox).Text.Contains(",") Then
                        Dim values As String() = CType(Ctrl, TextBox).Text.Split(",")
                        Dim tmp As String = ""
                        For Each value As String In values

                            tmp &= IIf(tmp = "", "", "','") & Trim(value)

                        Next

                        tmp = IIf(tmp = "", "", "'") & tmp & IIf(tmp = "", "", "'")

                        Return tmp
                    Else
                        Return CType(Ctrl, TextBox).Text
                    End If

                Else
                    Dim values As String() = CType(Ctrl, TextBox).Text.Split(",")

                    Dim tmp As String = ""

                    For Each value As String In values

                        tmp &= IIf(tmp = "", "", "{0},{0}") & Trim(value)

                    Next

                    tmp = IIf(tmp = "", "", "{0}") & tmp & IIf(tmp = "", "", "{0}")

                    Return tmp
                End If

            Case "numerictext"

                If Not IsCrystalReportsFilter Then

                    If CType(Ctrl, TextBox).Text.Contains(",") Then
                        Dim values As String() = CType(Ctrl, TextBox).Text.Split(",")
                        Dim tmp As String = ""
                        For Each value As String In values

                            tmp &= IIf(tmp = "", "", "','") & Trim(value)

                        Next

                        tmp = IIf(tmp = "", "", "'") & tmp & IIf(tmp = "", "", "'")

                        Return tmp
                    Else
                        Return CType(Ctrl, TextBox).Text
                    End If

                Else
                    Dim values As String() = CType(Ctrl, TextBox).Text.Split(",")

                    Dim tmp As String = ""

                    For Each value As String In values

                        tmp &= IIf(tmp = "", "", "{0},{0}") & Trim(value)

                    Next

                    tmp = IIf(tmp = "", "", "{0}") & tmp & IIf(tmp = "", "", "{0}")

                    Return tmp
                End If

        End Select

        Return Nothing

    End Function

    Private Function GetControlsTablesCollection() As List(Of Table)

        Dim ControlsTables As New List(Of Table)

        If radtabFilterTabs.Visible Then

            'means we are using controlgroups
            For Each rmp As RadPageView In radmpFilterTabs.PageViews

                If TypeOf rmp.Controls(0) Is Table Then

                    ControlsTables.Add(rmp.Controls(0))

                End If

            Next

        Else

            'means we are not using controlgroups
            ControlsTables.Add(ControlsTable)

        End If

        Return ControlsTables

    End Function

    Public Function BuildCrystalCriteria() As String

        Dim Criteria As String = ""

        For Each ControlsTable As Table In GetControlsTablesCollection()

            For Each row As TableRow In ControlsTable.Rows

                For Each cell As TableCell In row.Cells

                    For Each ctrl As Control In cell.Controls

                        If TypeOf ctrl Is WebControl Then 'for those which load webcontrols

                            If CType(ctrl, WebControl).Attributes.Item("DBField") IsNot Nothing AndAlso Not CStr(CType(ctrl, WebControl).Attributes.Item("DBField")).StartsWith("@") Then

                                Dim DBField As String = CType(ctrl, WebControl).Attributes.Item("DBField")
                                Dim AllowBlankCriteria As Boolean = Universal.CommonFunctions.StringToBoolean(IIf(IsNothing(CType(ctrl, WebControl).Attributes.Item("AllowBlankCriteria")), False, CType(ctrl, WebControl).Attributes.Item("AllowBlankCriteria")))
                                Dim ControlType As String = CType(ctrl, WebControl).Attributes.Item("ControlType")
                                Dim Value As String = GetValue(ctrl, ControlType, DBField, True)
                                Dim UseQuotes As String = CType(ctrl, WebControl).Attributes.Item("UseQuotes")

                                Dim Quotes As String
                                If UseQuotes Is Nothing Then
                                    Quotes = IIf(IsNumeric(Value), "", IIf(IsDate(Value), "#", "'"))
                                Else
                                    Select Case UseQuotes.ToLower
                                        Case "true", "t", "1", "y", "yes"
                                            Quotes = "'"
                                        Case Else
                                            Quotes = ""
                                    End Select
                                End If

                                If CType(ctrl, WebControl).Attributes("CrystalFieldValueType") IsNot Nothing AndAlso IsNumeric(CType(ctrl, WebControl).Attributes.Item("CrystalFieldValueType")) Then

                                    Quotes = GetCrystalFieldQuotes(CInt(CType(ctrl, WebControl).Attributes.Item("CrystalFieldValueType")))

                                End If

                                If (Trim(Value) = "" And AllowBlankCriteria) Or (Value <> "") Then

                                    If ControlType = "text" Then 'special treatment for textbox

                                        If Value.IndexOfAny("%*") >= 0 Then

                                            Criteria &= IIf(Criteria.Trim = "", "", " AND ") & DBField & " LIKE " & Quotes & Value.Replace("%", "*") & Quotes   'contains search"

                                        Else

                                            Criteria &= IIf(Criteria.Trim = "", "", " AND ") & DBField & IIf(Value.Contains(","), " IN [", " = ") & IIf(Value.Contains("{"), String.Format(Value, Quotes), Quotes & Value & Quotes) & IIf(Value.Contains(","), " ]", "") 'contains search

                                        End If

                                    ElseIf ControlType = "numerictext" Then 'special treatment for textbox

                                        Criteria &= IIf(Criteria.Trim = "", "", " AND ") & DBField & IIf(Value.Contains(","), " IN [", " = ") & IIf(Value.Contains("{"), String.Format(Value, Quotes), Quotes & Value & Quotes) & IIf(Value.Contains(","), " ]", "") 'contains search

                                    ElseIf ControlType = "date" Then 'special treatment for textbox

                                        If IsDate(Value) Then Criteria &= IIf(Criteria.Trim = "", "", " AND ") & DBField & " = #" & Value & "#" 'contains search"

                                    Else

                                        ' we need to exclude the categories field- the control name be "MemberCategory"
                                        If ControlType <> "lookup" Then

                                            Criteria &= IIf(Criteria = "", "", " AND ") & DBField & IIf(Value.Contains(","), " IN [", " = ") & IIf(Value.Contains("{"), String.Format(Value, Quotes), Quotes & Value & Quotes) & IIf(Value.Contains(","), " ]", "")

                                        End If

                                    End If

                                End If

                            End If

                        ElseIf TypeOf ctrl Is UserControl Then 'for those which load an .ascx file

                            If CType(ctrl, UserControl).Attributes.Item("DBField") IsNot Nothing AndAlso Not CStr(CType(ctrl, UI.UserControl).Attributes.Item("DBField")).StartsWith("@") Then

                                Dim DBField As String = CType(ctrl, UserControl).Attributes.Item("DBField")
                                Dim AllowBlankCriteria As Boolean = Universal.CommonFunctions.StringToBoolean(CType(ctrl, UserControl).Attributes.Item("AllowBlankCriteria"))
                                Dim Value As String = GetValue(ctrl, CType(ctrl, UserControl).Attributes.Item("ControlType"), DBField, True)
                                Dim ControlType As String = CType(ctrl, UserControl).Attributes.Item("ControlType")

                                If ControlType = "daterange" Then 'special treatment for textbox

                                    If Value <> "" Then Criteria &= IIf(Criteria = "", "", " AND ") & Value

                                ElseIf ControlType = "complementary" Then

                                    Dim Quotes As String = ""

                                    If CType(ctrl, WebControl).Attributes("CrystalFieldValueType") IsNot Nothing AndAlso IsNumeric(CType(ctrl, WebControl).Attributes.Item("CrystalFieldValueType")) Then

                                        Quotes = GetCrystalFieldQuotes(CInt(CType(ctrl, WebControl).Attributes.Item("CrystalFieldValueType")))

                                    End If

                                    Criteria &= IIf(Criteria = "", "", " AND ") & DBField & IIf(Value.Contains(","), " IN [", " = ") & IIf(Value.Contains("{"), String.Format(Value, Quotes), Quotes & Value & Quotes) & IIf(Value.Contains(","), " ]", "'")

                                Else

                                    Criteria &= IIf(Criteria = "", "", " AND ") & DBField & IIf(Value.Contains(","), " IN [", " = '") & Value & IIf(Value.Contains(","), " ]", "'")

                                End If

                            End If

                        End If

                    Next

                Next

            Next

        Next

        Return Criteria

    End Function
End Class