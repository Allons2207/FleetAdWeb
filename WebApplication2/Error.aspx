<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Error.aspx.vb" Inherits="WebApplication2._Error" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>
        Errror
    </title>
    
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
<body>
    <form id="form1" runat="server">
        <div>
              <main class="main-content  mt-0">
    <div class="page-header align-items-start min-vh-100"
      style="background-image: url('/assets/img/02.jpg');">
      <span class="mask bg-gradient-dark opacity-6"></span>
      <div class="container my-auto">
        <div class="row">
          <div class="col-lg-12 m-auto text-center">
            <h1 class="display-1 text-bolder text-white">Error Access Permission Denied</h1>
            <h2 class="text-white">You have no permission</h2>
            <p class="lead text-white">We suggest you to go to the homepage while we solve this issue.</p>
              <asp:HyperLink ID="HyperLink1" runat="server" type="button" class="btn btn-outline-white mt-4"  NavigateUrl="~/Dashboard.aspx">
                  Go to Homepage
              </asp:HyperLink>
     
          </div>
        </div>
      </div>
    </div>
  </main>

  <footer class="footer py-5">
    <div class="container">
      <div class="row">
        <div class="col-lg-8 mb-4 mx-auto text-center">
          <a href="javascript:;" target="_blank" class="text-secondary me-xl-5 me-3 mb-sm-0 mb-2">
            Company
          </a>
          <a href="javascript:;" target="_blank" class="text-secondary me-xl-5 me-3 mb-sm-0 mb-2">
            About Us
          </a>
          <a href="javascript:;" target="_blank" class="text-secondary me-xl-5 me-3 mb-sm-0 mb-2">
            Team
          </a>
          <a href="javascript:;" target="_blank" class="text-secondary me-xl-5 me-3 mb-sm-0 mb-2">
            Products
          </a>
          <a href="javascript:;" target="_blank" class="text-secondary me-xl-5 me-3 mb-sm-0 mb-2">
            Blog
          </a>
          <a href="javascript:;" target="_blank" class="text-secondary me-xl-5 me-3 mb-sm-0 mb-2">
            Pricing
          </a>
        </div>
        <div class="col-lg-8 mx-auto text-center mb-4 mt-2">
          <a href="javascript:;" target="_blank" class="text-secondary me-xl-4 me-4">
            <span class="text-lg fab fa-dribbble"></span>
          </a>
          <a href="javascript:;" target="_blank" class="text-secondary me-xl-4 me-4">
            <span class="text-lg fab fa-twitter"></span>
          </a>
          <a href="javascript:;" target="_blank" class="text-secondary me-xl-4 me-4">
            <span class="text-lg fab fa-instagram"></span>
          </a>
          <a href="javascript:;" target="_blank" class="text-secondary me-xl-4 me-4">
            <span class="text-lg fab fa-pinterest"></span>
          </a>
          <a href="javascript:;" target="_blank" class="text-secondary me-xl-4 me-4">
            <span class="text-lg fab fa-github"></span>
          </a>
        </div>
      </div>
      <div class="row">
        <div class="col-8 mx-auto text-center mt-1">
          <p class="mb-0 text-secondary">
            Copyright ©
            <script>
              document.write(new Date().getFullYear())
            </script> Vault ITS.
          </p>
        </div>
      </div>
    </div>
  </footer>

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
