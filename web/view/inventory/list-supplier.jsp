<%-- 
    Document   : list-supplier
    Created on : Oct 25, 2021, 8:40:55 AM
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
                            <table class="content__tab-table">
                                <tr class="content__tab-row">
                                    <td class="content__tab-col">
                                        <a class="content__tab-link" href="product/list">
                                            Products
                                        </a>
                                    </td>
                                    <td class="content__tab-col">
                                        <a class="content__tab-link" href="category/list">
                                            Categories
                                        </a>
                                    </td>
                                    <td class="content__tab-col content__tab-col--active">
                                        <a class="content__tab-link">
                                            Suppliers
                                        </a>
                                    </td>
                                </tr>
                            </table>
                            <a class="content__create-link"
                               data-toggle="modal" data-target="#modalInsert">
                                <span class="lnr lnr-file-add"></span>
                                Add new supplier
                            </a>
                            <table class="content__list-supplier-table">
                                <tr class="content__list-supplier-row">
                                    <th class="content__list-supplier-header">Company Name</th>
                                    <th class="content__list-supplier-header">Contact Name</th>
                                    <th class="content__list-supplier-header">Phone</th>
                                    <th class="content__list-supplier-header">Province</th>
                                    <th class="content__list-supplier-header">Comment</th>
                                    <th class="content__list-supplier-header"> </th>
                                    <th class="content__list-supplier-header"> </th>
                                </tr>
                                <c:forEach items="${requestScope.suppliers}" var="supplier">
                                    <tr class="content__list-supplier-row">
                                        <td class="content__list-supplier-col">
                                            <span class="content__list-supplier-link ${supplier.active?"":"link--disable"}" 
                                                  data-toggle="modal" data-target="#modalUpdate" 
                                                  onclick="passSupplierInfo(${supplier.id}, '${supplier.companyName}',
                                                                '${supplier.contactName}', '${supplier.phone}', 
                                                                '${supplier.email}','${supplier.address}',
                                                                '${supplier.district}', '${supplier.province}',
                                                                ${supplier.active}, '${supplier.comment}')" >
                                                ${supplier.companyName}
                                            </span>
                                        </td>
                                        <td class="content__list-supplier-col">${supplier.contactName}</td>
                                        <td class="content__list-supplier-col">${supplier.phone}</td>
                                        <td class="content__list-supplier-col">${supplier.province}</td>
                                        <td class="content__list-supplier-col">${supplier.comment}</td>
                                        <td class="content__list-supplier-col">
                                            <!--Edit-->
                                            <button type="button" class="button--small button--transparent" 
                                                    data-toggle="modal" data-target="#modalUpdate" 
                                                    onclick="passSupplierInfo(${supplier.id}, '${supplier.companyName}',
                                                                '${supplier.contactName}', '${supplier.phone}', 
                                                                '${supplier.email}','${supplier.address}',
                                                                '${supplier.district}', '${supplier.province}',
                                                                ${supplier.active}, '${supplier.comment}')" >
                                                <span class="lnr lnr-pencil"></span>
                                            </button>
                                        </td>
                                        <td class="content__list-supplier-col">
                                            <!--Delete-->
                                            <!--If this supplier is used and is already inactive, not allow to click to this btn-->
                                            <c:if test="${supplier.used}">
                                                <a class="button--small button--transparent ${supplier.active?"":"button--disable"}" 
                                                   onclick="passToInactiveSupplier(${supplier.id})" 
                                                   data-toggle="modal" data-target="${supplier.active?"#modalPreventDelete":""}">
                                                    <span class="lnr lnr-trash"></span>
                                                </a>
                                            </c:if>
                                            <c:if test="${not supplier.used}">
                                                <a class="button--small button--transparent"
                                                   onclick="passToDeleteSupplier(${supplier.id})" 
                                                   ${supplier.active?"":"disabled"}
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
                        <h3 class="modal-title" id="myModalLabel">ADD SUPPLIER</h3>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <!--Body-->
                    <form action="supplier/add" method="POST">
                        <div class="modal-body">
                            <table class="table table-hover">
                                <tbody>
                                    <tr>
                                        <td>Company Name: </td>
                                        <td><input type="text" name="companyName"/></td>
                                    </tr>
                                    <tr>
                                        <td>Contact Name: </td>
                                        <td><input type="text" name="contactName"/></td>
                                    </tr>
                                    <tr>
                                        <td>Phone: </td>
                                        <td><input type="text" name="phone"/></td>
                                    </tr>
                                    <tr>
                                        <td>Email: </td>
                                        <td><input type="text" name="email"/></td>
                                    </tr>
                                    <tr>
                                        <td>Address: </td>
                                        <td><input type="text" name="address"/></td>
                                    </tr>
                                    <tr>
                                        <td>District: </td>
                                        <td><input type="text" name="district"/></td>
                                    </tr>
                                    <tr>
                                        <td>Province: </td>
                                        <td><input type="text" name="province"/></td>
                                    </tr>
                                    <tr>
                                        <td>Status: </td>
                                        <td>
                                            <input type="checkbox" id="insertStatus" name="status" checked/>
                                            <label for="insertStatus">Active</label>
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
                            <input type="submit" class="button button--primary" value="Add"/>
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
                        <h3 class="modal-title" id="myModalLabel">EDIT SUPPLIER</h3>
                        <button type="button" class="close"  data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <!--Body-->
                    <form action="supplier/update" method="POST">
                        <div class="modal-body">
                            <table class="table table-hover">
                                <tbody>
                                    <tr>
                                        <td>ID: </td>
                                        <td>
                                            <input type="text" disabled id="supID"/>
                                            <input type="hidden" name="id" id="supIDSent"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Company Name: </td>
                                        <td><input type="text" name="companyName" id="supCompanyName"/></td>
                                    </tr>
                                    <tr>
                                        <td>Contact Name: </td>
                                        <td><input type="text" name="contactName" id="supContactName"/></td>
                                    </tr>
                                    <tr>
                                        <td>Phone: </td>
                                        <td><input type="text" name="phone" id="supPhone"/></td>
                                    </tr>
                                    <tr>
                                        <td>Email: </td>
                                        <td><input type="text" name="email" id="supEmail"/></td>
                                    </tr>
                                    <tr>
                                        <td>Address: </td>
                                        <td><input type="text" name="address" id="supAddress"/></td>
                                    </tr>
                                    <tr>
                                        <td>District: </td>
                                        <td><input type="text" name="district" id="supDistrict"/></td>
                                    </tr>
                                    <tr>
                                        <td>Province: </td>
                                        <td><input type="text" name="province" id="supProvince"/></td>
                                    </tr>
                                    <tr>
                                        <td>Status: </td>
                                        <td>
                                            <input type="checkbox" name="status" id="supStatus"/>
                                            <label for="updateStatus">Active</label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Comment: </td>
                                        <td><textarea name="comment" id="supComment" rows="4" cols="25"></textarea></td>
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
                        <p>This supplier has been used in some product. Do you want to inactive it instead?</p>
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
    </body>
</html>
