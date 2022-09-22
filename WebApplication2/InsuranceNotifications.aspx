<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="InsuranceNotifications.aspx.vb" Inherits="WebApplication2.InsuranceNotifications" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="apple-touch-icon" sizes="76x76" href="/assets/img/apple-icon.png">
    <link rel="icon" type="image/png" href="/assets/img/favicon.png">
    <title>
        Mimosa  FleetAd
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
            <a class="navbar-brand m-0" href="" target="_blank">
                <img src="/assets/img/mimosa.jpg" class="navbar-brand-img h-100" alt="main_logo">
                <span class="ms-1 font-weight-bold text-white">Mimosa FleetAd</span>
            </a>
        </div>
        <hr class="horizontal light mt-0 mb-2">
        <div class="collapse navbar-collapse  w-auto h-auto" id="sidenav-collapse-main">

            <ul class="navbar-nav">
                
                  <hr class="horizontal light mt-0">

                 
                  <li class="nav-item">
                    <a data-bs-toggle="collapse" href="#dashboardsExamplessss" class="nav-link text-white " aria-controls="dashboardsExamples" role="button" aria-expanded="false">
                        <i class="material-icons-round opacity-10">dashboard</i>
                        <span class="nav-link-text ms-2 ps-1">Home</span>
                    </a>
                    <div class="collapse " id="dashboardsExamplessss">
                        <ul class="nav ">
                            <li class="nav-item ">
                                <asp:HyperLink ID="HyperLink21" runat="server" class="nav-link text-white" NavigateUrl="~/Dashboard.aspx">

                                    <span class="sidenav-mini-icon"> HM </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Home</span>
                                </>
                               </asp:HyperLink>
                            </li>   
                        </ul>
                    </div>
                </li>

                <hr class="horizontal light mt-0 mb-2">
                <li class="nav-item">
                    <a data-bs-toggle="collapse" href="#dashboardsExamples1" class="nav-link text-white " aria-controls="dashboardsExamples" role="button" aria-expanded="false">
                        <i class="material-icons-round opacity-10">dashboard</i>
                        <span class="nav-link-text ms-2 ps-1">Licence And Permits</span>
                    </a>
                    <div class="collapse " id="dashboardsExamples1">
                        <ul class="nav ">
                             <li class="nav-item ">
                                 <asp:HyperLink ID="HyperLink7" runat="server" class="nav-link text-white" NavigateUrl="~/BulkInsert.aspx" >

                                    <span class="sidenav-mini-icon"> BK </span> 
                                    <span class="sidenav-normal  ms-2  ps-1"> Bulk Upload</span>
                                 </asp:HyperLink>
                                


                            </li>
                            <li class="nav-item ">
                                 <asp:HyperLink ID="HyperLink20" runat="server" class="nav-link text-white" NavigateUrl="~/HistoricalView.aspx">

                                    <span class="sidenav-mini-icon"> HS </span> 
                                    <span class="sidenav-normal  ms-2  ps-1"> Historical View</span>
                                 </asp:HyperLink>
                                


                            </li>

                             <li class="nav-item ">
                                 <asp:HyperLink ID="HyperLink14" runat="server" class="nav-link text-white" NavigateUrl="~/MergedLicenses.aspx" >

                                    <span class="sidenav-mini-icon"> MD </span> 
                                    <span class="sidenav-normal  ms-2  ps-1"> Merged</span>
                                 </asp:HyperLink>
                                

                            </li>
                            <li class="nav-item ">
                                <asp:LinkButton ID="LinkButton1" runat="server"  class="nav-link text-white " OnClick="Zinara">
                                    <span class="sidenav-mini-icon"> ZN </span> 
                                    <span class="sidenav-normal  ms-2  ps-1"> ZINARA </span>
                                </asp:LinkButton>

                            </li>
                            
                            <li class="nav-item ">
                                <asp:LinkButton ID="LinkButton2" runat="server"  class="nav-link text-white " OnClick="Zbc">
                     
                                    <span class="sidenav-mini-icon"> ZBC </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> ZBC </span>
                                </asp:LinkButton>
                                
                            </li>
                            <li class="nav-item ">
          <asp:LinkButton ID="LinkButton3" runat="server"  class="nav-link text-white " OnClick="cof">

                                    <span class="sidenav-mini-icon"> COF </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Certificate Of Fitness </span>

                                </asp:LinkButton>
                           
                            </li>
                            <li class="nav-item ">
                               <asp:LinkButton ID="LinkButton4" runat="server"  class="nav-link text-white " OnClick="rute">
                                    <span class="sidenav-mini-icon"> RT </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Route Authority </span>
                                </asp:LinkButton>
                               
                            </li>
                            <li class="nav-item ">
                              <asp:LinkButton ID="LinkButton5" runat="server"  class="nav-link text-white " OnClick="san">


                                    <span class="sidenav-mini-icon"> SN </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Sand and Gravel </span>
                                </asp:LinkButton>
                              
                            </li>
                            <li class="nav-item ">
                             <asp:LinkButton ID="LinkButton6" runat="server"  class="nav-link text-white " OnClick="abc">


                                    <span class="sidenav-mini-icon"> AB </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Abnormal Load </span>
                                </asp:LinkButton>
                             
                            </li>
                                         <li class="nav-item ">
                                        <asp:LinkButton ID="LinkButton7" runat="server"  class="nav-link text-white " OnClick="pas">

                                
                                    <span class="sidenav-mini-icon"> PS </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Passenger Insurance </span>
                               
                                             </asp:LinkButton>
                            </li>
                                         <li class="nav-item ">
                                             <asp:HyperLink ID="HyperLink13" runat="server" class="nav-link text-white " NavigateUrl="~/GarageInspections.aspx">

                                    <span class="sidenav-mini-icon"> GI </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Garage Inspections </span>

                                             </asp:HyperLink>

                                           

                            </li>
                                         <li class="nav-item ">

                                          <asp:LinkButton ID="LinkButton9" runat="server"  class="nav-link text-white " OnClick="garage">


                                    <span class="sidenav-mini-icon"> IS </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Insurance </span>
                                             </asp:LinkButton>
                                
                            </li>
                        </ul>
                    </div>
                </li>
                    <hr class="horizontal light mt-0">

                 
                  <li class="nav-item">
                    <a data-bs-toggle="collapse" href="#dashboardsExamples" class="nav-link text-white " aria-controls="dashboardsExamples" role="button" aria-expanded="false">
                        <i class="material-icons-round opacity-10">dashboard</i>
                        <span class="nav-link-text ms-2 ps-1">Driver Management</span>
                    </a>
                    <div class="collapse " id="dashboardsExamples">
                        <ul class="nav ">
                            <li class="nav-item ">
                                <asp:LinkButton ID="LinkButton10" CssClass="nav-link text-white" runat="server" OnClick="drvlist">

                                    <span class="sidenav-mini-icon"> DL </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Drivers List </span>
                                </asp:LinkButton>
                               
                            </li>
                                       
                        </ul>
                    </div>
                </li>

                    <hr class="horizontal light mt-0">

                 
                  <li class="nav-item">
                    <a data-bs-toggle="collapse" href="#dashboardsExamplesss" class="nav-link text-white " aria-controls="dashboardsExamples" role="button" aria-expanded="false">
                        <i class="material-icons-round opacity-10">dashboard</i>
                        <span class="nav-link-text ms-2 ps-1">Vehicle Management</span>
                    </a>
                    <div class="collapse " id="dashboardsExamplesss">
                        <ul class="nav ">
                            <li class="nav-item ">
                                <asp:HyperLink ID="HyperLink15" runat="server" class="nav-link text-white" NavigateUrl="~/VehiclesTrackit.aspx">

                                    <span class="sidenav-mini-icon"> VT </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Vehicle Trackit</span>
                                </>
                               </asp:HyperLink>
                            </li>
                            <li class="nav-item ">
                               <asp:HyperLink ID="HyperLink16" runat="server" class="nav-link text-white" NavigateUrl="~/Vehicles.aspx">

                                    <span class="sidenav-mini-icon"> VC </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Vehicles Category</span>
                                </asp:HyperLink>
                            </li>
                                       
                        </ul>
                    </div>
                </li>




                    <hr class="horizontal light mt-0">
                  <li class="nav-item">
                    <a data-bs-toggle="collapse" href="#dashboardsExamples2" class="nav-link text-white " aria-controls="dashboardsExamples" role="button" aria-expanded="false">
                        <i class="material-icons-round opacity-10">dashboard</i>
                        <span class="nav-link-text ms-2 ps-1">Trip Management</span>
                    </a>
                    <div class="collapse " id="dashboardsExamples2">
                        <ul class="nav ">
                            <li class="nav-item ">
                                <asp:LinkButton ID="LinkButton12" runat="server" class="nav-link text-white" OnClick="vehiclelist">

                                    <span class="sidenav-mini-icon"> VL </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Vehicle List </span>
                                </asp:LinkButton>
                       
                            </li>
                            <li class="nav-item ">
                                <asp:HyperLink ID="HyperLink2" runat="server" class="nav-link text-white" NavigateUrl="~/TripManagement.aspx">
                                  
                            


                                    <span class="sidenav-mini-icon"> TM </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Trip Management </span>
                               
                                      </asp:HyperLink>
                               
                            </li>
                                       <li class="nav-item ">
                                <asp:HyperLink ID="HyperLink9" runat="server" class="nav-link text-white" NavigateUrl="~/Trips.aspx">
                                  
      

                                    <span class="sidenav-mini-icon"> TP </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Trips </span>
                               
                                      </asp:HyperLink>
                               
                            </li>
                            <li class="nav-item ">
                                <asp:LinkButton ID="LinkButton14" runat="server" class="nav-link text-white" OnClick="bus">


                                    <span class="sidenav-mini-icon"> BS </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Bus Scheduling Calendar </span>
                                </asp:LinkButton>
                             
                            </li>
                              <li class="nav-item "> 
                                  <asp:HyperLink ID="HyperLink8" runat="server" class="nav-link text-white"  NavigateUrl="~/ScheduleList.aspx">


                                    <span class="sidenav-mini-icon"> BS </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Bus Scheduling</span>
                                  </asp:HyperLink>
                            
                             
                            </li>
                                    <li class="nav-item "> 
                                  <asp:HyperLink ID="HyperLink10" runat="server" class="nav-link text-white"  NavigateUrl="~/BusPassList.aspx">


                                    <span class="sidenav-mini-icon"> BP </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Bus Pass</span>
                                  </asp:HyperLink>
                            
                             
                            </li>
      
                        </ul>
                    </div>
                </li>
                <hr class="horizontal light mt-0">
                 <li class="nav-item">
                    <a data-bs-toggle="collapse" href="#dashboardsExamples6" class="nav-link text-white " aria-controls="dashboardsExamples" role="button" aria-expanded="false">
                        <i class="material-icons-round opacity-10">dashboard</i>
                        <span class="nav-link-text ms-2 ps-1">Inspections</span>
                    </a>
                    <div class="collapse " id="dashboardsExamples6">
                        <ul class="nav ">
                            <li class="nav-item ">
                             
                                <asp:HyperLink ID="HyperLink3" runat="server" class="nav-link text-white" NavigateUrl="~/MorningInspections.aspx">

                                    <span class="sidenav-mini-icon"> MO </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Morning Inspections </span>
                                </asp:HyperLink>
                                
                       
                            </li>
                            <li class="nav-item ">
                                <asp:HyperLink ID="HyperLink4" runat="server" class="nav-link text-white" NavigateUrl="~/QuarterlyInspection.aspx">


                                    <span class="sidenav-mini-icon"> QI </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Quartely Inspection  </span>
                                </asp:HyperLink>
                               
                            </li>
                            <li class="nav-item ">
                                <asp:HyperLink ID="HyperLink5" runat="server" class="nav-link text-white" NavigateUrl="~/PreTripInspection.aspx">


                                    <span class="sidenav-mini-icon"> PR </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Pretrip Inspection</span>
                                </asp:HyperLink>
                            </li>
                            <li class="nav-item ">
                               <asp:HyperLink ID="HyperLink6" runat="server" class="nav-link text-white" NavigateUrl="~/PreMaintanceList.aspx">


                                    <span class="sidenav-mini-icon"> PM </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> PreMaintanance Inspection</span>
                                 </asp:HyperLink>
                             
                            </li>
      
                        </ul>
                    </div>
                </li>
                    <hr class="horizontal light mt-0">
                                <li class="nav-item">
                    <a data-bs-toggle="collapse" href="#dashboardsExamples00" class="nav-link text-white " aria-controls="dashboardsExamples" role="button" aria-expanded="false">
                        <i class="material-icons-round opacity-10">dashboard</i>
                        <span class="nav-link-text ms-2 ps-1">Notifications</span>
                    </a>
                    <div class="collapse " id="dashboardsExamples00">
                        <ul class="nav ">
                            <li class="nav-item ">
                             
                                <asp:HyperLink ID="HyperLink11" runat="server" class="nav-link text-white" NavigateUrl="~/Notifications.aspx">

                                    <span class="sidenav-mini-icon"> NO </span>
                                    <span class="sidenav-normal  ms-2  ps-1">Notifications </span>
                                </asp:HyperLink>
                                
                       
                            </li>
                       
      
                        </ul>
                    </div>
                </li>
                <hr class="horizontal light mt-0">

                  <li class="nav-item">
                    <a data-bs-toggle="collapse" href="#dashboardsExamples7" class="nav-link text-white " aria-controls="dashboardsExamples" role="button" aria-expanded="false">
                        <i class="material-icons-round opacity-10">dashboard</i>
                        <span class="nav-link-text ms-2 ps-1">More</span>
                    </a>
                    <div class="collapse " id="dashboardsExamples7">
                        <ul class="nav ">
                            <li class="nav-item ">

                                <asp:HyperLink ID="HyperLink1" runat="server" class="nav-link text-white" NavigateUrl="https://usnconeboxax1aos.cloud.onebox.dynamics.com/">

                                    <span class="sidenav-mini-icon"> D365 </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> D365 </span>
                                </asp:HyperLink>
                       
                            </li>
                            <li class="nav-item ">
                               <asp:HyperLink ID="HyperLink12" runat="server" class="nav-link text-white" NavigateUrl="~/Modules/PertentoBI/Dashboard.aspx">


                                    <span class="sidenav-mini-icon"> RV </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Reports </span>
                               </asp:HyperLink>
                               
                            </li>
                        
      
                        </ul>
                    </div>
                </li>

                 <hr class="horizontal light mt-0">

                 
                  <li class="nav-item">
                    <a data-bs-toggle="collapse" href="#dashboardsExamplesssx" class="nav-link text-white " aria-controls="dashboardsExamples" role="button" aria-expanded="false">
                        <i class="material-icons-round opacity-10">dashboard</i>
                        <span class="nav-link-text ms-2 ps-1">User Management</span>
                    </a>
                    <div class="collapse " id="dashboardsExamplesssx">
                        <ul class="nav ">
                            <li class="nav-item ">
                                <asp:HyperLink ID="HyperLink17" runat="server" class="nav-link text-white" NavigateUrl="~/MapFleetUser.aspx">

                                    <span class="sidenav-mini-icon"> FU </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Map Fleet Users</span>
                                </>
                               </asp:HyperLink>
                            </li>
                            <li class="nav-item ">
                               <asp:HyperLink ID="HyperLink18" runat="server" class="nav-link text-white" NavigateUrl="~/MapUsersRolels.aspx">

                                    <span class="sidenav-mini-icon"> UR </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Map Users to Roles</span>
                                </asp:HyperLink>
                            </li>
                              <li class="nav-item ">
                               <asp:HyperLink ID="HyperLink19" runat="server" class="nav-link text-white" NavigateUrl="~/MapPermissionToRoles.aspx">

                                    <span class="sidenav-mini-icon"> RP </span>
                                    <span class="sidenav-normal  ms-2  ps-1"> Map Roles to Permission</span>
                                </asp:HyperLink>
                            </li>
                                 
                                       
                        </ul>
                    </div>
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
                    <h6 class="font-weight-bolder mb-0 px-3">Notifications</h6>
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
        <div class="row mt-4">
            <div class="col-12">
                <div class="card">
                    <div class="card-header">
                        <h5 class="mb-0">Insurance Expiry List</h5>
                     
                    </div>

                    <div class="table-responsive">
                         <asp:GridView ID="gvCustomers" runat="server" CssClass="table hover data-table-export nowrap" AutoGenerateColumns="false" OnLoad="gvCustomers_Load">
        <Columns>
            <asp:BoundField DataField="FLEETID" HeaderText="Fleet ID" />
            <asp:BoundField DataField="LICNUMBER" HeaderText="Policy Number" />
            <asp:BoundField DataField="DATEEXPIRY" HeaderText="Date" />
            <asp:BoundField DataField="COMMENTS" HeaderText="Comments" />
           <asp:BoundField DataField="DATEDIFF" HeaderText="Months To Expire" />
            <asp:BoundField DataField="DAYS" HeaderText="Days to Expire" />
            <asp:TemplateField ShowHeader="False">
            <ItemTemplate>  
                <asp:LinkButton ID="lnkstat" runat="server" CssClass="btn bg-gradient-secondary" >
                    STATUS
                </asp:LinkButton>
                
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
                        $(window).bind('resize', function(e)
{
  if (window.RT) clearTimeout(window.RT);
  window.RT = setTimeout(function()
  {
    this.location.reload(false); /* false to get page from cache */
  }, 100);
});
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
    </html>
