<%-- 
    Document   : list-receipt
    Created on : Nov 2, 2021, 10:18:58 PM
    Author     : quynm
--%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <jsp:include page="../template/head.jsp" flush="true" />
        <title>List Goods receipt notes</title>
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
                            <h2 class="content__title">List Goods receipt notes</h2>
                            <hr/>
                            <div class="content__list-receipt-report-filter">
                                <form action="" method="POST">
                                    From <input type="date" name="from" value="${requestScope.from}"/>
                                    To <input type="date" name="to" value="${requestScope.to}"/>
                                    Supply by: 
                                    <select name="supplierID">
                                        <option value="0">All suppliers</option>
                                        <c:forEach items="${requestScope.suppliers}" var="sup">
                                            <option value="${sup.id}" ${requestScope.selectedSupplierid eq sup.id?"selected":""}>
                                                ${sup.companyName}
                                            </option>
                                        </c:forEach>
                                    </select>
                                    <input class="btn btn-danger" type="submit" value="Filter"/>
                                </form>
                            </div>
                            <table class="content__list-receipt-report-table">
                                <tr class="content__list-receipt-report-row">
                                    <th class="content__list-receipt-report-header">Receipt ID</th>
                                    <th class="content__list-receipt-report-header">Date</th>
                                    <th class="content__list-receipt-report-header">Importer</th>
                                    <th class="content__list-receipt-report-header">Supplier</th>
                                    <th class="content__list-receipt-report-header">Value</th>
                                    <th class="content__list-receipt-report-header"> </th>
                                    <!--<th class="content__list-receipt-report-header"> </th>-->
                                </tr>
                                <c:set value="${requestScope.receipts}" var="receipts"></c:set>
                                <c:forEach items="${receipts}" var="receipt">
                                    <fmt:formatDate value="${receipt.date}" pattern="dd-MM-yyyy" var="date"/>
                                    <fmt:formatNumber value="${receipt.value}" type="currency" currencySymbol=" " var="value"/>
                                    <tr class="content__list-receipt-report-row">
                                        <td class="content__list-receipt-report-col">
                                            <a class="content__list-receipt-report-link" href="receipt/detail?id=${receipt.id}">
                                                ${receipt.id}
                                            </a>
                                        </td>
                                        <td class="content__list-receipt-report-col">${date}</td>
                                        <td class="content__list-receipt-report-col">${receipt.importer.username}</td>
                                        <td class="content__list-receipt-report-col">${receipt.supplier.companyName}</td>
                                        <td class="content__list-receipt-report-col">${value}</td>
                                        <td class="content__list-receipt-report-col">
                                            <a class="content__list-receipt-report-link" href="receipt/detail?id=${receipt.id}">
                                                Detail
                                            </a>
                                        </td>
<!--                                        <td class="content__list-receipt-report-col">
                                            Delete
                                            <a class="button--small button--transparent" 
                                               onclick="passToDeleteReceipt(${receipt.id})" 
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
