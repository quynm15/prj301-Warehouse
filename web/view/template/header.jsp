<%-- 
    Document   : header
    Created on : Oct 17, 2021, 8:57:59 AM
    Author     : quynm
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
    </head>
    <body>
        <header class="header">
            <a class="header__logo" href="home">MQ <span>Warehouse</span></a>
            <nav class="header__navbar">
                <ul class="header__navbar-list">
                    <li class="header__navbar-item">
                        <a class="header__navbar-link" href="home">HOME</a>
                    </li>
                    <li class="header__navbar-item">
                        <a class="header__navbar-link" href="about">ABOUT</a>
                    </li>
                    <!-- User -->
                    <c:if test="${empty sessionScope.account}">
                        <a class="header__navbar-link" href="login"> Login </a>
                    </c:if>
                    <c:if test="${not empty sessionScope.account}">
                        <li class="header__navbar-item navbar-user__container">
                            <a class="header__navbar-link" href="myaccount"> 
                                Hi, ${empty sessionScope.account.fullName ? sessionScope.account.username : sessionScope.account.fullName} 
                            </a>
                            <div class="navbar-user">
                                <ul class="navbar-user__list">
                                    <li class="navbar-user__item">
                                        <a class="navbar-user__link" href="myaccount">Account</a>
                                    </li>
                                    <li class="navbar-user__item">
                                        <a class="navbar-user__link" href="change-password">Change password</a>
                                    </li>
                                    <li class="navbar-user__item">
                                        <a class="navbar-user__link" href="logout">Log out</a>
                                    </li>
                                </ul>
                            </div>
                        </li>
                    </c:if>
                </ul>
            </nav>
        </header>
    </body>
</html>
