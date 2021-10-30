/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.auth;

import dal.account.AccountDBContext;
import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.account.Account;
import model.account.Feature;

/**
 *
 * @author quynm
 */
public class AuthenticationFilter implements Filter {

    public AuthenticationFilter() {
    }

    /**
     *
     * @param request The servlet request we are processing
     * @param response The servlet response we are creating
     * @param chain The filter chain we are processing
     *
     * @exception IOException if an input/output error occurs
     * @exception ServletException if a servlet error occurs
     */
    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        //if session null, check the cookie to get the account, 
        //if cookie also dont have info, redirect to login page
        if (req.getSession().getAttribute("account") == null) {
            Cookie[] cookies = req.getCookies();
            Cookie user = null;
            if (cookies != null) {
                for (Cookie c : cookies) {
                    if (c.getName().equals("username")) {
                        user = c;
                    }
                }
                if (user != null) {
                    AccountDBContext adb = new AccountDBContext();
                    Account account = adb.getAccount(user.getValue());
                    req.getSession().setAttribute("account", account);
                } else if (!req.getServletPath().equals("/home")) {
                    //redirect to login if (not logged in and access to any page)
                    //except for home page
                    res.sendRedirect(req.getContextPath() + "/login");
                    return;
                }
            }
        }
        chain.doFilter(request, response);
    }

    /**
     * Destroy method for this filter
     */
    @Override
    public void destroy() {
    }

    /**
     * Init method for this filter
     *
     * @param filterConfig
     */
    @Override
    public void init(FilterConfig filterConfig) {
    }
}
