<%-- 
    Document   : list-inout
    Created on : Nov 3, 2021, 9:02:01 PM
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
    <body onload="createPaggerInout('paggerBottom',${requestScope.pageIndex}, 2,${requestScope.totalPages})">
        <div class="app">
            <jsp:include page="../template/header.jsp" flush="true"/>
            <div class="grid">
                <div class="content">
                    <div class="row">
                        <div class="col l-2">
                            <jsp:include page="../template/nav.jsp" flush="true"/>
                        </div>
                        <div class="col l-10">
                            <h2 class="content__title">GENERAL ACCOUNT OF INPUT - OUTPUT - INVENTORY</h2>
                            <hr/>

                            <div class="content__inout-function">
                                <form action="report/inout" method="POST" class="content__inout-function-form">
                                    From <input type="date" name="from" value="${requestScope.from}"/>
                                    To <input type="date" name="to" value="${requestScope.to}"/>
                                    <select name="categoryid">
                                        <option value="0">All category</option>
                                        <c:forEach items="${requestScope.categories}" var="cate">
                                            <option value="${cate.id}" ${requestScope.selectedCategoryid eq cate.id?"selected":""}>
                                                ${cate.name}
                                            </option>
                                        </c:forEach>
                                    </select>
                                    <select name="supplierid">
                                        <option value="0">All supplier</option>
                                        <c:forEach items="${requestScope.suppliers}" var="sup">
                                            <option value="${sup.id}" ${requestScope.selectedSupplierid eq sup.id?"selected":""}>
                                                ${sup.companyName}
                                            </option>
                                        </c:forEach>
                                    </select>
                                    <input class="btn btn-secondary" type="submit" value="Filter"/>
                                </form>
                            </div>

                            <div class="content__inout-total">
                                <fmt:formatNumber value="${requestScope.totalReceivedValue}" type="currency" currencySymbol="" var="rv"/>
                                <fmt:formatNumber value="${requestScope.totalDeliveredValue}" type="currency" currencySymbol="" var="dv"/>
                                <span class="content__inout-total-text">Total received amount: ${rv}</span>
                                <span class="content__inout-total-text">Total delivered amount: ${dv}</span>
                            </div>

                            <table class="content__list-inout-table">
                                <tr class="content__list-inout-row">
                                    <th class="content__list-inout-header">ID</th>
                                    <th class="content__list-inout-header">Product Name</th>
                                    <th class="content__list-inout-header">Unit</th>
                                    <th class="content__list-inout-header">Unit Price</th>
                                    <th class="content__list-inout-header">Total Received</th>
                                    <th class="content__list-inout-header">Amount</th>
                                    <th class="content__list-inout-header">Total Delivered</th>
                                    <th class="content__list-inout-header">Amount</th>
                                    <th class="content__list-inout-header">Stock</th>
                                </tr>
                                <c:forEach items="${requestScope.products}" var="product">
                                    <tr class="content__list-inout-row">
                                        <td class="content__list-inout-col">${product.id}</td>
                                        <td class="content__list-inout-col">
                                            <span class="content__list-inout-link ${product.active?"":"link--disable"}" 
                                                  data-toggle="modal" data-target="#modalUpdate" 
                                                  onclick="passProInfo('${product.id}', '${product.name}',
                                                  ${product.category.id}, ${product.supplier.id},
                                                                  '${product.unit}', ${product.quantity}, ${product.unitPrice},
                                                  ${product.active}, '${product.comment}')" >
                                                ${product.name}
                                            </span>
                                        </td>
                                        <td class="content__list-inout-col">${product.unit}</td>
                                        <fmt:formatNumber value="${product.unitPrice}" type="currency" currencySymbol="" var="unitPrice"/>
                                        <td class="content__list-inout-col">${unitPrice}</td>
                                        <td class="content__list-inout-col">${product.totalReceived}</td>
                                        <fmt:formatNumber value="${product.totalReceivedAmount}" type="currency" currencySymbol="" var="ramount"/>
                                        <td class="content__list-inout-col">${ramount}</td>
                                        <td class="content__list-inout-col">${product.totalDelivered}</td>
                                        <fmt:formatNumber value="${product.totalDeliveredAmount}" type="currency" currencySymbol="" var="damount"/>
                                        <td class="content__list-inout-col">${damount}</td>
                                        <td class="content__list-inout-col">${product.quantity}</td>
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


        <!--Modal update-->
        <div class="modal fade" id="modalUpdate" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
             aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <!--Header-->
                    <div class="modal-header">
                        <h3 class="modal-title" id="myModalLabel1">DETAIL PRODUCT</h3>
                        <button type="button" class="close"  data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <!--Body-->
                    <form action="product/update" method="POST">
                        <div class="modal-body">
                            <table class="table table-hover">
                                <tbody>
                                    <tr>
                                        <td>ID: </td>
                                        <td>
                                            <input type="text" id="proID" disabled/>
                                            <input type="hidden" name="id" id="proIDSent"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Name: </td>
                                        <td><input type="text" name="name" id="proName" required/></td>
                                    </tr>
                                    <tr>
                                        <td>Category: </td>
                                        <td>
                                            <select name="categoryid" id="proCategory">
                                                <c:forEach items="${requestScope.categories}" var="cate">
                                                    <option value="${cate.id}">${cate.name}</option>
                                                </c:forEach>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Supplier: </td>
                                        <td>
                                            <select name="supplierid" id="proSupplier">
                                                <c:forEach items="${requestScope.suppliers}" var="sup">
                                                    <option value="${sup.id}">${sup.companyName}</option>
                                                </c:forEach>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Unit: </td>
                                        <td><input type="text" name="unit" id="proUnit"/></td>
                                    </tr>
                                    <tr>
                                        <td>Unit Price: </td>
                                        <td><input type="text" name="unitPrice" id="proUnitPrice"/></td>
                                    </tr>
                                    <tr>
                                        <td>Quantity: </td>
                                        <td>
                                            <input type="text" id="proQuantity" disabled/>
                                            <input type="hidden" name="quantity" id="proQuantitySent"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Status: </td>
                                        <td>
                                            <input type="checkbox" name="status" id="proStatus"/>
                                            <label for="updateStatus">Active</label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Comment: </td>
                                        <td><textarea id="proComment" name="comment" rows="4" cols="25"></textarea></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <!--Footer-->
                        <div class="modal-footer">
                            <button type="button" class="button btn-outline-primary" data-dismiss="modal">Close</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- Modal: modal Update -->
    </body>
</html>

