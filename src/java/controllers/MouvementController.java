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
 *
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

                handleCreateOrUpdate(request, response);
            } else if (op.equals("delete")) {

                handleDelete(request, response);
            } else if (op.equals("update")) {

                handlePrepareUpdate(request, response);
            } else {

                response.sendRedirect("Route?page=mouvementstock&error=unknown_operation");
            }
        } catch (Exception e) {

            e.printStackTrace();

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

        if (produitId == null || quantite == null || type == null || dateStr == null
                || produitId.isEmpty() || quantite.isEmpty() || type.isEmpty() || dateStr.isEmpty()) {
            response.sendRedirect("Route?page=ajoutermouvement&error=missing_fields");
            return;
        }

        Date date = sdf.parse(dateStr);

        Produit produit = ps.findById(Integer.parseInt(produitId));

        if (produit == null) {
            response.sendRedirect("Route?page=ajoutermouvement&error=invalid_product");
            return;
        }

        int qte = Integer.parseInt(quantite);

        if (qte <= 0) {
            response.sendRedirect("Route?page=ajoutermouvement&error=invalid_quantity");
            return;
        }

        if (id == null || id.isEmpty()) {

            if ("ajouter".equals(type)) {

                produit.setQuantite(produit.getQuantite() + qte);
            } else if ("retirer".equals(type)) {

                if (produit.getQuantite() < qte) {
                    response.sendRedirect("Route?page=ajoutermouvement&error=insufficient_stock&produit="
                            + produitId + "&quantite=" + quantite + "&type=" + type + "&date=" + dateStr);
                    return;
                }

                produit.setQuantite(produit.getQuantite() - qte);
            } else {
                response.sendRedirect("Route?page=ajoutermouvement&error=invalid_movement_type");
                return;
            }

            ps.update(produit);

            MouvementStock mouvement = new MouvementStock(type, qte, date, produit);
            mss.create(mouvement);

            response.sendRedirect("Route?page=mouvementstock&success=created");
        } else {

            MouvementStock originalMouvement = mss.findById(Integer.parseInt(id));
            if (originalMouvement != null) {

                if ("ajouter".equals(originalMouvement.getType())) {

                    produit.setQuantite(produit.getQuantite() - originalMouvement.getQuantite());
                } else if ("retirer".equals(originalMouvement.getType())) {

                    produit.setQuantite(produit.getQuantite() + originalMouvement.getQuantite());
                }

                if ("ajouter".equals(type)) {

                    produit.setQuantite(produit.getQuantite() + qte);
                } else if ("retirer".equals(type)) {

                    if (produit.getQuantite() < qte) {
                        response.sendRedirect("Route?page=ajoutermouvement&error=insufficient_stock&id=" + id
                                + "&produit=" + produitId + "&quantite=" + quantite
                                + "&type=" + type + "&date=" + dateStr);
                        return;
                    }

                    produit.setQuantite(produit.getQuantite() - qte);
                } else {
                    response.sendRedirect("Route?page=ajoutermouvement&error=invalid_movement_type");
                    return;
                }

                ps.update(produit);

                MouvementStock mouvement = new MouvementStock(type, qte, date, produit);
                mouvement.setId(Integer.parseInt(id));
                mss.update(mouvement);

                response.sendRedirect("Route?page=mouvementstock&success=updated");
            } else {
                response.sendRedirect("Route?page=mouvementstock&error=movement_not_found");
            }
        }
    }

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

        Produit produit = mouvement.getProduit();
        if (produit != null) {
            if ("ajouter".equals(mouvement.getType())) {

                produit.setQuantite(produit.getQuantite() - mouvement.getQuantite());
            } else if ("retirer".equals(mouvement.getType())) {

                produit.setQuantite(produit.getQuantite() + mouvement.getQuantite());
            }

            ps.update(produit);
        }

        mss.delete(mouvement);
        response.sendRedirect("Route?page=mouvementstock&success=deleted");
    }

    /**
     * Prepare for update operation by redirecting to the form with movement
     * data
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
        response.sendRedirect("Route?page=ajoutermouvement"
                + "&id=" + mouvement.getId()
                + "&date=" + dateStr
                + "&produit=" + mouvement.getProduit().getId()
                + "&quantite=" + mouvement.getQuantite()
                + "&type=" + mouvement.getType()
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
