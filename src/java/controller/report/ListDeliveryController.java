/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.report;

import dal.inventory.DeliveryDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.inventory.Delivery;

/**
 *
 * @author quynm
 */
public class ListDeliveryController extends HttpServlet {

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

        DeliveryDBContext ddb = new DeliveryDBContext();
        ArrayList<Delivery> deliveries = ddb.getAllDeliveries();

        for (Delivery delivery : deliveries) {
            double deliveryValue = ddb.getDeliveryValue(delivery.getId());
            delivery.setValue(deliveryValue);
        }
        request.setAttribute("deliveries", deliveries);

        request.getRequestDispatcher("../view/report/list-delivery.jsp").forward(request, response);
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

        Date dateFrom = from.isEmpty() ? null : Date.valueOf(from);
        Date dateTo = to.isEmpty() ? null : Date.valueOf(to);

        DeliveryDBContext ddb = new DeliveryDBContext();
        ArrayList<Delivery> deliveries = ddb.getAllDeliveries(dateFrom, dateTo);
        for (Delivery delivery : deliveries) {
            double deliveryValue = ddb.getDeliveryValue(delivery.getId());
            delivery.setValue(deliveryValue);
        }
        request.setAttribute("deliveries", deliveries);
        
        request.setAttribute("from", dateFrom);
        request.setAttribute("to", dateTo);

        request.getRequestDispatcher("../view/report/list-delivery.jsp").forward(request, response);
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
