<%-- 
    Document   : detail-account
    Created on : Oct 18, 2021, 8:13:16 PM
    Author     : quynm
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <jsp:include page="../template/head.jsp" flush="true" />
        <title>Account Management</title>
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
                            <h2 class="content__title">ACCOUNT DETAIL</h2>
                            <p class="errorMsg">${requestScope.updateMsg eq null ? "" : requestScope.updateMsg}</p>
                            <hr/>
                            <form action="account/update" method="POST">
                                <div class="content__account-detail">
                                    <table class="content__account-detail-table">
                                        <tr class="content__account-detail-row">
                                            <td class="content__account-detail-title">Username: </td>
                                            <td class="content__account-detail-data">
                                                <input type="text" name="username" readonly value="${requestScope.account.username}"/>
                                            </td>
                                        </tr>
                                        <tr class="content__account-detail-row">
                                            <td class="content__account-detail-title">Full name: </td>
                                            <td class="content__account-detail-data">
                                                <input type="text" name="fullname" value="${requestScope.account.fullName}"/>
                                            </td>
                                        </tr>
                                        <tr class="content__account-detail-row">
                                            <td class="content__account-detail-title">Date of birth: </td>
                                            <td class="content__account-detail-data">
                                                <input type="date" name="dob" value="${requestScope.account.dob}"/>
                                                <p class="errorMsg">
                                                    ${requestScope.errorDob eq null ? "" : requestScope.errorDob}
                                                </p>
                                            </td>
                                        </tr>
                                        <tr class="content__account-detail-row">
                                            <td class="content__account-detail-title">Address: </td>
                                            <td class="content__account-detail-data">
                                                <input type="text" name="address" value="${requestScope.account.address}"/>
                                            </td>
                                        </tr>
                                        <tr class="content__account-detail-row">
                                            <td class="content__account-detail-title">Phone: </td>
                                            <td class="content__account-detail-data">
                                                <input type="text" name="phone" value="${requestScope.account.phone}"/>
                                            </td>
                                        </tr>
                                        <tr class="content__account-detail-row">
                                            <td class="content__account-detail-title">Email: </td>
                                            <td class="content__account-detail-data">
                                                <input type="text" name="email" value="${requestScope.account.email}"/>
                                            </td>
                                        </tr>
                                        <tr class="content__account-detail-row">
                                            <td class="content__account-detail-title">Status: </td>
                                            <td class="content__account-detail-data">
                                                <input type="checkbox" name="status" id="status"
                                                       ${requestScope.account.isActive?"checked = \"checked\"":""}
                                                       ${requestScope.account.username eq "admin" ? "disabled":""} 
                                                       value="active"/>
                                                <label for="status">Active</label>
                                            </td>
                                        </tr>
                                        <tr class="content__account-detail-row">
                                            <td colspan="2">
                                                <input class="button button--primary" type="submit" value="Update"/>
                                                <a class="button button--green" 
                                                   href="account/reset-pass?username=${requestScope.account.username}">
                                                    Reset password
                                                </a>
                                            </td>
                                        </tr>
                                        <tr class="content__account-detail-row">
                                            <td colspan="2">
                                                <a class="button button--red" 
                                                   href="account/update?username=${requestScope.account.username}"
                                                   ${requestScope.account.username eq "admin" ? "style=\"display: none;\"":""}>
                                                    Delete Account
                                                </a>
                                            </td>
                                        </tr>
                                    </table>
                                    <div class="content__account-detail-permission">
                                        <p>
                                            <strong>Permissions:</strong> &nbsp;&nbsp;
                                            <input type="checkbox" id="checkAll" onclick="toggleAllPermissions(this)"
                                                   ${requestScope.account.username eq "admin" ? "disabled checked":""}/> 
                                            <label for="checkAll"> Select all</label>
                                        </p>
                                        <c:forEach items="${requestScope.features}" var="feature">
                                            <input type="checkbox" name="permission" id="f${feature.id}"
                                                   <c:forEach items="${requestScope.account.features}" var="af">
                                                       ${af.id eq feature.id ?"checked = \"checked\"":""}
                                                   </c:forEach>
                                                   ${requestScope.account.username eq "admin" ? "disabled":""}
                                                   value="${feature.id}"/> 
                                                   <label for="f${feature.id}"> ${feature.name} </label> <br/>
                                        </c:forEach>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <jsp:include page="../template/footer.jsp" flush="true"/>
        </div>
    </body>
</html>

