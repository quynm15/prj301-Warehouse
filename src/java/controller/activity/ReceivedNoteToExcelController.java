/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.activity;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.GenericServlet;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

/**
 *
 * @author quynm
 */
public class ReceivedNoteToExcelController extends GenericServlet {

    @Override
    public void service(ServletRequest req, ServletResponse res) throws ServletException, IOException {
        res.setContentType("text/csv; charset=UTF-8");
        req.setCharacterEncoding("UTF-8");
        res.setCharacterEncoding("UTF-8");
        
        PrintWriter out = res.getWriter();
        
        out.println("Nguyễn Mạnh\tQuý");
        out.print("Nguyễn Mạnh\tQuý");
        out.print("tQuý");
        
        
        out.close();
    }

}
