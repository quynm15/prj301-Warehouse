<%-- 
    Document   : listAccount
    Created on : Oct 18, 2021, 12:58:57 PM
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
                            <h2 class="content__title">LIST ACCOUNTS</h2>
                            <hr/>
                            <table class="content__list-account-table">
                                <tr class="content__list-account-row">
                                    <th class="content__list-account-header">USERNAME</th>
                                    <th class="content__list-account-header">FULL NAME</th>
                                    <th class="content__list-account-header">PHONE</th>
                                    <th class="content__list-account-header">EMAIL</th>
                                    <th class="content__list-account-header">ADDRESS</th>
                                </tr>
                                <c:forEach items="${requestScope.accounts}" var="account">
                                    <tr class="content__list-account-row">
                                        <td class="content__list-account-col">
                                            <a class="content__list-account-link" href="account/detail?username=${account.username}">
                                                ${account.username}
                                            </a>
                                        </td>
                                        <td class="content__list-account-col">${account.fullName}</td>
                                        <td class="content__list-account-col">${account.phone}</td>
                                        <td class="content__list-account-col">${account.email}</td>
                                        <td class="content__list-account-col">${account.address}</td>
                                    </tr>
                                </c:forEach>
                                <tr class="content__list-account-row">
                                    <td colspan="5" class="content__list-account-col">
                                        <a class="content__list-account-link" href="account/create">
                                            <span class="lnr lnr-file-add"></span>
                                            Create new account
                                        </a>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <jsp:include page="../template/footer.jsp" flush="true"/>
        </div>
    </body>
</html>
