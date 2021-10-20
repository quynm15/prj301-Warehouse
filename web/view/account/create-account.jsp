<%-- 
    Document   : create-account
    Created on : Oct 20, 2021, 1:19:25 PM
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
                            <h2 class="content__title">CREATE ACCOUNT</h2>
                            <p class="errorMsg">${requestScope.errorMsg eq null ? "" : requestScope.errorMsg}</p>
                            <hr/>
                            <form action="account/create" method="POST">
                                <div class="content__account-detail">
                                    <table class="content__account-detail-table">
                                        <tr class="content__account-detail-row">
                                            <td class="content__account-detail-title">Username: </td>
                                            <td class="content__account-detail-data">
                                                <input type="text" name="username" required
                                                       value="${requestScope.account.username}"/>
                                                <p class="errorMsg">
                                                    ${requestScope.errorUsername eq null ? "" : requestScope.errorUsername}
                                                </p>
                                            </td>
                                        </tr>
                                        <tr class="content__account-detail-row">
                                            <td class="content__account-detail-title">Full name: </td>
                                            <td class="content__account-detail-data">
                                                <input type="text" name="fullname"
                                                       value="${requestScope.account.fullName}"/>
                                            </td>
                                        </tr>
                                        <tr class="content__account-detail-row">
                                            <td class="content__account-detail-title">Date of birth: </td>
                                            <td class="content__account-detail-data">
                                                <input type="date" name="dob"
                                                       value="${requestScope.account.dob}"/>
                                            </td>
                                        </tr>
                                        <tr class="content__account-detail-row">
                                            <td class="content__account-detail-title">Address: </td>
                                            <td class="content__account-detail-data">
                                                <input type="text" name="address"
                                                       value="${requestScope.account.address}"/>
                                            </td>
                                        </tr>
                                        <tr class="content__account-detail-row">
                                            <td class="content__account-detail-title">Phone: </td>
                                            <td class="content__account-detail-data">
                                                <input type="text" name="phone"
                                                       value="${requestScope.account.phone}"/>
                                            </td>
                                        </tr>
                                        <tr class="content__account-detail-row">
                                            <td class="content__account-detail-title">Email: </td>
                                            <td class="content__account-detail-data">
                                                <input type="text" name="email"
                                                       value="${requestScope.account.email}"/>
                                            </td>
                                        </tr>
                                        <tr class="content__account-detail-row">
                                            <td class="content__account-detail-title">Status: </td>
                                            <td class="content__account-detail-data">
                                                <input type="checkbox" name="status" id="status"
                                                       ${requestScope.account.isActive?"checked = \"checked\"":""} 
                                                       value="active"/>
                                                <label for="status">Active</label>
                                            </td>
                                        </tr>
                                        <tr class="content__account-detail-row">
                                            <td colspan="2">
                                                <input class="button button--primary" type="submit" value="Create"/>
                                                <input class="button button--green" type="reset" value="Clear"/>
                                            </td>
                                        </tr>
                                    </table>
                                    <div class="content__account-detail-permission">
                                        <p class="content__account-detail-title">Permissions: </p>
                                        <c:forEach items="${requestScope.features}" var="feature">
                                            <input type="checkbox" name="permission" id="f${feature.id}"
                                                   <c:forEach items="${requestScope.account.features}" var="af">
                                                       ${af.id eq feature.id ?"checked = \"checked\"":""}
                                                   </c:forEach>
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
