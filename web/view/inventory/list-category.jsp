<%-- 
    Document   : list-category
    Created on : Oct 22, 2021, 8:38:43 PM
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
                                    <td class="content__tab-col content__tab-col--active">
                                        <a class="content__tab-link">
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
                            <a class="content__create-link"
                               data-toggle="modal" data-target="#modalInsert">
                                <span class="lnr lnr-file-add"></span>
                                Create new category
                            </a>
                            <table class="content__list-category-table">
                                <tr class="content__list-category-row">
                                    <th class="content__list-category-header">Category ID</th>
                                    <th class="content__list-category-header">Category Name</th>
                                    <th class="content__list-category-header">Description</th>
                                    <th class="content__list-category-header"> </th>
                                    <th class="content__list-category-header"> </th>
                                </tr>
                                <c:forEach items="${requestScope.categories}" var="category">
                                    <tr class="content__list-category-row">
                                        <td class="content__list-category-col">${category.id}</td>
                                        <td class="content__list-category-col">
                                            <span class="content__list-category-link ${category.active?"":"link--disable"}" 
                                                  data-toggle="modal" data-target="#modalUpdate" 
                                                  onclick="passCateInfo(${category.id}, '${category.name}',
                                                                  '${category.description}', ${category.active})" >
                                                ${category.name}
                                            </span>
                                        </td>
                                        <td class="content__list-category-col">${category.description}</td>
                                        <td class="content__list-category-col">
                                            <!--Edit-->
                                            <button type="button" class="button--small button--transparent" 
                                                    data-toggle="modal" data-target="#modalUpdate" 
                                                    onclick="passCateInfo(${category.id}, '${category.name}',
                                                                    '${category.description}', ${category.active})" >
                                                <span class="lnr lnr-pencil"></span>
                                            </button>
                                        </td>
                                        <td class="content__list-category-col">
                                            <!--Delete-->
                                            <!--If this category is used and is already inactive, not allow to click to this btn-->
                                            <c:if test="${category.used}">
                                                <a class="button--small button--transparent ${category.active?"":"button--disable"}" 
                                                   onclick="passToInactiveCategory(${category.id})" 
                                                   data-toggle="modal" data-target="${category.active?"#modalPreventDelete":""}">
                                                    <span class="lnr lnr-trash"></span>
                                                </a>
                                            </c:if>
                                            <c:if test="${not category.used}">
                                                <a class="button--small button--transparent"
                                                   onclick="passToDeleteCategory(${category.id})" 
                                                   ${category.active?"":"disabled"}
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
                        <h3 class="modal-title" id="myModalLabel">CREATE CATEGORY</h3>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <!--Body-->
                    <form action="category/create" method="POST">
                        <div class="modal-body">
                            <table class="table table-hover">
                                <tbody>
                                    <tr>
                                        <td>Name: </td>
                                        <td><input type="text" name="insertName" required/></td>
                                    </tr>
                                    <tr>
                                        <td>Description: </td>
                                        <td><textarea name="insertDesc" rows="4" cols="25"></textarea></td>
                                    </tr>
                                    <tr>
                                        <td>Status: </td>
                                        <td>
                                            <input type="checkbox" id="status" name="insertStatus" checked/>
                                            <label for="status">Active</label>
                                        </td>
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
                        <h3 class="modal-title" id="myModalLabel">EDIT CATEGORY</h3>
                        <button type="button" class="close"  data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <!--Body-->
                    <form action="category/update" method="POST">
                        <div class="modal-body">
                            <table class="table table-hover">
                                <tbody>
                                    <tr>
                                        <td>ID: </td>
                                        <td>
                                            <input type="text" id="cateID" disabled/>
                                            <input type="hidden" name="updateID" id="cateIDSent"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Name: </td>
                                        <td><input type="text" name="updateName" id="cateName" required/></td>
                                    </tr>
                                    <tr>
                                        <td>Description: </td>
                                        <td>
                                            <textarea name="updateDesc" id="cateDesc" rows="4" cols="25"></textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Status: </td>
                                        <td>
                                            <input type="checkbox" name="updateStatus" id="cateStatus"/>
                                            <label for="updateStatus">Active</label>
                                        </td>
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
                        <p>This category has been used in some product. Do you want to inactive it instead?</p>
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