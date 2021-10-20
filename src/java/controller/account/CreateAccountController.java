/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.account;

import controller.auth.BaseAuthPermission;
import dal.AccountDBContext;
import dal.FeatureDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Account;
import model.Feature;

/**
 *
 * @author quynm
 */
public class CreateAccountController extends BaseAuthPermission {

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
    protected void processGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        FeatureDBContext fdb = new FeatureDBContext();
        ArrayList<Feature> features = fdb.getFeatures();
        request.setAttribute("features", features);

        request.getRequestDispatcher("../view/account/create-account.jsp").forward(request, response);
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
    protected void processPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String fullname = request.getParameter("fullname");
        String dob = request.getParameter("dob");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String status = request.getParameter("status") == null ? "" : request.getParameter("status");
        String[] pers = request.getParameterValues("permission");
        
        Account account = new Account();
        account.setUsername(username);
        account.setFullName(fullname.isEmpty() ? null : fullname);
        account.setDob(dob.isEmpty() ? null : Date.valueOf(dob));
        account.setAddress(address.isEmpty() ? null : address);
        account.setPhone(phone.isEmpty() ? null : phone);
        account.setEmail(email.isEmpty() ? null : email);
        account.setIsActive(status.equals("active"));

        FeatureDBContext fdb = new FeatureDBContext();
        if (pers != null) {
            for (String per : pers) {
                account.getFeatures().add(fdb.getFeature(Integer.parseInt(per)));
            }
        }

        AccountDBContext adb = new AccountDBContext();
        ArrayList<Account> accounts = adb.getAccounts();
        //check duplicate
        for (Account acc : accounts) {
            //if duplicate, then back to jsp and show error
            if (acc.getUsername().equals(username)) {
                request.setAttribute("errorUsername", "Username has been already used.");
                request.setAttribute("account", account);
                processGet(request, response);
            }
        }
        //if not, insert to DB
        adb.insertAccount(account);
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
