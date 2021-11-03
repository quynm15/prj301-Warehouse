<%-- 
    Document   : list-delivery
    Created on : Nov 3, 2021, 4:07:05 PM
    Author     : quynm
--%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <jsp:include page="../template/head.jsp" flush="true" />
        <title>List Goods delivery notes</title>
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
                            <h2 class="content__title">List Goods delivery notes</h2>
                            <hr/>
                            <div class="content__list-receipt-report-filter">
                                <form action="" method="POST">
                                    From <input type="date" name="from" value="${requestScope.from}"/>
                                    To <input type="date" name="to" value="${requestScope.to}"/>
                                    <input class="btn btn-danger" type="submit" value="Filter"/>
                                </form>
                            </div>
                            <table class="content__list-receipt-report-table">
                                <tr class="content__list-receipt-report-row">
                                    <th class="content__list-receipt-report-header">Delivery ID</th>
                                    <th class="content__list-receipt-report-header">Date</th>
                                    <th class="content__list-receipt-report-header">Exporter</th>
                                    <th class="content__list-receipt-report-header">Recipient</th>
                                    <th class="content__list-receipt-report-header">Value</th>
                                    <th class="content__list-receipt-report-header"> </th>
                                    <!--<th class="content__list-delivery-report-header"> </th>-->
                                </tr>
                                <c:set value="${requestScope.deliveries}" var="deliveries"></c:set>
                                <c:forEach items="${deliveries}" var="delivery">
                                    <fmt:formatDate value="${delivery.date}" pattern="dd-MM-yyyy" var="date"/>
                                    <fmt:formatNumber value="${delivery.value}" type="currency" currencySymbol=" " var="value"/>
                                    <tr class="content__list-receipt-report-row">
                                        <td class="content__list-receipt-report-col">
                                            <a class="content__list-receipt-report-link" href="delivery/detail?id=${delivery.id}">
                                                ${delivery.id}
                                            </a>
                                        </td>
                                        <td class="content__list-receipt-report-col">${date}</td>
                                        <td class="content__list-receipt-report-col">${delivery.exporter.username}</td>
                                        <td class="content__list-receipt-report-col">${delivery.recipient}</td>
                                        <td class="content__list-receipt-report-col">${value}</td>
                                        <td class="content__list-receipt-report-col">
                                            <a class="content__list-receipt-report-link" href="delivery/detail?id=${delivery.id}">
                                                Detail
                                            </a>
                                        </td>
<!--                                        <td class="content__list-receipt-report-col">
                                            Delete
                                            <a class="button--small button--transparent" 
                                               onclick="passToDeleteReceipt(${delivery.id})" 
                                               data-toggle="modal" data-target="#modalConfirmDelete">
                                                <span class="lnr lnr-trash"></span>
                                            </a>
                                        </td>-->
                                    </tr>
                                </c:forEach>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <jsp:include page="../template/footer.jsp" flush="true"/>
        </div>

        <!--Modal: modal Confirm Delete-->
        <div id="modalConfirmDelete" class="modal fade js-delete">
            <div class="modal-dialog modal-confirm">
                <div class="modal-content">
                    <div class="modal-header flex-column">
                        <div class="icon-box">
                            <i class="material-icons">&#xE5CD;</i>
                        </div>						
                        <h4 class="modal-title w-100">Are you sure?</h4>	
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    </div>
                    <div class="modal-body">
                        <p>Do you really want to delete this record? This process cannot be undone.</p>
                    </div>
                    <div class="modal-footer justify-content-center">
                        <button type="button" id="cancelConfirmDelete" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                        <a id="confirmDelete" class="btn btn-danger">Delete</a>
                    </div>
                </div>
            </div>
        </div>
        <!--Modal: modal Confirm Delete-->
    </body>
</html>
