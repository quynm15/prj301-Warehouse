<%-- 
    Document   : detail-receipt
    Created on : Nov 1, 2021, 4:56:26 PM
    Author     : quynm
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <jsp:include page="../template/head.jsp" flush="true" />
        <title>Goods Received Note</title>
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
                                    <td class="content__tab-col">
                                        <a class="content__tab-link" href="delivery/create">
                                            Delivery
                                        </a>
                                    </td>
                                    <td class="content__tab-col content__tab-col--active">
                                        <a class="content__tab-link" href="receipt/create">
                                            Receipt
                                        </a>
                                    </td>
                                </tr>
                            </table>

                            <h2 class="content__title">Goods received note</h2>
                            <hr/>

                            <c:set value="${requestScope.receipt}" var="receipt"></c:set>
                                <div class="content__receipt-info">
                                    <p class="content__receipt-info-text">No: ${receipt.id}</p>
                                <p class="content__receipt-info-text">
                                    Date: ${receipt.date}
                                    Time: ${receipt.time}
                                </p>
                                <p class="content__receipt-info-text">
                                    Importer: ${receipt.importer.fullName eq null ? receipt.importer.username : receipt.importer.fullName}
                                </p>
                                <p class="content__receipt-info-text">Supplier: ${receipt.supplier.companyName}</p>
                                <p class="content__receipt-info-text">Shipper: ${receipt.shipper}</p>
                                <p class="content__receipt-info-text">Note: ${receipt.comment}</p>
                            </div>

                            <table class="content__list-receipt-table">
                                <tbody>
                                    <tr class="content__list-receipt-row">
                                        <th class="content__list-receipt-header">ProductID</th>
                                        <th class="content__list-receipt-header">Product Name</th>
                                        <th class="content__list-receipt-header">Unit</th>
                                        <th class="content__list-receipt-header">Unit Price</th>
                                        <th class="content__list-receipt-header">Quantity</th>
                                        <th class="content__list-receipt-header">Mgf</th>
                                        <th class="content__list-receipt-header">Exp</th>
                                        <th class="content__list-receipt-header">Comment</th>
                                    </tr>
                                    <c:forEach items="${requestScope.receiptDetails}" var="rd">
                                        <tr class="content__list-receipt-row">
                                            <td class="content__list-receipt-col">${rd.product.id}</td>
                                            <td class="content__list-receipt-col">${rd.product.name}</td>
                                            <td class="content__list-receipt-col">${rd.product.unit}</td>
                                            <td class="content__list-receipt-col">${rd.unitPrice}</td>
                                            <td class="content__list-receipt-col">${rd.quantity}</td>
                                            <td class="content__list-receipt-col">${rd.mgf}</td>
                                            <td class="content__list-receipt-col">${rd.exp}</td>
                                            <td class="content__list-receipt-col">${rd.comment}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                            <a class="button button--primary" href="receipt/create">Create new note</a>
                            <a class="button button--green" href="#">View all received note</a>
                        </div>
                    </div>
                </div>
            </div>
            <jsp:include page="../template/footer.jsp" flush="true"/>
        </div>
    </body>
</html>

