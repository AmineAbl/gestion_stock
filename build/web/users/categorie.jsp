<%-- 
    Document   : users
    Created on : 15 avr. 2025, 10:56:11
    Author     : AMINE
--%>

<%@page import="entities.Categorie"%>
<%@page import="services.CategorieService"%>
<%@page import="entities.User"%>
<%@page import="services.UserService"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Liste des Categories</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <%
            // Empêcher la mise en cache
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
            response.setHeader("Pragma", "no-cache"); // HTTP 1.0
            response.setDateHeader("Expires", 0); // Proxies
            
            if (session.getAttribute("id") == null) {
                response.sendRedirect("users/login.jsp");
                return;
            }
        %>
        <style>
            :root {
                --primary: #3b82f6;
                --primary-dark: #2563eb;
                --primary-light: #dbeafe;
                --secondary: #6366f1;
                --success: #10b981;
                --success-light: #d1fae5;
                --danger: #ef4444;
                --danger-light: #fee2e2;
                --warning: #f59e0b;
                --warning-light: #fef3c7;
                --dark: #1e293b;
                --gray: #64748b;
                --gray-light: #f1f5f9;
                --gray-lighter: #f8fafc;
                --border: #e2e8f0;
                --shadow-sm: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
                --shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
                --shadow-md: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
                --shadow-lg: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
                --radius-sm: 0.25rem;
                --radius: 0.375rem;
                --radius-md: 0.5rem;
                --radius-lg: 0.75rem;
                --transition: all 0.2s ease;
            }

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Inter', sans-serif;
            }

            body {
                background-color: var(--gray-lighter);
                color: var(--dark);
                display: flex;
                min-height: 100vh;
                line-height: 1.5;
            }

            /* Scrollbar styling */
            ::-webkit-scrollbar {
                width: 6px;
                height: 6px;
            }

            ::-webkit-scrollbar-track {
                background: var(--gray-light);
            }

            ::-webkit-scrollbar-thumb {
                background: var(--gray);
                border-radius: 10px;
            }

            ::-webkit-scrollbar-thumb:hover {
                background: var(--primary);
            }

            /* Sidebar styles */
            .sidebar {
                width: 280px;
                background: linear-gradient(to bottom, var(--primary-dark), var(--secondary));
                color: white;
                height: 100vh;
                position: fixed;
                padding: 0;
                transition: var(--transition);
                box-shadow: var(--shadow-md);
                z-index: 1000;
                display: flex;
                flex-direction: column;
            }

            .sidebar-header {
                padding: 1.5rem;
                border-bottom: 1px solid rgba(255, 255, 255, 0.1);
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .sidebar-header h3 {
                color: white;
                font-weight: 600;
                font-size: 1.25rem;
                letter-spacing: 0.025em;
                margin: 0;
            }

            .sidebar-menu {
                padding: 1rem 0;
                flex-grow: 1;
                overflow-y: auto;
            }

            .sidebar-menu ul {
                list-style: none;
            }

            .sidebar-menu li {
                margin-bottom: 0.25rem;
            }

            .sidebar-menu li a {
                display: flex;
                align-items: center;
                padding: 0.875rem 1.5rem;
                color: rgba(255, 255, 255, 0.8);
                text-decoration: none;
                transition: var(--transition);
                border-left: 3px solid transparent;
                font-weight: 500;
                font-size: 0.9375rem;
            }

            .sidebar-menu li a:hover, .sidebar-menu li a.active {
                background-color: rgba(255, 255, 255, 0.1);
                color: white;
                border-left-color: white;
            }

            .sidebar-menu li a i {
                margin-right: 0.75rem;
                font-size: 1.125rem;
                width: 1.25rem;
                text-align: center;
                opacity: 0.85;
            }

            /* Main content area */
            .main-content {
                margin-left: 280px;
                padding: 2rem;
                width: calc(100% - 280px);
                transition: var(--transition);
            }

            .page-header {
                margin-bottom: 2rem;
            }

            .page-title {
                font-size: 1.75rem;
                font-weight: 700;
                color: var(--dark);
                margin-bottom: 0.5rem;
            }

            .page-subtitle {
                color: var(--gray);
                font-size: 1rem;
                font-weight: 400;
            }

            .card {
                background-color: white;
                border-radius: var(--radius-lg);
                box-shadow: var(--shadow);
                margin-bottom: 2rem;
                overflow: hidden;
                transition: var(--transition);
            }

            .card:hover {
                box-shadow: var(--shadow-md);
            }

            .card-header {
                padding: 1.25rem 1.5rem;
                border-bottom: 1px solid var(--border);
                background-color: white;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .card-title {
                font-size: 1.125rem;
                font-weight: 600;
                color: var(--dark);
                margin: 0;
                display: flex;
                align-items: center;
            }

            .card-title i {
                margin-right: 0.75rem;
                color: var(--primary);
                font-size: 1.25rem;
            }

            .card-body {
                padding: 1.5rem;
            }

            .table-container {
                overflow-x: auto;
                margin: 0 -1.5rem;
            }

            table {
                width: 100%;
                border-collapse: separate;
                border-spacing: 0;
            }

            th, td {
                padding: 1rem 1.5rem;
                text-align: left;
                vertical-align: middle;
            }

            th {
                background-color: var(--gray-lighter);
                font-weight: 600;
                color: var(--gray);
                font-size: 0.875rem;
                text-transform: uppercase;
                letter-spacing: 0.05em;
                border-bottom: 1px solid var(--border);
                position: sticky;
                top: 0;
                z-index: 10;
            }

            td {
                border-bottom: 1px solid var(--border);
                color: var(--dark);
                font-size: 0.9375rem;
            }

            tbody tr {
                transition: var(--transition);
            }

            tbody tr:hover {
                background-color: var(--gray-lighter);
            }

            tbody tr:last-child td {
                border-bottom: none;
            }

            .btn {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                padding: 0.5rem 1rem;
                border-radius: var(--radius);
                font-weight: 500;
                font-size: 0.875rem;
                transition: var(--transition);
                text-decoration: none;
                border: none;
                cursor: pointer;
                gap: 0.5rem;
                box-shadow: var(--shadow-sm);
            }

            .btn-sm {
                padding: 0.375rem 0.75rem;
                font-size: 0.8125rem;
            }

            .btn-primary {
                background-color: var(--primary);
                color: white;
            }

            .btn-primary:hover {
                background-color: var(--primary-dark);
                transform: translateY(-1px);
                box-shadow: var(--shadow);
            }

            .btn-danger {
                background-color: var(--danger);
                color: white;
            }

            .btn-danger:hover {
                background-color: #dc2626;
                transform: translateY(-1px);
                box-shadow: var(--shadow);
            }

            .btn-success {
                background-color: var(--success);
                color: white;
            }

            .btn-success:hover {
                background-color: #059669;
                transform: translateY(-1px);
                box-shadow: var(--shadow);
            }

            .actions-container {
                display: flex;
                gap: 0.5rem;
            }

            .empty-state {
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                padding: 3rem 1.5rem;
                text-align: center;
                color: var(--gray);
            }

            .empty-state i {
                font-size: 3rem;
                color: var(--gray);
                margin-bottom: 1rem;
                opacity: 0.5;
            }

            .empty-state p {
                font-size: 1rem;
                max-width: 20rem;
                margin: 0 auto;
            }

            .badge {
                display: inline-flex;
                align-items: center;
                padding: 0.25rem 0.75rem;
                border-radius: 9999px;
                font-size: 0.75rem;
                font-weight: 600;
                line-height: 1.5;
                gap: 0.25rem;
            }

            .category-name {
                font-weight: 600;
                color: var(--dark);
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .category-name i {
                color: var(--primary);
                font-size: 1rem;
            }

            .card-footer {
                padding: 1.25rem 1.5rem;
                border-top: 1px solid var(--border);
                background-color: var(--gray-lighter);
                display: flex;
                justify-content: flex-end;
            }

            /* Mobile menu toggle */
            .menu-toggle {
                display: none;
                position: fixed;
                top: 1rem;
                right: 1rem;
                z-index: 1001;
                background-color: var(--primary);
                color: white;
                border: none;
                border-radius: 50%;
                width: 3rem;
                height: 3rem;
                cursor: pointer;
                box-shadow: var(--shadow);
                align-items: center;
                justify-content: center;
            }

            .menu-toggle i {
                font-size: 1.25rem;
            }

            /* Responsive styles */
            @media (max-width: 1024px) {
                .sidebar {
                    width: 240px;
                }

                .main-content {
                    margin-left: 240px;
                    width: calc(100% - 240px);
                }
            }

            @media (max-width: 768px) {
                .sidebar {
                    width: 0;
                    overflow: hidden;
                }

                .main-content {
                    margin-left: 0;
                    width: 100%;
                    padding: 1.5rem;
                }

                .menu-toggle {
                    display: flex;
                }

                .sidebar.active {
                    width: 280px;
                }

                .page-title {
                    font-size: 1.5rem;
                }

                .card-header {
                    flex-direction: column;
                    align-items: flex-start;
                    gap: 1rem;
                }

                .card-header .btn {
                    width: 100%;
                }
            }

            /* Animation for sidebar */
            @keyframes slideIn {
                from {
                    transform: translateX(-100%);
                    opacity: 0;
                }
                to {
                    transform: translateX(0);
                    opacity: 1;
                }
            }

            .sidebar.active {
                animation: slideIn 0.3s forwards;
            }
        </style>
        <!-- Font Awesome for icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    </head>
    <body>
        <!-- Mobile menu toggle -->
        <button class="menu-toggle" id="menuToggle">
            <i class="fas fa-bars"></i>
        </button>
        
        <!-- Sidebar -->
        <div class="sidebar" id="sidebar">
            <div class="sidebar-header">
                <h3><i class="fas fa-boxes"></i> Gestion de Stock</h3>
            </div>
            <div class="sidebar-menu">
                <ul>
                    <li><a href="Route?page=produits"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
                    <li><a href="Route?page=categories" class="active"><i class="fas fa-tags"></i> Catégories</a></li>
                    <li><a href="Route?page=mouvementstock"><i class="fas fa-exchange-alt"></i> Mouvement de stock</a></li>
                    <li><a href="Route?page=statistiques"><i class="fas fa-chart-bar"></i> Statistiques</a></li>
                    <li><a href="Route?page=profile"><i class="fas fa-user-cog"></i> Profile</a></li>
                    <li><a href="${pageContext.request.contextPath}/LogoutController"><i class="fas fa-sign-out-alt"></i> Déconnexion</a></li>
                </ul>
            </div>
        </div>
        
        <!-- Main content -->
        <div class="main-content">
            <div class="page-header">
                <h1 class="page-title">Gestion des Catégories</h1>
                <p class="page-subtitle">Consultez et gérez les catégories de produits</p>
            </div>
            
            <div class="card">
                <div class="card-header">
                    <h2 class="card-title"><i class="fas fa-tag"></i> Liste des Catégories</h2>
                    <a href="Route?page=ajoutercategorie" class="btn btn-success">
                        <i class="fas fa-plus"></i> Ajouter une catégorie
                    </a>
                </div>
                <div class="card-body">
                    <div class="table-container">
                        <table>
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Nom</th>
                                   
                                </tr>
                            </thead>
                            
                            <tbody>
                                <%
                                    CategorieService cd = new CategorieService();
                                    java.util.List<Categorie> categories = cd.findAll();
                                    if(categories != null && !categories.isEmpty()) {
                                        for(Categorie c : categories){
                                %>
                                <tr>
                                    <td><%= c.getId() %></td>
                                    <td class="category-name"><i class="fas fa-tag"></i> <%= c.getNom() %></td>
                                    <td class="actions-container">
                                        <a href="${pageContext.request.contextPath}/CategorieController?id=<%= c.getId() %>&op=update" class="btn btn-primary btn-sm">
                                            <i class="fas fa-edit"></i> Modifier
                                        </a>
                                        <a href="${pageContext.request.contextPath}/CategorieController?id=<%= c.getId() %>&op=delete" class="btn btn-danger btn-sm" 
                                           onclick="return confirm('Êtes-vous sûr de vouloir supprimer cette catégorie? Cette action peut affecter les produits associés.');">
                                            <i class="fas fa-trash"></i> Supprimer
                                        </a>
                                    </td>
                                </tr>
                                <% 
                                        }
                                    } else {
                                %>
                                <tr>
                                    <td colspan="3">
                                        <div class="empty-state">
                                            <i class="fas fa-tags"></i>
                                            <p>Aucune catégorie trouvée. Commencez par ajouter une catégorie pour organiser vos produits.</p>
                                        </div>
                                    </td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- JavaScript for mobile menu toggle -->
        <script>
            document.addEventListener('DOMContentLoaded', function() {
                const menuToggle = document.getElementById('menuToggle');
                const sidebar = document.getElementById('sidebar');
                
                if (menuToggle && sidebar) {
                    menuToggle.addEventListener('click', function() {
                        sidebar.classList.toggle('active');
                    });
                    
                    // Close sidebar when clicking outside on mobile
                    document.addEventListener('click', function(event) {
                        const isClickInsideMenu = sidebar.contains(event.target);
                        const isClickOnToggle = menuToggle.contains(event.target);
                        
                        if (!isClickInsideMenu && !isClickOnToggle && window.innerWidth <= 768 && sidebar.classList.contains('active')) {
                            sidebar.classList.remove('active');
                        }
                    });
                }
            });
        </script>
    </body>
</html>