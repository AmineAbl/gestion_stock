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
import javax.servlet.RequestDispatcher;
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
@WebServlet(name = "ProduitController", urlPatterns = {"/ProduitController"})
public class ProduitController extends HttpServlet {
     private ProduitService ps;
    private CategorieService cs;
    
    @Override
        public void init() throws ServletException {
            super.init(); //To change body of generated methods, choose Tools | Templates.
            ps = new ProduitService();
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

            String nom = request.getParameter("nom");
            String prix = request.getParameter("prix");
            String quantite = request.getParameter("quantite");
            int idCategorie = Integer.parseInt(request.getParameter("categorie"));
            Categorie categorie = cs.findById(idCategorie);
            System.out.println("###################");
            System.out.println(nom);
            System.out.println(prix);
            System.out.println(quantite);
            System.out.println(categorie);
            if (id == null || id.isEmpty()) {
                // Création
                Produit p = new Produit(nom, (int) Double.parseDouble(prix), Integer.parseInt(quantite), categorie);
                ps.create(p);
            } else {
                // Modification
                Produit p = new Produit(nom, (int) Double.parseDouble(prix), Integer.parseInt(quantite), categorie);
                p.setId(Integer.parseInt(id));
                ps.update(p);
            }

            response.sendRedirect("Route?page=produits");
       /*     RequestDispatcher dispatcher = request.getRequestDispatcher("users/produits.jsp");
            dispatcher.forward(request, response);*/

        } else if (op.equals("delete")) {
            int id = Integer.parseInt(request.getParameter("id"));
            ps.delete(ps.findById(id));
            response.sendRedirect("Route?page=produits");
     /*       RequestDispatcher dispatcher = request.getRequestDispatcher("users/produits.jsp");
            dispatcher.forward(request, response);*/

        } else if (op.equals("update")) {
            int id = Integer.parseInt(request.getParameter("id"));
            Produit p = ps.findById(id);
           response.sendRedirect("Route?page=ajouterproduit&id=" + p.getId()
                    + "&nom=" + p.getNom()
                    + "&prix=" + p.getPrix()
                    + "&quantite=" + p.getQuantite()
                    + "&categorie=" + p.getCategorie().getId());
            
      /*      RequestDispatcher dispatcher = request.getRequestDispatcher("users/addProduit.jsp?id=" + p.getId()
                    + "&nom=" + p.getNom()
                    + "&prix=" + p.getPrix()
                    + "&quantite=" + p.getQuantite()
                    + "&categorie=" + p.getCategorie().getId());
            dispatcher.forward(request, response);*/
        
        
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
