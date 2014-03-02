/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pnc.dbf.filtre;

import com.pnc.dbf.config.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.util.ArrayList;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author IMA7
 */
public class Filtrage implements Filter {

    Connection con;

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        try {
            con = DBConnection.getConnection();
            System.out.println("une connexion c'est bien : " + con.getCatalog());
        } catch (Exception e) {
        }
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest httpservletReq = (HttpServletRequest) request;
        String askedPath = httpservletReq.getPathInfo();
        if (!askedPath.endsWith(".xhtml")) {
            chain.doFilter(request, response);
        } else {            
            if (askedPath.substring(askedPath.lastIndexOf("/") + 1, askedPath.lastIndexOf(".")).equalsIgnoreCase("index")) {
                chain.doFilter(request, response);
            } else {
                processRequest(askedPath, request, response, chain);
            }
        }
    }

    @Override
    public void destroy() {
    }

    private void processRequest(String askedPath, ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        
        boolean find = false;
        HttpServletRequest httpservletReq = (HttpServletRequest) request;
        HttpServletResponse httpservletRes = (HttpServletResponse) response;
        System.out.println("chemin voulue : " + askedPath);
        HttpSession session = httpservletReq.getSession();
        ArrayList<String> userPaths = (ArrayList<String>) session.getAttribute("userPaths");
        if (userPaths != null) {
            for (int i = 0; i < userPaths.size(); i++) {
                System.out.println("chemin :"+userPaths.get(i));
                
                if (userPaths.get(i).equalsIgnoreCase("/faces" + askedPath)) {
                    find = true;
                    break;
                }
            }
            if (find) {
                chain.doFilter(request, response);
            } else {
                //System.out.println("Redirection");
                //httpservletRes.sendRedirect("/"+httpservletReq.getContextPath());
                session.invalidate();
                httpservletRes.sendRedirect("/PNCApp/");
                
            }
        } else {
            session.invalidate();
            httpservletRes.sendRedirect("/PNCApp/");

        }
    }
}
