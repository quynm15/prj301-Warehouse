<%-- 
    Document   : nav
    Created on : Oct 17, 2021, 9:23:42 AM
    Author     : quynm
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
    </head>
    <body>
        <div class="content__nav">
            <h3 class="content__nav-header">Control Panel</h3>
            <p class="content__nav-title">Inventory</p>
            <ul class="content__nav-list">
                <li class="content__nav-item">
                    <a href="product/list" class="content__nav-link">View Inventory</a>
                </li>
                <li class="content__nav-item">
                    <a href="category/list" class="content__nav-link">View Categories</a>
                </li>
                <li class="content__nav-item">
                    <a href="supplier/list" class="content__nav-link">View Suppliers</a>
                </li>
            </ul>

            <p class="content__nav-title">Goods Receipt - Delivery</p>
            <ul class="content__nav-list">
                <li class="content__nav-item">
                    <a href="receipt/create" class="content__nav-link">Receipt</a>
                </li>
                <li class="content__nav-item">
                    <a href="delivery/create" class="content__nav-link">Delivery</a>
                </li>
            </ul>

            <p class="content__nav-title">Report</p>
            <ul class="content__nav-list">
                <li class="content__nav-item">
                    <a href="report" class="content__nav-link">Create a Report</a>
                </li>
                <li class="content__nav-item">
                    <a href="report/receipt-list" class="content__nav-link">Received Report</a>
                </li>
                <li class="content__nav-item">
                    <a href="report/delivery-list" class="content__nav-link">Delivery Report</a>
                </li>
            </ul>

            <p class="content__nav-title">Account management</p>
            <ul class="content__nav-list">
                <li class="content__nav-item">
                    <a href="account/create" class="content__nav-link">Create new account</a>
                </li>
                <li class="content__nav-item">
                    <a href="account/list" class="content__nav-link">Account management</a>
                </li>
            </ul>
        </div>
    </body>
</html>
