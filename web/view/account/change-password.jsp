<%-- 
    Document   : change-password
    Created on : Oct 20, 2021, 10:17:52 PM
    Author     : quynm
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <jsp:include page="../template/head.jsp" flush="true" />
        <title>Change password</title>
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
                            <h2 class="content__title">CHANGE PASSWORD</h2>
                            <p class="errorMsg">${requestScope.errorMsg eq null ? "" : requestScope.errorMsg}</p>
                            <hr/>
                            <form action="change-password" method="POST">
                                <div class="content__account-detail">
                                    <table class="content__account-detail-table">
                                        <tr class="content__account-detail-row">
                                            <td class="content__account-detail-data">Username: </td>
                                            <td class="content__account-detail-data">
                                                <input type="text" name="username" disabled value="${sessionScope.account.username}"/>
                                            </td>
                                        </tr>
                                        <tr class="content__account-detail-row">
                                            <td class="content__account-detail-data">Old password: </td>
                                            <td class="content__account-detail-data">
                                                <input type="password" name="oldPass" required/>
                                            </td>
                                        </tr>
                                        <tr class="content__account-detail-row">
                                            <td class="content__account-detail-data">New password: </td>
                                            <td class="content__account-detail-data">
                                                <input type="password" name="newPass" id="newPass" required/>
                                            </td>
                                        </tr>
                                        <tr class="content__account-detail-row">
                                            <td class="content__account-detail-data">Re-enter new password: </td>
                                            <td class="content__account-detail-data">
                                                <input type="password" name="renewPass" required onkeyup="validateConfirm(this.value)"/>
                                                <span id="error"></span>
                                            </td>
                                        </tr>
                                        <tr class="content__account-detail-row">
                                            <td colspan="2">
                                                <input class="button button--primary" type="submit" value="Change"/>
                                                <input class="button button--green" type="reset" value="Clear"/>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <jsp:include page="../template/footer.jsp" flush="true"/>
        </div>
        <script>
            function validateConfirm(input) {
                var error = document.getElementById("error");
                if (input === document.getElementById("newPass").value) {
                    error.innerHTML = "Valid";
                    error.style.color="green";
                } else {
                    error.innerHTML = "Invalid";
                    error.style.color="red";
                }
            }
        </script>
    </body>
</html>
