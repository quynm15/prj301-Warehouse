<%-- 
    Document   : SessionTimeout
    Created on : Oct 20, 2021, 7:50:34 AM
    Author     : quynm
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<script>
    var lastActiveTime = new Date().getTime();
    $(document).ready(function () {
        $('body').bind('click mousemove keypress scroll resize', function () {
            lastActiveTime = new Date().getTime();
        });
        setInterval(checkIdleTime, 30000); // 30 sec
    });

    function checkIdleTime() {
        var diff = new Date().getTime() - lastActiveTime;
        if (diff > 60000) {//1 min of inactivity
            window.location.href = "/logout"
        }
    }
</script>
