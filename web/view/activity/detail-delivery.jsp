<%-- 
    Document   : detail-delivery
    Created on : Nov 2, 2021, 8:30:59 AM
    Author     : quynm
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <jsp:include page="../template/head.jsp" flush="true" />
        <title>Goods Delivery Note</title>
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
                            <table class="content__tab-table">
                                <tr class="content__tab-row">
                                    <td class="content__tab-col content__tab-col--active">
                                        <a class="content__tab-link" href="delivery/create">
                                            Delivery
                                        </a>
                                    </td>
                                    <td class="content__tab-col">
                                        <a class="content__tab-link" href="delivery/create">
                                            Receipt
                                        </a>
                                    </td>
                                </tr>
                            </table>

                            <h2 class="content__title">Goods delivery note</h2>
                            <hr/>

                            <c:set value="${requestScope.delivery}" var="delivery"></c:set>
                                <div class="content__delivery-info">
                                    <p class="content__delivery-info-text">No: ${delivery.id}</p>
                                <p class="content__delivery-info-text">
                                    Date: ${delivery.date}
                                    Time: ${delivery.time}
                                </p>
                                <p class="content__delivery-info-text">
                                    Exporter: ${delivery.exporter.fullName eq null ? delivery.exporter.username : delivery.exporter.fullName}
                                </p>
                                <p class="content__delivery-info-text">Recipient: ${delivery.recipient}</p>
                                <p class="content__delivery-info-text">Note: ${delivery.comment}</p>
                            </div>

                            <table class="content__list-delivery-table">
                                <tbody>
                                    <tr class="content__list-delivery-row">
                                        <th class="content__list-delivery-header">ProductID</th>
                                        <th class="content__list-delivery-header">Product Name</th>
                                        <th class="content__list-delivery-header">Unit</th>
                                        <th class="content__list-delivery-header">Quantity</th>                                        <th class="content__list-delivery-header">Comment</th>
                                    </tr>
                                    <c:forEach items="${requestScope.deliveryDetails}" var="dd">
                                        <tr class="content__list-delivery-row">
                                            <td class="content__list-delivery-col">${dd.product.id}</td>
                                            <td class="content__list-delivery-col">${dd.product.name}</td>
                                            <td class="content__list-delivery-col">${dd.product.unit}</td>
                                            <td class="content__list-delivery-col">${dd.quantity}</td>
                                            <td class="content__list-delivery-col">${dd.comment}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                            <a class="button button--primary" href="delivery/create">Create new note</a>
                            <a class="button button--green" href="#">View all delivery note</a>
                        </div>
                    </div>
                </div>
            </div>
            <jsp:include page="../template/footer.jsp" flush="true"/>
        </div>
    </body>
</html>