<%-- 
    Document   : accessDenied
    Created on : Oct 18, 2021, 11:20:33 AM
    Author     : quynm
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Access Denied</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <meta charset="UTF-8">
        <!-- CDN to reset CSS -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/8.0.1/normalize.min.css" />
        <!-- CSS -->
        <link rel="stylesheet" href="../css/base.css" />
        <link rel="stylesheet" href="../css/main.css" />
        <link rel="stylesheet" href="../css/grid.css" />
        <link rel="stylesheet" href="assets/css/style_access_denied.css">
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    </head>
    <body>    
        <div class="app">
            <jsp:include page="../template/header.jsp" flush="true"/>
            <div class="content">
                <div class="content-box">
                    <h1 class="w3-jumbo w3-animate-top w3-center"><code>Access Denied</code></h1>
                    <hr class="w3-border-black w3-animate-left" style="margin:auto;width:50%">
                    <h3 class="w3-center w3-animate-right">You don't have permission to view this site.</h3>
                    <h3 class="w3-center w3-animate-zoom">🚫🚫🚫🚫</h3>
                    <h6 class="w3-center w3-animate-zoom"><a href="../home.jsp">Back to home page</a></h6>
                </div>
            </div>
            <jsp:include page="../template/footer.jsp" flush="true"/>
        </div>
    </body>
</html>
