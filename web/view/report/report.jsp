<%-- 
    Document   : report
    Created on : Nov 2, 2021, 8:07:21 PM
    Author     : quynm
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <jsp:include page="../template/head.jsp" flush="true" />
        <title>MQ Warehouse</title>
    </head>
    <body>
        <div class="app">
            <jsp:include page="../template/header.jsp" flush="true"/>
            <div class="grid">
                <div class="content">
                    <div class="row">
                        <div class="col l-2">
                            <jsp:include page="../template/nav.jsp" flush="true"/>
                        </div>
                        <div class="col l-10">
                            <div class="content__report">
                                <div class="grid">
                                    <div class="row">
                                        <div class="col l-2-10">
                                            <a class="content__report-link" href="report/receipt-list">
                                                <img class="content__report-link-icon" src="images/receipt-icon.png" alt="receipt icon"/>
                                                <h5 class="content__report-link-title">RECEIPT</h5>
                                                <p class="content__report-link-desc">Goods Received Notes Report</p>
                                            </a>
                                        </div>
                                        <div class="col l-2-10">
                                            <a class="content__report-link" href="report/delivery-list">
                                                <img class="content__report-link-icon" src="images/delivery-icon.png" alt="delivery icon"/>
                                                <h5 class="content__report-link-title">DELIVERY</h5>
                                                <p class="content__report-link-desc">Goods Delivery Notes Report</p>
                                            </a>
                                        </div>
                                        <div class="col l-2-10">
                                            <a class="content__report-link" href="#">
                                                <img class="content__report-link-icon" src="images/report-icon.png" alt="report icon"/>
                                                <h5 class="content__report-link-title">IN - OUT</h5>
                                                <p class="content__report-link-desc">Input - Output - Inventory Report</p>
                                            </a>
                                        </div>
                                        <div class="col l-2-10">
                                            <a class="content__report-link" href="#">
                                                <img class="content__report-link-icon" src="images/out-of-date-icon.png" alt="out of date icon"/>
                                                <h5 class="content__report-link-title">EXPIRATION</h5>
                                                <p class="content__report-link-desc">Goods that are about to expire</p>
                                            </a>
                                        </div>
                                        <div class="col l-2-10">
                                            <a class="content__report-link" href="#">
                                                <img class="content__report-link-icon" src="images/out-of-stock-icon.png" alt="out of stock icon"/>
                                                <h5 class="content__report-link-title">OUT OF STOCK</h5>
                                                <p class="content__report-link-desc">Goods that are about to running out of stock</p>
                                            </a>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col l-12">
                                            <img src="images/banner_report.jpg" alt="banner report" class="content__report-banner-img"/>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <jsp:include page="../template/footer.jsp" flush="true"/>
            <div class="copyright">
                Icons made by 
                <a href="https://www.freepik.com" title="Freepik">Freepik</a>
                from 
                <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a>
            </div>
        </div>
    </body>
</html>
