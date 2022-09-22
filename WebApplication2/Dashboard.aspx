<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site1.Master" CodeBehind="Dashboard.aspx.vb" Inherits="WebApplication2.Dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
       <noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-NKDMSK6" height="0" width="0"
      style="display:none;visibility:hidden"></iframe></noscript>

   
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
                    <a data-bs-toggle="collapse" href="#dashboardsExamplesssx" class="nav-link text-white " aria-controls="dashboardsExamplesssx" role="button" aria-expanded="false">
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
                 <hr class="horizontal light mt-0">

                 
                  <li class="nav-item">
                   
                    
                       
                        <asp:LinkButton ID="LinkButton8" runat="server" class="nav-link text-white " aria-controls="dashboardsExamples" role="button" aria-expanded="false"  OnClick="logout">Logout</asp:LinkButton>
                           
                      

                    
                  
                </li>

            </ul>
        </div>
    </aside>
    <main class="main-content position-relative max-height-vh-100 h-100 border-radius-lg ">

        <nav class="navbar navbar-main navbar-expand-lg position-sticky mt-4 top-1 px-0 mx-4 shadow-none border-radius-xl z-index-sticky" id="navbarBlur" data-scroll="true">
            <div class="container-fluid py-1 px-3">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb bg-transparent mb-0 pb-0 pt-1 px-0 me-sm-6 me-5">
                    </ol>
                    <h6 class="font-weight-bolder mb-0">Home</h6>
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
                            <a href="/pages/pages/authentication/signin/illustration.html" class="nav-link text-body p-0 position-relative" target="_blank">
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
                <div class="col-xl-7">
                    <div class="card h-500">
                        <div class="card-header p-0 position-relative mt-n4 mx-3 z-index-2">
                            <div class="tab-content shadow-dark border-radius-lg" id="v-pills-tabContent">
                                <div class="tab-pane fade show position-relative active height-600 border-radius-lg" id="cam1" role="tabpanel" aria-labelledby="cam1" style="background-image: url('/assets/img/02.jpg'); background-size:cover;" loading="lazy">
                                    <div class="position-absolute d-flex top-0 w-100">
                                        
                                        <p class="text-white font-weight-normal p-3 mb-0">17.05.2021 4:34PM</p>
                                        <div class="ms-auto p-3">
                                            <span class="badge badge-secondary">
                        <i class="fas fa-dot-circle text-danger"></i>
                       Mimosa</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane fade position-relative height-600 border-radius-lg" id="cam2" role="tabpanel" aria-labelledby="cam2" style="background-image: url('/assets/img/03.jpg'); background-size:cover;" loading="lazy">
                                    <div class="position-absolute d-flex top-0 w-100">
                                        <p class="text-white font-weight-normal p-3 mb-0">17.05.2021 4:35PM</p>
                                        <div class="ms-auto p-3">
                                            <span class="badge badge-secondary">
                        <i class="fas fa-dot-circle text-danger"></i>
                      Mimosa</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane fade position-relative height-600 border-radius-lg" id="cam3" role="tabpanel" aria-labelledby="cam3" style="background-image: url('/assets/img/04.jpg'); background-size:cover;" loading="lazy">
                                    <div class="position-absolute d-flex top-0 w-100">
                                        <p class="text-white font-weight-normal p-3 mb-0">17.05.2021 4:57PM</p>
                                        <div class="ms-auto p-3">
                                            <span class="badge badge-secondary">
                        <i class="fas fa-dot-circle text-danger"></i>
                        Mimosa</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card-body d-flex p-3 mt-2">
                            <h6 class="my-auto">FleetAd</h6>
                            <div class="nav-wrapper position-relative ms-auto w-50">
                                <ul class="nav nav-pills nav-fill p-1" role="tablist">
                                    <li class="nav-item">
                                        <a class="nav-link mb-0 px-0 py-1 active" data-bs-toggle="tab" href="#cam1" role="tab" aria-controls="cam1" aria-selected="true">
                      POOL
                    </a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link mb-0 px-0 py-1" data-bs-toggle="tab" href="#cam2" role="tab" aria-controls="cam2" aria-selected="false">
                    TRUCK
                    </a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link mb-0 px-0 py-1" data-bs-toggle="tab" href="#cam3" role="tab" aria-controls="cam3" aria-selected="false">
                      BUS
                    </a>
                                    </li>
                                </ul>
                            </div>
                            <div class="dropdown pt-2">
                                <a href="javascript:;" class="text-secondary ps-4" id="dropdownCam" data-bs-toggle="dropdown" aria-expanded="false">
                                    <i class="fas fa-ellipsis-v"></i>
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end me-sm-n4 p-2" aria-labelledby="dropdownCam">
                                    <li><a class="dropdown-item border-radius-md" href="javascript:;">Pause</a></li>
                                    <li><a class="dropdown-item border-radius-md" href="javascript:;">Stop</a></li>
                                    <li><a class="dropdown-item border-radius-md" href="javascript:;">Schedule</a></li>
                                    <li>
                                        <hr class="dropdown-divider">
                                    </li>
                                    <li><a class="dropdown-item border-radius-md text-danger" href="javascript:;">Remove</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-xl-5">
                    <div class="row mt-4">
                <div class="col-md-12 col-sm-6 col-6">
                    <div class="card">
                         <div class="card-body text-center">
                            <div class="text-gradient text-success h2">
                              </div>
                            <h5 class="mb-0 font-weight-bolder">Notifications</h5>

                            <h2 class="mb-0 font-weight-bolder text-lg">Available</h2>
                             <asp:HyperLink ID="HyperLink22" runat="server" class="btn btn-outline-success" NavigateUrl="~/Notifications.aspx">View

                             </asp:HyperLink>
                            
                        </div>
                    </div>
                </div>


                        </div>
                 <div class="row mt-4">
                <div class="col-md-12 col-sm-6 col-6">
                    <div class="card">
                         <div class="card-body text-center">
                            <div class="text-gradient text-success h2">
                                <div  id="Div4"  runat="server" countto="21">

                            <asp:Label ID="Label5" runat="server" Text="0"></asp:Label>
                                </div> <span class="text-md"></span></div>
                            <h5 class="mb-0 font-weight-bolder">Vehicles</h5>

                            <h2 class="mb-0 font-weight-bolder text-lg">Missing Atrributes</h2>
                            <asp:Button ID="Button5" runat="server" class="btn btn-outline-success" Text="View" OnClick="vehiclelist" />
                        </div>
                    </div>
                </div>
                        </div>
            </div>
              
            </div>
            <div class="row mt-4">
                <div class="col-md-4 col-sm-6 col-6">
                    <div class="card">
                        <div class="card-body text-center">
                            <div class="text-gradient text-success h2">
                                <div  id="status1"  runat="server" countto="21">

                            <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
                                </div> <span class="text-md"></span></div>
                            <h5 class="mb-0 font-weight-bolder">Drivers</h5>

                            <h2 class="mb-0 font-weight-bolder text-lg">Available</h2>
                               <div class="row">
                                <asp:Label ID="lblpoolex" runat="server" Text="Label" class="mb-0 font-weight-bolder text-lg" ></asp:Label>
                             </div>
                             <div class="row">
                             <asp:Label ID="lblpooldr" runat="server" Text="Label" class="mb-0 font-weight-bolder text-lg" ></asp:Label>
                                  </div>
                                 <div class="row">
                             <asp:Label ID="lblpoolbus" runat="server" Text="Label" class="mb-0 font-weight-bolder text-lg" ></asp:Label>
                                      </div>
                           
                            <asp:Button ID="Button1" runat="server" class="btn btn-outline-success" Text="View" OnClick="drvlist" />
                 
                        </div>
                    </div>
                </div>

                <div class="col-md-4 col-sm-6 col-6">
                    <div class="card">
                         <div class="card-body text-center">
                            <div class="text-gradient text-success h2">
                                <div  id="Div1"  runat="server" countto="21">

                            <asp:Label ID="Label2" runat="server" Text="Label"></asp:Label>
                                </div> <span class="text-md "></span></div>
                            <h5 class="mb-0 font-weight-bolder">Vehicles</h5>

                            <h2 class="mb-5 font-weight-bolder text-lg">Available</h2>
                             <div class="row">

                             <asp:Label ID="lblpav" runat="server" Text="Label" class="mb-0 font-weight-bolder text-lg" ></asp:Label>
                             </div>
                             <div class="row">
                             <asp:Label ID="lblpool" runat="server" Text="Label" class="mb-0 font-weight-bolder text-lg" ></asp:Label>
                                  </div>
                                 <div class="row">
                             <asp:Label ID="lblbus" runat="server" Text="Label" class="mb-0 font-weight-bolder text-lg" ></asp:Label>
                                      </div>
                              <div class="row">
                             <asp:Label ID="lblsurface" runat="server" Text="Label" class="mb-0 font-weight-bolder text-lg" ></asp:Label>
                                      </div>

                              <asp:HyperLink ID="HyperLink23" runat="server" class="btn btn-outline-success" NavigateUrl="~/Vehicles.aspx">View

                             </asp:HyperLink>
                            
                        </div>
                    </div>
                </div>
                <div class="col-md-4 col-sm-6 col-6 mt-4 mt-md-0">
                    <div class="card">
                     <div class="card-body text-center">
                            <div class="text-gradient text-success h2">
                                <div  id="Div2"  runat="server" countto="21">

                            <asp:Label ID="Label3" runat="server" Text="0"></asp:Label>
                                </div> <span class="text-md"></span></div>
                            <h5 class="mb-0 font-weight-bolder">Vehicles</h5>

                            <h2 class="mb-0 font-weight-bolder text-lg">Unvailable</h2>
                             <asp:HyperLink ID="HyperLink24" runat="server" class="btn btn-outline-success" NavigateUrl="~/VehicleList.aspx">View

                             </asp:HyperLink>
                      
                        </div>
                         </div>
                </div>
               
            
       
            <hr class="horizontal dark my-5">
     </div>

                        <div class="row mt-4">
                <div class="col-md-4 col-sm-6 col-6">
                    <div class="card">
                        <div class="card-body text-center">
                            <div class="text-gradient text-success h2">
                                <div  id="Div5"  runat="server" countto="21">

                            <asp:Label ID="lbltotadrive" runat="server" Text="29"></asp:Label>
                                </div> <span class="text-md"></span></div>
                            <h5 class="mb-0 font-weight-bolder">Total</h5>

                            <h2 class="mb-0 font-weight-bolder text-lg">Drivers</h2>
                            <asp:Button ID="Button6" runat="server" class="btn btn-outline-success" Text="View" OnClick="drvlist" />
                        </div>
                    </div>
                </div>

                <div class="col-md-4 col-sm-6 col-6">
                    <div class="card">
                         <div class="card-body text-center">
                            <div class="text-gradient text-success h2">
                                <div  id="Div6"  runat="server" countto="5">

                            <asp:Label ID="lbltri" runat="server" Text="5"></asp:Label>
                                </div> <span class="text-md"></span></div>
                            <h5 class="mb-0 font-weight-bolder">Trip</h5>

                            <h2 class="mb-0 font-weight-bolder text-lg">Requests</h2>
                                 <asp:HyperLink ID="HyperLink25" runat="server" class="btn btn-outline-success" NavigateUrl="~/TripManagement.aspx">View

                             </asp:HyperLink>
                            
                        </div>
                    </div>
                </div>
                <div class="col-md-4 col-sm-6 col-6 mt-4 mt-md-0">
                    <div class="card">
                     <div class="card-body text-center">
                            <div class="text-gradient text-success h1">
                           </div>
                            <h5 class="mb-0 font-weight-bolder">Vehicles</h5>

                            <h2 class="mb-0 text-lg font-weight-bolder ">Trackit</h2>

                             <asp:HyperLink ID="HyperLink26" runat="server" class="btn btn-outline-success" NavigateUrl="~/VehiclesTrackit.aspx">View

                             </asp:HyperLink>
                
                        </div>
                         </div>
                </div>
               
            
       
            <hr class="horizontal dark my-5">
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
                                <a href="" class="font-weight-bold" target="_blank">Vault ITS </a> for a better web.
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <ul class="nav nav-footer justify-content-center justify-content-lg-end">
                                <li class="nav-item">
                                    <a href="" class="nav-link text-muted" target="_blank">Vault ITS</a>
                                </li>
                                <li class="nav-item">
                                    <a href="" class="nav-link text-muted" target="_blank">About
                    Us</a>
                                </li>
                                <li class="nav-item">
                                    <a href="" class="nav-link text-muted" target="_blank">Blog</a>
                                </li>
                                <li class="nav-item">
                                    <a href="" class="nav-link pe-0 text-muted" target="_blank">License</a>
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
                <a class="btn bg-gradient-primary w-100" href="https://www.creative-tim.com/product/material-dashboard-pro">Buy
          now</a>
                <a class="btn bg-gradient-info w-100" href="https://www.creative-tim.com/product/material-dashboard">Free
          demo</a>
                <a class="btn btn-outline-dark w-100" href="https://www.creative-tim.com/learning-lab/bootstrap/overview/material-dashboard">View documentation</a>
                <div class="w-100 text-center">
                    <a class="github-button" href="https://github.com/creativetimofficial/material-dashboard" data-icon="octicon-star" data-size="large" data-show-count="true" aria-label="Star creativetimofficial/material-dashboard on GitHub">Star</a>
                    <h6 class="mt-3">Thank you for sharing!</h6>
                    <a href="https://twitter.com/intent/tweet?text=Check%20Material%20UI%20Dashboard%20PRO%20made%20by%20%40CreativeTim%20%23webdesign%20%23dashboard%20%23bootstrap5&amp;url=https%3A%2F%2Fwww.creative-tim.com%2Fproduct%2Fsoft-ui-dashboard-pro" class="btn btn-dark mb-0 me-2"
                        target="_blank">
                        <i class="fab fa-twitter me-1" aria-hidden="true"></i> Tweet
                    </a>
                    <a href="https://www.facebook.com/sharer/sharer.php?u=https://www.creative-tim.com/product/material-dashboard-pro" class="btn btn-dark mb-0 me-2" target="_blank">
                        <i class="fab fa-facebook-square me-1" aria-hidden="true"></i> Share
                    </a>
                </div>
            </div>
        </div>
    </div>


</asp:Content>
