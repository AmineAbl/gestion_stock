package controllers;

import entities.Categorie;
import entities.MouvementStock;
import entities.Produit;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import services.CategorieService;
import services.MouvementStockService;
import services.ProduitService;

/**
 * Controller for handling stock movement operations
 * @author AMINE
 */
@WebServlet(name = "MouvementController", urlPatterns = {"/MouvementController"})
public class MouvementController extends HttpServlet {

    private final ProduitService ps = new ProduitService();
    private final MouvementStockService mss = new MouvementStockService();
    private final CategorieService cs = new CategorieService();
    private final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

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
        
        try {
            if (op == null) {
                // Create or update operation
                handleCreateOrUpdate(request, response);
            } else if (op.equals("delete")) {
                // Delete operation
                handleDelete(request, response);
            } else if (op.equals("update")) {
                // Prepare for update operation
                handlePrepareUpdate(request, response);
            } else {
                // Unknown operation
                response.sendRedirect("Route?page=mouvementstock&error=unknown_operation");
            }
        } catch (Exception e) {
            // Log the error
            e.printStackTrace();
            // Redirect with error message
            response.sendRedirect("Route?page=mouvementstock&error=" + e.getMessage());
        }
    }
    
    /**
     * Handle create or update operation
     */
    private void handleCreateOrUpdate(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException, ParseException {
    
        String id = request.getParameter("id");
        String produitId = request.getParameter("produit");
        String quantite = request.getParameter("quantite");
        String type = request.getParameter("type");
        String dateStr = request.getParameter("date");
        
        // Validate required fields
        if (produitId == null || quantite == null || type == null || dateStr == null || 
            produitId.isEmpty() || quantite.isEmpty() || type.isEmpty() || dateStr.isEmpty()) {
            response.sendRedirect("Route?page=ajoutermouvement&error=missing_fields");
            return;
        }
        
        // Parse date
        Date date = sdf.parse(dateStr);
        
        // Get product
        Produit produit = ps.findById(Integer.parseInt(produitId));
        
        if (produit == null) {
            response.sendRedirect("Route?page=ajoutermouvement&error=invalid_product");
            return;
        }
        
        int qte = Integer.parseInt(quantite);
        
        // Validate quantity is positive
        if (qte <= 0) {
            response.sendRedirect("Route?page=ajoutermouvement&error=invalid_quantity");
            return;
        }
        
        // Check if we're creating a new movement or updating an existing one
        if (id == null || id.isEmpty()) {
            // Create new movement
            
            // Update product quantity based on movement type
            if ("ajouter".equals(type)) {
                // Add to stock
                produit.setQuantite(produit.getQuantite() + qte);
            } else if ("retirer".equals(type)) {
                // Check if there's enough stock
                if (produit.getQuantite() < qte) {
                    response.sendRedirect("Route?page=ajoutermouvement&error=insufficient_stock&produit=" + 
                                         produitId + "&quantite=" + quantite + "&type=" + type + "&date=" + dateStr);
                    return;
                }
                // Remove from stock
                produit.setQuantite(produit.getQuantite() - qte);
            } else {
                response.sendRedirect("Route?page=ajoutermouvement&error=invalid_movement_type");
                return;
            }
            
            // Update product in database
            ps.update(produit);
            
            // Create movement record
            MouvementStock mouvement = new MouvementStock(type, qte, date, produit);
            mss.create(mouvement);
            
            // Redirect to movement list
            response.sendRedirect("Route?page=mouvementstock&success=created");
        } else {
            // Update existing movement
            
            // Get the original movement to find the original quantity and type
            MouvementStock originalMouvement = mss.findById(Integer.parseInt(id));
            if (originalMouvement != null) {
                // Reverse the effect of the original movement
                if ("ajouter".equals(originalMouvement.getType())) {
                    // Original was an addition, so subtract
                    produit.setQuantite(produit.getQuantite() - originalMouvement.getQuantite());
                } else if ("retirer".equals(originalMouvement.getType())) {
                    // Original was a removal, so add back
                    produit.setQuantite(produit.getQuantite() + originalMouvement.getQuantite());
                }
                
                // Apply the new movement
                if ("ajouter".equals(type)) {
                    // Add to stock
                    produit.setQuantite(produit.getQuantite() + qte);
                } else if ("retirer".equals(type)) {
                    // Check if there's enough stock
                    if (produit.getQuantite() < qte) {
                        response.sendRedirect("Route?page=ajoutermouvement&error=insufficient_stock&id=" + id + 
                                             "&produit=" + produitId + "&quantite=" + quantite + 
                                             "&type=" + type + "&date=" + dateStr);
                        return;
                    }
                    // Remove from stock
                    produit.setQuantite(produit.getQuantite() - qte);
                } else {
                    response.sendRedirect("Route?page=ajoutermouvement&error=invalid_movement_type");
                    return;
                }
                
                // Update product in database
                ps.update(produit);
                
                // Update the movement
                MouvementStock mouvement = new MouvementStock(type, qte, date, produit);
                mouvement.setId(Integer.parseInt(id));
                mss.update(mouvement);
                
                // Redirect to movement list
                response.sendRedirect("Route?page=mouvementstock&success=updated");
            } else {
                response.sendRedirect("Route?page=mouvementstock&error=movement_not_found");
            }
        }
    }
    
    /**
     * Handle delete operation
     */
    private void handleDelete(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String idStr = request.getParameter("id");
        
        if (idStr == null || idStr.isEmpty()) {
            response.sendRedirect("Route?page=mouvementstock&error=missing_id");
            return;
        }
        
        int id = Integer.parseInt(idStr);
        MouvementStock mouvement = mss.findById(id);
        
        if (mouvement == null) {
            response.sendRedirect("Route?page=mouvementstock&error=movement_not_found");
            return;
        }
        
        // Reverse the effect of the movement on the product stock
        Produit produit = mouvement.getProduit();
        if (produit != null) {
            if ("ajouter".equals(mouvement.getType())) {
                // If it was an addition, subtract the quantity
                produit.setQuantite(produit.getQuantite() - mouvement.getQuantite());
            } else if ("retirer".equals(mouvement.getType())) {
                // If it was a removal, add the quantity back
                produit.setQuantite(produit.getQuantite() + mouvement.getQuantite());
            }
            // Update the product
            ps.update(produit);
        }
        
        // Delete the movement
        mss.delete(mouvement);
        response.sendRedirect("Route?page=mouvementstock&success=deleted");
    }
    
    /**
     * Prepare for update operation by redirecting to the form with movement data
     */
    private void handlePrepareUpdate(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String idStr = request.getParameter("id");
        
        if (idStr == null || idStr.isEmpty()) {
            response.sendRedirect("Route?page=mouvementstock&error=missing_id");
            return;
        }
        
        int id = Integer.parseInt(idStr);
        MouvementStock mouvement = mss.findById(id);
        
        if (mouvement == null) {
            response.sendRedirect("Route?page=mouvementstock&error=movement_not_found");
            return;
        }
        
        // Format date to string
        String dateStr = "";
        if (mouvement.getDate() != null) {
            dateStr = sdf.format(mouvement.getDate());
        }
        
        // Redirect to form with movement data
        response.sendRedirect("Route?page=ajoutermouvement" + 
                "&id=" + mouvement.getId() +
                "&date=" + dateStr +
                "&produit=" + mouvement.getProduit().getId() +
                "&quantite=" + mouvement.getQuantite() +
                "&type=" + mouvement.getType()
        );
    }

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
        return "Controller for stock movement operations";
    }
}