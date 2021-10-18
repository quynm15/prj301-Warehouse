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
        <!--===============================================================================================-->	
        <link rel="icon" type="image/png" href="assets/images/icons/favicon.ico"/>
        <!--===============================================================================================-->
        <link rel=”stylesheet” href=”https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css” />
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="view/auth/assets/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="view/auth/assets/fonts/Linearicons-Free-v1.0.0/icon-font.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="view/auth/assets/vendor/animate/animate.css">
        <!--===============================================================================================-->	
        <link rel="stylesheet" type="text/css" href="view/auth/assets/vendor/css-hamburgers/hamburgers.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="view/auth/assets/vendor/animsition/css/animsition.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="view/auth/assets/vendor/select2/select2.min.css">
        <!--===============================================================================================-->	
        <link rel="stylesheet" type="text/css" href="view/auth/assets/vendor/daterangepicker/daterangepicker.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="view/auth/assets/css/util.css">
        <link rel="stylesheet" type="text/css" href="view/auth/assets/css/style_login.css">
        <!--===============================================================================================-->
    </head>
    <body>
        <div class="limiter">
            <div class="container-login100" style="background-image: url('view/auth/assets/images/bg-01.jpg');">
                <div class="wrap-login100 p-t-30 p-b-50">
                    <span class="login100-form-title p-b-21">Account Login</span><br/>

                    <form action="login" method="POST" class="login100-form validate-form p-b-33 p-t-5">
                        <span class="error100 p-t-10">${requestScope.errorLogin eq null?"":requestScope.errorLogin}</span><br/>
                        <div class="wrap-input100 validate-input" data-validate = "Enter username">
                            <input class="input100" type="text" name="username" placeholder="User name">
                            <span class="focus-input100" data-placeholder="&#xe82a;"></span>
                        </div>

                        <div class="wrap-input100 validate-input" data-validate="Enter password">
                            <input class="input100" type="password" name="password" placeholder="Password">
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
        <script src=”https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js”></script>
        <!--===============================================================================================-->
        <script src="view/auth/assets/vendor/animsition/js/animsition.min.js"></script>
        <!--===============================================================================================-->
        <script src=”https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js”></script>
        <script src=”https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js”></script>
        <!--===============================================================================================-->
        <script src="view/auth/assets/vendor/select2/select2.min.js"></script>
        <!--===============================================================================================-->
        <script src="view/auth/assets/vendor/daterangepicker/moment.min.js"></script>
        <script src="view/auth/assets/vendor/daterangepicker/daterangepicker.js"></script>
        <!--===============================================================================================-->
        <script src="view/auth/assets/vendor/countdowntime/countdowntime.js"></script>
        <!--===============================================================================================-->
        <script src="view/auth/js/login.js"></script>

    </body>
</html>
