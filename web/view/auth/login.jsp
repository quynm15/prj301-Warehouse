<%-- 
    Document   : login
    Created on : Oct 15, 2021, 9:12:01 PM
    Author     : quynm
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Login</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <base href="${pageContext.servletContext.contextPath}/">
        <!--===============================================================================================-->	
        <link rel="icon" type="image/png" href="images/icons/favicon.ico">
        <!--===============================================================================================-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/4.6.1/css/bootstrap.min.css" />
        <!--===============================================================================================-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css"/>
        <!--===============================================================================================-->
        <link rel="stylesheet" href="fonts/Linearicons-Free-v1.0.0/icon-font.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.5.2/animate.min.css"/>
        <!--===============================================================================================-->	
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/hamburgers/1.1.3/hamburgers.min.css"/>
        <!--===============================================================================================-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animsition/4.0.2/js/animsition.min.js"/>
        <!--===============================================================================================-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/css/select2.min.css"/>
        <!--===============================================================================================-->	
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-daterangepicker/2.1.25/daterangepicker.min.css"/>
        <!--===============================================================================================-->
        <link rel="stylesheet" href="css/util.css"/>
        <link rel="stylesheet" href="css/style_login.css"/>
        <!--===============================================================================================-->
    </head>
    <body>
        <div class="limiter">
            <div class="container-login100" style="background-image: url('images/login_background.jpg');">
                <div class="wrap-login100 p-t-30 p-b-50">
                    <span class="login100-form-title p-b-21">Account Login</span><br/>

                    <form action="login" method="POST" class="login100-form validate-form p-b-33 p-t-5">
                        <span class="error100 p-t-10">${requestScope.errorLogin eq null?"":requestScope.errorLogin}</span><br/>
                        <div class="wrap-input100 validate-input" data-validate = "Enter username">
                            <input class="input100" type="text" name="username" placeholder="User name" required>
                            <span class="focus-input100" data-placeholder="&#xe82a;"></span>
                        </div>

                        <div class="wrap-input100 validate-input" data-validate="Enter password">
                            <input class="input100" type="password" name="password" placeholder="Password" required>
                            <span class="focus-input100" data-placeholder="&#xe80f;"></span>
                        </div>

                        <div class="contact100-form-checkbox m-l-35 p-t-10 ">
                            <input class="input-checkbox100" id="ckb1" type="checkbox" name="remember-me" />
                            <label class="label-checkbox100" for="ckb1"> Remember me </label>
                        </div>

                        <div class="container-login100-form-btn m-t-32">
                            <button class="login100-form-btn">Login</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!--===============================================================================================-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <!--===============================================================================================-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/animsition/4.0.2/js/animsition.js"></script>
        <!--===============================================================================================-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/2.10.2/umd/popper.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/4.6.1/js/bootstrap.min.js"></script>
        <!--===============================================================================================-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/js/select2.min.js"></script>
        <!--===============================================================================================-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-daterangepicker/2.1.25/daterangepicker.min.js"></script>
        <!--===============================================================================================-->
        <script src="js/login.js"></script>

    </body>
</html>
