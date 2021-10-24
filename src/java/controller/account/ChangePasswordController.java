/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.account;

import controller.auth.BaseAuthPermission;
import dal.account.AccountDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.account.Account;

/**
 *
 * @author quynm
 */
public class ChangePasswordController extends BaseAuthPermission {

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
        request.getRequestDispatcher("view/account/change-password.jsp").forward(request, response);
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
        
        Account account = (Account) request.getSession().getAttribute("account");
        String username = account.getUsername();
        String oldPassword = request.getParameter("oldPass");
        if (!oldPassword.equals(account.getPassword())) {
            request.setAttribute("errorMsg", "Wrong password!");
            request.getRequestDispatcher("view/account/change-password.jsp").forward(request, response);
        } else{
            String newPassword = request.getParameter("newPass");
            AccountDBContext adb = new AccountDBContext();
            adb.updatePassword(username, newPassword);
            //update to session
            account.setPassword(newPassword);
            request.getSession().setAttribute("account", account);
            
            request.setAttribute("errorMsg", "Password changed!");
            request.getRequestDispatcher("view/account/change-password.jsp").forward(request, response);
        }
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
