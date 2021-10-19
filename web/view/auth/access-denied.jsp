<%-- 
    Document   : accessDenied
    Created on : Oct 18, 2021, 11:20:33 AM
    Author     : quynm
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="../template/head.jsp" flush="true" />
        <link rel="stylesheet" href="view/auth/assets/css/style_access_denied.css">
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <title>Access Denied</title>
    </head>
    <body>    
        <div class="app">
            <jsp:include page="/view/template/header.jsp" flush="true"/>
            <div class="content">
                <div class="content-box">
                    <h1 class="w3-jumbo w3-animate-top w3-center"><code>Access Denied</code></h1>
                    <hr class="w3-border-black w3-animate-left" style="margin:auto;width:50%">
                    <h3 class="w3-center w3-animate-right">You don't have permission to view this site.</h3>
                    <h3 class="w3-center w3-animate-zoom">🚫🚫🚫🚫</h3>
                    <h6 class="w3-center w3-animate-zoom"><a href="home">Back to home page</a></h6>
                </div>
            </div>
            <jsp:include page="/view/template/footer.jsp" flush="true"/>
        </div>
    </body>
</html>
