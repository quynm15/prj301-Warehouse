/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.inventory;

import dal.inventory.CategoryDBContext;
import dal.inventory.ProductDBContext;
import dal.inventory.SupplierDBContext;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.inventory.Category;
import model.inventory.Product;
import model.inventory.Supplier;

/**
 *
 * @author quynm
 */
public class CreateProductController extends HttpServlet {


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
        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        String id = request.getParameter("id").isEmpty() ? null : request.getParameter("id");
        String name = request.getParameter("name").isEmpty() ? null : request.getParameter("name");
        String categoryid = request.getParameter("categoryid").isEmpty() ? null : request.getParameter("categoryid");
        String supplierid = request.getParameter("supplierid").isEmpty() ? null : request.getParameter("supplierid");
        String unit = request.getParameter("unit").isEmpty() ? null : request.getParameter("unit");
        String unitPrice = request.getParameter("unitPrice").isEmpty() ? "0" : request.getParameter("unitPrice");
        String comment = request.getParameter("comment").isEmpty() ? null : request.getParameter("comment");
        String status = request.getParameter("status") == null ? "" : request.getParameter("status");

        CategoryDBContext cdb = new CategoryDBContext();
        Category category = cdb.getCategory(Integer.parseInt(categoryid));

        SupplierDBContext sdb = new SupplierDBContext();
        Supplier supplier = sdb.getSupplier(Integer.parseInt(supplierid));

        Product product = new Product(id, name, category, supplier, unit, 0,
                Double.parseDouble(unitPrice), comment, status.equals("on"));
        
        ProductDBContext pdb = new ProductDBContext();
        pdb.insertProduct(product);

        response.sendRedirect("list");
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
