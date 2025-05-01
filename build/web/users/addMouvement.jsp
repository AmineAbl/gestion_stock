<%@page import="entities.Categorie"%>
<%@page import="services.CategorieService"%>
<%@page import="entities.Produit"%>
<%@page import="java.util.List"%>
<%@page import="services.ProduitService"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Ajouter Mouvement</title>
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
                display: flex;
                flex-direction: column;
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
                letter-spacing: 0.5px;
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
                font-weight: 500;
            }

            .sidebar-menu li a:hover, .sidebar-menu li a.active {
                background-color: rgba(255, 255, 255, 0.1);
                color: white;
                border-left-color: white;
            }

            .sidebar-menu li a i {
                margin-right: 12px;
                font-size: 1.1rem;
                width: 20px;
                text-align: center;
            }

            /* Main content area */
            .main-content {
                margin-left: 280px;
                padding: 30px;
                width: calc(100% - 280px);
                transition: var(--transition);
                display: flex;
                flex-direction: column;
                min-height: 100vh;
            }

            .content-header {
                margin-bottom: 30px;
            }

            .content-header h1 {
                font-size: 1.8rem;
                font-weight: 600;
                color: var(--dark);
                margin-bottom: 10px;
            }

            .content-header p {
                color: var(--gray);
                font-size: 0.95rem;
            }

            .card {
                background-color: white;
                border-radius: var(--radius);
                box-shadow: var(--shadow);
                padding: 30px;
                margin-bottom: 30px;
                transition: var(--transition);
                max-width: 700px;
                width: 100%;
                margin: 0 auto;
            }

            .card:hover {
                box-shadow: var(--shadow-lg);
            }

            .card-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 25px;
                padding-bottom: 15px;
                border-bottom: 1px solid var(--gray-light);
            }

            .card-title {
                font-size: 1.25rem;
                font-weight: 600;
                color: var(--dark);
                position: relative;
                padding-left: 15px;
            }

            .card-title::before {
                content: '';
                position: absolute;
                left: 0;
                top: 0;
                height: 100%;
                width: 4px;
                background: linear-gradient(to bottom, var(--primary), var(--secondary));
                border-radius: 2px;
            }

            .form-group {
                margin-bottom: 25px;
            }

            .form-label {
                display: block;
                margin-bottom: 8px;
                font-weight: 500;
                color: var(--dark);
                font-size: 0.95rem;
            }

            .form-control {
                width: 100%;
                padding: 12px 15px;
                border: 1px solid #ddd;
                border-radius: var(--radius);
                font-size: 1rem;
                transition: var(--transition);
                background-color: var(--light);
                color: var(--dark);
            }

            .form-control:focus {
                border-color: var(--primary);
                box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.2);
                outline: none;
                background-color: white;
            }

            .form-control::placeholder {
                color: #adb5bd;
            }

            .form-select {
                appearance: none;
                background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' viewBox='0 0 24 24' fill='none' stroke='%236c757d' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpath d='M6 9l6 6 6-6'/%3E%3C/svg%3E");
                background-repeat: no-repeat;
                background-position: right 15px center;
                background-size: 16px;
                padding-right: 40px;
            }

            .btn {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                padding: 12px 20px;
                border-radius: var(--radius);
                font-weight: 500;
                font-size: 1rem;
                transition: var(--transition);
                text-decoration: none;
                border: none;
                cursor: pointer;
                gap: 8px;
            }

            .btn-primary {
                background-color: var(--primary);
                color: white;
            }

            .btn-primary:hover {
                background-color: var(--primary-dark);
                transform: translateY(-2px);
            }

            .btn-secondary {
                background-color: var(--gray);
                color: white;
            }

            .btn-secondary:hover {
                background-color: #5a6268;
                transform: translateY(-2px);
            }

            .btn-block {
                width: 100%;
            }

            .form-actions {
                display: flex;
                gap: 15px;
                margin-top: 30px;
            }

            .error-message {
                color: var(--danger);
                font-size: 0.85rem;
                margin-top: 5px;
                display: flex;
                align-items: center;
                gap: 5px;
            }

            .error-message i {
                font-size: 0.9rem;
            }

            /* Responsive styles */
            @media (max-width: 992px) {
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
                    padding: 20px;
                }

                .card {
                    padding: 20px;
                }

                .form-actions {
                    flex-direction: column;
                }
            }

            /* Mobile menu toggle */
            .menu-toggle {
                display: none;
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
                cursor: pointer;
                box-shadow: var(--shadow);
            }

            @media (max-width: 768px) {
                .menu-toggle {
                    display: flex;
                    align-items: center;
                    justify-content: center;
                }

                .sidebar.active {
                    width: 280px;
                }
            }

            /* Form validation styles */
            .form-control.is-invalid {
                border-color: var(--danger);
                background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' viewBox='0 0 24 24' fill='none' stroke='%23e74c3c' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3E%3Ccircle cx='12' cy='12' r='10'%3E%3C/circle%3E%3Cline x1='12' y1='8' x2='12' y2='12'%3E%3C/line%3E%3Cline x1='12' y1='16' x2='12.01' y2='16'%3E%3C/line%3E%3C/svg%3E");
                background-repeat: no-repeat;
                background-position: right 15px center;
                background-size: 16px;
                padding-right: 40px;
            }

            .form-control.is-valid {
                border-color: var(--success);
                background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' viewBox='0 0 24 24' fill='none' stroke='%232ecc71' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpath d='M22 11.08V12a10 10 0 1 1-5.93-9.14'%3E%3C/path%3E%3Cpolyline points='22 4 12 14.01 9 11.01'%3E%3C/polyline%3E%3C/svg%3E");
                background-repeat: no-repeat;
                background-position: right 15px center;
                background-size: 16px;
                padding-right: 40px;
            }
        </style>
    </head>
    <body>
        <%
            
            String id = request.getParameter("id");
            String produitId = request.getParameter("produit");
            String quantite = request.getParameter("quantite");
            String typeId = request.getParameter("type");
            String date = request.getParameter("date");
            
            
            String error = request.getParameter("error");
            String success = request.getParameter("success");
        %>
        
       
        <button class="menu-toggle" id="menuToggle">
            <i class="fas fa-bars"></i>
        </button>

        
        <div class="sidebar" id="sidebar">
            <div class="sidebar-header">
                <h3>Gestion de Stock</h3>
            </div>
            <div class="sidebar-menu">
                <ul>
                    <li><a href="Route?page=produits"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
                    <li><a href="Route?page=categories"><i class="fas fa-tags"></i> Catégories</a></li>
                    <li><a href="Route?page=mouvementstock" class="active"><i class="fas fa-exchange-alt"></i> Mouvement de stock</a></li>
                    <li><a href="Route?page=statistiques"><i class="fas fa-chart-bar"></i> Statistiques</a></li>
                    <li><a href="Route?page=profile"><i class="fas fa-user-cog"></i> Profile</a></li>
                    <li><a href="${pageContext.request.contextPath}/LogoutController"><i class="fas fa-sign-out-alt"></i> Déconnexion</a></li>
                </ul>
            </div>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <div class="content-header">
                <h1><%= id != null && !id.isEmpty() ? "Modifier" : "Ajouter" %> un Mouvement de Stock</h1>
                <p>Veuillez remplir le formulaire ci-dessous pour <%= id != null && !id.isEmpty() ? "modifier" : "ajouter" %> un mouvement de stock</p>
            </div>

            <div class="card">
                <div class="card-header">
                    <h2 class="card-title">Formulaire de Mouvement</h2>
                </div>
                
                <% if (error != null && !error.isEmpty()) { %>
                <div class="alert alert-danger" style="background-color: #f8d7da; color: #721c24; padding: 12px; border-radius: var(--radius); margin-bottom: 20px; border-left: 4px solid #f5c6cb;">
                    <i class="fas fa-exclamation-circle"></i> Erreur: <%= error %>
                </div>
                <% } %>
                
                <% if (success != null && !success.isEmpty()) { %>
                <div class="alert alert-success" style="background-color: #d4edda; color: #155724; padding: 12px; border-radius: var(--radius); margin-bottom: 20px; border-left: 4px solid #c3e6cb;">
                    <i class="fas fa-check-circle"></i> Succès: <%= success %>
                </div>
                <% } %>
                
                
                <form action="${pageContext.request.contextPath}/MouvementController" method="POST" id="mouvementForm">
                    <% if (id != null && !id.isEmpty()) { %>
                        <input type="hidden" name="id" value="<%= id %>" />
                    <% } %>
                    
                    <div class="form-group">
                        <label for="produit" class="form-label">Produit</label>
                        <select id="produit" name="produit" class="form-control form-select" required>
                            <option value="" disabled selected>Sélectionnez un produit</option>
                            <%
                                ProduitService ps = new ProduitService();
                                java.util.List<Produit> produits = ps.findAll();
                                if (produits != null && !produits.isEmpty()) {
                                    for (Produit p : produits) {
                                        boolean isSelected = produitId != null && produitId.equals(String.valueOf(p.getId()));
                            %>
                            <option value="<%= p.getId() %>" <%= isSelected ? "selected" : "" %>><%= p.getNom() %> (Stock: <%= p.getQuantite() %>)</option>
                            <%
                                    }
                                } else {
                            %>
                            <option value="" disabled>Aucun produit disponible</option>
                            <%
                                }
                            %>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="quantite" class="form-label">Quantité</label>
                        <input type="number" id="quantite" name="quantite" class="form-control" value="<%= quantite != null ? quantite : "" %>" placeholder="Entrez la quantité" required />
                    </div>

                    <div class="form-group">
                        <label for="type" class="form-label">Type de Mouvement</label>
                        <select id="type" name="type" class="form-control form-select" required>
                            <option value="" disabled selected>Sélectionnez un type</option>
                            <option value="ajouter">Ajouter</option>
                            <option value="retirer">retirer</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="date" class="form-label">Date du mouvement</label>
                        <input type="date" id="date" name="date" class="form-control" value="<%= date != null ? date : "" %>" required>
                    </div>

                    <div class="form-actions">
                        <a href="Route?page=mouvementstock" class="btn btn-secondary">
                            <i class="fas fa-arrow-left"></i> Retour
                        </a>
                        <button type="submit" class="btn btn-primary btn-block">
                            <i class="fas fa-<%= id != null && !id.isEmpty() ? "save" : "plus" %>"></i>
                            <%= id != null && !id.isEmpty() ? "Modifier" : "Ajouter" %> le Mouvement
                        </button>
                    </div>
                </form>
            </div>
        </div>

        
        <script>
            document.addEventListener('DOMContentLoaded', function() {
               
                const menuToggle = document.getElementById('menuToggle');
                const sidebar = document.getElementById('sidebar');
                
                if (menuToggle && sidebar) {
                    menuToggle.addEventListener('click', function() {
                        sidebar.classList.toggle('active');
                    });
                    
                    
                    document.addEventListener('click', function(event) {
                        const isClickInsideMenu = sidebar.contains(event.target);
                        const isClickOnToggle = menuToggle.contains(event.target);
                        
                        if (!isClickInsideMenu && !isClickOnToggle && window.innerWidth <= 768 && sidebar.classList.contains('active')) {
                            sidebar.classList.remove('active');
                        }
                    });
                }
                
               
                const form = document.getElementById('mouvementForm');
                const quantiteInput = document.getElementById('quantite');
                
                if (form && quantiteInput) {
                    quantiteInput.addEventListener('input', function() {
                        if (this.value < 0) {
                            this.classList.add('is-invalid');
                            this.classList.remove('is-valid');
                        } else {
                            this.classList.remove('is-invalid');
                            this.classList.add('is-valid');
                        }
                    });
                    
                    form.addEventListener('submit', function(event) {
                        let isValid = true;
                        
                        // Check if quantity is valid
                        if (quantiteInput.value < 0) {
                            quantiteInput.classList.add('is-invalid');
                            isValid = false;
                        }
                        
                        if (!isValid) {
                            event.preventDefault();
                        }
                    });
                }
                
                
                const dateInput = document.getElementById('date');
                if (dateInput && dateInput.value === '') {
                    const today = new Date();
                    const year = today.getFullYear();
                    let month = today.getMonth() + 1;
                    let day = today.getDate();
                    
                    month = month < 10 ? '0' + month : month;
                    day = day < 10 ? '0' + day : day;
                    
                    dateInput.value = `${year}-${month}-${day}`;
                }
            });
        </script>
    </body>
</html>