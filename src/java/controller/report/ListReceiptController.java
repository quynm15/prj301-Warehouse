/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.report;

import dal.inventory.ReceiptDBContext;
import dal.inventory.SupplierDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.inventory.Receipt;
import model.inventory.Supplier;

/**
 *
 * @author quynm
 */
public class ListReceiptController extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        ReceiptDBContext rdb = new ReceiptDBContext();
        ArrayList<Receipt> receipts = rdb.getAllReceipts();

        for (Receipt receipt : receipts) {
            double receiptValue = rdb.getReceiptValue(receipt.getId());
            receipt.setValue(receiptValue);
        }
        request.setAttribute("receipts", receipts);

        SupplierDBContext sdb = new SupplierDBContext();
        ArrayList<Supplier> suppliers = sdb.getSuppliers();
        request.setAttribute("suppliers", suppliers);

        request.getRequestDispatcher("../view/report/list-receipt.jsp").forward(request, response);

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
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        String from = request.getParameter("from");
        String to = request.getParameter("to");
        String supplierID = request.getParameter("supplierID");

        Date dateFrom = from.isEmpty() ? null : Date.valueOf(from);
        Date dateTo = to.isEmpty() ? null : Date.valueOf(to);

        ReceiptDBContext rdb = new ReceiptDBContext();
        ArrayList<Receipt> receipts = rdb.getAllReceipts(dateFrom, dateTo, Integer.parseInt(supplierID));
        for (Receipt receipt : receipts) {
            double receiptValue = rdb.getReceiptValue(receipt.getId());
            receipt.setValue(receiptValue);
        }
        request.setAttribute("receipts", receipts);

        SupplierDBContext sdb = new SupplierDBContext();
        ArrayList<Supplier> suppliers = sdb.getSuppliers();
        request.setAttribute("suppliers", suppliers);
        
        request.setAttribute("from", dateFrom);
        request.setAttribute("to", dateTo);
        request.setAttribute("selectedSupplierid", supplierID);

        request.getRequestDispatcher("../view/report/list-receipt.jsp").forward(request, response);
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
