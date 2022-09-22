
function SecurityDashboardExtension(_wrapper) {
    var _this = this;
    this._wrapper = _wrapper;
    this._control = _wrapper.GetDashboardControl();
    this._toolbox = this._control.findExtension('toolbox');
    this.name = "dxdadd-dashboard-security";

    var dataGrid, appliedSecurity, dt = [], cnt = 0;
    // Specifies which actions will be performed on clicking a custom menu item (which is added below using addMenuItem).
    this.clickAction = function () {
        // Creates a popup that will display a text box allowing end-users to specify a comment to be appended to the dashboard XML file.
        var popup = $("#securityContainer").dxPopup({
            title: "Apply Security",
            visible: true,
            width: 600,
            height: 450,
            onShown: function () {

                var appliedkeys = [];

                var dataSource = new DevExpress.data.DataSource({
                    store: {
                        type: 'array',
                        data: dt
                    },
                    paginate: false
                });

                PageMethods.GetDocwizeGroups(function (data) {
                    var d = JSON.parse(data);
                    for (i = 0; i < d.length; i++) {
                        let dr = { Group_ID: d[i].Group_ID, Group_Name: d[i].Group_Name };
                        dt.push(dr);
                    }

                });

                var dashboardid = _this._wrapper.GetDashboardId();

                PageMethods.GetDashboardAppliedSecurity(dashboardid, function (data) {

                    var d = JSON.parse(data);
                    var rows = [];

                    for (i = 0; i < d.length; i++) {
                        let row = dt.filter(function (r) { return r.Group_ID == d[i].Group_ID; });
                        if (row[0]) {
                            rows.push({ Group_ID: row[0].Group_ID, Group_Name: row[0].Group_Name });
                            appliedkeys.push(row[0].Group_ID);
                        }
                    }

                    appliedSecurity = rows;
                    $("#gridBox").dxDropDownBox("instance").option("value", appliedkeys);

                });

                

                $("#gridBox").dxDropDownBox({
                    loadMode: "raw",
                    valueExpr: "Group_ID",
                    placeholder: "Select a value...",
                    displayExpr: "Group_Name",
                    showClearButton: true,
                    dataSource: dataSource,
                    contentTemplate: function (e) {
                        var value = e.component.option("value"),
                            $dataGrid = $("<div>").dxDataGrid({
                                dataSource: e.component.option("dataSource"),
                                columns: ["Group_Name"],
                                hoverStateEnabled: true,
                                paging: { enabled: true, pageSize: 10 },
                                filterRow: { visible: true },
                                scrolling: { mode: "infinite" },
                                height: 345,
                                selection: { mode: "multiple" },
                                selectedRowKeys: appliedSecurity,
                                onSelectionChanged: function (selectedItems) {
                                    var selectedRows = selectedItems.selectedRowKeys;
                                    var keys = [];
                                    for (i = 0; i < selectedRows.length; i++) {
                                        keys.push(selectedRows[i].Group_ID);
                                    }
                                    e.component.option("value", keys);
                                }
                            });

                        dataGrid = $dataGrid.dxDataGrid("instance");

                        //e.component.on("valueChanged", function (args) {
                        //    var rows = [];
                        //    for (i = 0; i < args.value.length; i++) {
                        //        let row = dt.filter(function (r) { return r.Group_ID == args.value[i]; });
                        //        rows.push({ Group_ID: row[0].Group_ID, Group_Name: row[0].Group_Name });
                        //    }
                        //    if (rows.length == 0 && args.pr)
                        //    dataGrid.selectRows(rows, false);

                        //});

                        return $dataGrid;
                    }
                });

            },
            toolbarItems: [{
                toolbar: "bottom",
                widget: "dxButton",
                location: "after",
                options: {
                    text: "Save",
                    onClick: saveButtonAction
                }
            }, {
                toolbar: "bottom",
                widget: "dxButton",
                location: "after",
                options: {
                    text: "Cancel",
                    onClick: cancelButtonAction
                }
            }]
        });

        if (webDashboard.cpGroupName != null && webDashboard.cpGroupName != '') $("#textBoxContainer").dxSelectBox.text = webDashboard.cpGroupName;
        popup.show();
    };

    // Passes the custom data (a comment, a modified date and a current dashboard state) to the server side.
    // On the server side, the CustomDataCallback event is used to obtain and parse these values.
    var saveButtonAction = function () {

        if (_this.isExtensionAvailable()) {
            var dashboardid = _this._wrapper.GetDashboardId();
            var groupIds = $("#gridBox").dxDropDownBox("instance").option("value").toString();
            var param = JSON.stringify({ DashboardID: dashboardid, ExtensionName: _this.name, GroupIDs: groupIds });
            _this._toolbox.menuVisible(false);
            _this._wrapper.PerformDataCallback(param, function () {
                // _this._control.unloadDashboard();
            });

            $("#securityContainer").dxPopup("instance").hide();
            _this._toolbox.menuVisible(false);

        }

    };

    var cancelButtonAction = function () {
        $("#securityContainer").dxPopup("instance").hide();
        _this._toolbox.menuVisible(false);
    };

    //Att to menu
    this._menuItem = {
        id: this.name,
        title: "Apply Security",
        click: this.clickAction,
        selected: ko.observable(false),
        disabled: ko.computed(function () { return !_this._control.dashboard(); }),
        index: 113,
        hasSeparator: true,
        data: _this
    };
}


SecurityDashboardExtension.prototype.isExtensionAvailable = function () {
    return this._toolbox !== undefined;
}

SecurityDashboardExtension.prototype.start = function () {
    if (this.isExtensionAvailable())
        this._toolbox.menuItems.push(this._menuItem);
};
SecurityDashboardExtension.prototype.stop = function () {
    if (this.isExtensionAvailable())
        this._toolbox.menuItems.remove(this._menuItem);
};