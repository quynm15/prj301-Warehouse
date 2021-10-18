<%-- 
    Document   : listAccount
    Created on : Oct 18, 2021, 12:58:57 PM
    Author     : quynm
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Account Management</title>
    </head>
    <body>
        <c:forEach items="${requestScope.accounts}" var="account">
            ${account.username}<br/>
        </c:forEach>
    </body>
</html>
