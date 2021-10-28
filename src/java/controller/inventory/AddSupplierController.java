/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.inventory;

import dal.inventory.SupplierDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.inventory.Supplier;

/**
 *
 * @author quynm
 */
public class AddSupplierController extends HttpServlet {

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
        
        String companyName = request.getParameter("companyName").isEmpty()?null:request.getParameter("companyName");
        String contactName = request.getParameter("contactName").isEmpty()?null:request.getParameter("contactName");
        String phone = request.getParameter("phone").isEmpty()?null:request.getParameter("phone");
        String email = request.getParameter("email").isEmpty()?null:request.getParameter("email");
        String address = request.getParameter("address").isEmpty()?null:request.getParameter("address");
        String district = request.getParameter("district").isEmpty()?null:request.getParameter("district");
        String province = request.getParameter("province").isEmpty()?null:request.getParameter("province");
        String comment = request.getParameter("comment").isEmpty()?null:request.getParameter("comment");
        String status = request.getParameter("status") == null ? "" : request.getParameter("status");
        
        Supplier sup = new Supplier(0, companyName, contactName, phone, email, address, 
                province, district, status.equals("on"), comment);
        SupplierDBContext sdb = new SupplierDBContext();
        sdb.inserSupplier(sup);
        
        response.sendRedirect("list");
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
