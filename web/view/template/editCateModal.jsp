<%-- 
    Document   : editCateModal
    Created on : Oct 22, 2021, 9:38:21 PM
    Author     : quynm
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link href="${pageContext.servletContext.contextPath}/css/style_modal.css" rel="stylesheet" type="text/css"/>
        <script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
        <script src="${pageContext.servletContext.contextPath}/js/bootstrap.js" type="text/javascript"></script>
        <script src="${pageContext.servletContext.contextPath}/js/modal.js" type="text/javascript"></script>
        <link href="${pageContext.servletContext.contextPath}/assets/fonts/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <!-- Button trigger modal-->
        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modalConfirmDelete">Launch
            modal</button>

        <!--Modal: modalConfirmDelete-->
        <div class="modal fade" id="modalConfirmDelete" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
             aria-hidden="true">
            <div class="modal-dialog modal-sm modal-notify modal-danger" role="document">
                <!--Content-->
                <div class="modal-content text-center">
                    <!--Header-->
                    <div class="modal-header d-flex justify-content-center">
                        <p class="heading">Are you sure?</p>
                    </div>

                    <!--Body-->
                    <div class="modal-body">

                        <i class="fas fa-times fa-4x animated rotateIn"></i>

                    </div>

                    <!--Footer-->
                    <div class="modal-footer flex-center">
                        <button href="" class="button  btn-outline-danger">Yes</button>
                        <button class="button btn-danger waves-effect" data-dismiss="modal">No</button>
                    </div>
                </div>
                <!--/.Content-->
            </div>
        </div>
        <!--Modal: modalConfirmDelete-->
    </body>
</html>
