<%-- 
    Document   : detail-delivery
    Created on : Nov 2, 2021, 8:30:59 AM
    Author     : quynm
--%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
                            <fmt:formatDate value="${delivery.date}" pattern="dd-MM-yyyy" var="date"/>
                            <div class="content__delivery-info">
                                <p class="content__delivery-info-text">No: ${delivery.id}</p>
                                <p class="content__delivery-info-text">
                                    Date: ${date}
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
                                        <th class="content__list-delivery-header">Unit Price</th>
                                        <th class="content__list-delivery-header">Quantity</th>
                                        <th class="content__list-delivery-header">Comment</th>
                                    </tr>
                                    <c:forEach items="${requestScope.deliveryDetails}" var="dd">
                                        <fmt:formatNumber value="${dd.product.unitPrice}" type="currency" currencySymbol="" var="uPrice"/>
                                        <tr class="content__list-delivery-row">
                                            <td class="content__list-delivery-col">${dd.product.id}</td>
                                            <td class="content__list-delivery-col">${dd.product.name}</td>
                                            <td class="content__list-delivery-col">${dd.product.unit}</td>
                                            <td class="content__list-delivery-col">${uPrice}</td>
                                            <td class="content__list-delivery-col">${dd.quantity}</td>
                                            <td class="content__list-delivery-col">${dd.comment}</td>
                                        </tr>
                                    </c:forEach>
                                    <fmt:formatNumber value="${delivery.value}" type="currency" currencySymbol=" " var="value"/>
                                    <tr class="content__list-delivery-row">
                                        <td class="content__list-delivery-col" colspan="3">Total</td>
                                        <td class="content__list-delivery-col" colspan="2" style="text-align: right">
                                            ${value}
                                        </td>
                                        <td class="content__list-delivery-col"></td>
                                    </tr>
                                </tbody>
                            </table>
                            <a class="button button--primary" href="delivery/create">Create new note</a>
                            <a class="button button--green" href="report/delivery-list">View all delivery note</a>
                        </div>
                    </div>
                </div>
            </div>
            <jsp:include page="../template/footer.jsp" flush="true"/>
        </div>
    </body>
</html>