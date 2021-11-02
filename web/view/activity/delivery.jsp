<%-- 
    Document   : delivery
    Created on : Oct 31, 2021, 9:04:02 AM
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
                                    <td class="content__tab-col content__tab-col--active">
                                        <a class="content__tab-link">
                                            Delivery
                                        </a>
                                    </td>
                                    <td class="content__tab-col">
                                        <a class="content__tab-link" href="receipt/create">
                                            Receipt
                                        </a>
                                    </td>
                                </tr>
                            </table>

                            <h2 class="content__title">Stock out</h2>
                            <span class="errorMsg">${requestScope.msg eq null ? "" : requestScope.msg}</span>
                            <c:if test="${not empty requestScope.deliveryID and requestScope.deliveryID ne 0}">
                                <a class="errorMsg"
                                   href="delivery/detail?id=${requestScope.deliveryID}">
                                    View Goods Delivery Note.
                                </a>
                            </c:if>
                            <hr/>
                            <form id="createForm" action="delivery/create" method="POST">
                                <div class="content__receipt-info">
                                    <label for="date">Date: </label>
                                    <input id="date" type="date" name="date" value="${requestScope.date}"/>
                                    <label for="time">Time: </label>
                                    <input id="time" type="time" name="time" value="${requestScope.hour}"/><br/>
                                    <label for="exporter">Exporter: </label>
                                    <input id="exporter" type="text" disabled
                                           value="${sessionScope.account.fullName eq null?sessionScope.account.username:sessionScope.account.fullName}"/><br/>
                                    <input type="hidden" name="exporter"
                                           value="${sessionScope.account.username}"/><br/>
                                    <label for="recipient">Recipient: </label>
                                    <input id="recipient" type="text" name="recipient"/><br/>
                                    <label for="commentDelivery">Note: </label>
                                    <textarea rows="1" cols="100" id="commentDelivery" type="text" name="commentDelivery"></textarea><br/>
                                </div>


                                <table class="content__list-delivery-table">
                                    <tbody id="productList" >
                                        <tr class="content__list-delivery-row">
                                            <th class="content__list-delivery-header">ProductID</th>
                                            <th class="content__list-delivery-header">Product Name</th>
                                            <th class="content__list-delivery-header">Unit</th>
                                            <th class="content__list-delivery-header">Unit Price</th>
                                            <th class="content__list-delivery-header">Quantity</th>
                                            <th class="content__list-delivery-header">Comment</th>
                                            <th class="content__list-delivery-header"> </th>
                                        </tr>
                                        <tr id="lastRow" class="content__list-delivery-row">
                                            <td class="content__list-delivery-col" colspan="7">
                                                <a class="content__create-link" onclick="addDeliveryProductRow()">
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

