﻿<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="OperatorLicence.aspx.vb" Inherits="WebApplication2.OperatorLicence" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="apple-touch-icon" sizes="76x76" href="/assets/img/apple-icon.png">
    <link rel="icon" type="image/png" href="/assets/img/favicon.png">
    <title>
        Mimosa FleetAd
    </title>


    <link rel="canonical" href="" />

    <meta name="keywords" content="Primasys, html dashboard, html css dashboard, web dashboard, bootstrap 5 dashboard, bootstrap 5, css3 dashboard, bootstrap 5 admin, Mimosa FleetAd bootstrap 5 dashboard, frontend, responsive bootstrap 5 dashboard, material design, Mimosa FleetAd bootstrap 5 dashboard">
    <meta name="description" content="Mimosa FleetAd PRO is a beautiful Bootstrap 5 admin dashboard with a large number of components, designed to look beautiful, clean and organized. If you are looking for a tool to manage dates about your business, this dashboard is the thing for you.">

    <meta name="twitter:card" content="product">
    <meta name="twitter:site" content="@creativetim">
    <meta name="twitter:title" content="Mimosa FleetAd PRO by Primasys ">
    <meta name="twitter:description" content="Mimosa FleetAd PRO is a beautiful Bootstrap 5 admin dashboard with a large number of components, designed to look beautiful, clean and organized. If you are looking for a tool to manage dates about your business, this dashboard is the thing for you.">
    <meta name="twitter:creator" content="@creativetim">
    <meta name="twitter:image" content="//s3.amazonaws.com/creativetim_bucket/products/51/original/opt_mdp_bs5_thumbnail.jpg">

    <meta property="fb:app_id" content="655968634437471">
    <meta property="og:title" content="Mimosa FleetAd PRO by Primasys " />
    <meta property="og:type" content="article" />
    <meta property="og:url" content="https://demos.creative-tim.com/pages/dashboards/default.html" />
    <meta property="og:image" content="//s3.amazonaws.com/creativetim_bucket/products/51/original/opt_mdp_bs5_thumbnail.jpg" />
    <meta property="og:description" content="Mimosa FleetAd PRO is a beautiful Bootstrap 5 admin dashboard with a large number of components, designed to look beautiful, clean and organized. If you are looking for a tool to manage dates about your business, this dashboard is the thing for you."
    />
    <meta property="og:site_name" content="Primasys" />

    <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700,900|Roboto+Slab:400,700" />

    <link href="/assets/css/nucleo-icons.css" rel="stylesheet" />
    <link href="/assets/css/nucleo-svg.css" rel="stylesheet" />

    <script src="//kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script>

<script src="//kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script>


    <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Round" rel="stylesheet">
        <script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script src="/assets/js/core/popper.min.js"></script>
    <script src="/assets/js/core/bootstrap.min.js"></script>
    <script type="text/javascript" src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

    <link id="pagestyle" href="/assets/css/material-dashboard.min4c20.css?v=3.0.3" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="/assets/vendors/styles/icon-font.min.css">
    <link rel="stylesheet" type="text/css" href="/assets/src/plugins/datatables/css/dataTables.bootstrap4.min.css">
    <link rel="stylesheet" type="text/css" href="/assets/src/plugins/datatables/css/responsive.bootstrap4.min.css">
    <link rel="stylesheet" type="text/css" href="/assets/vendors/styles/style.css">
    <style>
        .async-hide {
            opacity: 0 !important
        }
    </style>
    <script>
        (function(a, s, y, n, c, h, i, d, e) {
            s.className += ' ' + y;
            h.start = 1 * new Date;
            h.end = i = function() {
                s.className = s.className.replace(RegExp(' ?' + y), '')
            };
            (a[n] = a[n] || []).hide = h;
            setTimeout(function() {
                i();
                h.end = null
            }, c);
            h.timeout = c;
        })(window, document.documentElement, 'async-hide', 'dataLayer', 4000, {
            'GTM-K9BGS8K': true
        });
    </script>

    <script>
        (function(i, s, o, g, r, a, m) {
            i['GoogleAnalyticsObject'] = r;
            i[r] = i[r] || function() {
                (i[r].q = i[r].q || []).push(arguments)
            }, i[r].l = 1 * new Date();
            a = s.createElement(o),
                m = s.getElementsByTagName(o)[0];
            a.async = 1;
            a.src = g;
            m.parentNode.insertBefore(a, m)
        })(window, document, 'script', '//www.google-analytics.com/analytics.js', 'ga');
        ga('create', 'UA-46172202-22', 'auto', {
            allowLinker: true
        });
        ga('set', 'anonymizeIp', true);
        ga('require', 'GTM-K9BGS8K');
        ga('require', 'displayfeatures');
        ga('require', 'linker');
        ga('linker:autoLink', ["2checkout.com", "avangate.com"]);
    </script>


    <script>
        (function(w, d, s, l, i) {
            w[l] = w[l] || [];
            w[l].push({
                'gtm.start': new Date().getTime(),
                event: 'gtm.js'
            });
            var f = d.getElementsByTagName(s)[0],
                j = d.createElement(s),
                dl = l != 'dataLayer' ? '&l=' + l : '';
            j.async = true;
            j.src =
                '//www.googletagmanager.com/gtm5445.html?id=' + i + dl;
            f.parentNode.insertBefore(j, f);
        })(window, document, 'script', 'dataLayer', 'GTM-NKDMSK6');
    </script>

</head>

<body class="g-sidenav-show  bg-gray-200">
     <form id="form1" runat="server">

    <noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-NKDMSK6" height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>

    <aside class="sidenav navbar navbar-vertical navbar-expand-xs border-0 border-radius-xl my-3 fixed-start ms-3   bg-gradient-success" id="sidenav-main">
        <div class="sidenav-header">
            <i class="fas fa-times p-3 cursor-pointer text-white opacity-5 position-absolute end-0 top-0 d-none d-xl-none" aria-hidden="true" id="iconSidenav"></i>
            <a class="navbar-brand m-0" href="https://demos.creative-tim.com/pages/dashboards/analytics.html" target="_blank">
                <img src="/assets/img/mimosa.jpg" class="navbar-brand-img h-100" alt="main_logo">
                <span class="ms-1 font-weight-bold text-white">Mimosa FleetAd</span>
            </a>
        </div>
        <hr class="horizontal light mt-0 mb-2">
        <div class="collapse navbar-collapse  w-auto h-auto" id="sidenav-collapse-main">
            <ul class="navbar-nav">
                <li class="nav-item mb-2 mt-0">
                    <a data-bs-toggle="collapse" href="#ProfileNav" class="nav-link text-white" aria-controls="ProfileNav" role="button" aria-expanded="false">
                        <img src="/assets/img/team-3.jpg" class="avatar">
                        <span class="nav-link-text ms-2 ps-1">Logged User</span>
                    </a>
                    <div class="collapse" id="ProfileNav" style="">
                        <ul class="nav ">
                            <li class="nav-item">
                                <a class="nav-link text-white" href="https://demos.creative-tim.com/pages/pages/profile/overview.html">
                                    <span class="sidenav-mini-icon"> MP </span>
                                    <span class="sidenav-normal  ms-3  ps-1"> My Profile </span>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link text-white " href="https://demos.creative-tim.com/pages/pages/account/settings.html">
                                    <span class="sidenav-mini-icon"> S </span>
                                    <span class="sidenav-normal  ms-3  ps-1"> Settings </span>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link text-white " href="https://demos.creative-tim.com/pages/authentication/signin/basic.html">
                                    <span class="sidenav-mini-icon"> L </span>
                                    <span class="sidenav-normal  ms-3  ps-1"> Logout </span>
                                </a>
                            </li>
                        </ul>
                    </div>
                </li>
                <hr class="horizontal light mt-0">
                <li class="nav-item">
                    <a data-bs-toggle="collapse" href="#dashboardsExamples" class="nav-link text-white " aria-controls="dashboardsExamples" role="button" aria-expanded="false">
                        <i class="material-icons-round opacity-10">dashboard</i>
                        <span class="nav-link-text ms-2 ps-1">Dashboards</span>
                    </a>
                    <div class="collapse " id="dashboardsExamples">
                        <ul class="nav ">
                            <li class="nav-item ">
                                <a class="nav-link text-white " href="https://demos.creative-tim.com/pages/dashboards/analytics.html">
                                    <span class="sidenav-mini-icon"> A </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Analytics </span>
                                </a>
                            </li>
                            <li class="nav-item ">
                                <a class="nav-link text-white " href="https://demos.creative-tim.com/pages/dashboards/discover.html">
                                    <span class="sidenav-mini-icon"> D </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Discover </span>
                                </a>
                            </li>
                            <li class="nav-item ">
                                <a class="nav-link text-white " href="https://demos.creative-tim.com/pages/dashboards/sales.html">
                                    <span class="sidenav-mini-icon"> S </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Sales </span>
                                </a>
                            </li>
                            <li class="nav-item ">
                                <a class="nav-link text-white " href="https://demos.creative-tim.com/pages/dashboards/automotive.html">
                                    <span class="sidenav-mini-icon"> A </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Automotive </span>
                                </a>
                            </li>
                            <li class="nav-item ">
                                <a class="nav-link text-white " href="https://demos.creative-tim.com/pages/dashboards/smart-home.html">
                                    <span class="sidenav-mini-icon"> S </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Smart Home </span>
                                </a>
                            </li>
                        </ul>
                    </div>
                </li>
                <li class="nav-item mt-3">
                    <h6 class="ps-4  ms-2 text-uppercase text-xs font-weight-bolder text-white">PAGES</h6>
                </li>
                <li class="nav-item">
                    <a data-bs-toggle="collapse" href="#pagesExamples" class="nav-link text-white " aria-controls="pagesExamples" role="button" aria-expanded="false">
                        <i class="material-icons-round {% if page.brand == 'RTL' %}ms-2{% else %} me-2{% endif %}">image</i>
                        <span class="nav-link-text ms-2 ps-1">Pages</span>
                    </a>
                    <div class="collapse " id="pagesExamples">
                        <ul class="nav ">
                            <li class="nav-item ">
                                <a class="nav-link text-white " data-bs-toggle="collapse" aria-expanded="false" href="#profileExample">
                                    <span class="sidenav-mini-icon"> P </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Profile <b class="caret"></b></span>
                                </a>
                                <div class="collapse " id="profileExample">
                                    <ul class="nav nav-sm flex-column">
                                        <li class="nav-item">
                                            <a class="nav-link text-white " href="https://demos.creative-tim.com/pages/pages/profile/overview.html">
                                                <span class="sidenav-mini-icon"> P </span>
                                                <span class="sidenav-normal  ms-2  ps-1"> Profile Overview </span>
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link text-white " href="https://demos.creative-tim.com/pages/pages/profile/projects.html">
                                                <span class="sidenav-mini-icon"> A </span>
                                                <span class="sidenav-normal  ms-2  ps-1"> All Projects </span>
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link text-white " href="https://demos.creative-tim.com/pages/pages/profile/messages.html">
                                                <span class="sidenav-mini-icon"> M </span>
                                                <span class="sidenav-normal  ms-2  ps-1"> Messages </span>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                            <li class="nav-item ">
                                <a class="nav-link text-white " data-bs-toggle="collapse" aria-expanded="false" href="#usersExample">
                                    <span class="sidenav-mini-icon"> U </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Users <b class="caret"></b></span>
                                </a>
                                <div class="collapse " id="usersExample">
                                    <ul class="nav nav-sm flex-column">
                                        <li class="nav-item">
                                            <a class="nav-link text-white " href="https://demos.creative-tim.com/pages/pages/users/reports.html">
                                                <span class="sidenav-mini-icon"> R </span>
                                                <span class="sidenav-normal  ms-2  ps-1"> Reports </span>
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link text-white " href="https://demos.creative-tim.com/pages/pages/users/new-user.html">
                                                <span class="sidenav-mini-icon"> N </span>
                                                <span class="sidenav-normal  ms-2  ps-1"> New User </span>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                            <li class="nav-item ">
                                <a class="nav-link text-white " data-bs-toggle="collapse" aria-expanded="false" href="#accountExample">
                                    <span class="sidenav-mini-icon"> A </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Account <b class="caret"></b></span>
                                </a>
                                <div class="collapse " id="accountExample">
                                    <ul class="nav nav-sm flex-column">
                                        <li class="nav-item">
                                            <a class="nav-link text-white " href="https://demos.creative-tim.com/pages/pages/account/settings.html">
                                                <span class="sidenav-mini-icon"> S </span>
                                                <span class="sidenav-normal  ms-2  ps-1"> Settings </span>
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link text-white " href="https://demos.creative-tim.com/pages/pages/account/billing.html">
                                                <span class="sidenav-mini-icon"> B </span>
                                                <span class="sidenav-normal  ms-2  ps-1"> Billing </span>
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link text-white " href="https://demos.creative-tim.com/pages/pages/account/invoice.html">
                                                <span class="sidenav-mini-icon"> I </span>
                                                <span class="sidenav-normal  ms-2  ps-1"> Invoice </span>
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link text-white " href="https://demos.creative-tim.com/pages/pages/account/security.html">
                                                <span class="sidenav-mini-icon"> S </span>
                                                <span class="sidenav-normal  ms-2  ps-1"> Security </span>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                            <li class="nav-item ">
                                <a class="nav-link text-white " data-bs-toggle="collapse" aria-expanded="false" href="#projectsExample">
                                    <span class="sidenav-mini-icon"> P </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Projects <b class="caret"></b></span>
                                </a>
                                <div class="collapse " id="projectsExample">
                                    <ul class="nav nav-sm flex-column">
                                        <li class="nav-item">
                                            <a class="nav-link text-white " href="https://demos.creative-tim.com/pages/pages/projects/general.html">
                                                <span class="sidenav-mini-icon"> G </span>
                                                <span class="sidenav-normal  ms-2  ps-1"> General </span>
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link text-white " href="https://demos.creative-tim.com/pages/pages/projects/timeline.html">
                                                <span class="sidenav-mini-icon"> T </span>
                                                <span class="sidenav-normal  ms-2  ps-1"> Timeline </span>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                            <li class="nav-item ">
                                <a class="nav-link text-white " data-bs-toggle="collapse" aria-expanded="false" href="#vrExamples">
                                    <span class="sidenav-mini-icon"> V </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Virtual Reality <b class="caret"></b></span>
                                </a>
                                <div class="collapse " id="vrExamples">
                                    <ul class="nav nav-sm flex-column">
                                        <li class="nav-item">
                                            <a class="nav-link text-white " href="https://demos.creative-tim.com/pages/pages/vr/vr-default.html">
                                                <span class="sidenav-mini-icon"> V </span>
                                                <span class="sidenav-normal  ms-2  ps-1"> VR Default </span>
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link text-white " href="https://demos.creative-tim.com/pages/pages/vr/vr-info.html">
                                                <span class="sidenav-mini-icon"> V </span>
                                                <span class="sidenav-normal  ms-2  ps-1"> VR Info </span>
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link text-white " href="https://demos.creative-tim.com/pages/pages/projects/new-project.html">
                                                <span class="sidenav-mini-icon"> N </span>
                                                <span class="sidenav-normal  ms-2  ps-1"> New Project </span>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                            <li class="nav-item ">
                                <a class="nav-link text-white " href="https://demos.creative-tim.com/pages/pages/pricing-page.html">
                                    <span class="sidenav-mini-icon"> P </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Pricing Page </span>
                                </a>
                            </li>
                            <li class="nav-item ">
                                <a class="nav-link text-white " href="https://demos.creative-tim.com/pages/pages/rtl-page.html">
                                    <span class="sidenav-mini-icon"> R </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> RTL </span>
                                </a>
                            </li>
                            <li class="nav-item ">
                                <a class="nav-link text-white " href="https://demos.creative-tim.com/pages/pages/widgets.html">
                                    <span class="sidenav-mini-icon"> W </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Widgets </span>
                                </a>
                            </li>
                            <li class="nav-item ">
                                <a class="nav-link text-white " href="https://demos.creative-tim.com/pages/pages/charts.html">
                                    <span class="sidenav-mini-icon"> C </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Charts </span>
                                </a>
                            </li>
                            <li class="nav-item ">
                                <a class="nav-link text-white " href="https://demos.creative-tim.com/pages/pages/sweet-alerts.html">
                                    <span class="sidenav-mini-icon"> S </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Sweet Alerts </span>
                                </a>
                            </li>
                            <li class="nav-item ">
                                <a class="nav-link text-white " href="https://demos.creative-tim.com/pages/pages/notifications.html">
                                    <span class="sidenav-mini-icon"> N </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Notifications </span>
                                </a>
                            </li>
                        </ul>
                    </div>
                </li>
                <li class="nav-item">
                    <a data-bs-toggle="collapse" href="#applicationsExamples" class="nav-link text-white active" aria-controls="applicationsExamples" role="button" aria-expanded="false">
                        <i class="material-icons-round {% if page.brand == 'RTL' %}ms-2{% else %} me-2{% endif %}">apps</i>
                        <span class="nav-link-text ms-2 ps-1">Applications</span>
                    </a>
                    <div class="collapse  show " id="applicationsExamples">
                        <ul class="nav ">
                            <li class="nav-item ">
                                <a class="nav-link text-white " href="crm.html">
                                    <span class="sidenav-mini-icon"> C </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> CRM </span>
                                </a>
                            </li>
                            <li class="nav-item ">
                                <a class="nav-link text-white " href="kanban.html">
                                    <span class="sidenav-mini-icon"> K </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Kanban </span>
                                </a>
                            </li>
                            <li class="nav-item ">
                                <a class="nav-link text-white " href="wizard.html">
                                    <span class="sidenav-mini-icon"> W </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Wizard </span>
                                </a>
                            </li>
                            <li class="nav-item active">
                                <a class="nav-link text-white active" href="datatables.html">
                                    <span class="sidenav-mini-icon"> D </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> DataTables </span>
                                </a>
                            </li>
                            <li class="nav-item ">
                                <a class="nav-link text-white " href="calendar.html">
                                    <span class="sidenav-mini-icon"> C </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Calendar </span>
                                </a>
                            </li>
                            <li class="nav-item ">
                                <a class="nav-link text-white " href="stats.html">
                                    <span class="sidenav-mini-icon"> S </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Stats </span>
                                </a>
                            </li>
                        </ul>
                    </div>
                </li>
                <li class="nav-item">
                    <a data-bs-toggle="collapse" href="#ecommerceExamples" class="nav-link text-white " aria-controls="ecommerceExamples" role="button" aria-expanded="false">
                        <i class="material-icons-round {% if page.brand == 'RTL' %}ms-2{% else %} me-2{% endif %}">shopping_basket</i>
                        <span class="nav-link-text ms-2 ps-1">Ecommerce</span>
                    </a>
                    <div class="collapse " id="ecommerceExamples">
                        <ul class="nav ">
                            <li class="nav-item ">
                                <a class="nav-link text-white " data-bs-toggle="collapse" aria-expanded="false" href="#productsExample">
                                    <span class="sidenav-mini-icon"> P </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Products <b class="caret"></b></span>
                                </a>
                                <div class="collapse " id="productsExample">
                                    <ul class="nav nav-sm flex-column">
                                        <li class="nav-item">
                                            <a class="nav-link text-white " href="https://demos.creative-tim.com/pages/ecommerce/products/new-product.html">
                                                <span class="sidenav-mini-icon"> N </span>
                                                <span class="sidenav-normal  ms-2  ps-1"> New Product </span>
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link text-white " href="https://demos.creative-tim.com/pages/ecommerce/products/edit-product.html">
                                                <span class="sidenav-mini-icon"> E </span>
                                                <span class="sidenav-normal  ms-2  ps-1"> Edit Product </span>
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link text-white " href="https://demos.creative-tim.com/pages/ecommerce/products/product-page.html">
                                                <span class="sidenav-mini-icon"> P </span>
                                                <span class="sidenav-normal  ms-2  ps-1"> Product Page </span>
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link text-white " href="https://demos.creative-tim.com/pages/ecommerce/products/products-list.html">
                                                <span class="sidenav-mini-icon"> P </span>
                                                <span class="sidenav-normal  ms-2  ps-1"> Products List </span>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                            <li class="nav-item ">
                                <a class="nav-link text-white " data-bs-toggle="collapse" aria-expanded="false" href="#ordersExample">
                                    <span class="sidenav-mini-icon"> O </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Orders <b class="caret"></b></span>
                                </a>
                                <div class="collapse " id="ordersExample">
                                    <ul class="nav nav-sm flex-column">
                                        <li class="nav-item">
                                            <a class="nav-link text-white " href="https://demos.creative-tim.com/pages/ecommerce/orders/list.html">
                                                <span class="sidenav-mini-icon"> O </span>
                                                <span class="sidenav-normal  ms-2  ps-1"> Order List </span>
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link text-white " href="https://demos.creative-tim.com/pages/ecommerce/orders/details.html">
                                                <span class="sidenav-mini-icon"> O </span>
                                                <span class="sidenav-normal  ms-2  ps-1"> Order Details </span>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                            <li class="nav-item ">
                                <a class="nav-link text-white " href="https://demos.creative-tim.com/pages/ecommerce/referral.html">
                                    <span class="sidenav-mini-icon"> R </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Referral </span>
                                </a>
                            </li>
                        </ul>
                    </div>
                </li>
                <li class="nav-item">
                    <a data-bs-toggle="collapse" href="#authExamples" class="nav-link text-white " aria-controls="authExamples" role="button" aria-expanded="false">
                        <i class="material-icons-round {% if page.brand == 'RTL' %}ms-2{% else %} me-2{% endif %}">content_paste</i>
                        <span class="nav-link-text ms-2 ps-1">Authentication</span>
                    </a>
                    <div class="collapse " id="authExamples">
                        <ul class="nav ">
                            <li class="nav-item ">
                                <a class="nav-link text-white " data-bs-toggle="collapse" aria-expanded="false" href="#signinExample">
                                    <span class="sidenav-mini-icon"> S </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Sign In <b class="caret"></b></span>
                                </a>
                                <div class="collapse " id="signinExample">
                                    <ul class="nav nav-sm flex-column">
                                        <li class="nav-item">
                                            <a class="nav-link text-white " href="https://demos.creative-tim.com/pages/authentication/signin/basic.html">
                                                <span class="sidenav-mini-icon"> B </span>
                                                <span class="sidenav-normal  ms-2  ps-1"> Basic </span>
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link text-white " href="https://demos.creative-tim.com/pages/authentication/signin/cover.html">
                                                <span class="sidenav-mini-icon"> C </span>
                                                <span class="sidenav-normal  ms-2  ps-1"> Cover </span>
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link text-white " href="https://demos.creative-tim.com/pages/authentication/signin/illustration.html">
                                                <span class="sidenav-mini-icon"> I </span>
                                                <span class="sidenav-normal  ms-2  ps-1"> Illustration </span>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                            <li class="nav-item ">
                                <a class="nav-link text-white " data-bs-toggle="collapse" aria-expanded="false" href="#signupExample">
                                    <span class="sidenav-mini-icon"> S </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Sign Up <b class="caret"></b></span>
                                </a>
                                <div class="collapse " id="signupExample">
                                    <ul class="nav nav-sm flex-column">
                                        <li class="nav-item">
                                            <a class="nav-link text-white " href="https://demos.creative-tim.com/pages/authentication/signup/basic.html">
                                                <span class="sidenav-mini-icon"> B </span>
                                                <span class="sidenav-normal  ms-2  ps-1"> Basic </span>
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link text-white " href="https://demos.creative-tim.com/pages/authentication/signup/cover.html">
                                                <span class="sidenav-mini-icon"> C </span>
                                                <span class="sidenav-normal  ms-2  ps-1"> Cover </span>
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link text-white " href="https://demos.creative-tim.com/pages/authentication/signup/illustration.html">
                                                <span class="sidenav-mini-icon"> I </span>
                                                <span class="sidenav-normal  ms-2  ps-1"> Illustration </span>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                            <li class="nav-item ">
                                <a class="nav-link text-white " data-bs-toggle="collapse" aria-expanded="false" href="#resetExample">
                                    <span class="sidenav-mini-icon"> R </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Reset Password <b class="caret"></b></span>
                                </a>
                                <div class="collapse " id="resetExample">
                                    <ul class="nav nav-sm flex-column">
                                        <li class="nav-item">
                                            <a class="nav-link text-white " href="https://demos.creative-tim.com/pages/authentication/reset/basic.html">
                                                <span class="sidenav-mini-icon"> B </span>
                                                <span class="sidenav-normal  ms-2  ps-1"> Basic </span>
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link text-white " href="https://demos.creative-tim.com/pages/authentication/reset/cover.html">
                                                <span class="sidenav-mini-icon"> C </span>
                                                <span class="sidenav-normal  ms-2  ps-1"> Cover </span>
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link text-white " href="https://demos.creative-tim.com/pages/authentication/reset/illustration.html">
                                                <span class="sidenav-mini-icon"> I </span>
                                                <span class="sidenav-normal  ms-2  ps-1"> Illustration </span>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                            <li class="nav-item ">
                                <a class="nav-link text-white " data-bs-toggle="collapse" aria-expanded="false" href="#lockExample">
                                    <span class="sidenav-mini-icon"> L </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Lock <b class="caret"></b></span>
                                </a>
                                <div class="collapse " id="lockExample">
                                    <ul class="nav nav-sm flex-column">
                                        <li class="nav-item">
                                            <a class="nav-link text-white " href="https://demos.creative-tim.com/pages/authentication/lock/basic.html">
                                                <span class="sidenav-mini-icon"> B </span>
                                                <span class="sidenav-normal  ms-2  ps-1"> Basic </span>
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link text-white " href="https://demos.creative-tim.com/pages/authentication/lock/cover.html">
                                                <span class="sidenav-mini-icon"> C </span>
                                                <span class="sidenav-normal  ms-2  ps-1"> Cover </span>
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link text-white " href="https://demos.creative-tim.com/pages/authentication/lock/illustration.html">
                                                <span class="sidenav-mini-icon"> I </span>
                                                <span class="sidenav-normal  ms-2  ps-1"> Illustration </span>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                            <li class="nav-item ">
                                <a class="nav-link text-white " data-bs-toggle="collapse" aria-expanded="false" href="#StepExample">
                                    <span class="sidenav-mini-icon"> 2 </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> 2-Step Verification <b class="caret"></b></span>
                                </a>
                                <div class="collapse " id="StepExample">
                                    <ul class="nav nav-sm flex-column">
                                        <li class="nav-item">
                                            <a class="nav-link text-white " href="https://demos.creative-tim.com/pages/authentication/verification/basic.html">
                                                <span class="sidenav-mini-icon"> B </span>
                                                <span class="sidenav-normal  ms-2  ps-1"> Basic </span>
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link text-white " href="https://demos.creative-tim.com/pages/authentication/verification/cover.html">
                                                <span class="sidenav-mini-icon"> C </span>
                                                <span class="sidenav-normal  ms-2  ps-1"> Cover </span>
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link text-white " href="https://demos.creative-tim.com/pages/authentication/verification/illustration.html">
                                                <span class="sidenav-mini-icon"> I </span>
                                                <span class="sidenav-normal  ms-2  ps-1"> Illustration </span>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                            <li class="nav-item ">
                                <a class="nav-link text-white " data-bs-toggle="collapse" aria-expanded="false" href="#errorExample">
                                    <span class="sidenav-mini-icon"> E </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Error <b class="caret"></b></span>
                                </a>
                                <div class="collapse " id="errorExample">
                                    <ul class="nav nav-sm flex-column">
                                        <li class="nav-item">
                                            <a class="nav-link text-white " href="https://demos.creative-tim.com/pages/authentication/error/404.html">
                                                <span class="sidenav-mini-icon"> E </span>
                                                <span class="sidenav-normal  ms-2  ps-1"> Error 404 </span>
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link text-white " href="https://demos.creative-tim.com/pages/authentication/error/500.html">
                                                <span class="sidenav-mini-icon"> E </span>
                                                <span class="sidenav-normal  ms-2  ps-1"> Error 500 </span>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                        </ul>
                    </div>
                </li>
                <li class="nav-item">
                    <hr class="horizontal light" />
                    <h6 class="ps-4  ms-2 text-uppercase text-xs font-weight-bolder text-white">DOCS</h6>
                </li>
                <li class="nav-item">
                    <a data-bs-toggle="collapse" href="#basicExamples" class="nav-link text-white " aria-controls="basicExamples" role="button" aria-expanded="false">
                        <i class="material-icons-round {% if page.brand == 'RTL' %}ms-2{% else %} me-2{% endif %}">upcoming</i>
                        <span class="nav-link-text ms-2 ps-1">Basic</span>
                    </a>
                    <div class="collapse " id="basicExamples">
                        <ul class="nav ">
                            <li class="nav-item ">
                                <a class="nav-link text-white " data-bs-toggle="collapse" aria-expanded="false" href="#gettingStartedExample">
                                    <span class="sidenav-mini-icon"> G </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Getting Started <b class="caret"></b></span>
                                </a>
                                <div class="collapse " id="gettingStartedExample">
                                    <ul class="nav nav-sm flex-column">
                                        <li class="nav-item">
                                            <a class="nav-link text-white " href="https://www.creative-tim.com/learning-lab/bootstrap/quick-start/material-dashboard" target="_blank">
                                                <span class="sidenav-mini-icon"> Q </span>
                                                <span class="sidenav-normal  ms-2  ps-1"> Quick Start </span>
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link text-white " href="https://www.creative-tim.com/learning-lab/bootstrap/license/material-dashboard" target="_blank">
                                                <span class="sidenav-mini-icon"> L </span>
                                                <span class="sidenav-normal  ms-2  ps-1"> License </span>
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link text-white " href="https://www.creative-tim.com/learning-lab/bootstrap/overview/material-dashboard" target="_blank">
                                                <span class="sidenav-mini-icon"> C </span>
                                                <span class="sidenav-normal  ms-2  ps-1"> Contents </span>
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link text-white " href="https://www.creative-tim.com/learning-lab/bootstrap/build-tools/material-dashboard" target="_blank">
                                                <span class="sidenav-mini-icon"> B </span>
                                                <span class="sidenav-normal  ms-2  ps-1"> Build Tools </span>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                            <li class="nav-item ">
                                <a class="nav-link text-white " data-bs-toggle="collapse" aria-expanded="false" href="#foundationExample">
                                    <span class="sidenav-mini-icon"> F </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Foundation <b class="caret"></b></span>
                                </a>
                                <div class="collapse " id="foundationExample">
                                    <ul class="nav nav-sm flex-column">
                                        <li class="nav-item">
                                            <a class="nav-link text-white " href="https://www.creative-tim.com/learning-lab/bootstrap/colors/material-dashboard" target="_blank">
                                                <span class="sidenav-mini-icon"> C </span>
                                                <span class="sidenav-normal  ms-2  ps-1"> Colors </span>
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link text-white " href="https://www.creative-tim.com/learning-lab/bootstrap/grid/material-dashboard" target="_blank">
                                                <span class="sidenav-mini-icon"> G </span>
                                                <span class="sidenav-normal  ms-2  ps-1"> Grid </span>
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link text-white " href="https://www.creative-tim.com/learning-lab/bootstrap/typography/material-dashboard" target="_blank">
                                                <span class="sidenav-mini-icon"> T </span>
                                                <span class="sidenav-normal  ms-2  ps-1"> Typography </span>
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link text-white " href="https://www.creative-tim.com/learning-lab/bootstrap/icons/material-dashboard" target="_blank">
                                                <span class="sidenav-mini-icon"> I </span>
                                                <span class="sidenav-normal  ms-2  ps-1"> Icons </span>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                        </ul>
                    </div>
                </li>
                <li class="nav-item">
                    <a data-bs-toggle="collapse" href="#componentsExamples" class="nav-link text-white " aria-controls="componentsExamples" role="button" aria-expanded="false">
                        <i class="material-icons-round {% if page.brand == 'RTL' %}ms-2{% else %} me-2{% endif %}">view_in_ar</i>
                        <span class="nav-link-text ms-2 ps-1">Components</span>
                    </a>
                    <div class="collapse " id="componentsExamples">
                        <ul class="nav ">
                            <li class="nav-item ">
                                <a class="nav-link text-white " href="https://www.creative-tim.com/learning-lab/bootstrap/alerts/material-dashboard" target="_blank">
                                    <span class="sidenav-mini-icon"> A </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Alerts </span>
                                </a>
                            </li>
                            <li class="nav-item ">
                                <a class="nav-link text-white " href="https://www.creative-tim.com/learning-lab/bootstrap/badge/material-dashboard" target="_blank">
                                    <span class="sidenav-mini-icon"> B </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Badge </span>
                                </a>
                            </li>
                            <li class="nav-item ">
                                <a class="nav-link text-white " href="https://www.creative-tim.com/learning-lab/bootstrap/buttons/material-dashboard" target="_blank">
                                    <span class="sidenav-mini-icon"> B </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Buttons </span>
                                </a>
                            </li>
                            <li class="nav-item ">
                                <a class="nav-link text-white " href="https://www.creative-tim.com/learning-lab/bootstrap/cards/material-dashboard" target="_blank">
                                    <span class="sidenav-mini-icon"> C </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Card </span>
                                </a>
                            </li>
                            <li class="nav-item ">
                                <a class="nav-link text-white " href="https://www.creative-tim.com/learning-lab/bootstrap/carousel/material-dashboard" target="_blank">
                                    <span class="sidenav-mini-icon"> C </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Carousel </span>
                                </a>
                            </li>
                            <li class="nav-item ">
                                <a class="nav-link text-white " href="https://www.creative-tim.com/learning-lab/bootstrap/collapse/material-dashboard" target="_blank">
                                    <span class="sidenav-mini-icon"> C </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Collapse </span>
                                </a>
                            </li>
                            <li class="nav-item ">
                                <a class="nav-link text-white " href="https://www.creative-tim.com/learning-lab/bootstrap/dropdowns/material-dashboard" target="_blank">
                                    <span class="sidenav-mini-icon"> D </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Dropdowns </span>
                                </a>
                            </li>
                            <li class="nav-item ">
                                <a class="nav-link text-white " href="https://www.creative-tim.com/learning-lab/bootstrap/forms/material-dashboard" target="_blank">
                                    <span class="sidenav-mini-icon"> F </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Forms </span>
                                </a>
                            </li>
                            <li class="nav-item ">
                                <a class="nav-link text-white " href="https://www.creative-tim.com/learning-lab/bootstrap/modal/material-dashboard" target="_blank">
                                    <span class="sidenav-mini-icon"> M </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Modal </span>
                                </a>
                            </li>
                            <li class="nav-item ">
                                <a class="nav-link text-white " href="https://www.creative-tim.com/learning-lab/bootstrap/navs/material-dashboard" target="_blank">
                                    <span class="sidenav-mini-icon"> N </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Navs </span>
                                </a>
                            </li>
                            <li class="nav-item ">
                                <a class="nav-link text-white " href="https://www.creative-tim.com/learning-lab/bootstrap/navbar/material-dashboard" target="_blank">
                                    <span class="sidenav-mini-icon"> N </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Navbar </span>
                                </a>
                            </li>
                            <li class="nav-item ">
                                <a class="nav-link text-white " href="https://www.creative-tim.com/learning-lab/bootstrap/pagination/material-dashboard" target="_blank">
                                    <span class="sidenav-mini-icon"> P </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Pagination </span>
                                </a>
                            </li>
                            <li class="nav-item ">
                                <a class="nav-link text-white " href="https://www.creative-tim.com/learning-lab/bootstrap/popovers/material-dashboard" target="_blank">
                                    <span class="sidenav-mini-icon"> P </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Popovers </span>
                                </a>
                            </li>
                            <li class="nav-item ">
                                <a class="nav-link text-white " href="https://www.creative-tim.com/learning-lab/bootstrap/progress/material-dashboard" target="_blank">
                                    <span class="sidenav-mini-icon"> P </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Progress </span>
                                </a>
                            </li>
                            <li class="nav-item ">
                                <a class="nav-link text-white " href="https://www.creative-tim.com/learning-lab/bootstrap/spinners/material-dashboard" target="_blank">
                                    <span class="sidenav-mini-icon"> S </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Spinners </span>
                                </a>
                            </li>
                            <li class="nav-item ">
                                <a class="nav-link text-white " href="https://www.creative-tim.com/learning-lab/bootstrap/tables/material-dashboard" target="_blank">
                                    <span class="sidenav-mini-icon"> T </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Tables </span>
                                </a>
                            </li>
                            <li class="nav-item ">
                                <a class="nav-link text-white " href="https://www.creative-tim.com/learning-lab/bootstrap/tooltips/material-dashboard" target="_blank">
                                    <span class="sidenav-mini-icon"> T </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Tooltips </span>
                                </a>
                            </li>
                        </ul>
                    </div>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="" target="_blank">
                        <i class="material-icons-round {% if page.brand == 'RTL' %}ms-2{% else %} me-2{% endif %}">receipt_long</i>
                        <span class="nav-link-text ms-2 ps-1">Changelog</span>
                    </a>
                </li>
            </ul>
        </div>
    </aside>
    <main class="main-content position-relative max-height-vh-100 h-100 border-radius-lg ">

        <nav class="navbar navbar-main navbar-expand-lg position-sticky mt-4 top-1 px-0 mx-4 shadow-none border-radius-xl z-index-sticky" id="navbarBlur" data-scroll="true">
            <div class="container-fluid py-1 px-3">
                <nav aria-label="breadcrumb px-3">
                    <ol class="breadcrumb bg-transparent mb-0 pb-0 pt-1 px-0 me-sm-6 me-5">
                    </ol>
                    <h6 class="font-weight-bolder mb-0 px-3">Abnormal Permits</h6>
                </nav>
                <div class="sidenav-toggler sidenav-toggler-inner d-xl-block d-none ">
                    <a href="javascript:;" class="nav-link text-body p-0">
                        <div class="sidenav-toggler-inner">
                            <i class="sidenav-toggler-line"></i>
                            <i class="sidenav-toggler-line"></i>
                            <i class="sidenav-toggler-line"></i>
                        </div>
                    </a>
                </div>
                <div class="collapse navbar-collapse mt-sm-0 mt-2 me-md-0 me-sm-4" id="navbar">
                    <div class="ms-md-auto pe-md-3 d-flex align-items-center">
                        <div class="input-group input-group-outline">
                            <label class="form-label">Search here</label>
                            <input type="text" class="form-control">
                        </div>
                    </div>
                    <ul class="navbar-nav  justify-content-end">
                        <li class="nav-item">
                            <a href="" class="nav-link text-body p-0 position-relative" target="_blank">
                                <i class="material-icons me-sm-1">
account_circle
</i>
                            </a>
                        </li>
                        <li class="nav-item d-xl-none ps-3 d-flex align-items-center">
                            <a href="javascript:;" class="nav-link text-body p-0" id="iconNavbarSidenav">
                                <div class="sidenav-toggler-inner">
                                    <i class="sidenav-toggler-line"></i>
                                    <i class="sidenav-toggler-line"></i>
                                    <i class="sidenav-toggler-line"></i>
                                </div>
                            </a>
                        </li>
                        <li class="nav-item px-3">
                            <a href="javascript:;" class="nav-link text-body p-0">
                                <i class="material-icons fixed-plugin-button-nav cursor-pointer">
settings
</i>
                            </a>
                        </li>
                        <li class="nav-item dropdown pe-2">
                            <a href="javascript:;" class="nav-link text-body p-0 position-relative" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="material-icons cursor-pointer">
notifications
</i>
                                <span class="position-absolute top-5 start-100 translate-middle badge rounded-pill bg-danger border border-white small py-1 px-2">
<span class="small">11</span>
                                <span class="visually-hidden">unread notifications</span>
                                </span>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end p-2 me-sm-n4" aria-labelledby="dropdownMenuButton">
                                <li class="mb-2">
                                    <a class="dropdown-item border-radius-md" href="javascript:;">
                                        <div class="d-flex align-items-center py-1">
                                            <span class="material-icons">email</span>
                                            <div class="ms-2">
                                                <h6 class="text-sm font-weight-normal my-auto">
                                                    Check new messages
                                                </h6>
                                            </div>
                                        </div>
                                    </a>
                                </li>
                                <li class="mb-2">
                                    <a class="dropdown-item border-radius-md" href="javascript:;">
                                        <div class="d-flex align-items-center py-1">
                                            <span class="material-icons">podcasts</span>
                                            <div class="ms-2">
                                                <h6 class="text-sm font-weight-normal my-auto">
                                                    Manage podcast session
                                                </h6>
                                            </div>
                                        </div>
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item border-radius-md" href="javascript:;">
                                        <div class="d-flex align-items-center py-1">
                                            <span class="material-icons">shopping_cart</span>
                                            <div class="ms-2">
                                                <h6 class="text-sm font-weight-normal my-auto">
                                                    Payment successfully completed
                                                </h6>
                                            </div>
                                        </div>
                                    </a>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="container-fluid py-4">
            <div class="row mt-4 text-center">
                <div class="col-sm-2 mt-2 text">
                    <div class="text-center">
                        <div class="col-md-6 text-center">
                            <button type="button" class="btn b-lg-block bg-gradient-warning mb-3 modal-dialog-centered mt-3 text-bold " data-bs-toggle="modal" data-bs-target="#modal-form">Add New</button>
                            <div class="modal fade" id="modal-form" tabindex="-1" role="dialog" aria-labelledby="modal-form" aria-hidden="true" >
                                <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                                    <div class="modal-content">
                                        <div class="modal-body p-0">
                                        <div class="modal-body p-0">
                                                <div class="card-header pb-0 text-left">
                                                </div>
                                                <div class="card-body">

                                                   
                                                    <div class="row">
                                                            <h5 class="mb-0">Abnormal Load Permits</h5>
                                                            <hr>
                                                            <div class="col-6">
                                                                <div class="input-group input-group-outline my-3">
                                                                    <label class="form-label">Licence Number</label>
                                                                    <asp:TextBox ID="txtLicence" runat="server" class="form-control" onfocus="focused(this)" onfocusout="defocused(this)"></asp:TextBox>
                                                                   
                                                                </div>
                                                            </div>
                                                            <div class="col-6">
                                                                 <div class="input-group input-group-dynamic my-3">
                                                                    <span class="input-group-text" id="basic-addon2">Upload File</span>
                                                                    <asp:FileUpload ID="fdfile" runat="server" class="form-control" onfocus="focused(this)" onfocusout="defocused(this)" />
                                                                
                                                                </div>
                                                            </div>
                                                        </div>
                                       
                                                            <h5 class="mb-0">Details</h5>
                                                            <hr>
                                                    <div class="row">
                                                            <div class="col-6">
                                                                <div class="input-group input-group-dynamic my-3">
                                                                    <span class="input-group-date" id="basic-addon1">Date Issued</span>
                                                                    <asp:TextBox ID="txtDateIssued" runat="server" class="form-control datepicker" onfocus="focused(this)" onfocusout="defocused(this)" TextMode="Date"></asp:TextBox>
                                                                  
                                                                </div>
                                                            </div>
                                                            <div class="col-6">
                                                                <div class="input-group input-group-dynamic my-3">
                                                                    <span class="input-group-date" id="basic-addon2">Date Expiry</span>
                                                                     <asp:TextBox ID="txtDateEx" runat="server" class="form-control datepicker" onfocus="focused(this)" onfocusout="defocused(this)" TextMode="Date"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                        </div>
                                                     </div>
                                                        <div class="row  d-flex justify-content-center">
                                                            <div class="col-12  d-flex justify-content-center">
                                                                <div class="input-group input-group-dynamic  my-3  d-flex justify-content-center">
                                                                    <span class="input-group-date" id="basic-addon2">Comment</span>
                                                                    <asp:TextBox ID="txtComment" runat="server" class=" my-3 form-control" onfocus="focused(this)" onfocusout="defocused(this)" TextMode="MultiLine"></asp:TextBox>
                                              
                                                                </div>
                                                            </div>

              
                                                        </div>
                                                          <div class="row text-center d-flex justify-content-center ">
                                                            <div class="col-12 text-center d-flex justify-content-center ">
                                                                <div class="input-group input-group-outline my-3 text-center d-flex justify-content-center ">
                                                                        <div class="  my-3 table-responsive">
           <asp:GridView ID="GridView1" runat="server" CssClass="table hover data-table-export nowrap" AutoGenerateColumns="false">
        <Columns>
            <asp:TemplateField HeaderText="SELECT">
            <ItemTemplate>
                <asp:CheckBox ID="chkRow" runat="server" />
            </ItemTemplate>
        </asp:TemplateField>
            <asp:BoundField DataField="OBJECTID" HeaderText="Fleet ID" />
            <asp:BoundField DataField="PRODUCT_NAME_MAKE" HeaderText=" Make " />
            <asp:BoundField DataField="MODEL" HeaderText="Model" />
            <asp:BoundField DataField="NAME" HeaderText="Name" />
        </Columns>
    </asp:GridView>
 </div>

                                                                </div>
                                                            </div>

              
                                                        </div>
                                                        <div class="row">
  
                                                            <div class="col-2">
                                                                <div class="input-group input-group-outline-my-3">
                                                                    <div class="text-center">
                                                                       <asp:Button ID="cmdSave" runat="server" Text="Save" class="btn btn-success mt-3" OnClick="Bulk_Insert" AutoPostBack="True"  />
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                          
                                                
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row mt-4">
            <div class="col-12">
                <div class="card">
                    <div class="card-header">
                        <h5 class="mb-0">Abornaml Load Permits</h5>
                        <p class="text-sm mb-0">
                           Abornaml Load Permits List
                        </p>
                    </div>

                    <div class="table-responsive">
                         <asp:GridView ID="gvCustomers" runat="server" CssClass="table hover data-table-export nowrap" AutoGenerateColumns="false">
        <Columns>
            <asp:BoundField DataField="FLEETID" HeaderText="Fleet ID" />
            <asp:BoundField DataField="DATEISSUED" HeaderText="Date Issued" />
            <asp:BoundField DataField="DATEEXPIRY" HeaderText="Date Expiry" />
            <asp:BoundField DataField="COMMENTS" HeaderText="Comments" />
           <asp:BoundField DataField="FILE" HeaderText="File Name" /> 
                <asp:TemplateField HeaderText="DOWNLOAD">  
                    <ItemTemplate>  
                                 <asp:LinkButton ID="lnkDownload" runat="server" Text="Download" 
                    CommandArgument='<%# Eval("ID") %>'></asp:LinkButton> 
                    </ItemTemplate>  
                </asp:TemplateField> 
        </Columns>
    </asp:GridView>
 </div>
                </div>
            </div>
        </div>
        <footer class="footer py-4  ">
            <div class="container-fluid">
                <div class="row align-items-center justify-content-lg-between">
                    <div class="col-lg-6 mb-lg-0 mb-4">
                        <div class="copyright text-center text-sm text-muted text-lg-start">
                            ©
                            <script>
                                document.write(new Date().getFullYear())
                            </script>, made with <i class="fa fa-heart"></i> by
                            <a href="https://www.creative-tim.com/" class="font-weight-bold" target="_blank">Primasys</a> for a better web.
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <ul class="nav nav-footer justify-content-center justify-content-lg-end">
                            <li class="nav-item">
                                <a href="https://www.creative-tim.com/" class="nav-link text-muted" target="_blank">Primasys</a>
                            </li>
                            <li class="nav-item">
                                <a href="https://www.creative-tim.com/presentation" class="nav-link text-muted" target="_blank">About Us</a>
                            </li>
                            <li class="nav-item">
                                <a href="https://www.creative-tim.com/blog" class="nav-link text-muted" target="_blank">Blog</a>
                            </li>
                            <li class="nav-item">
                                <a href="https://www.creative-tim.com/license" class="nav-link pe-0 text-muted" target="_blank">License</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </footer>
        </div>
    </main>
    <div class="fixed-plugin">
        <a class="fixed-plugin-button text-dark position-fixed px-3 py-2">
            <i class="material-icons py-2">settings</i>
        </a>
        <div class="card shadow-lg">
            <div class="card-header pb-0 pt-3">
                <div class="float-start">
                    <h5 class="mt-3 mb-0">Material UI Configurator</h5>
                    <p>See our dashboard options.</p>
                </div>
                <div class="float-end mt-4">
                    <button class="btn btn-link text-dark p-0 fixed-plugin-close-button">
<i class="material-icons">clear</i>
</button>
                </div>

            </div>
            <hr class="horizontal dark my-1">
            <div class="card-body pt-sm-3 pt-0">

                <div>
                    <h6 class="mb-0">Sidebar Colors</h6>
                </div>
                <a href="javascript:void(0)" class="switch-trigger background-color">
                    <div class="badge-colors my-2 text-start">
                        <span class="badge filter bg-gradient-primary active" data-color="primary" onclick="sidebarColor(this)"></span>
                        <span class="badge filter bg-gradient-dark" data-color="dark" onclick="sidebarColor(this)"></span>
                        <span class="badge filter bg-gradient-info" data-color="info" onclick="sidebarColor(this)"></span>
                        <span class="badge filter bg-gradient-success" data-color="success" onclick="sidebarColor(this)"></span>
                        <span class="badge filter bg-gradient-warning" data-color="warning" onclick="sidebarColor(this)"></span>
                        <span class="badge filter bg-gradient-danger" data-color="danger" onclick="sidebarColor(this)"></span>
                    </div>
                </a>

                <div class="mt-3">
                    <h6 class="mb-0">Sidenav Type</h6>
                    <p class="text-sm">Choose between 2 different sidenav types.</p>
                </div>
                <div class="d-flex">
                    <button class="btn bg-gradient-dark px-3 mb-2 active" data-class="bg-gradient-dark" onclick="sidebarType(this)">Dark</button>
                    <button class="btn bg-gradient-dark px-3 mb-2 ms-2" data-class="bg-transparent" onclick="sidebarType(this)">Transparent</button>
                    <button class="btn bg-gradient-dark px-3 mb-2 ms-2" data-class="bg-white" onclick="sidebarType(this)">White</button>
                </div>
                <p class="text-sm d-xl-none d-block mt-2">You can change the sidenav type just on desktop view.</p>

                <div class="mt-3 d-flex">
                    <h6 class="mb-0">Navbar Fixed</h6>
                    <div class="form-check form-switch ps-0 ms-auto my-auto">
                        <input class="form-check-input mt-1 ms-auto" type="checkbox" id="navbarFixed" onclick="navbarFixed(this)">
                    </div>
                </div>
                <hr class="horizontal dark my-3">
                <div class="mt-2 d-flex">
                    <h6 class="mb-0">Sidenav Mini</h6>
                    <div class="form-check form-switch ps-0 ms-auto my-auto">
                        <input class="form-check-input mt-1 ms-auto" type="checkbox" id="navbarMinimize" onclick="navbarMinimize(this)">
                    </div>
                </div>
                <hr class="horizontal dark my-3">
                <div class="mt-2 d-flex">
                    <h6 class="mb-0">Light / Dark</h6>
                    <div class="form-check form-switch ps-0 ms-auto my-auto">
                        <input class="form-check-input mt-1 ms-auto" type="checkbox" id="dark-version" onclick="darkMode(this)">
                    </div>
                </div>
                <hr class="horizontal dark my-sm-4">
                <a class="btn bg-gradient-primary w-100" href="">Buy now</a>
                <a class="btn bg-gradient-info w-100" href="/material-dashboard">Free demo</a>
                <a class="btn btn-outline-dark w-100" href="https://www.creative-tim.com/learning-lab/bootstrap/overview/material-dashboard">View documentation</a>
                <div class="w-100 text-center">
                    <a class="github-button" href="https://github.com/creativetimofficial/material-dashboard" data-icon="octicon-star" data-size="large" data-show-count="true" aria-label="Star creativetimofficial/material-dashboard on GitHub">Star</a>
                    <h6 class="mt-3">Thank you for sharing!</h6>
                    <a href="https://twitter.com/intent/tweet?text=Check%20Material%20UI%20Dashboard%20PRO%20made%20by%20%40CreativeTim%20%23webdesign%20%23dashboard%20%23bootstrap5&amp;url=https%3A%2F%2Fwww.creative-tim.com%2Fproduct%2Fsoft-ui-dashboard-pro" class="btn btn-dark mb-0 me-2"
                        target="_blank">
                        <i class="fab fa-twitter me-1" aria-hidden="true"></i> Tweet
                    </a>
                    <a href="https://www.facebook.com/sharer/sharer.php?u=" class="btn btn-dark mb-0 me-2" target="_blank">
                        <i class="fab fa-facebook-square me-1" aria-hidden="true"></i> Share
                    </a>
                </div>
            </div>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
    <script src="/assets/js/core/popper.min.js"></script>
    <script src="/assets/js/core/bootstrap.min.js"></script>
    <script src="/assets/js/plugins/flatpickr.min.js"></script>
    <script src="/assets/js/plugins/perfect-scrollbar.min.js"></script>
    <script src="/assets/js/plugins/smooth-scrollbar.min.js"></script>
    <!-- <script src="/assets/js/plugins/datatables.js"></script> -->

    <script src="/assets/src/plugins/datatables/js/jquery.dataTables.min.js"></script>
    <script src="/assets/src/plugins/datatables/js/dataTables.bootstrap4.min.js"></script>
    <script src="/assets/src/plugins/datatables/js/dataTables.responsive.min.js"></script>
    <script src="/assets/src/plugins/datatables/js/responsive.bootstrap4.min.js"></script>
    <!-- buttons for Export datatable -->
    <script src="/assets/src/plugins/datatables/js/dataTables.buttons.min.js"></script>
    <script src="/assets/src/plugins/datatables/js/buttons.bootstrap4.min.js"></script>
    <script src="/assets/src/plugins/datatables/js/buttons.print.min.js"></script>
    <script src="/assets/src/plugins/datatables/js/buttons.html5.min.js"></script>
    <script src="/assets/src/plugins/datatables/js/buttons.flash.min.js"></script>
    <script src="/assets/src/plugins/datatables/js/pdfmake.min.js"></script>
    <script src="/assets/src/plugins/datatables/js/vfs_fonts.js"></script>

    <script src="/assets/js/plugins/jquery.dataTables.min.js"></script>
    <script src="/assets/js/datatable-setting.js"></script>

    <script src="/assets/js/plugins/dragula/dragula.min.js"></script>
    <script src="/assets/js/plugins/jkanban/jkanban.js"></script>
    <script src="/assets/js/plugins/dataTables.bootstrap4.min.js"></script>
    <script src="/assets/js/plugins/dataTables.buttons.min.js"></script>
    <script src="/assets/js/plugins/buttons.bootstrap4.min.js"></script>
    <script src="/assets/js/plugins/pdfmake.min.js"></script>
    <script src="/assets/js/plugins/pdfmake.min.js.map"></script>
    <script src="/assets/js/plugins/vfs_fonts.js"></script>
    <script src="/assets/js/plugins/jszip.min.js"></script>

    <script src="/assets/js/plugins/buttons.flash.min.js"></script>
    <script src="/assets/js/plugins/buttons.html5.min.js"></script>
    <script src="/assets/js/plugins/buttons.print.min.js"></script>
<script type="text/javascript">
 
</script>
    <script>
                
        // const dataTableBasic = new simpleDatatables.DataTable("#datatable-basic", {
        //     searchable: false,
        //     fixedHeight: true,
        //     dom: 'Bfrtip',
        //     buttons: [
        //         'copy', 'csv', 'excel', 'pdf', 'print'
        //     ]
        // });

        // $('.table-flush').DataTable({
        //     dom: 'Bfrtip',
        //     buttons: [
        //         'copy', 'excel', 'pdf', 'print'
        //     ]
        // });


        // const dataTableSearch = new simpleDatatables.DataTable("#datatable-search", {
        //     dom: 'Bfrtip',
        //     buttons: [
        //         'copy', 'csv', 'excel', 'pdf', 'print'
        //     ]
        // });
    </script>
 <%--    <script type="text/javascript">
    $(function () {
        $("[id*=gvCustomers]").DataTable(
        {
            bLengthChange: true,
            lengthMenu: [[5, 10, -1], [5, 10, "All"]],
            bFilter: true,
            bSort: true,
            bPaginate: true,
            dom: 'Bfrtip',
                 buttons: [
                     'copy', 'csv', 'excel', 'pdf', 'print'
                 ]
        });
    });
</script>--%>
    <script>
        var win = navigator.platform.indexOf('Win') > -1;
        if (win && document.querySelector('#sidenav-scrollbar')) {
            var options = {
                damping: '0.5'
            }
            Scrollbar.init(document.querySelector('#sidenav-scrollbar'), options);
        }
    </script>

    <script async defer src="/buttons.github.io/buttons.js"></script>

    <script src="/assets/js/material-dashboard.min4c20.js?v=3.0.3"></script>

         </form>
   
</body>

<!-- Mirrored from demos.creative-tim.com/pages/applications/datatables.html by HTTrack Website Copier/3.x [XR&CO'2014], Thu, 19 May 2022 13:22:07 GMT -->

</html>

