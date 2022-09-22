<%@ Page Title="" Language="vb" EnableEventValidation="true" AutoEventWireup="false" MasterPageFile="~/Site1.Master" CodeBehind="Signin.aspx.vb" Inherits="WebApplication2.Signin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    
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
                            <div class="position-relative h-100 m-3 px-7 border-radius-lg d-flex flex-column justify-content-center" style="background-image: url('/assets/img/illustrations/login.jpg'); background-size: cover;"></div>
                        </div>
                        <div class="col-xl-4 col-lg-5 col-md-7 d-flex flex-column ms-auto me-auto ms-lg-auto me-lg-5">
                            <div class="card card-plain">
                                <div class="card-header text-center">
                                    <h4 class="font-weight-bolder">Sign In
                                    </h4>
                                    <p class="mb-0">Enter your username and password to sign in</p>
                                </div>
                                <div class="card-body mt-2">
                     
                                        <div class="input-group input-group-outline mb-3">
                                            <label class="form-label">Username</label>
                                            <asp:TextBox ID="username" runat="server" class="form-control"></asp:TextBox>
                                            
                                        </div>
                                        <div class="input-group input-group-outline mb-3">
                                            <label class="form-label">Password</label>
                                            <asp:TextBox ID="password" runat="server" class="form-control" TextMode="Password" ></asp:TextBox>
                                         
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
    
    
    <asp:Label ID="lblMessages" runat="server" Text="Label"></asp:Label>
    
    
</asp:Content>
