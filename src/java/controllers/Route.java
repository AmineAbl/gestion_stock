/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import entities.Categorie;
import entities.Produit;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import services.CategorieService;
import services.ProduitService;

/**
 *
 * @author AMINE
 */
@WebServlet(name = "Route", urlPatterns = {"/Route"})
public class Route extends HttpServlet {
        ProduitService ps;
        CategorieService cs;
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
        ps = new ProduitService();
        cs = new CategorieService();
        String page = request.getParameter("page");

        switch (page){
            case "profile":
                request.getRequestDispatcher("users/profile.jsp").forward(request, response);
                break;
            case "produits":
                List<Produit> produits = ps.findAll();
                request.setAttribute("produits", produits);
                request.getRequestDispatcher("users/produits.jsp").forward(request, response);
                break;
            case "categories":
                List<Categorie> categories = cs.findAll();
                request.setAttribute("categories", categories);
                request.getRequestDispatcher("users/categorie.jsp").forward(request, response);
                break;
            case "ajouterproduit":
                request.getRequestDispatcher("users/addProduit.jsp").forward(request, response);
                break;
             case "ajoutercategorie":
                request.getRequestDispatcher("users/addCategorie.jsp").forward(request, response);
                break;
            case "deconnexion":
                request.getRequestDispatcher("users/login.jsp").forward(request, response);
                break;
            
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
