<%-- 
    Document   : users
    Created on : 15 avr. 2025, 10:56:11
    Author     : AMINE
--%>

<%@page import="entities.Produit"%>
<%@page import="services.ProduitService"%>
<%@page import="entities.User"%>
<%@page import="services.UserService"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Liste des Produits</title>
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
                min-height: 100vh;
            }
            
            /* Sidebar styles */
            .sidebar {
                width: 250px;
                background-color: #2c3e50;
                color: white;
                height: 100vh;
                position: fixed;
                padding: 20px 0;
                transition: all 0.3s;
            }
            
            .sidebar-header {
                padding: 0 20px 20px;
                border-bottom: 1px solid rgba(255, 255, 255, 0.1);
                text-align: center;
            }
            
            .sidebar-header h3 {
                color: white;
                margin-top: 10px;
            }
            
            .sidebar-menu {
                padding: 20px 0;
            }
            
            .sidebar-menu ul {
                list-style: none;
            }
            
            .sidebar-menu li a {
                display: block;
                padding: 12px 20px;
                color: #ecf0f1;
                text-decoration: none;
                transition: all 0.3s;
            }
            
            .sidebar-menu li a:hover {
                background-color: #34495e;
                color: white;
            }
            
            .sidebar-menu li a i {
                margin-right: 10px;
            }
            
            /* Main content area */
            .main-content {
                margin-left: 250px;
                padding: 20px;
                width: calc(100% - 250px);
            }
            
            fieldset {
                border: none;
                background-color: white;
                border-radius: 10px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
                padding: 30px;
                width: 100%;
                max-width: 900px;
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
            
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 15px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
            }
            
            th, td {
                padding: 15px;
                text-align: left;
                border-bottom: 1px solid #eee;
            }
            
            th {
                background-color: #f8f9fa;
                font-weight: 600;
                color: #444;
                position: sticky;
                top: 0;
            }
            
            tbody tr:hover {
                background-color: #f9f9f9;
            }
            
            tbody tr:last-child td {
                border-bottom: none;
            }
            
            a {
                text-decoration: none;
                padding: 8px 12px;
                border-radius: 5px;
                font-weight: 500;
                font-size: 14px;
                transition: all 0.3s ease;
                display: inline-block;
            }
            
            a[href*="delete"] {
                background-color: #ff5252;
                color: white;
            }
            
            a[href*="delete"]:hover {
                background-color: #e04646;
            }
            
            a[href*="update"] {
                background-color: #4a6fdc;
                color: white;
            }
            
            a[href*="update"]:hover {
                background-color: #3a5fc8;
            }
            
            .empty-message {
                text-align: center;
                padding: 20px;
                color: #666;
                font-style: italic;
            }
            
            .actions-container {
                display: flex;
                gap: 8px;
            }
            
            .add-button {
                display: inline-block;
                background-color: #4CAF50;
                color: white;
                padding: 10px 15px;
                border-radius: 5px;
                margin-top: 20px;
                font-weight: 500;
                transition: background-color 0.3s;
            }
            
            .add-button:hover {
                background-color: #3e9142;
            }
            
            @media (max-width: 768px) {
                .sidebar {
                    width: 0;
                    overflow: hidden;
                }
                
                .main-content {
                    margin-left: 0;
                    width: 100%;
                }
                
                table {
                    display: block;
                    overflow-x: auto;
                    white-space: nowrap;
                }
                
                fieldset {
                    padding: 20px;
                }
                
                th, td {
                    padding: 10px;
                }
                
                a {
                    padding: 6px 10px;
                    font-size: 13px;
                }
            }
        </style>
        <!-- Font Awesome for icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    </head>
    <body>
        <!-- Sidebar -->
        <div class="sidebar">
            <div class="sidebar-header">
                <h3>Menu Admin</h3>
            </div>
            <div class="sidebar-menu">
                <ul>
                    <li><a href="Route?page=produits"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
                    <li><a href="Route?page=categories" class="active"><i class="fas fa-users"></i> Catégories</a></li>
                    <li><a href="#"><i class="fas fa-book"></i> Mouvement de stock</a></li>
                    <li><a href="Route?page=statistiques"><i class="fas fa-chart-bar"></i> Statistiques</a></li>
                    <li><a href="Route?page=profile"><i class="fas fa-cog"></i> Profile</a></li>
                    <li><a href="${pageContext.request.contextPath}/LogoutController"><i class="fas fa-sign-out-alt"></i> Déconnexion</a></li>
                </ul>
            </div>
        </div>
        
        <!-- Main content -->
        <div class="main-content">
            <fieldset>
                <legend>Liste des produits</legend>
                
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Nom</th>
                            <th>Prix</th>
                            <th>Quantité</th>
                            <th>Catégorie</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    
                    <tbody>
                        <%
                           ProduitService ps = new ProduitService();
                            java.util.List<Produit> produits = ps.findAll();
                            if(produits != null && !produits.isEmpty()) {
                                for(Produit p : produits){
                        %>
                        <tr>
                            <td><%= p.getId() %></td>
                            <td><%= p.getNom() %></td>
                            <td><%= p.getPrix() %></td>
                            <td><%= p.getQuantite() %></td>
                            <td><%= (p.getCategorie() != null) ? p.getCategorie().getNom() : "Sans catégorie" %></td>
                            <td class="actions-container">
                                <a href="${pageContext.request.contextPath}/ProduitController?id=<%= p.getId() %>&op=delete">Supprimer</a>
                                <a href="${pageContext.request.contextPath}/ProduitController?id=<%= p.getId() %>&op=update">Modifier</a>
                            </td>
                        </tr>
                        <% 
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="5" class="empty-message">Aucun produit trouvé</td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
                
                <a href="Route?page=ajouterproduit" class="add-button">Ajouter un produit</a>
            </fieldset>
        </div>
    </body>
</html>