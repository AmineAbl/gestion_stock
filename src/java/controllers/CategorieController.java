/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import entities.Categorie;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import services.CategorieService;

/**
 *
 * @author AMINE
 */
@WebServlet(name = "CategorieController", urlPatterns = {"/CategorieController"})
public class CategorieController extends HttpServlet {
        private CategorieService cs;
        
        @Override
        public void init() throws ServletException {
            super.init(); //To change body of generated methods, choose Tools | Templates.
            cs = new CategorieService();
        }
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         String op = request.getParameter("op");
        if (op == null) {
            String id = request.getParameter("id");
            if (id == null || id.isEmpty()) {
                String nom = request.getParameter("nom");
                cs.create(new Categorie(nom));
                response.sendRedirect("users/categorie.jsp");
            }else{
                String nom = request.getParameter("nom");
                Categorie c = new Categorie(nom);
                c.setId(Integer.parseInt(id));
                cs.update(c);
                response.sendRedirect("users/categorie.jsp");
            }
        } else if (op.equals("delete")) {
            String id = request.getParameter("id");
            cs.delete(cs.findById(Integer.parseInt(id)));
            response.sendRedirect("users/categorie.jsp");
        } else if (op.equals("update")) {
            String id = request.getParameter("id");
            Categorie u = cs.findById(Integer.parseInt(id));
            response.sendRedirect("users/addCategorie.jsp?id=" + u.getId() + "&nom=" + u.getNom());
        }
    }

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
        processRequest(request, response);
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
        processRequest(request, response);
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
