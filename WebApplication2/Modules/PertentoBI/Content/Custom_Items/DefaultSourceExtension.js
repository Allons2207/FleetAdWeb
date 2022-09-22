// Creates and implements a custom SaveAsDashboardExtension class.

function DefaultSourceDashboardExtension(_wrapper) {
    var _this = this;
    this._control = _wrapper.GetDashboardControl();
    this._toolbox = this._control.findExtension('toolbox');
    this.name = "dxdset-defaultsources";

    var dataGrid, appliedSecurity, dt = [], cnt = 0;
    // Specifies which actions will be performed on clicking a custom menu item (which is added below using addMenuItem).
    this.clickAction = function () {
        // Creates a popup that will display a text box allowing end-users to specify a comment to be appended to the dashboard XML file.
        var popup = $("#extractContainer").dxPopup({
            title: "Set Default Source Type",
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
                    $("#extractBox").dxDropDownBox("instance").option("value", appliedkeys);

                });

                var sourceTypes = [{
                    "Value": "L",
                    "Text": "Live"
                }, {
                    "Value": "E",
                    "Text": "Extract"
                }];

                $("#extractBox").dxSelectBox({
                    dataSource: new DevExpress.data.ArrayStore({
                        data: sourceTypes,
                        key: "Value"
                    }),
                    displayExpr: "Text",
                    valueExpr: "Value",
                    value: sourceTypes[0].Value
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
            var groupIds = $("#extractBox").dxDropDownBox("instance").option("value").toString();
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
        $("#extractContainer").dxPopup("instance").hide();
        _this._toolbox.menuVisible(false);
    };

    //Att to menu
    this._menuItem = {
        id: this.name,
        title: "Set Source Type",
        click: this.clickAction,
        selected: ko.observable(false),
        disabled: ko.computed(function () { return !_this._control.dashboard(); }),
        index: 113,
        hasSeparator: true,
        data: _this
    };


}


DefaultSourceDashboardExtension.prototype.isExtensionAvailable = function () {
    return this._toolbox !== undefined && this._newDashboardExtension !== undefined;
}

DefaultSourceDashboardExtension.prototype.start = function () {
    if (this.isExtensionAvailable())
        this._toolbox.menuItems.push(this._menuItem);
};
DefaultSourceDashboardExtension.prototype.stop = function () {
    if (this.isExtensionAvailable())
        this._toolbox.menuItems.remove(this._menuItem);
}

var url = "";

function onDashboardTitleToolbarUpdated(s, e) {

    var dashboardid = webDashboard.GetDashboardId();
    var DefaultSourceType = "";
    var iconName = "";
    var Item = "";
    var urlParams = new URLSearchParams(window.location.search);


    if (webDashboard.cpSourceType != null && webDashboard.cpSourceType !== "") {
        DefaultSourceType = webDashboard.cpSourceType;
        updateQueryStringParameter(url, "dst", DefaultSourceType);
        SetCookie("cSourceType", DefaultSourceType);
        if (DefaultSourceType == "E") {
            AddSourceTypeActionItem(e, "disconnectedSvg", "Live", DefaultSourceType);
            SetCookie("cSourceType", DefaultSourceType);
        } else if (DefaultSourceType == "L") {
            AddSourceTypeActionItem(e, "connectedSvg", "Extract", DefaultSourceType);
            SetCookie("cSourceType", DefaultSourceType);
        }

    }
    else if (urlParams.has("dst")) {
        DefaultSourceType = urlParams.get("dst");
        if (DefaultSourceType == "E") {
            AddSourceTypeActionItem(e, "disconnectedSvg", "Live", DefaultSourceType);
            SetCookie("cSourceType", DefaultSourceType);
        } else if (DefaultSourceType == "L") {
            AddSourceTypeActionItem(e, "connectedSvg", "Extract", DefaultSourceType);
            SetCookie("cSourceType", DefaultSourceType);
        }

    } else if (GetCookie("cSourceType") != "") {
        DefaultSourceType = GetCookie("cSourceType");
    }
    if (webDashboard.cpHasExtract) {
        if (DefaultSourceType == "E") {
            AddSourceTypeActionItem(e, "disconnectedSvg", "Live", DefaultSourceType);
            SetCookie("cSourceType", DefaultSourceType);
        } else if (DefaultSourceType == "L") {
            AddSourceTypeActionItem(e, "connectedSvg", "Extract", DefaultSourceType);
            SetCookie("cSourceType", DefaultSourceType);
        }
    } else {
        PageMethods.GetDefaultDatasource(dashboardid, function (data) {

            if (isJsonString(data)) {
                var d = JSON.parse(data);
                if (d) {

                    webDashboard.cpExtractionDate = d.LastExtractDate;
                    webDashboard.cpExtractStatus = d.ExtractStatus;
                    webDashboard.cpSourceType = d.SourceType;
                    webDashboard.cpHasExtract = d.HasExtract;

                    updateQueryStringParameter(url, "dst", webDashboard.cpSourceType);
                    if (webDashboard.cpSourceType == "E") {
                        SetCookie("cSourceType", webDashboard.cpSourceType);
                        AddSourceTypeActionItem(e, "disconnectedSvg", "Live", webDashboard.cpSourceType);
                    } else if (DefaultSourceType == "L") {
                        SetCookie("cSourceType", webDashboard.cpSourceType);
                        AddSourceTypeActionItem(e, "connectedSvg", "Extract", webDashboard.cpSourceType);
                    }

                    SetCookie("cSourceType", webDashboard.cpSourceType);

                } else {
                    SetCookie("cSourceType", L);
                    AddSourceTypeActionItem(e, "connectedSvg", "Live", DefaultSourceType);
                }

            }


        });
    }


}

function AddSourceTypeActionItem(e, iconName, Item, defaultSourceType) {

    var extractionDate = webDashboard.cpExtractionDate;
    if (defaultSourceType === 'L') extractionDate = "";

    e.Options.actionItems.push({
        icon: iconName,
        type: "menu",
        menu: {
            title: 'Source Type',
            type: 'list',
            items: [Item],
            selectionMode: 'single',
            itemClick: function (itemData, itemElement, index) {

                var elem = document.getElementsByClassName("dx-button dx-button-normal dx-button-mode-contained dx-widget")[1].getElementsByTagName("svg")[0];
                var wd = webDashboard.GetDashboardControl();

                if (itemData.toString() == 'Extract') {
                    $(elem).find("use").attr("xlink:href", "#disconnectedSvg");
                    this.items = ['Live'];
                    SetCookie("cSourceType", 'E');
                    webDashboard.cpSourceType = "E";
                    updateQueryStringParameter(url, "dst", "E");
                    AddExtractionDetails(e, "E");
                    wd.refresh();
                } else {
                    $(elem).find("use").attr("xlink:href", "#connectedSvg");
                    this.items = ['Extract'];
                    SetCookie("cSourceType", 'L');
                    webDashboard.cpSourceType = "L";
                    updateQueryStringParameter(url, "dst", "L");
                    AddExtractionDetails(e, "L");
                    wd.refresh();
                }
            }
        }
    }, {
        template: function (element) {
            var div = $('<div/>');
            div.addClass('extractDate');
            div.text(extractionDate);
            return div;
        }
    });

    AddExtractionDetails(e, defaultSourceType);
}

function AddExtractionDetails(e, defaultSourceType) {

    if (defaultSourceType === "E") {
        $(".extractDate").text(webDashboard.cpExtractionDate);
    } else {
        $(".extractDate").text("");
    }

}

function updateQueryStringParameter(uri, key, value) {

    var urlParams = new URLSearchParams(window.location.search);
    var newUrl;
    if (!urlParams.has(key)) {
        urlParams.append(key, value);
        newUrl = window.location.origin + window.location.pathname + "?" + urlParams.toString();

    } else {
        urlParams.set(key, value);
        newUrl = window.location.origin + window.location.pathname + "?" + urlParams.toString();
    }
    history.pushState({}, null, newUrl);
}

function GetCookie(name) {
    const value = `; ${document.cookie}`;
    const parts = value.split(`; ${name}=`);
    if (parts.length === 2) return parts.pop().split(';').shift();
}

function isJsonString(str) {
    try {
        JSON.parse(str);
    } catch (e) {
        return false;
    }
    return true;
}