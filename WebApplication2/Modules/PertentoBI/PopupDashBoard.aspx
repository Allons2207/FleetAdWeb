<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PopupDashBoard.aspx.cs" Inherits="PertentoBI.PopupDashBoard" %>

<%@ Register Assembly="DevExpress.Dashboard.v21.2.Web.WebForms, Version=21.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.DashboardWeb" TagPrefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <%--    <script type="text/javascript" src="Content/jszip.js"></script>--%>
    <link href="Content/fontawesome_5.8.2_web/css/fontawesome.css" rel="stylesheet" />
    <script type="text/javascript" src="Scripts/jquery.min.js"></script>
    <script type="text/javascript" src="Scripts/jszip.min.js"></script>
    <script type="text/javascript" src='Content/Custom_Items/SaveAsExtension.js'></script>
    <script type="text/javascript" src='Content/Custom_Items/DeleteExtension.js'></script>
    <script type="text/javascript" src='Content/Custom_Items/DashboardGroupExtension.js'></script>
    <script type="text/javascript" src='Content/Custom_Items/DashboardSecurityExtension.js'></script>
    <script type="text/javascript" src='Content/Custom_Items/DefaultSourceExtension.js'></script>
    <%--    <script type="text/javascript" src="Content/Custom_Items/d3/d3.v4.min.js"></script>
    <script type="text/javascript" src="Content/Custom_Items/d3-funnel/d3-funnel.min.js"></script>
    <script type="text/javascript" src="Content/Custom_Items/dashboard-extensions/funnel-d3-item.js"></script>--%>
    <%--    <script type="text/javascript" src="Content/Custom_Items/dashboard-extensions/online-map-item.js"></script>--%>
    <%--    <script type="text/javascript" src="Content/Custom_Items/dashboard-extensions/parameter-item.js"></script>
    <script type="text/javascript" src="Content/Custom_Items/dashboard-extensions/webpage-item.js"></script>
    <script type="text/javascript" src="Content/Custom_Items/dashboard-extensions/simple-table-item.js"></script>
    <script type="text/javascript" src="Content/Custom_Items/dashboard-extensions/dashboard-panel.js"></script>--%>
    <script type="text/javascript" src="Content/Custom_Items/UnderlyingData.js"></script>
    <script type="text/javascript" src="Scripts/Cookies.js"></script>
    <script type="text/javascript">


        function onBeforeRender(sender, e) {
            // Gets an underlying part of the ASPxClientDashboard control and removes the 'Save' item from a standard menu. 
            DevExpress.Dashboard.ResourceManager.embedBundledResources();

            var innerControl = sender.GetDashboardControl();
            var extension = new DevExpress.Dashboard.DashboardPanelExtension(innerControl);
            extension.allowSwitchToDesigner(true);
            //CustomDashboardPanelExtension
            innerControl.registerExtension(extension);
            //  innerControl.registerExtension(new CustomDashboardPanelExtension(innerControl));
            innerControl.registerExtension(new SaveAsDashboardExtension(innerControl));
            innerControl.registerExtension(new DeleteDashboardExtension(sender));
            //innerControl.registerExtension(new OnlineMapItemExtension(innerControl));
            //innerControl.registerExtension(new FunnelD3ItemExtension(innerControl));
            //innerControl.registerExtension(new WebPageItemExtension(innerControl));
            //innerControl.registerExtension(new ParameterItemExtension(innerControl));
            //innerControl.registerExtension(new SimpleTableItemExtension(innerControl));
            innerControl.registerExtension(new GroupDashboardExtension(sender));
            innerControl.registerExtension(new SecurityDashboardExtension(sender));
            innerControl.registerExtension(new DefaultSourceDashboardExtension(sender));
            // webDashboard.Refresh();

        }
    </script>
    <%--    <telerik:RadScriptManager ID="ScriptManager1" runat="server" EnableTheming="True" EnablePageMethods="true">
    </telerik:RadScriptManager>--%>
    <style type="text/css">
        @import url(https://fonts.googleapis.com/css?family=Roboto:400,300);

        *,
        *::before,
        *::after {
            box-sizing: border-box;
        }

        fieldset {
            border: 1px solid #c0c0c0;
            margin: 0 2px;
            padding: .35em .625em .75em;
            height: 1000px;
        }

        body {
            color: #595959;
            font-family: "Roboto", sans-serif;
            font-size: 16px;
            font-weight: 300;
            line-height: 1.5;
        }

        .container {
            margin: 0 auto;
            padding: 0 24px;
            max-width: 960px;
        }

        /* primary header */

        .primary-header {
            padding: 24px 0;
            text-align: center;
            border-bottom: solid 2px #cfcfcf;
        }

        .primary-header__title {
            color: #393939;
            font-size: 36px;
        }

            .primary-header__title small {
                font-size: 18px;
                color: #898989;
            }

        /* content */

        .content {
            padding: 48px 0;
            border-bottom: solid 2px #cfcfcf;
        }

        .content__footer {
            margin-top: 12px;
            text-align: center;
        }

        /* footer */

        .primary-footer {
            padding: 24px 0;
            color: #898989;
            font-size: 14px;
            text-align: center;
        }

        /* tasks */

        .tasks {
            list-style: none;
            margin: 0;
            padding: 0;
        }

        .task {
            display: flex;
            justify-content: space-between;
            padding: 12px 0;
            border-bottom: solid 1px #dfdfdf;
        }

            .task:last-child {
                border-bottom: none;
            }
        /* action-sheet */
        /*#action-sheet {
            z-index: 10;
            padding: 12px 0;
            width: 240px;
            background-color: #fff;
            border: solid 1px #dfdfdf;
            box-shadow: 1px 1px 2px #cfcfcf;
        }*/
        /* context menu */

        .context-menu {
            display: none;
            position: absolute;
            z-index: 10;
            padding: 12px 0;
            width: 240px;
            background-color: #fff;
            border: solid 1px #dfdfdf;
            box-shadow: 1px 1px 2px #cfcfcf;
        }

        .context-menu--active {
            display: block;
        }

        .context-menu__items {
            list-style: none;
            margin: 0;
            padding: 0;
        }

        .context-menu__item {
            display: block;
            margin-bottom: 4px;
        }

            .context-menu__item:last-child {
                margin-bottom: 0;
            }

        .context-menu__link {
            display: block;
            padding: 4px 12px;
            color: #0066aa;
            text-decoration: none;
        }

            .context-menu__link:hover {
                color: #fff;
                background-color: #0066aa;
            }

        #popup {
            padding: 10px;
        }

            #popup ul {
                list-style-type: none;
                text-align: center;
            }

                #popup ul li {
                    display: inline-block;
                    width: 160px;
                    margin: 10px;
                }

                    #popup ul li img {
                        width: 100px;
                    }

        .button-info {
            margin: 10px;
        }

        .popup p {
            margin-bottom: 10px;
            margin-top: 0;
        }
    </style>

    <link rel="stylesheet" href="Content/Custom_Items/dashboard-extensions/dashboard-panel.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <%--    <script type="text/javascript" src="Content/Custom_Items/WidgetsCustomization.js"></script>--%>
            <script type=""></script>

            <!-- Defines the "Save As" extension template. -->
            <script type="text/html" id="dx-save-as-form">
                <div>Dashboard Name:</div>
                <div style="margin: 10px 0" data-bind="dxTextBox: { value: newName }"></div>
                <div data-bind="dxButton: { text: 'Save', onClick: saveAs }"></div>
            </script>


            <div style="display: none">
                <svg id="grayTriangle" viewBox="0 0 24 24">
                    <path fill="dx_gray" d="M12 2 L2 22 L22 22 Z" />
                </svg>
            </div>
            <div style="display: none">
                <svg id="connectedSvg" xmlns="http://www.w3.org/2000/svg" x="0px" y="0px"
                    width="24" height="24"
                    viewBox="0 0 172 172"
                    style="fill: #000000;">
                    <g fill="none" fill-rule="nonzero" stroke="none" stroke-width="1" stroke-linecap="butt" stroke-linejoin="miter" stroke-miterlimit="10" stroke-dasharray="" stroke-dashoffset="0" font-family="none" font-weight="none" font-size="none" text-anchor="none" style="mix-blend-mode: normal">
                        <path d="M0,172v-172h172v172z" fill="none"></path>
                        <g fill="#23b133">
                            <path d="M145.43294,16.43294l-24.83138,24.83138l-6.29883,-6.29883c-8.11983,-8.11983 -22.27535,-8.127 -30.40235,0l-8.65039,8.65039l-5.68294,-5.68294l-10.13411,10.13411l64.5,64.5l10.13411,-10.13411l-5.68294,-5.68294l8.6504,-8.65039c8.385,-8.385 8.385,-22.01735 0,-30.40235l-6.29883,-6.29883l24.83137,-24.83138zM48.06706,59.43294l-10.13411,10.13411l5.68294,5.68294l-8.65039,8.65039c-8.385,8.385 -8.385,22.01735 0,30.40235l6.29883,6.29883l-24.83138,24.83138l10.13411,10.13411l24.83138,-24.83137l6.29883,6.29883c4.05633,4.05633 9.45351,6.29883 15.20117,6.29883c5.7405,0 11.14484,-2.23533 15.20117,-6.29883l8.65039,-8.6504l5.68294,5.68294l10.13411,-10.13411z"></path>
                        </g>
                        <g fill="#23b133">
                            <path d="M126.88,123.59l0.33,-1.39h13.16l-0.34,1.39c-0.8,0.28667 -1.60667,0.53667 -2.42,0.75c-0.82,0.20667 -1.63,0.35667 -2.43,0.45v0l-6,28.51h10.99l4.47,-7.72h1.25c-0.06667,0.66667 -0.14667,1.44 -0.24,2.32c-0.1,0.88 -0.22,1.79333 -0.36,2.74c-0.14667,0.94667 -0.30667,1.86667 -0.48,2.76c-0.18,0.89333 -0.36667,1.69333 -0.56,2.4v0h-24.14l0.24,-1.39c0.86667,-0.35333 1.63333,-0.61 2.3,-0.77c0.67333,-0.16 1.31333,-0.28667 1.92,-0.38v0l6,-28.47c-1.5,-0.28667 -2.73,-0.68667 -3.69,-1.2z"></path>
                        </g>
                    </g></svg>
                <svg id="disconnectedSvg" xmlns="http://www.w3.org/2000/svg" x="0px" y="0px"
                    width="24" height="24"
                    viewBox="0 0 172 172"
                    style="fill: #000000;">
                    <g fill="none" fill-rule="nonzero" stroke="none" stroke-width="1" stroke-linecap="butt" stroke-linejoin="miter" stroke-miterlimit="10" stroke-dasharray="" stroke-dashoffset="0" font-family="none" font-weight="none" font-size="none" text-anchor="none" style="mix-blend-mode: normal">
                        <path d="M0,172v-172h172v172z" fill="none"></path>
                        <g fill="#FCB737">
                            <g id="surface1">
                                <path d="M164.55769,0c-1.47296,0.15505 -2.86839,0.82692 -3.92788,1.86058l-10.95673,10.95673c-14.57452,-10.51743 -34.80829,-8.63101 -48.375,4.34135c0,0.51683 -5.65926,6.02103 -10.75,10.95673l-6.40865,-6.40865c-1.36959,-1.47296 -3.35937,-2.22235 -5.375,-2.06731c-0.28426,0.05169 -0.56851,0.12921 -0.82692,0.20673c-2.48077,0.4393 -4.47055,2.2482 -5.16827,4.65144c-0.69772,2.42909 0.02584,5.01322 1.86058,6.71875l15.09135,15.09135l-21.70673,21.70673c-2.63581,2.63582 -2.63581,6.8738 0,9.50962c2.63582,2.63582 6.8738,2.63582 9.50962,0l21.70673,-21.70673l16.95192,16.95192l-21.70673,21.70673c-2.63581,2.63582 -2.63581,6.8738 0,9.50962c2.63582,2.63582 6.8738,2.63582 9.50962,0l21.70673,-21.70673l15.09135,15.09135c2.63582,2.63582 6.8738,2.63582 9.50962,0c2.63582,-2.63581 2.63582,-6.87379 0,-9.50962l-6.40865,-6.40865l10.95673,-10.75c12.97236,-12.97235 14.29026,-33.1286 4.13462,-48.16827l11.16346,-11.16346c2.14483,-1.98978 2.71334,-5.14243 1.42128,-7.7524c-1.26622,-2.63581 -4.13462,-4.08293 -7.00301,-3.61779zM25.84135,72.5625c-0.28426,0.05169 -0.56851,0.12921 -0.82692,0.20673c-2.48077,0.4393 -4.47055,2.2482 -5.16827,4.65144c-0.69772,2.42909 0.02584,5.01322 1.86058,6.71875l6.40865,6.40865l-10.95673,10.75c-12.97235,12.97236 -14.29026,33.12861 -4.13462,48.16827l-11.16346,11.16346c-2.63582,2.63582 -2.63582,6.8738 0,9.50962c2.63582,2.63582 6.8738,2.63582 9.50962,0l10.95673,-10.95673c14.57452,10.51743 34.80829,8.63101 48.375,-4.34135c0,-0.51683 5.65926,-6.02103 10.75,-10.95673l6.40865,6.40865c2.63582,2.63582 6.8738,2.63582 9.50962,0c2.63582,-2.63581 2.63582,-6.87379 0,-9.50962l-66.15385,-66.15385c-1.36959,-1.47296 -3.35937,-2.22235 -5.375,-2.06731z"></path>
                            </g>
                        </g>
                    </g></svg>

            </div>
            <div style="display: none">
            </div>
            <div id="dashboard" style="position: absolute; left: 0; right: 0; top: 0; bottom: 0;">
                <div id="myPopup"></div>
                <div id="popupContainer">
                    <div id="textBoxContainer"></div>
                </div>
                <div id="securityContainer">
                    <div id="gridBox"></div>
                </div>
                <div id="extractContainer">
                    <div id="extractBox"></div>
                </div>
                <div class="dx-viewport demo-container">
                    <div id="popup">
                        <div class="popup"></div>
                    </div>
                </div>
                <nav id="context-menu" class="context-menu"></nav>
                <div class="loadpanel"></div>
                <dx:ASPxDashboard ID="ASPxDashboard1" runat="server"
                    Width="100%"
                    ClientInstanceName="webDashboard"
                    IncludeDashboardIdToUrl="true"
                    IncludeDashboardStateToUrl="true" Height="100%"
                    UseDashboardConfigurator="true"
                    WorkingMode="Viewer" EnableCustomSql="true"
                    AllowExecutingCustomSql="true"
                    AllowExportDashboardItems="true"
                    UseNeutralFilterMode="true" ColorScheme="dark" OnCustomJSProperties="ASPxDashboard1_CustomJSProperties" OnCustomDataCallback="ASPxDashboard1_CustomDataCallback">
                    <clientsideevents beforerender="onBeforeRender"
                        init="function(s, e) { initPopup(); }" itemwidgetcreated="OnItemWidgetCreated"
                        itemwidgetupdated="OnItemWidgetCreated" dashboardtitletoolbarupdated="onDashboardTitleToolbarUpdated" />
                    <pdfexportoptions dashboardautomaticpagelayout="true" documentscalemode="AutoFitToPagesWidth" />
                </dx:ASPxDashboard>
            </div>
        </div>
    </form>
</body>
</html>
