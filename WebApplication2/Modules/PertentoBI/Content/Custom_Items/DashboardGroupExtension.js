
function GroupDashboardExtension(_wrapper) {
    var _this = this;
    this._wrapper = _wrapper;
    this._control = _wrapper.GetDashboardControl();
    this._toolbox = this._control.findExtension('toolbox');
    this.name = "dxdadd-dashboard-to-Group";

    var dt = [];
    // Specifies which actions will be performed on clicking a custom menu item (which is added below using addMenuItem).
    this.clickAction = function () {
        // Creates a popup that will display a text box allowing end-users to specify a comment to be appended to the dashboard XML file.
        var popup = $("#popupContainer").dxPopup({
            title: "Add to Group",
            visible: true,
            width: 600,
            height: 450,
            onShown: function () {
                var dashboardid = _this._wrapper.GetDashboardId();
                var currentGroup;
                var selectedIndex;

                PageMethods.GetDashboardGroups(dashboardid, function (data) {

                    var d = JSON.parse(data);
                    for (i = 0; i < d.length; i++) {
                        var r = dt.filter(function (r) { return r == d[i].GroupName; });
                        if (r.length == 0) {
                            dt.push(d[i].GroupName);
                        }

                        if (d[i].Selected == 1) {
                            currentGroup = d[i].GroupName;
                            selectedIndex = i;
                        }
                    }

                    var selectBox = $("#textBoxContainer").dxSelectBox("instance");
                    selectBox.option('value', currentGroup);

                });//"Dashboard.aspx/GetDashboardGroups"



                $("#textBoxContainer").dxSelectBox({
                    acceptCustomValue: true,
                    items: dt,
                    showPopupTitle: false,
                    onCustomItemCreating: function (e) { if (!e.customItem) { e.customItem = e.text; } }
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
            var groupName = $("#textBoxContainer").dxSelectBox("instance").option("text");
            var param = JSON.stringify({ DashboardID: dashboardid, ExtensionName: _this.name, GroupName: groupName });
            _this._toolbox.menuVisible(false);
            _this._wrapper.PerformDataCallback(param, function () {
                // _this._control.unloadDashboard();
            });

            $("#popupContainer").dxPopup("instance").hide();
            _this._toolbox.menuVisible(false);

        }

    };

    var cancelButtonAction = function () {
        $("#popupContainer").dxPopup("instance").hide();
        _this._toolbox.menuVisible(false);
    };

    //Att to menu
    this._menuItem = {
        id: this.name,
        title: "Add to Group",
        click: this.clickAction,
        selected: ko.observable(false),
        disabled: ko.computed(function () { return !_this._control.dashboard(); }),
        index: 113,
        hasSeparator: true,
        data: _this
    };
}


GroupDashboardExtension.prototype.isExtensionAvailable = function () {
    return this._toolbox !== undefined;
}

GroupDashboardExtension.prototype.start = function () {
    if (this.isExtensionAvailable())
        this._toolbox.menuItems.push(this._menuItem);
};
GroupDashboardExtension.prototype.stop = function () {
    if (this.isExtensionAvailable())
        this._toolbox.menuItems.remove(this._menuItem);
};