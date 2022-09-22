<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Index.aspx.vb" Inherits="WebApplication2.Index1" %>

<!DOCTYPE html>
<html lang="en">
<head>
     <title>
        Mimosa FleetAd
    </title>
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


</head>
<body>
    <form id="form1" runat="server">
           
    <noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-NKDMSK6" height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>

    <div class="container position-sticky z-index-sticky top-0">
        <div class="row">
            <div class="col-12">

                <nav class="navbar navbar-expand-lg blur border-radius-lg top-0 z-index-3 shadow position-absolute mt-4 py-2 start-0 end-0 mx-4">
                    <div class="container-fluid ps-2 pe-0">
                        <a class="navbar-brand font-weight-bolder ms-lg-0 ms-3 " href="">
D365
</a>
                        <button class="navbar-toggler shadow-none ms-2" type="button" data-bs-toggle="collapse" data-bs-target="#navigation" aria-controls="navigation" aria-expanded="false" aria-label="Toggle navigation">
<span class="navbar-toggler-icon mt-2">
<span class="navbar-toggler-bar bar1"></span>
<span class="navbar-toggler-bar bar2"></span>
<span class="navbar-toggler-bar bar3"></span>
</span>
</button>
                    </div>
                </nav>

            </div>
        </div>
    </div>
    <main class="main-content  mt-0">
        <section>
            <div class="page-header min-vh-100">
                <div class="container">
                    <div class="row">
                        <div class="col-6 d-lg-flex d-none h-100 my-auto pe-0 position-absolute top-0 start-0 text-center justify-content-center flex-column">
                            <div class="position-relative h-100 m-3 px-7 border-radius-lg d-flex flex-column justify-content-center" style="background-image: url('/assets/img/001.jpg'); background-size: cover;"></div>
                        </div>
                        <div class="col-xl-4 col-lg-5 col-md-7 d-flex flex-column ms-auto me-auto ms-lg-auto me-lg-5">
                            <div class="card card-plain">
                                <div class="card-header text-center">
                                    <h4 class="font-weight-bolder">Sign In
                                    </h4>
                                    <p class="mb-0">Enter your username and password to sign in</p>
                                </div>
                                <div class="card-body mt-2">
                     
                                        <div class="input-group input-group-dynamic my-3">
                                                                    <span class="input-group-text" id="basic-addon2">Username</span>
                                            <asp:TextBox ID="username" runat="server" class="form-control" ></asp:TextBox>
                                            
                                        </div>
                                          <div class="input-group input-group-dynamic my-3">
                                                                    <span class="input-group-text" id="basic-addon1">Password</span>
                                            <asp:TextBox ID="password" runat="server" class="form-control"  TextMode="Password" ></asp:TextBox>
                                         
                                        </div>
                                        <div class="text-center">
                                            <asp:Button ID="Button1" runat="server" Text="Signin" class="btn btn-lg bg-gradient-success btn-lg w-100 mt-4 mb-0" />
                                            
                                        </div>
                                    
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </main>
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
    
    </form>
</body>
</html>
