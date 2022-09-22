

var actionSheetItems = [
    { text: "View underlying data" },
    { text: "Drill down" }
];


Array.prototype.unique = function () {
    let arr = [];
    for (let i = 0; i < this.length; i++) {
        if (!arr.includes(this[i])) {
            arr.push(this[i]);
        }
    }
    return arr;
};

function getUnderlyingData(e, args) {


    var $popupContainer = $("<div />")
        .addClass("popup")
        .appendTo($("#popup"));

    popupx = $popupContainer.dxPopup(popupOptions).dxPopup("instance");
    popupx.show();


    var underlyingData = [];
    //actionSheet.classList.remove("context-menu--active");
    if (popupx) {
        $(".popup").remove();
    }
    popupx.hide();

    args.RequestUnderlyingData(function (data) {
        dataMembers = data.GetDataMembers();
        for (var i = 0; i < data.GetRowCount(); i++) {
            var dataTableRow = {};
            $.each(dataMembers, function (_, dataMember) {
                dataTableRow[dataMember] = data.GetRowValue(i, dataMember);
            });
            underlyingData.push(dataTableRow);
        }

        var $grid = $('<div/>');
        $grid.dxDataGrid({
            height: 500,
            scrolling: {
                mode: 'virtual'
            },
            dataSource: underlyingData
        });

        var popup = $("#myPopup").data("dxPopup");
        $popupContent = popup.content();
        $popupContent.empty();
        $popupContent.append($grid);
        popup.show();
    });

}


function initPopup() {
    $("#myPopup").dxPopup({
        width: 800, height: 600,
        title: "Underlying data",
        showCloseButton: true
    });
}


var ctrls = [];
var uData = [];
var cellData;

function filterItems(arr, filters) {
    return arr.filter(function (val) {
        for (var i = 0; i < filters.length; i++)
            if (filters[i][1] != undefined) {
                if (filters[i][2].includes("Date")) {
                    var dt1 = new Date(val[filters[i][0]]);
                    var dt2 = new Date(filters[i][1]);
                    if (JSON.stringify(dt1) !== JSON.stringify(dt2)) {
                        return false;
                    }
                } else if (val[filters[i][0]] != filters[i][1])
                    return false;
            }
        return true;
    });
};

//Underlying data for widgets using right click

function showPivotUnderlyingData(args) {

    var itemName = args.ItemName;
    var underlyingData = [];
    var dataMembers = [];
    var filters = args.filters;
    uData = [];

    var clientData = webDashboard.GetItemData(itemName);

    var availableDataMembers = clientData.GetDataMembers();
    var requestParameters;

    if (args.ShowAllColumns == true) {
        requestParameters = {
            DataMembers: availableDataMembers
        };
    } else {
        requestParameters = {};
    }

    webDashboard.RequestUnderlyingData(itemName, requestParameters, function (data) {
        var dataM = data.GetDataMembers();
        for (var i = 0; i < data.GetRowCount(); i++) {
            var dataTableRow = {};
            $.each(dataM, function (_, dataMember) {
                dataTableRow[dataMember] = data.GetRowValue(i, dataMember);
            });
            uData.push(dataTableRow);
        }

        cellData = filterItems(uData, filters);
        underlyingData = cellData.unique();
        //underlyingData = cellData.filter((x, i, a) => a.indexOf(x) == i);
        //actionSheet.classList.remove("context-menu--active");

        var $grid = $('<div/>');
        $grid.dxDataGrid({
            height: 500,
            columnHidingEnabled: true,
            columnAutoWidth: true,
            scrolling: {
                mode: 'virtual'
            },
            selection: {
                mode: "multiple"
            },
            "export": {
                enabled: true,
                fileName: "Employees",
                allowExportSelectedData: true
            },
            dataSource: underlyingData
        });

        var popup = $("#myPopup").dxPopup({
            width: 1500, height: 600,
            title: "Underlying data",
            showCloseButton: true
        }).dxPopup("instance");
        $popupContent = popup.content();
        $popupContent.empty();
        $popupContent.append($grid);
        popup.show();
    });

}

function showGridUnderlyingData(args) {

    var itemName = args.ItemName;
    var underlyingData = [];
    var dataMembers = [];
    var filters = args.filters;
    uData = [];

    var clientData = webDashboard.GetItemData(itemName);

    var availableDataMembers = clientData.GetDataMembers();
    var requestParameters;

    if (args.ShowAllColumns == true) {
        requestParameters = {
            DataMembers: availableDataMembers
        };
    } else {
        requestParameters = {};
    }

    webDashboard.RequestUnderlyingData(itemName, requestParameters, function (data) {
        var dataM = data.GetDataMembers();
        for (var i = 0; i < data.GetRowCount(); i++) {
            var dataTableRow = {};
            $.each(dataM, function (_, dataMember) {
                dataTableRow[dataMember] = data.GetRowValue(i, dataMember);
            });
            uData.push(dataTableRow);
        }

        cellData = filterItems(uData, filters);

        underlyingData = cellData.unique();
        //underlyingData = cellData.filter((x, i, a) => a.indexOf(x) == i);
        //actionSheet.classList.remove("context-menu--active");

        var $grid = $('<div/>');
        $grid.dxDataGrid({
            height: 500,
            columnHidingEnabled: true,
            columnAutoWidth: true,
            scrolling: {
                mode: 'virtual'
            },
            selection: {
                mode: "multiple"
            },
            "export": {
                enabled: true,
                fileName: "Employees",
                allowExportSelectedData: true
            },
            dataSource: underlyingData
        });

        var popup = $("#myPopup").dxPopup({
            width: 1500, height: 600,
            title: "Underlying data",
            showCloseButton: true
        }).dxPopup("instance");
        $popupContent = popup.content();
        $popupContent.empty();
        $popupContent.append($grid);
        popup.show();
    });

}

function OnItemWidgetCreated(s, arg) {
    var ctrl = arg.GetWidget();

    if (ctrl[0] != undefined) ctrl = ctrl[0];

    ctrls.push(ctrl);
    var itemName = arg.ItemName;

    switch (ctrl.NAME) {

        case "dxPivotGrid":
            var baseFunc = ctrl.option('onContextMenuPreparing');

            var pvtgrid = ctrl;
            pvtgrid.contextMenuEnabled = true;

            pvtgrid.option('onContextMenuPreparing', function (e) {
                if (baseFunc)
                    baseFunc(e);
                else
                    e.items = [];

                if (e.area === "data") {

                    var filters = [];

                    if (typeof (e.items) == "undefined") e.items = [];
                    var fieldNames = [];

                    for (i = 0; i < e.rowFields.length; i++) {
                        fieldNames[i] = e.rowFields[i].caption;
                    }
                    var columnNames = [];
                    for (i = 0; i < e.columnFields.length; i++) {
                        columnNames[i] = e.columnFields[i].caption;
                    }
                    var cnt = 0;

                    for (var i = 0; i < fieldNames.length; i++) {

                        var vtype = Object.prototype.toString.call(e.cell.rowPath[i]);
                        filters.push([fieldNames[i], e.cell.rowPath[i], vtype]);

                    }

                    for (var i = 0; i < columnNames.length; i++) {
                        var vtype1 = Object.prototype.toString.call(e.cell.rowPath[i]);
                        filters.push([columnNames[i], e.cell.columnPath[i], vtype1]);

                    }

                    arg.filters = filters;

                    e.items.push({
                        text: 'View Select data',
                        icon: "fields",
                        onItemClick: function (args) {
                            arg.ShowAllColumns = false;
                            showPivotUnderlyingData(arg);
                        }
                    });

                    e.items.push({
                        text: 'View Underlying data (All columns)',
                        icon: "columnfield",
                        onItemClick: function (args) {
                            arg.ShowAllColumns = true;
                            showPivotUnderlyingData(arg);
                        }
                    });
                }
            });

            pvtgrid.getDataSource().load();

            break;

        case "dxDataGrid":
            var grid = ctrl;
            var gridOptions = {
                onContextMenuPreparing: function (e) {

                    if (e.row.rowType === "data") {

                        e.items = [];

                        var filters = [];

                        var multiData = webDashboard.GetItemData(arg.ItemName);
                        var value = multiData.GetAxis().GetPoints()[e.row.data.index].getUniquePath();
                        var dimensions = multiData.GetDimensions();


                        for (i = 0; i < dimensions.length; i++) {

                            var points = multiData.GetAxis().GetPoints()[e.row.data.index];
                            var vtype = Object.prototype.toString.call(points.GetDimensionValue(dimensions[i].Id).GetValue());

                            filters.push([dimensions[i].DataMember, points.GetDimensionValue(dimensions[i].Id).GetValue(), vtype]);
                        }

                        arg.filters = filters;

                        e.items.push({
                            text: 'View Select data',
                            icon: "fields",
                            onItemClick: function (args) {
                                arg.ShowAllColumns = false;
                                showGridUnderlyingData(arg);
                            }
                        });

                        e.items.push({
                            text: 'View Underlying data (All columns)',
                            icon: "columnfield",
                            onItemClick: function (args) {
                                arg.ShowAllColumns = true;
                                showGridUnderlyingData(arg);
                            }
                        });

                    }

                },
                hoverStateEnabled: true
            };

            grid._$element.dxDataGrid(gridOptions);

            break;
        case "dxChart":

            var $ctrl = ctrl._$element;

            var _chartOptions = {

                // other options omitted ...

                onSeriesHoverChanged: function (e) {
                    var ser = $ctrl.data('hoveredSeries');
                    if (typeof ser !== 'undefined' && ser && ser === e.target && !e.target.isHovered()) {
                        $ctrl.removeData('hoveredSeries');
                    } else if (e.target.isHovered()) {
                        $ctrl.data('hoveredSeries', e.target);
                    }
                },
                onPointHoverChanged: function (e) {
                    var ser = $ctrl.data('hoveredPointSeries');

                    if (typeof ser !== 'undefined' && ser && ser === e.target.series && !e.target.isHovered()) {
                        $ctrl.removeData('hoveredPointSeries');
                    } else if (e.target.isHovered()) {
                        $ctrl.data('hoveredPointSeries', e.target);
                    }
                }
            };

            $ctrl.dxChart(_chartOptions)
                .on('contextmenu', function (e) {

                    e.stopPropagation();
                    e.preventDefault();

                    var ser = $ctrl.data('hoveredSeries') || $ctrl.data('hoveredPointSeries');
                    // ser now contains the hovered series, if any.
                    var xPoint = ser._dataItem.data.tag.axisPoint;

                    var filters = [];
                    var dimensions = xPoint.GetDimensions();

                    for (i = 0; i < dimensions.length; i++) {
                        var vtype = Object.prototype.toString.call(xPoint.GetDimensionValue(dimensions[i].Id).GetValue());
                        filters.push([dimensions[i].DataMember, xPoint.GetDimensionValue(dimensions[i].Id).GetValue(), vtype]);
                    }

                    arg.filters = filters;

                    var contextMenuItems = [
                        {
                            text: 'View Select data',
                            icon: "fields",
                            onItemClick: function (args) {
                                arg.ShowAllColumns = false;
                                showGridUnderlyingData(arg);
                            }
                        },
                        {
                            text: 'View Underlying data (All columns)',
                            icon: "columnfield",
                            onItemClick: function (args) {
                                arg.ShowAllColumns = true;
                                showGridUnderlyingData(arg);
                            }
                        }
                    ];

                    var elPos = "left+" + ser.x + " top+" + ser.y;

                    popupx = null,
                        popupOptions = {
                            width: 251,
                            height: 65,
                            contentTemplate: function () {
                                return $("<div />").append(
                                    $("<div />").dxButton({
                                        text: 'View Select data',
                                        stylingMode: "text",
                                        icon: "fields",
                                        onClick: function () {
                                            arg.ShowAllColumns = false;
                                            showGridUnderlyingData(arg);
                                        }
                                    }), $("<div />").dxButton({
                                        text: 'View Underlying data (All columns)',
                                        stylingMode: "text",
                                        icon: "columnfield",
                                        onClick: function () {
                                            arg.ShowAllColumns = true;
                                            showGridUnderlyingData(arg);
                                        }
                                    })

                                );
                            },
                            showTitle: false,
                            visible: false,
                            dragEnabled: false,
                            closeOnOutsideClick: true,
                            position: { my: 'center', at: 'center', of: $ctrlPie },
                            container: $ctrl
                        };


                    var $popupContainer = $("<div />")
                        .addClass("popup")
                        .appendTo($("#popup"));

                    popupx = $popupContainer.dxPopup(popupOptions).dxPopup("instance");
                    popupx.show();


                    //positionMenu(e);
                    //toggleMenuOn();

                    //simulate($ctrl, "click", { pointerX: clickCoordsX, pointerY: clickCoordsY });

                });
            break;

        case "dxPieChart":
            var $ctrlPie = ctrl._$element;

            var chartOptions = {

                // other options omitted ...

                onPointSelectionChanged: function (e) {
                    var ser = $ctrlPie.data('hoveredSeries');
                    if (typeof ser !== 'undefined' && ser && ser === e.target && !e.target.isHovered()) {
                        $ctrlPie.removeData('hoveredSeries');
                    } else if (e.target.isHovered()) {
                        $ctrlPie.data('hoveredSeries', e.target);
                    }
                },
                onPointHoverChanged: function (e) {
                    var ser = $ctrlPie.data('hoveredPointSeries');

                    if (typeof ser !== 'undefined' && ser && ser === e.target.series && !e.target.isHovered()) {
                        $ctrlPie.removeData('hoveredPointSeries');
                    } else if (e.target.isHovered()) {
                        $ctrlPie.data('hoveredPointSeries', e.target);
                    }
                },
                legend: {
                    visible: true,
                    border: {
                        visible: true
                    }
                }

            };

            $ctrlPie.dxPieChart(chartOptions)
                .on('contextmenu', function (e) {

                    e.stopPropagation();
                    e.preventDefault();

                    var ser = $ctrlPie.data('hoveredSeries') || $ctrlPie.data('hoveredPointSeries');
                    // ser now contains the hovered series, if any.
                    var xPoint = ser._dataItem.data.tag.axisPoint;

                    var filters = [];
                    var dimensions = xPoint.GetDimensions();

                    for (i = 0; i < dimensions.length; i++) {

                        var vtype = Object.prototype.toString.call(xPoint.GetDimensionValue(dimensions[i].Id).GetValue());
                        filters.push([dimensions[i].DataMember, xPoint.GetDimensionValue(dimensions[i].Id).GetValue(), vtype]);
                    }

                    arg.filters = filters;

                    var contextMenuItems = [
                        {
                            text: 'View Select data',
                            icon: "fields",
                            onItemClick: function (args) {
                                arg.ShowAllColumns = false;
                                showGridUnderlyingData(arg);
                            }
                        },
                        {
                            text: 'View Underlying data (All columns)',
                            icon: "columnfield",
                            onItemClick: function (args) {
                                arg.ShowAllColumns = true;
                                showGridUnderlyingData(arg);
                            }
                        }
                    ];

                    var elPos = "left+" + ser.x + " top+" + ser.y;

                    popupx = null,
                        popupOptions = {
                            width: 251,
                            height: 65,
                            contentTemplate: function () {
                                return $("<div />").append(
                                    $("<div />").dxButton({
                                        text: 'View Select data',
                                        stylingMode: "text",
                                        icon: "fields",
                                        onClick: function () {
                                            arg.ShowAllColumns = false;
                                            showGridUnderlyingData(arg);
                                        }
                                    }), $("<div />").dxButton({
                                        text: 'View Underlying data (All columns)',
                                        stylingMode: "text",
                                        icon: "columnfield",
                                        onClick: function () {
                                            arg.ShowAllColumns = true;
                                            showGridUnderlyingData(arg);
                                        }
                                    })

                                );
                            },
                            showTitle: false,
                            visible: false,
                            dragEnabled: false,
                            closeOnOutsideClick: true,
                            position: { my: 'center', at: 'center', of: $ctrlPie },
                            container: $ctrlPie
                        };


                    var $popupContainer = $("<div />")
                        .addClass("popup")
                        .appendTo($("#popup"));

                    popupx = $popupContainer.dxPopup(popupOptions).dxPopup("instance");
                    popupx.show();


                    //positionMenu(e);
                    //toggleMenuOn();

                    //simulate($ctrl, "click", { pointerX: clickCoordsX, pointerY: clickCoordsY });

                });
            break;

    }
}
//Variables

var menu = document.querySelector("#context-menu");
var menuState = 0;
var activeClassName = "context-menu--active";
var contextMenuClassName = "context-menu";
var contextMenuItemClassName = "context-menu__item";
var contextMenuLinkClassName = "context-menu__link";
var contextMenuActive = "context-menu--active";

var taskItemClassName = "task";
var taskItemInContext;

var clickCoords;
var clickCoordsX;
var clickCoordsY;

var menuWidth;
var menuHeight;
var menuPosition;
var menuPositionX;
var menuPositionY;

var windowWidth;
var windowHeight;

//Simulate mouse click

function simulate(element, eventName) {
    var options = extend(defaultOptions, arguments[2] || {});
    var oEvent, eventType = null;

    for (var name in eventMatchers) {
        if (eventMatchers[name].test(eventName)) { eventType = name; break; }
    }

    if (!eventType)
        throw new SyntaxError('Only HTMLEvents and MouseEvents interfaces are supported');

    if (document.createEvent) {
        oEvent = document.createEvent(eventType);
        if (eventType == 'HTMLEvents') {
            oEvent.initEvent(eventName, options.bubbles, options.cancelable);
        }
        else {
            oEvent.initMouseEvent(eventName, options.bubbles, options.cancelable, document.defaultView,
                options.button, options.pointerX, options.pointerY, options.pointerX, options.pointerY,
                options.ctrlKey, options.altKey, options.shiftKey, options.metaKey, options.button, element);
        }
        element.dispatchEvent(oEvent);
    }
    else {
        options.clientX = options.pointerX;
        options.clientY = options.pointerY;
        var evt = document.createEventObject();
        oEvent = extend(evt, options);
        element.fireEvent('on' + eventName, oEvent);
    }
    return element;
}

function extend(destination, source) {
    for (var property in source)
        destination[property] = source[property];
    return destination;
}

var eventMatchers = {
    'HTMLEvents': /^(?:load|unload|abort|error|select|change|submit|reset|focus|blur|resize|scroll)$/,
    'MouseEvents': /^(?:click|dblclick|mouse(?:down|up|over|move|out))$/
}

var defaultOptions = {
    pointerX: 0,
    pointerY: 0,
    button: 0,
    ctrlKey: false,
    altKey: false,
    shiftKey: false,
    metaKey: false,
    bubbles: true,
    cancelable: true
};


// updated positionMenu function
function positionMenu(e) {
    clickCoords = getPosition(e);
    clickCoordsX = clickCoords.x;
    clickCoordsY = clickCoords.y;
    if (menu == null) menu = document.querySelector("#context-menu");

    menuWidth = menu.offsetWidth;
    menuHeight = menu.offsetHeight;

    windowWidth = window.innerWidth;
    windowHeight = window.innerHeight;

    if ((windowWidth - clickCoordsX) < menuWidth) {
        menu.style.left = windowWidth - menuWidth + "px";
    } else {
        menu.style.left = clickCoordsX + "px";
    }

    if ((windowHeight - clickCoordsY) < menuHeight) {
        menu.style.top = windowHeight - menuHeight + "px";
    } else {
        menu.style.top = clickCoordsY + "px";
    }
}

function getPosition(e) {
    var posx = 0;
    var posy = 0;

    if (!e) e = window.event;

    if (e.pageX || e.pageY) {
        posx = e.pageX;
        posy = e.pageY;
    } else if (e.clientX || e.clientY) {
        posx = e.clientX + document.body.scrollLeft +
            document.documentElement.scrollLeft;
        posy = e.clientY + document.body.scrollTop +
            document.documentElement.scrollTop;
    }

    return {
        x: posx,
        y: posy
    };
}

function toggleMenuOff() {
    if (menuState !== 0) {
        menuState = 0;
        if (menu == null) {
            menu = document.querySelector("#context-menu");
            menu.classList.remove(activeClassName);
        } else
            menu.classList.remove(activeClassName);
    }
}

function toggleMenuOn() {
    if (menuState !== 1) {
        menuState = 1;
        menu.classList.add(activeClassName);

    }
}

function clickInsideElement(e, className) {
    var el = e.srcElement || e.target;

    if (el.classList.contains(className)) {
        return el;
    } else {
        while (el == el.parentNode) {
            if (el.classList && el.classList.contains(className)) {
                return el;
            }
        }
    }

    return false;
}