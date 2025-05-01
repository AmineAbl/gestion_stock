<%-- 
    Document   : users
    Created on : 15 avr. 2025, 10:56:11
    Author     : AMINE
--%>

<%@page import="entities.User"%>
<%@page import="services.UserService"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Profil Utilisateur</title>
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

            .profile-header {
                display: flex;
                align-items: center;
                margin-bottom: 2rem;
                padding-bottom: 1.5rem;
                border-bottom: 1px solid var(--border);
            }

            .profile-avatar {
                width: 100px;
                height: 100px;
                border-radius: 50%;
                background-color: var(--primary-light);
                display: flex;
                align-items: center;
                justify-content: center;
                margin-right: 1.5rem;
                font-size: 2.5rem;
                font-weight: 700;
                color: var(--primary-dark);
                border: 3px solid var(--primary);
            }

            .profile-info {
                flex: 1;
            }

            .profile-name {
                font-size: 1.5rem;
                font-weight: 700;
                color: var(--dark);
                margin-bottom: 0.25rem;
            }

            .profile-email {
                color: var(--gray);
                font-size: 1rem;
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .profile-email i {
                color: var(--primary);
                font-size: 1rem;
            }

            .profile-actions {
                display: flex;
                gap: 0.75rem;
                margin-top: 1rem;
            }

            .profile-section {
                margin-bottom: 2rem;
            }

            .profile-section-title {
                font-size: 1.125rem;
                font-weight: 600;
                color: var(--dark);
                margin-bottom: 1rem;
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .profile-section-title i {
                color: var(--primary);
            }

            .info-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
                gap: 1.5rem;
            }

            .info-item {
                background-color: var(--gray-lighter);
                padding: 1rem;
                border-radius: var(--radius);
                transition: var(--transition);
            }

            .info-item:hover {
                background-color: var(--primary-light);
            }

            .info-label {
                font-size: 0.875rem;
                color: var(--gray);
                margin-bottom: 0.25rem;
            }

            .info-value {
                font-size: 1rem;
                font-weight: 500;
                color: var(--dark);
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

            .btn-outline {
                background-color: transparent;
                border: 1px solid var(--border);
                color: var(--gray);
            }

            .btn-outline:hover {
                background-color: var(--gray-light);
                color: var(--dark);
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

                .profile-header {
                    flex-direction: column;
                    align-items: center;
                    text-align: center;
                }

                .profile-avatar {
                    margin-right: 0;
                    margin-bottom: 1rem;
                }

                .profile-actions {
                    flex-direction: column;
                    width: 100%;
                }

                .profile-actions .btn {
                    width: 100%;
                }

                .info-grid {
                    grid-template-columns: 1fr;
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
                    <li><a href="Route?page=categories"><i class="fas fa-tags"></i> Catégories</a></li>
                    <li><a href="Route?page=mouvementstock"><i class="fas fa-exchange-alt"></i> Mouvement de stock</a></li>
                    <li><a href="Route?page=statistiques"><i class="fas fa-chart-bar"></i> Statistiques</a></li>
                    <li><a href="Route?page=profile" class="active"><i class="fas fa-user-cog"></i> Profil</a></li>
                    <li><a href="${pageContext.request.contextPath}/LogoutController"><i class="fas fa-sign-out-alt"></i> Déconnexion</a></li>
                </ul>
            </div>
        </div>
        
        <!-- Main content -->
        <div class="main-content">
            <div class="page-header">
                <h1 class="page-title">Profil Utilisateur</h1>
                <p class="page-subtitle">Consultez et gérez vos informations personnelles</p>
            </div>
            
            <div class="card">
                <div class="card-header">
                    <h2 class="card-title"><i class="fas fa-user"></i> Informations personnelles</h2>
                </div>
                <div class="card-body">
                    <div class="profile-header">
                        <div class="profile-avatar">
                            <%
                                String nom = (String)session.getAttribute("nom");
                                String prenom = (String)session.getAttribute("prenom");
                                if(nom != null && prenom != null && !nom.isEmpty() && !prenom.isEmpty()) {
                                    out.print(nom.charAt(0) + "" + prenom.charAt(0));
                                } else {
                                    out.print("U");
                                }
                            %>
                        </div>
                        <div class="profile-info">
                            <h3 class="profile-name">
                                <%= session.getAttribute("prenom") %> <%= session.getAttribute("nom") %>
                            </h3>
                            <div class="profile-email">
                                <i class="fas fa-envelope"></i>
                                <%= session.getAttribute("email") %>
                            </div>
                            <div class="profile-actions">
                               
                            </div>
                        </div>
                    </div>
                    
                    <div class="profile-section">
                        <h3 class="profile-section-title">
                            <i class="fas fa-info-circle"></i> Détails du compte
                        </h3>
                        <div class="info-grid">
                            <div class="info-item">
                                <div class="info-label">Nom</div>
                                <div class="info-value"><%= session.getAttribute("nom") %></div>
                            </div>
                            <div class="info-item">
                                <div class="info-label">Prénom</div>
                                <div class="info-value"><%= session.getAttribute("prenom") %></div>
                            </div>
                            <div class="info-item">
                                <div class="info-label">Email</div>
                                <div class="info-value"><%= session.getAttribute("email") %></div>
                            </div>
                            <div class="info-item">
                                <div class="info-label">Rôle</div>
                                <div class="info-value">Administrateur</div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="profile-section">
                        <h3 class="profile-section-title">
                            <i class="fas fa-shield-alt"></i> Sécurité du compte
                        </h3>
                        <div class="info-grid">
                            <div class="info-item">
                                <div class="info-label">Dernière connexion</div>
                                <div class="info-value">Aujourd'hui</div>
                            </div>
                            <div class="info-item">
                                <div class="info-label">Statut du compte</div>
                                <div class="info-value">Actif</div>
                            </div>
                        </div>
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