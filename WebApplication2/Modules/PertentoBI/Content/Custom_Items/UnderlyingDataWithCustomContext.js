

var actionSheetItems = [
    { text: "View underlying data" },
    { text: "Drill down" }
];


function getUnderlyingData(e, args) {

    popupx = null,
        popupOptions = {
            width: 150,
            height: 150,
            contentTemplate: function () {
                return $("<div />").append(
                    $("<div />").dxButton({
                        text: "View data",
                        type: "default",
                        mode: "contained",
                        icon: "columnfield",
                        onClick: function () {
                            showInfo(this);
                        }
                    }), $("<br/><br/><div />").dxButton({
                        text: "Drill down",
                        type: "success",
                        mode: "contained",
                        icon: "arrowdown",
                        onClick: function () {
                            showInfo(this);
                        }
                    })

                );
            },
            showTitle: true,
            title: "Select Action",
            visible: false,
            dragEnabled: false,
            closeOnOutsideClick: true
        };


    var $popupContainer = $("<div />")
        .addClass("popup")
        .appendTo($("#popup"));

    popupx = $popupContainer.dxPopup(popupOptions).dxPopup("instance");
    popupx.show();


    var showInfo = function (btn) {
        var txt = btn._$element.text();
        if (txt === 'View data') {
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
        } else {

            if (popupx) {
                $(".popup").remove();
            }
            popupx.hide();
        }

    };

}


function initPopup() {
    $("#myPopup").dxPopup({
        width: 800, height: 600,
        title: "Underlying data",
        showCloseButton: true
    });
}

function getContexAction(showUnderlyingData) {
    actionUnderlyingData = showUnderlyingData;
}

var actionUnderlyingData = false;

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
var ctrls = [];
var uData = [];
var cellData;


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

function filterItems(arr, filters) {
    return arr.filter(function (val) {
        for (var i = 0; i < filters.length; i++)
            if (filters[i][1] != undefined) {
                if (val[filters[i][0]] != filters[i][1])
                    return false;
            }
        return true;
    });
};


function showUnderlyingData(args) {

    var itemName = args.ItemName;
    var underlyingData = [];
    var dataMembers = [];
    var filters = args.filters;

    var requestParameters = {
    };

    webDashboard.RequestUnderlyingData(itemName, requestParameters, function (data) {
        var dataM = data.GetDataMembers();
        for (var i = 0; i < data.GetRowCount(); i++) {
            var dataTableRow = {};
            $.each(dataM, function (_, dataMember) {
                        dataTableRow[dataMember] = data.GetRowValue(i, dataMember);
            });
            uData.push(dataTableRow);
        }
         columnHidingEnabled: true,
        cellData = filterItems(uData, filters);

        underlyingData = cellData.filter((x, i, a) => a.indexOf(x) == i);
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

                    cellData = null;
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

                        filters.push([fieldNames[i], e.cell.rowPath[i]]);

                    }

                    for (var i = 0; i < columnNames.length; i++) {

                        filters.push([columnNames[i], e.cell.columnPath[i]]);

                    }


                    arg.filters = filters;
                    arg.fieldNames = fieldNames;
                    arg.columnNames = columnNames;

                    e.items.push({
                        text: 'Get Underlying data',
                        icon: "columnfield",
                        onItemClick: function (args) {
                            showUnderlyingData(arg);
                        }
                    });
                }
            });

            pvtgrid.getDataSource().load();

            break;

        case "dxDataGrid":
            var gridBaseFunc = ctrl.option('onContextMenuPreparing');
            var grid = ctrl;
            ctrl.option('onContextMenuPreparing', function (e) {
                if (gridBaseFunc)
                    gridBaseFunc(e);
                else
                    e.items = [];

                if (e.row.rowType === "data") {
                    if (typeof (e.items) == "undefined") e.items = [];

                    e.items.push({
                        text: 'Get Underlying data',
                        onItemClick: function (args) {
                            getUnderlyingData(args);
                        }
                    });
                    e.items.push({
                        text: 'SubItems',
                        onItemClick: function () {
                        },
                        items: [{
                            text: 'SubItem',
                            onItemClick: function () {
                            }
                        }]
                    });
                }
            });
            break;

        case "dxChart":

            var $c = ctrl._$element;
            $c.attr("master", JSON.stringify(ctrl));
            var chartOptions = {

                // other options omitted ...
                control: ctrl,
                defaultPane: ctrl.defaultPane,
                onSeriesHoverChanged: function (e) {
                    var ser = $c.data('hoveredSeries');
                    if (typeof ser !== 'undefined' && ser && ser === e.target && !e.target.isHovered()) {
                        $c.removeData('hoveredSeries');
                    } else if (e.target.isHovered()) {
                        $c.data('hoveredSeries', e.target);
                    }
                },
                onPointHoverChanged: function (e) {
                    var ser = $c.data('hoveredPointSeries');
                    if (typeof ser !== 'undefined' && ser && ser === e.target.series && !e.target.isHovered()) {
                        $c.removeData('hoveredPointSeries');
                    } else if (e.target.isHovered()) {
                        $c.data('hoveredPointSeries', e.target.series);
                    }
                }
            };
            //            //  toggleMenuOff();
            $c.dxChart(chartOptions).on('contextmenu', function (e, args) {

                var ctrlChart = ctrls.filter(function (c) {
                    return c._$element == $c;
                });

                e.stopPropagation();
                e.preventDefault();
                positionMenu(e);
                toggleMenuOn();

                simulate(ctrlChart, "click", { pointerX: clickCoordsX, pointerY: clickCoordsY });

                e.preventDefault();
                var ser = $c.data('hoveredSeries') || $c.data('hoveredPointSeries');
                //                //var popup = $menu.data("dxPopup");
                //                //    $popupContent = popup.content();
                //                //    $popupContent.empty();
                //                //    $popupContent.append($menu);
                //                //    popup.show();

            });



            break;
    }
}


//    //Simulate mouse click
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
