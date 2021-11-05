<%-- 
    Document   : home
    Created on : Oct 17, 2021, 9:23:20 AM
    Author     : quynm
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <jsp:include page="template/head.jsp" flush="true" />
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
                                            <a class="content__home-link" href="product/list">
                                                <img class="content__home-link-icon" src="images/inventory-icon.png" alt="receipt icon"/>
                                                <h5 class="content__home-link-title">INVENTORY</h5>
                                                <p class="content__home-link-desc">View all product in warehouse</p>
                                            </a>
                                        </div>
                                        <div class="content-home__top-btn col l-3">
                                            <a class="content__home-link" href="delivery/create">
                                                <img class="content__home-link-icon" src="images/inout-icon.png" alt="receipt icon"/>
                                                <h5 class="content__home-link-title">STOCK IN - OUT</h5>
                                                <p class="content__home-link-desc">Create Goods Receipt - Delivery Note</p>
                                            </a>
                                        </div>
                                        <div class="content-home__top-btn col l-3">
                                            <a class="content__home-link" href="report">
                                                <img class="content__home-link-icon" src="images/report-home-icon.png" alt="receipt icon"/>
                                                <h5 class="content__home-link-title">REPORT</h5>
                                                <p class="content__home-link-desc">Create report</p>
                                            </a>
                                        </div>
                                        <div class="content-home__top-btn col l-3">
                                            <a class="content__home-link" href="account/list">
                                                <img class="content__home-link-icon" src="images/account-icon.png" alt="receipt icon"/>
                                                <h5 class="content__home-link-title">ACCOUNT</h5>
                                                <p class="content__home-link-desc">Manage accounts</p>
                                            </a>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="content-home__banner col col-l-12">
                                            <img src="images/banner_home.jpg" alt="banner home" class="content__home-banner-img" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <jsp:include page="template/footer.jsp" flush="true"/>
            <div class="copyright">
                Icons made by 
                <a href="https://www.freepik.com" title="Freepik">Freepik</a>
                from 
                <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a>
            </div>
        </div>
    </body>
</html>