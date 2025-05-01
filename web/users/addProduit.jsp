<%@page import="entities.Categorie"%>
<%@page import="services.CategorieService"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion Produit</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        :root {
            --primary: #4361ee;
            --primary-dark: #3a56d4;
            --secondary: #7209b7;
            --accent: #f72585;
            --success: #2ecc71;
            --danger: #e74c3c;
            --warning: #f39c12;
            --light: #f8f9fa;
            --dark: #212529;
            --gray: #6c757d;
            --gray-light: #e9ecef;
            --shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
            --radius: 8px;
            --transition: all 0.3s ease;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            background-color: #f5f7fa;
            min-height: 100vh;
            color: var(--dark);
        }

        /* Sidebar styles */
        .sidebar {
            width: 280px;
            background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
            color: white;
            height: 100vh;
            position: fixed;
            padding: 20px 0;
            transition: var(--transition);
            box-shadow: var(--shadow-lg);
            z-index: 1000;
        }

        .sidebar-header {
            padding: 0 25px 25px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            text-align: center;
        }

        .sidebar-header h3 {
            color: white;
            margin-top: 15px;
            font-weight: 600;
            font-size: 1.5rem;
        }

        .sidebar-menu {
            padding: 25px 0;
        }

        .sidebar-menu ul {
            list-style: none;
        }

        .sidebar-menu li {
            margin-bottom: 5px;
        }

        .sidebar-menu li a {
            display: flex;
            align-items: center;
            padding: 14px 25px;
            color: rgba(255, 255, 255, 0.85);
            text-decoration: none;
            transition: var(--transition);
            border-left: 4px solid transparent;
        }

        .sidebar-menu li a:hover,
        .sidebar-menu li a.active {
            background-color: rgba(255, 255, 255, 0.1);
            color: white;
            border-left-color: white;
        }

        .sidebar-menu li a i {
            margin-right: 12px;
            font-size: 1.1rem;
            width: 20px;
        }

        /* Main content */
        .main-content {
            margin-left: 280px;
            padding: 30px;
            transition: var(--transition);
            min-height: 100vh;
        }

        .card {
            background-color: white;
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            padding: 30px;
            max-width: 700px;
            margin: 0 auto;
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
        }

        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: var(--radius);
            font-size: 1rem;
            transition: var(--transition);
        }

        .form-control:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.2);
            outline: none;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 12px 20px;
            border-radius: var(--radius);
            font-weight: 500;
            transition: var(--transition);
            cursor: pointer;
            gap: 8px;
            border: none;
        }

        .btn-primary {
            background-color: var(--primary);
            color: white;
        }

        .btn-primary:hover {
            background-color: var(--primary-dark);
        }

        .btn-secondary {
            background-color: var(--gray);
            color: white;
        }

        .alert {
            padding: 12px;
            border-radius: var(--radius);
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .alert-danger {
            background-color: #f8d7da;
            color: #721c24;
            border-left: 4px solid #f5c6cb;
        }

        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border-left: 4px solid #c3e6cb;
        }

        @media (max-width: 768px) {
            .sidebar {
                width: 0;
                overflow: hidden;
            }

            .main-content {
                margin-left: 0;
                width: 100%;
                padding: 20px;
            }

            .menu-toggle {
                display: flex;
                position: fixed;
                top: 20px;
                right: 20px;
                z-index: 1001;
                background-color: var(--primary);
                color: white;
                border: none;
                border-radius: 50%;
                width: 45px;
                height: 45px;
                align-items: center;
                justify-content: center;
                box-shadow: var(--shadow);
            }

            .sidebar.active {
                width: 280px;
            }
        }
    </style>
</head>
<body>
    <%
        String error = request.getParameter("error");
        String success = request.getParameter("success");
        String id = request.getParameter("id");
    %>

    <button class="menu-toggle" id="menuToggle" style="display: none;">
        <i class="fas fa-bars"></i>
    </button>

    <!-- Sidebar -->
    <div class="sidebar" id="sidebar">
        <div class="sidebar-header">
            <h3>Gestion de Stock</h3>
        </div>
        <div class="sidebar-menu">
            <ul>
                <li><a href="Route?page=produits"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
                <li><a href="Route?page=categories"><i class="fas fa-tags"></i> Catégories</a></li>
                <li><a href="Route?page=mouvementstock"><i class="fas fa-exchange-alt"></i> Mouvements</a></li>
                <li><a href="Route?page=statistiques"><i class="fas fa-chart-bar"></i> Statistiques</a></li>
                <li><a href="Route?page=profile"><i class="fas fa-user-cog"></i> Profil</a></li>
                <li><a href="${pageContext.request.contextPath}/LogoutController"><i class="fas fa-sign-out-alt"></i> Déconnexion</a></li>
            </ul>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <div class="card">
            <% if (error != null) { %>
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-circle"></i> <%= error %>
                </div>
            <% } %>

            <% if (success != null) { %>
                <div class="alert alert-success">
                    <i class="fas fa-check-circle"></i> <%= success %>
                </div>
            <% } %>

            <h2 style="margin-bottom: 25px; font-size: 1.5rem;">
                <%= id != null ? "Modifier le produit" : "Nouveau produit" %>
            </h2>

            <form method="POST" action="${pageContext.request.contextPath}/ProduitController">
                <input type="hidden" name="id" value="<%= id != null ? id : "" %>">

                <div class="form-group">
                    <label class="form-label">Nom du produit</label>
                    <input type="text" name="nom" class="form-control" 
                           value="<%= request.getParameter("nom") != null ? request.getParameter("nom") : "" %>" 
                           placeholder="Nom du produit"
                           required>
                </div>

                <div class="form-group">
                    <label class="form-label">Prix (DH)</label>
                    <input type="number" name="prix" class="form-control" 
                           value="<%= request.getParameter("prix") != null ? request.getParameter("prix") : "" %>" 
                           step="0.01" 
                           placeholder="Prix unitaire"
                           required>
                </div>

                <div class="form-group">
                    <label class="form-label">Quantité en stock</label>
                    <input type="number" name="quantite" class="form-control" 
                           value="<%= request.getParameter("quantite") != null ? request.getParameter("quantite") : "" %>" 
                           placeholder="Quantité disponible"
                           min="0"
                           required>
                </div>

                <div class="form-group">
                    <label class="form-label">Catégorie</label>
                    <select name="categorie" class="form-control" required>
                        <option value="">Sélectionnez une catégorie</option>
                        <% 
                            CategorieService cs = new CategorieService();
                            List<Categorie> categories = cs.findAll();
                            String selectedCategory = request.getParameter("categorie");
                            
                            for (Categorie c : categories) {
                                String selected = "";
                                if (selectedCategory != null && selectedCategory.equals(String.valueOf(c.getId()))) {
                                    selected = "selected";
                                }
                        %>
                            <option value="<%= c.getId() %>" <%= selected %>><%= c.getNom() %></option>
                        <% } %>
                    </select>
                </div>

                <div style="display: flex; gap: 15px; margin-top: 30px;">
                    <a href="Route?page=produits" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i> Annuler
                    </a>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save"></i> <%= id != null ? "Modifier" : "Enregistrer" %>
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Gestion du menu mobile
            const menuToggle = document.getElementById('menuToggle');
            const sidebar = document.getElementById('sidebar');

            if (menuToggle && sidebar) {
                menuToggle.addEventListener('click', () => {
                    sidebar.classList.toggle('active');
                });

                // Fermer le menu en cliquant à l'extérieur
                document.addEventListener('click', (e) => {
                    if (window.innerWidth <= 768) {
                        if (!sidebar.contains(e.target) && !menuToggle.contains(e.target)) {
                            sidebar.classList.remove('active');
                        }
                    }
                });

                // Afficher le bouton menu en mobile
                const checkWindowSize = () => {
                    menuToggle.style.display = window.innerWidth <= 768 ? 'flex' : 'none';
                };
                checkWindowSize();
                window.addEventListener('resize', checkWindowSize);
            }

            // Validation des entrées numériques
            document.querySelectorAll('input[type="number"]').forEach(input => {
                input.addEventListener('input', function() {
                    if (this.value < 0) {
                        this.value = 0;
                    }
                });
            });
        });
    </script>
</body>
</html>