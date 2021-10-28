<%-- 
    Document   : list-product
    Created on : Oct 22, 2021, 4:31:15 PM
    Author     : quynm
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <jsp:include page="../template/head.jsp" flush="true" />
        <title>Inventory</title>
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
                            <!--<h2 class="content__title">INVENTORY</h2>
                            <hr/>-->
                            <table class="content__tab-table">
                                <tr class="content__tab-row">
                                    <td class="content__tab-col content__tab-col--active">
                                        <a class="content__tab-link">
                                            Products
                                        </a>
                                    </td>
                                    <td class="content__tab-col">
                                        <a class="content__tab-link" href="category/list">
                                            Categories
                                        </a>
                                    </td>
                                    <td class="content__tab-col">
                                        <a class="content__tab-link" href="supplier/list">
                                            Suppliers
                                        </a>
                                    </td>
                                </tr>
                            </table>
                            <div class="content__product-function">
                                <a class="content__create-link"
                                   data-toggle="modal" data-target="#modalInsert">
                                    <span class="lnr lnr-file-add"></span>
                                    Create new product
                                </a>

                                <form action="product/list" method="POST" id="filterProduct" class="content__product-function-form">
                                    <span class="content__product-function-title">Filter: </span>
                                    <select name="categoryid" onchange="submitForm('filterProduct')">
                                        <option value="0">All category</option>
                                        <c:forEach items="${requestScope.categories}" var="cate">
                                            <option value="${cate.id}" ${requestScope.selectedCategoryid eq cate.id?"selected":""}>
                                                ${cate.name}
                                            </option>
                                        </c:forEach>
                                    </select>
                                    <select name="supplierid" onchange="submitForm('filterProduct')">
                                        <option value="0">All supplier</option>
                                        <c:forEach items="${requestScope.suppliers}" var="sup">
                                            <option value="${sup.id}" ${requestScope.selectedSupplierid eq sup.id?"selected":""}>
                                                ${sup.companyName}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </form>
                            </div>

                            <table class="content__list-product-table">

                                <tr class="content__list-product-row">
                                    <th class="content__list-product-header">ID</th>
                                    <th class="content__list-product-header">Product Name</th>
                                    <th class="content__list-product-header">Category</th>
                                    <th class="content__list-product-header">Supplier</th>
                                    <th class="content__list-product-header">Unit</th>
                                    <th class="content__list-product-header">Quantity</th>
                                    <th class="content__list-product-header"> </th>
                                    <th class="content__list-product-header"> </th>
                                </tr>
                                <c:forEach items="${requestScope.products}" var="product">
                                    <tr class="content__list-product-row">
                                        <td class="content__list-product-col">${product.id}</td>
                                        <td class="content__list-product-col">
                                            <span class="content__list-product-link ${product.active?"":"link--disable"}" 
                                                  data-toggle="modal" data-target="#modalUpdate" 
                                                  onclick="passProInfo('${product.id}', '${product.name}',
                                                  ${product.category.id}, ${product.supplier.id},
                                                                  '${product.unit}', ${product.quantity}, ${product.unitPrice},
                                                  ${product.active}, '${product.comment}')" >
                                                ${product.name}
                                            </span>
                                        </td>
                                        <td class="content__list-product-col">
                                            <span class="content__list-product-link ${product.category.active?"":"link--disable"}" 
                                                  data-toggle="modal" data-target="#modalDetailCategory" 
                                                  onclick="passCateInfo(${product.category.id}, '${product.category.name}',
                                                                  '${product.category.description}', ${product.category.active})" >
                                                ${product.category.name}
                                            </span>
                                        </td>
                                        <td class="content__list-product-col">
                                            <span class="content__list-supplier-link ${product.supplier.active?"":"link--disable"}" 
                                                  data-toggle="modal" data-target="#modalDetailSupplier" 
                                                  onclick="passSupplierInfo(${product.supplier.id}, '${product.supplier.companyName}',
                                                                  '${product.supplier.contactName}', '${product.supplier.phone}',
                                                                  '${product.supplier.email}', '${product.supplier.address}',
                                                                  '${product.supplier.district}', '${product.supplier.province}',
                                                  ${product.supplier.active}, '${product.supplier.comment}')" >
                                                ${product.supplier.companyName}
                                            </span>
                                        </td>
                                        <td class="content__list-product-col">${product.unit}</td>
                                        <td class="content__list-product-col">${product.quantity}</td>
                                        <td class="content__list-product-col">
                                            <!--Edit-->
                                            <button type="button" class="button--small button--transparent" 
                                                    data-toggle="modal" data-target="#modalUpdate" 
                                                    onclick="passProInfo('${product.id}', '${product.name}',
                                                    ${product.category.id}, ${product.supplier.id},
                                                                    '${product.unit}', ${product.quantity}, ${product.unitPrice},
                                                    ${product.active}, '${product.comment}')" >
                                                <span class="lnr lnr-pencil"></span>
                                            </button>
                                        </td>
                                        <td class="content__list-product-col">
                                            <!--Delete-->
                                            <!--If this product is used and is already inactive, not allow to click to this btn-->
                                            <c:if test="${product.used}">
                                                <a class="button--small button--transparent ${product.active?"":"button--disable"}" 
                                                   onclick="passToInactiveProduct('${product.id}')" 
                                                   data-toggle="modal" data-target="${product.active?"#modalPreventDelete":""}">
                                                    <span class="lnr lnr-trash"></span>
                                                </a>
                                            </c:if>
                                            <c:if test="${not product.used}">
                                                <a class="button--small button--transparent"
                                                   onclick="passToDeleteProduct('${product.id}')" 
                                                   ${product.active?"":"disabled"}
                                                   data-toggle="modal" data-target="#modalConfirmDelete">
                                                    <span class="lnr lnr-trash"></span>
                                                </a>
                                            </c:if>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <jsp:include page="../template/footer.jsp" flush="true"/>
        </div>

        <!--Modal insert-->
        <div class="modal fade" id="modalInsert" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
             aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <!--Header-->
                    <div class="modal-header">
                        <h3 class="modal-title" id="myModalLabel">CREATE PRODUCT</h3>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <!--Body-->
                    <form action="product/create" method="POST">
                        <div class="modal-body">
                            <table class="table table-hover">
                                <tbody>
                                    <tr>
                                        <td>ID: </td>
                                        <td><input type="text" name="id"/></td>
                                    </tr>
                                    <tr>
                                        <td>Name: </td>
                                        <td><input type="text" name="name"/></td>
                                    </tr>
                                    <tr>
                                        <td>Category: </td>
                                        <td>
                                            <select name="categoryid">
                                                <c:forEach items="${requestScope.categories}" var="cate">
                                                    <option value="${cate.id}">${cate.name}</option>
                                                </c:forEach>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Supplier: </td>
                                        <td>
                                            <select name="supplierid">
                                                <c:forEach items="${requestScope.suppliers}" var="sup">
                                                    <option value="${sup.id}">${sup.companyName}</option>
                                                </c:forEach>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Unit: </td>
                                        <td><input type="text" name="unit"/></td>
                                    </tr>
                                    <tr>
                                        <td>Unit Price: </td>
                                        <td><input type="text" name="unitPrice"/></td>
                                    </tr>
                                    <tr>
                                        <td>Status: </td>
                                        <td>
                                            <input type="checkbox" id="status" name="insertStatus" checked/>
                                            <label for="status">Active</label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Comment: </td>
                                        <td><textarea name="comment" rows="4" cols="25"></textarea></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <!--Footer-->
                        <div class="modal-footer">
                            <button type="button" class="button btn-outline-primary" data-dismiss="modal">Close</button>
                            <input type="submit" class="button button--primary" value="Create"/>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- Modal: modal Insert -->

        <!--Modal update-->
        <div class="modal fade" id="modalUpdate" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
             aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <!--Header-->
                    <div class="modal-header">
                        <h3 class="modal-title" id="myModalLabel1">EDIT PRODUCT</h3>
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
                                        <td><input type="text" name="name" id="proName"/></td>
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
                            <input type="submit" class="button button--primary" value="Update"/>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- Modal: modal Update -->

        <!--Modal: modal Prevent Delete-->
        <div id="modalPreventDelete" class="modal fade js-delete">
            <div class="modal-dialog modal-confirm">
                <div class="modal-content">
                    <div class="modal-header flex-column">
                        <div class="icon-box-warning">
                            <i class="material-icons">report_problem</i>
                        </div>						
                        <h4 class="modal-title w-100">Can not delete</h4>	
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    </div>
                    <div class="modal-body">
                        <p>This product has been used. Do you want to inactive it instead?</p>
                    </div>
                    <div class="modal-footer justify-content-center">
                        <button type="button" id="cancelConfirmDelete" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                        <a id="confirmInactive" class="btn btn-warning">Yes</a>
                    </div>
                </div>
            </div>
        </div>     
        <!--Modal: modal Prevent Delete-->

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

        <!--Modal Detailed category-->
        <div class="modal fade" id="modalDetailCategory" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
             aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <!--Header-->
                    <div class="modal-header">
                        <h3 class="modal-title" id="myModalLabel2">CATEGORY DETAIL</h3>
                        <button type="button" class="close"  data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <!--Body-->
                    <div class="modal-body">
                        <table class="table table-hover">
                            <tbody>
                                <tr>
                                    <td>ID: </td>
                                    <td>
                                        <input type="text" id="cateID" disabled/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Name: </td>
                                    <td><input type="text" name="updateName" id="cateName" disabled/></td>
                                </tr>
                                <tr>
                                    <td>Description: </td>
                                    <td>
                                        <textarea name="updateDesc" id="cateDesc" rows="4" cols="25" disabled></textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Status: </td>
                                    <td>
                                        <input type="checkbox" name="updateStatus" id="cateStatus" disabled/>
                                        <label for="updateStatus">Active</label>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <!--Footer-->
                    <div class="modal-footer">
                        <button type="button" class="button btn-outline-primary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Modal: modal Detailed category -->

        <!--Modal Detail Supplier-->
        <div class="modal fade" id="modalDetailSupplier" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
             aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <!--Header-->
                    <div class="modal-header">
                        <h3 class="modal-title" id="myModalLabel3">SUPPLIER DETAIL</h3>
                        <button type="button" class="close"  data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <!--Body-->
                    <div class="modal-body">
                        <table class="table table-hover">
                            <tbody>
                                <tr>
                                    <td>ID: </td>
                                    <td>
                                        <input type="text" disabled id="supID"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Company Name: </td>
                                    <td><input type="text" name="companyName" id="supCompanyName" disabled/></td>
                                </tr>
                                <tr>
                                    <td>Contact Name: </td>
                                    <td><input type="text" name="contactName" id="supContactName" disabled/></td>
                                </tr>
                                <tr>
                                    <td>Phone: </td>
                                    <td><input type="text" name="phone" id="supPhone" disabled/></td>
                                </tr>
                                <tr>
                                    <td>Email: </td>
                                    <td><input type="text" name="email" id="supEmail" disabled/></td>
                                </tr>
                                <tr>
                                    <td>Address: </td>
                                    <td><input type="text" name="address" id="supAddress" disabled/></td>
                                </tr>
                                <tr>
                                    <td>District: </td>
                                    <td><input type="text" name="district" id="supDistrict" disabled/></td>
                                </tr>
                                <tr>
                                    <td>Province: </td>
                                    <td><input type="text" name="province" id="supProvince" disabled/></td>
                                </tr>
                                <tr>
                                    <td>Status: </td>
                                    <td>
                                        <input type="checkbox" name="status" id="supStatus" disabled/>
                                        <label for="updateStatus">Active</label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Comment: </td>
                                    <td><textarea id="updateComment" name="comment" rows="4" cols="25" disabled></textarea></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <!--Footer-->
                    <div class="modal-footer">
                        <button type="button" class="button btn-outline-primary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Modal: modal Detail Supplier -->

    </body>
</html>
