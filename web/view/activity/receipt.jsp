<%-- 
    Document   : receipt
    Created on : Oct 31, 2021, 9:04:22 AM
    Author     : quynm
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <jsp:include page="../template/head.jsp" flush="true" />
        <title>Stock in</title>
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
                                        <a class="content__tab-link">
                                            Receipt
                                        </a>
                                    </td>
                                </tr>
                            </table>

                            <h2 class="content__title">Stock in</h2>
                            <span class="errorMsg">${requestScope.msg eq null ? "" : requestScope.msg}</span>
                            <c:if test="${not empty requestScope.receiptID and requestScope.receiptID ne 0}">
                                <a class="errorMsg"
                                   href="receipt/detail?id=${requestScope.receiptID}">
                                    View Goods Received Note.
                                </a>
                            </c:if>
                            <hr/>
                            <form id="createForm" action="receipt/create" method="POST">
                                <div class="content__receipt-info">
                                    <label for="date">Date: </label>
                                    <input id="date" type="date" name="date" value="${requestScope.date}"/>
                                    <label for="time">Time: </label>
                                    <input id="time" type="time" name="time" value="${requestScope.hour}"/><br/>
                                    <label for="importer">Importer: </label>
                                    <input id="importer" type="text" disabled
                                           value="${sessionScope.account.fullName eq null?sessionScope.account.username:sessionScope.account.fullName}"/><br/>
                                    <input type="hidden" name="importer"
                                           value="${sessionScope.account.username}"/><br/>
                                    <label for="supplier">Supplier: </label>
                                    <select id="supplier" name="supplierid">
                                        <c:forEach items="${requestScope.suppliers}" var="sup">
                                            <option value="${sup.id}">${sup.companyName}</option>
                                        </c:forEach>
                                    </select>
                                    <label for="shipper">Shipper: </label>
                                    <input id="shipper" type="text" name="shipper"/><br/>
                                    <label for="commentReceipt">Note: </label>
                                    <textarea rows="1" cols="100" id="commentReceipt" type="text" name="commentReceipt"></textarea><br/>
                                </div>


                                <table class="content__list-receipt-table">
                                    <tbody id="productList" >
                                        <tr class="content__list-receipt-row">
                                            <th class="content__list-receipt-header">ProductID</th>
                                            <th class="content__list-receipt-header">Product Name</th>
                                            <th class="content__list-receipt-header">Unit</th>
                                            <th class="content__list-receipt-header">Unit Price</th>
                                            <th class="content__list-receipt-header">Quantity</th>
                                            <th class="content__list-receipt-header">Mgf</th>
                                            <th class="content__list-receipt-header">Exp</th>
                                            <th class="content__list-receipt-header">Comment</th>
                                            <th class="content__list-receipt-header"> </th>
                                        </tr>
                                        <tr id="lastRow" class="content__list-receipt-row">
                                            <td class="content__list-receipt-col" colspan="9">
                                                <a class="content__create-link" onclick="addReceiptProductRow()">
                                                    <span class="lnr lnr-file-add"></span>
                                                    Add product
                                                </a>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                                <button id="btnSubmit" class="button button--primary" 
                                        onclick="validateSubmit('productList')">Create</button>
                                <p id="errorSubmit" class="errorMsg"></p>
                            </form>
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
