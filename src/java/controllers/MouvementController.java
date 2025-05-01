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
    String typeId = request.getParameter("type");
    String dateStr = request.getParameter("date");
    
    // Validate required fields
    if (produitId == null || quantite == null || typeId == null || dateStr == null || 
        produitId.isEmpty() || quantite.isEmpty() || typeId.isEmpty() || dateStr.isEmpty()) {
        response.sendRedirect("Route?page=ajoutermouvement&error=missing_fields");
        return;
    }
    
    // Parse date
    Date date = sdf.parse(dateStr);
    
    // Get product and category
    Produit produit = ps.findById(Integer.parseInt(produitId));
    Categorie categorie = cs.findById(Integer.parseInt(typeId));
    
    if (produit == null || categorie == null) {
        response.sendRedirect("Route?page=ajoutermouvement&error=invalid_product_or_category");
        return;
    }
    
    int qte = Integer.parseInt(quantite);
    
    if (id == null || id.isEmpty()) {
        // Create new movement
        
        // Update product quantity - subtract the entered quantity
        produit.setQuantite(produit.getQuantite() - qte);
        ps.update(produit); // Make sure to update the product in the database
        
        // Create movement
        MouvementStock mouvement = new MouvementStock(categorie.getNom(), qte, date, produit);
        mss.create(mouvement);
        
        // Redirect to movement list
        response.sendRedirect("Route?page=mouvementstock&success=created");
    } else {
        // Update existing movement
        
        // Get the original movement to find the original quantity
        MouvementStock originalMouvement = mss.findById(Integer.parseInt(id));
        if (originalMouvement != null) {
            // Restore the original quantity first (add back what was subtracted)
            produit.setQuantite(produit.getQuantite() + originalMouvement.getQuantite());
            
            // Then subtract the new quantity
            produit.setQuantite(produit.getQuantite() - qte);
            ps.update(produit); // Make sure to update the product in the database
        }
        
        // Update the movement
        MouvementStock mouvement = new MouvementStock(categorie.getNom(), qte, date, produit);
        mouvement.setId(Integer.parseInt(id));
        mss.update(mouvement);
        
        // Redirect to movement list
        response.sendRedirect("Route?page=mouvementstock&success=updated");
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
        // Important: Send IDs instead of names for proper selection in dropdowns
        response.sendRedirect("Route?page=ajoutermouvement" + 
                "&id=" + mouvement.getId() +
                "&date=" + dateStr +
                "&produit=" + mouvement.getProduit().getId() +
                "&quantite=" + mouvement.getQuantite() +
                "&type=" + getTypeIdFromName(mouvement.getType())
        );
    }
    
    /**
     * Helper method to get category ID from type name
     */
    private int getTypeIdFromName(String typeName) {
        if (typeName == null || typeName.isEmpty()) {
            return 0;
        }
        
        // Find category by name
        for (Categorie categorie : cs.findAll()) {
            if (typeName.equals(categorie.getNom())) {
                return categorie.getId();
            }
        }
        
        return 0;
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