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
public class AuthorizationFilter implements Filter {

    public AuthorizationFilter() {
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
        //check authorization for this account
        if (req.getSession().getAttribute("account") != null) {
            boolean check = false;
            Account account = (Account) req.getSession().getAttribute("account");
            if (account != null) {
                for (Feature feature : account.getFeatures()) {
                    if (feature.getUrl().equals(req.getServletPath())) {
                        check = true;
                    }
                }
            }
            if(!check){
                res.sendRedirect(req.getContextPath() + "/access-denied");
                return;
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
     * @param filterConfig
     */
    @Override
    public void init(FilterConfig filterConfig) {
    }

}
