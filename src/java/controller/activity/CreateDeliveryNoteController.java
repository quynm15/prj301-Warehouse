/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.activity;

import dal.account.AccountDBContext;
import dal.inventory.DeliveryDBContext;
import dal.inventory.ProductDBContext;
import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.account.Account;
import model.inventory.Delivery;
import model.inventory.DeliveryDetail;
import model.inventory.Product;
import model.inventory.ReceiptDetail;

/**
 *
 * @author quynm
 */
public class CreateDeliveryNoteController extends HttpServlet {

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

        java.util.Date now = new java.util.Date();
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        String date = df.format(now);
        SimpleDateFormat hf = new SimpleDateFormat("HH:mm");
        String hour = hf.format(now);
        request.setAttribute("date", date);
        request.setAttribute("hour", hour);

        request.getRequestDispatcher("../view/activity/delivery.jsp").forward(request, response);
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
        String exporterUsername = request.getParameter("exporter");
        String recipient = request.getParameter("recipient");
        String commentDelivery = request.getParameter("commentDelivery");

        AccountDBContext adb = new AccountDBContext();
        Account exporter = adb.getAccount(exporterUsername);
        
        Delivery delivery = new Delivery();
        delivery.setDate(date.isEmpty() ? null : Date.valueOf(date));
        delivery.setTime(time.isEmpty() ? null : Time.valueOf(time + ":00"));
        delivery.setExporter(exporter);
        delivery.setRecipient(recipient.isEmpty() ? null : recipient);
        delivery.setComment(commentDelivery.isEmpty() ? null : commentDelivery);
        
        String[] ids = request.getParameterValues("productID");
        String[] quantitys = request.getParameterValues("quantity");
        String[] comments = request.getParameterValues("commentProduct");

        ProductDBContext pdb = new ProductDBContext();
        ArrayList<DeliveryDetail> deliveryDetails = new ArrayList<>();
        if (ids != null && ids.length > 0) {
            for (int i = 0; i < ids.length; i++) {
                DeliveryDetail dd = new DeliveryDetail();
                Product product = pdb.getProduct(ids[i]);
                //update quantity of product after delivery
                product.setQuantity(product.getQuantity() - Double.parseDouble(quantitys[i]));

                dd.setProduct(product);
                dd.setQuantity(Double.parseDouble(quantitys[i]));
                dd.setComment(comments[i].isEmpty() ? null : comments[i]);
                deliveryDetails.add(dd);
            }
        }
        
        DeliveryDBContext ddb = new DeliveryDBContext();
        int insertDeliveryID = ddb.insertDelivery(delivery, deliveryDetails);
        if (insertDeliveryID > 0) {
            request.setAttribute("msg", "Added successfully.");
        } else {
            request.setAttribute("msg", "Something was wrong, add failed.");
        }
        request.setAttribute("deliveryID", insertDeliveryID);
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
