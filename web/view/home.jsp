<%-- 
    Document   : home
    Created on : Oct 17, 2021, 9:23:20 AM
    Author     : quynm
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <!-- CDN to reset CSS -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/8.0.1/normalize.min.css" />
        <!-- CSS -->
        <link rel="stylesheet" href="view/css/base.css" />
        <link rel="stylesheet" href="view/css/main.css" />
        <link rel="stylesheet" href="view/css/grid.css" />
        <title>MQ Warehouse</title>
    </head>
    <body>
        <div class="app">
            <jsp:include page="template/header.jsp" flush="true"/>
            <div class="grid">
                <div class="content">
                    <div class="row">
                        <div class="col l-2">
                            <jsp:include page="template/nav.jsp" flush="true"/>
                        </div>
                        <div class="col l-10">
                            <div class="content-home">
                                <div class="grid">
                                    <div class="row">
                                        <div class="content-home__top-btn col l-3">
                                            <a href="#" class="content-home__top-link content-home__top-link--green"> Inventory </a>
                                        </div>
                                        <div class="content-home__top-btn col l-3">
                                            <a href="#" class="content-home__top-link content-home__top-link--red"> Goods Receipt - Issue </a>
                                        </div>
                                        <div class="content-home__top-btn col l-3">
                                            <a href="#" class="content-home__top-link content-home__top-link--orange"> Report </a>
                                        </div>
                                        <div class="content-home__top-btn col l-3">
                                            <a href="account/list" class="content-home__top-link content-home__top-link--blue"> Account management </a>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="content-home__banner col col-l-12">
                                            <img src="view/images/banner_home.jpg" alt="banner home" class="content-home__banner-img" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <jsp:include page="template/footer.jsp" flush="true"/>
        </div>
    </body>
</html>