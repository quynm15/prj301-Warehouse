/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.report;

import dal.inventory.CategoryDBContext;
import dal.inventory.ProductDBContext;
import dal.inventory.SupplierDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
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
public class InOutReportController extends HttpServlet {

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
        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        ProductDBContext pdb = new ProductDBContext();

        String categoryid = request.getParameter("categoryid") == null ? "0" : request.getParameter("categoryid");
        String supplierid = request.getParameter("supplierid") == null ? "0" : request.getParameter("supplierid");
        String from = request.getParameter("from") == null ? "" : request.getParameter("from");
        String to = request.getParameter("to") == null ? "" : request.getParameter("to");

        Date dateFrom = from.isEmpty() ? null : Date.valueOf(from);
        Date dateTo = from.isEmpty() ? null : Date.valueOf(to);

        String page = request.getParameter("page");
        if (page == null || page.isEmpty()) {
            page = "1";
        }
        int pageIndex = Integer.parseInt(page);
        int pageSize = 20;
        int totalRecords = pdb.countProducts(Integer.parseInt(categoryid), Integer.parseInt(supplierid));
        int totalPages = totalRecords % pageSize == 0 ? totalRecords / pageSize : (totalRecords / pageSize) + 1;
        request.setAttribute("pageIndex", pageIndex);
        request.setAttribute("totalPages", totalPages);

        ArrayList<Product> products = pdb.getProductsInOut(Integer.parseInt(categoryid), Integer.parseInt(supplierid),
                dateFrom, dateTo, pageIndex, pageSize);
        request.setAttribute("products", products);
        
        double totalReceivedValue = 0;
        double totalDeliveredValue = 0;
        for (Product product : products) {
            totalReceivedValue += product.getTotalReceivedAmount();
            totalDeliveredValue += product.getTotalDeliveredAmount();
        }
        request.setAttribute("totalReceivedValue", totalReceivedValue);
        request.setAttribute("totalDeliveredValue", totalDeliveredValue);

        CategoryDBContext cdb = new CategoryDBContext();
        ArrayList<Category> categories = cdb.getCategories();
        request.setAttribute("categories", categories);

        SupplierDBContext sdb = new SupplierDBContext();
        ArrayList<Supplier> suppliers = sdb.getSuppliers();
        request.setAttribute("suppliers", suppliers);

        request.setAttribute("selectedCategoryid", categoryid);
        request.setAttribute("selectedSupplierid", supplierid);
        request.setAttribute("from", dateFrom);
        request.setAttribute("to", dateTo);

        request.getRequestDispatcher("../view/report/list-inout.jsp").forward(request, response);
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
        doGet(request, response);
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
