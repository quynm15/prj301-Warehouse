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
import java.io.PrintWriter;
import java.util.ArrayList;
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
public class ListProductController extends HttpServlet {

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
        
        String categoryid = request.getParameter("categoryid") == null ? "0" : request.getParameter("categoryid");
        String supplierid = request.getParameter("supplierid") == null ? "0" : request.getParameter("supplierid");
        
        ProductDBContext pdb = new ProductDBContext();
        ArrayList<Product> products = pdb.getProducts(Integer.parseInt(categoryid), Integer.parseInt(supplierid));
        request.setAttribute("products", products);
        
        CategoryDBContext cdb = new CategoryDBContext();
        ArrayList<Category> categories = cdb.getCategories();
        request.setAttribute("categories", categories);
        
        SupplierDBContext sdb = new SupplierDBContext();
        ArrayList<Supplier> suppliers = sdb.getSuppliers();
        request.setAttribute("suppliers", suppliers);
        
        request.setAttribute("selectedCategoryid", categoryid);
        request.setAttribute("selectedSupplierid", supplierid);
        
        request.getRequestDispatcher("../view/inventory/list-product.jsp").forward(request, response);
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
