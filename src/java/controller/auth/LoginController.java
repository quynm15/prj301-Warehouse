/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.auth;

import dal.account.AccountDBContext;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.account.Account;

/**
 *
 * @author quynm
 */
public class LoginController extends HttpServlet {

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

//        Cookie[] cookies = request.getCookies();
//        Cookie user = null, pass = null;
//        if (cookies != null) {
//            for (Cookie c : cookies) {
//                if (c.getName().equals("username")) {
//                    user = c;
//                }
//            }
//        }
//        if (user != null && pass != null) {
//            AccountDBContext adb = new AccountDBContext();
//            Account account = adb.getAccount(user.getValue());
//            request.getSession().setAttribute("account", account);
//            response.sendRedirect("home");
//        } else {
//            request.getRequestDispatcher("view/auth/login.jsp").forward(request, response);
//        }
        request.getRequestDispatcher("view/auth/login.jsp").forward(request, response);
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

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String remember = request.getParameter("remember-me");

        AccountDBContext adb = new AccountDBContext();
        Account account = adb.getAccount(username, password);

        if (account == null) {
            request.setAttribute("errorLogin", "Username or password is incorrect.");
            request.getRequestDispatcher("view/auth/login.jsp").forward(request, response);
        } else {
            if (remember != null && remember.equals("on")) {
                Cookie user = new Cookie("username", username);
                user.setMaxAge(24 * 60 * 60 * 7); //1 week
                response.addCookie(user);
            }
            request.getSession().setAttribute("account", account);
            response.sendRedirect("home");
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
