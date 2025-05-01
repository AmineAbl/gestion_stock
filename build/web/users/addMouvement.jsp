<%-- 
    Document   : addMouvement
    Created on : 30 avr. 2025, 20:42:50
    Author     : AMINE
--%>

<%@page import="entities.Categorie"%>
<%@page import="services.CategorieService"%>
<%@page import="entities.Produit"%>
<%@page import="java.util.List"%>
<%@page import="services.ProduitService"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ajouter Mouvement</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            body {
                background-color: #f5f5f5;
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
                padding: 20px;
            }

            fieldset {
                border: none;
                background-color: white;
                border-radius: 10px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
                padding: 30px;
                width: 100%;
                max-width: 600px;
            }

            legend {
                font-size: 24px;
                font-weight: 600;
                color: #333;
                padding: 0 10px;
                margin-bottom: 20px;
                position: relative;
            }

            legend::after {
                content: '';
                display: block;
                width: 50px;
                height: 3px;
                background-color: #4a6fdc;
                margin-top: 8px;
            }

            .form-group {
                margin-bottom: 20px;
            }

            label {
                display: block;
                margin-bottom: 8px;
                font-weight: 500;
                color: #555;
            }

            input[type="text"], input[type="number"], input[type="date"], select {
                width: 100%;
                padding: 12px 15px;
                border: 1px solid #ddd;
                border-radius: 6px;
                font-size: 16px;
                transition: border-color 0.3s, box-shadow 0.3s;
            }

            input[type="text"]:focus, input[type="number"]:focus, input[type="date"]:focus, select:focus {
                border-color: #4a6fdc;
                box-shadow: 0 0 0 3px rgba(74, 111, 220, 0.2);
                outline: none;
            }

            button[type="submit"] {
                background-color: #4a6fdc;
                color: white;
                border: none;
                border-radius: 6px;
                padding: 12px 25px;
                font-size: 16px;
                font-weight: 500;
                cursor: pointer;
                transition: background-color 0.3s;
                width: 100%;
                margin-top: 10px;
            }

            button[type="submit"]:hover {
                background-color: #3a5fc8;
            }

            .error-message {
                color: #e53e3e;
                font-size: 14px;
                margin-top: 5px;
            }

            @media (max-width: 600px) {
                fieldset {
                    padding: 20px;
                }
            }
        </style>
    </head>
    <body>
        <%
            // Get parameters for modification
            String id = request.getParameter("id");
            String produitId = request.getParameter("produit");
            String quantite = request.getParameter("quantite");
            String typeId = request.getParameter("type");
            String date = request.getParameter("date");
        %>
        <fieldset>
            <legend>Ajouter Mouvement</legend>
            <!-- Formulaire d'ajout de mouvement de stock -->
            <form action="${pageContext.request.contextPath}/MouvementController" method="POST">
                <% if (id != null && !id.isEmpty()) { %>
                    <input type="hidden" name="id" value="<%= id %>" />
                <% } %>
                
                <div class="form-group">
                    <label for="produit">Produit</label>
                    <select id="produit" name="produit" required>
                        <%
                            ProduitService ps = new ProduitService();
                            java.util.List<Produit> produits = ps.findAll();
                            if (produits != null && !produits.isEmpty()) {
                                for (Produit p : produits) {
                                    boolean isSelected = produitId != null && produitId.equals(String.valueOf(p.getId()));
                        %>
                        <option value="<%= p.getId() %>" <%= isSelected ? "selected" : "" %>><%= p.getNom() %></option>
                        <%
                                }
                            } else {
                        %>
                        <option value="">Aucun produit disponible</option>
                        <%
                            }
                        %>
                    </select>
                </div>

                <div class="form-group">
                    <label for="quantite">Quantité</label>
                    <input type="number" id="quantite" name="quantite" value="<%= quantite != null ? quantite : "" %>" required />
                </div>

                <div class="form-group">
                    <label for="type">Catégorie</label>
                    <select id="type" name="type" required>
                        <%
                            CategorieService cs = new CategorieService();
                            java.util.List<Categorie> categories = cs.findAll();
                            if (categories != null && !categories.isEmpty()) {
                                for (Categorie c : categories) {
                                    boolean isSelected = typeId != null && typeId.equals(String.valueOf(c.getId()));
                        %>
                        <option value="<%= c.getId() %>" <%= isSelected ? "selected" : "" %>><%= c.getNom() %></option>
                        <%
                                }
                            } else {
                        %>
                        <option value="">Aucune catégorie disponible</option>
                        <%
                            }
                        %>
                    </select>
                </div>

                <div class="form-group">
                    <label for="date">Date du mouvement</label>
                    <input type="date" id="date" name="date" value="<%= date != null ? date : "" %>" required>
                </div>

                <button type="submit">
                    <%= id != null && !id.isEmpty() ? "Modifier" : "Ajouter" %> Mouvement
                </button>
            </form>
        </fieldset>
    </body>
</html>