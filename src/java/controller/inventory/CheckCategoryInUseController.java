/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.inventory;

import dal.inventory.CategoryDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author quynm
 */
public class CheckCategoryInUseController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        String raw_id = request.getParameter("id");
        CategoryDBContext cdb = new CategoryDBContext();

        //cate is used, show modal to inactive
        if (cdb.isUsedCategory(Integer.parseInt(raw_id))) {
//            out.print("<div class=\"modal-dialog modal-confirm\">\n"
//                    + "         <div class=\"modal-content\">\n"
//                    + "             <div class=\"modal-header flex-column\">\n"
//                    + "                 <div class=\"icon-box-warning\">\n"
//                    + "                     <i class=\"material-icons\">report_problem</i>\n"
//                    + "                 </div>						\n"
//                    + "                 <h4 class=\"modal-title w-100\">Can not delete</h4>	\n"
//                    + "                 <button type=\"button\" id=\"closeConfirmDelete\" class=\"close\" data-dismiss=\"modal\" aria-hidden=\"true\">&times;</button>\n"
//                    + "             </div>\n"
//                    + "             <div class=\"modal-body\">\n"
//                    + "                 <p>This category has been used in some product. Do you want to inactive it instead?</p>\n"
//                    + "             </div>\n"
//                    + "             <div class=\"modal-footer justify-content-center\">\n"
//                    + "                 <button type=\"button\" id=\"cancelConfirmDelete\" class=\"btn btn-secondary\" data-dismiss=\"modal\">Cancel</button>\n"
//                    + "                 <a href = \"category/inactive?id=" + raw_id + "\" class=\"btn btn-warning\">Yes</a>\n"
//                    + "             </div>\n"
//                    + "         </div>\n"
//                    + "</div>");

out.print("true");
        } else {
            //show modal to confirm delete
//            out.print("<!--Modal: modal Confirm Delete-->\n"
//                    + "<div id=\"modalConfirmDelete\" class=\"modal fade\">\n"
//                    + "<div class=\"modal-dialog modal-confirm\">\n"
//                    + "    <div class=\"modal-content\">\n"
//                    + "        <div class=\"modal-header flex-column\">\n"
//                    + "            <div class=\"icon-box\">\n"
//                    + "                <i class=\"material-icons\">&#xE5CD;</i>\n"
//                    + "            </div>						\n"
//                    + "            <h4 class=\"modal-title w-100\">Are you sure?</h4>	\n"
//                    + "            <button type=\"button\" onclick=\"hideModal()\" id=\"closeConfirmDelete\" class=\"close\" data-dismiss=\"modal\" aria-hidden=\"true\">&times;</button>\n"
//                    + "        </div>\n"
//                    + "        <div class=\"modal-body\">\n"
//                    + "            <p>Do you really want to delete this record? This process cannot be undone.</p>\n"
//                    + "        </div>\n"
//                    + "        <div class=\"modal-footer justify-content-center\">\n"
//                    + "            <button type=\"button\" id=\"cancelConfirmDelete\" class=\"btn btn-secondary\" data-dismiss=\"modal\">Cancel</button>\n"
//                    + "            <a href = \"category/update?id=" + raw_id + "\" class=\"btn btn-danger\">Delete</a>\n"
//                    + "        </div>\n"
//                    + "    </div>\n"
//                    + "</div>\n"
//                    + "</div>\n"
//                    + "<!--Modal: modal Confirm Delete-->");
out.print("false");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
