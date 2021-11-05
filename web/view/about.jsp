<%-- 
    Document   : About
    Created on : Nov 5, 2021, 11:11:03 PM
    Author     : quynm
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <jsp:include page="template/head.jsp" flush="true" />
        <title>MQ Warehouse</title>
    </head>
    <body>
        <div class="app">
            <jsp:include page="template/header.jsp" flush="true"/>
            <div class="content-about">
                <p class="content-about__text">
                    The <strong>MQ Warehouse</strong> is the product of my Assignment on PRJ301 - Java web application.
                </p><br/>
                <p class="content-about__text">
                    <strong>About me:</strong>
                </p>
                <p class="content-about__text">
                    Nguyen Manh Quy - FPT University Student
                </p>
                <p class="content-about__text">
                    Contact for work: quynm15@gmail.com
                </p> <br/><br/>
                <p class="content-about__text">
                    Since it is the first product, it may have unexpected errors. Please contact me for any feedback. 
                </p>
                <p class="content-about__text">
                    Your feedback will be a valuable resource to help me improve this product.
                </p>
                <p class="content-about__text">
                    Sincere thanks.
                </p>
                <p class="content-about__text">
                    <a href="mailto:quynm15@gmail.com" class="button button--primary">Email me</a> 
                </p>
            </div>
            <jsp:include page="template/footer.jsp" flush="true"/>
        </div>
    </body>
</html>
