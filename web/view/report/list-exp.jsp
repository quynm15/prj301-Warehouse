<%-- 
    Document   : list-exp
    Created on : Nov 4, 2021, 5:13:43 PM
    Author     : quynm
--%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <jsp:include page="../template/head.jsp" flush="true" />
        <title>Report</title>
    </head>
    <body onload="createPaggerExpReport('paggerBottom',${requestScope.pageIndex}, 2,${requestScope.totalPages})">
        <div class="app">
            <jsp:include page="../template/header.jsp" flush="true"/>
            <div class="grid">
                <div class="content">
                    <div class="row">
                        <div class="col l-2">
                            <jsp:include page="../template/nav.jsp" flush="true"/>
                        </div>
                        <div class="col l-10">
                            <h2 class="content__title">EXPIRATION PRODUCTS REPORT</h2>
                            <hr/>

                            <table class="content__list-inout-table">
                                <tr class="content__list-inout-row">
                                    <th class="content__list-inout-header">ID</th>
                                    <th class="content__list-inout-header">Product Name</th>
                                    <th class="content__list-inout-header">Unit</th>
                                    <th class="content__list-inout-header">Unit Price</th>
                                    <th class="content__list-inout-header">Received Date</th>
                                    <th class="content__list-inout-header">Exp Date</th>
                                    <th class="content__list-inout-header">Exp Quantity</th>
                                    <th class="content__list-inout-header">Status</th>
                                </tr>
                                <c:forEach items="${requestScope.products}" var="product">
                                    <tr class="content__list-inout-row">
                                        <td class="content__list-inout-col">${product.id}</td>
                                        <td class="content__list-inout-col">${product.name}</td>
                                        <td class="content__list-inout-col">${product.unit}</td>
                                        <fmt:formatNumber value="${product.unitPrice}" type="currency" currencySymbol="" var="unitPrice"/>
                                        <td class="content__list-inout-col">${unitPrice}</td>
                                        <fmt:formatDate value="${product.receiptDate}" pattern="dd-MM-yyyy" var="rdate"/>
                                        <td class="content__list-inout-col">${rdate}</td>
                                        <fmt:formatDate value="${product.expDate}" pattern="dd-MM-yyyy" var="edate"/>
                                        <td class="content__list-inout-col">${edate}</td>
                                        <td class="content__list-inout-col">${product.inStock}</td>
                                        <td class="content__list-inout-col">
                                            <c:if test="${product.dateDiff < 0}">
                                                Over ${product.dateDiff * -1} day(s)
                                            </c:if>
                                            <c:if test="${product.dateDiff >= 0}">
                                                ${product.dateDiff} day(s) left
                                            </c:if>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </table>
                            <div id="paggerBottom" class="pagger pagger_product"></div>
                        </div>
                    </div>
                </div>
            </div>
            <jsp:include page="../template/footer.jsp" flush="true"/>
        </div>
    </body>
</html>
