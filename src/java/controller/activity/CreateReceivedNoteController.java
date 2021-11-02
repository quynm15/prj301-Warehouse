/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.activity;

import dal.account.AccountDBContext;
import dal.inventory.ProductDBContext;
import dal.inventory.ReceiptDBContext;
import dal.inventory.SupplierDBContext;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.sql.Date;
import java.sql.Time;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.account.Account;
import model.inventory.Product;
import model.inventory.Receipt;
import model.inventory.ReceiptDetail;
import model.inventory.Supplier;

/**
 *
 * @author quynm
 */
public class CreateReceivedNoteController extends HttpServlet {

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

        SupplierDBContext sdb = new SupplierDBContext();
        ArrayList<Supplier> suppliers = sdb.getSuppliers();
        request.setAttribute("suppliers", suppliers);

        java.util.Date now = new java.util.Date();
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        String date = df.format(now);
        SimpleDateFormat hf = new SimpleDateFormat("HH:mm");
        String hour = hf.format(now);
        request.setAttribute("date", date);
        request.setAttribute("hour", hour);

        request.getRequestDispatcher("../view/activity/receipt.jsp").forward(request, response);
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

        String date = request.getParameter("date");
        String time = request.getParameter("time");
        String importerUsername = request.getParameter("importer");
        String supplierID = request.getParameter("supplierid");
        String shipper = request.getParameter("shipper");
        String commentReceipt = request.getParameter("commentReceipt");

        AccountDBContext adb = new AccountDBContext();
        Account importer = adb.getAccount(importerUsername);

        SupplierDBContext sdb = new SupplierDBContext();
        Supplier supplier = sdb.getSupplier(Integer.parseInt(supplierID));

        Receipt receipt = new Receipt();
        receipt.setDate(date.isEmpty() ? null : Date.valueOf(date));
        receipt.setTime(time.isEmpty() ? null : Time.valueOf(time + ":00"));
        receipt.setImporter(importer);
        receipt.setSupplier(supplier);
        receipt.setShipper(shipper.isEmpty() ? null : shipper);
        receipt.setComment(commentReceipt.isEmpty() ? null : commentReceipt);

        String[] ids = request.getParameterValues("productID");
        String[] unitPrices = request.getParameterValues("productUnitPrice");
        String[] quantitys = request.getParameterValues("quantity");
        String[] mgfs = request.getParameterValues("mgf");
        String[] exps = request.getParameterValues("exp");
        String[] comments = request.getParameterValues("commentProduct");

        ProductDBContext pdb = new ProductDBContext();
        ArrayList<ReceiptDetail> receiptDetails = new ArrayList<>();
        if (ids != null && ids.length > 0) {
            for (int i = 0; i < ids.length; i++) {
                ReceiptDetail rd = new ReceiptDetail();
                Product product = pdb.getProduct(ids[i]);
                //update quantity for product after receipt
                product.setQuantity(product.getQuantity() + Double.parseDouble(quantitys[i]));

                rd.setProduct(product);
                rd.setUnitPrice(Double.parseDouble(unitPrices[i]));
                rd.setQuantity(Double.parseDouble(quantitys[i]));
                rd.setInStock(Double.parseDouble(quantitys[i]));
                rd.setMgf(mgfs[i].isEmpty() ? null : Date.valueOf(mgfs[i]));
                rd.setExp(exps[i].isEmpty() ? null : Date.valueOf(exps[i]));
                rd.setComment(comments[i].isEmpty() ? null : comments[i]);
                receiptDetails.add(rd);
            }
        }

        ReceiptDBContext rdb = new ReceiptDBContext();
        int insertReceiptID = rdb.insertReceipt(receipt, receiptDetails);
        if (insertReceiptID > 0) {
            request.setAttribute("msg", "Added successfully.");
        } else {
            request.setAttribute("msg", "Something was wrong, add failed.");
        }
        request.setAttribute("receiptID", insertReceiptID);
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
