<%-- 
    Document   : my-account
    Created on : Oct 20, 2021, 9:30:25 PM
    Author     : quynm
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <jsp:include page="../template/head.jsp" flush="true" />
        <title>My Account</title>
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
                            <form action="myaccount" method="POST">
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
                                                ${requestScope.account.isActive?"Active":"Inactive"}
                                                <input type="hidden" name="status" 
                                                       value="${requestScope.account.isActive?"active":""}"/>
                                            </td>
                                        </tr>
                                        <tr class="content__account-detail-row">
                                            <td colspan="2">
                                                <input class="button button--primary" type="submit" value="Update"/>
                                                <a class="button button--green" href="change-password">
                                                    Change password
                                                </a>
                                            </td>
                                        </tr>
                                    </table>
                                    <div class="content__account-detail-permission">
                                        <p class="content__account-detail-title">Permissions: </p>
                                        <c:forEach items="${requestScope.features}" var="feature">
                                            <input type="checkbox"
                                                   <c:forEach items="${requestScope.account.features}" var="af">
                                                       ${af.id eq feature.id ?"checked = \"checked\"":""}
                                                   </c:forEach>
                                                   disabled value="${feature.id}"/>
                                            <c:forEach items="${requestScope.account.features}" var="af">
                                                <c:if test="${af.id eq feature.id}">
                                                    <input type="hidden" name="permission" value="${feature.id}"/>
                                                </c:if>
                                            </c:forEach>
                                            ${feature.name}<br/>
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