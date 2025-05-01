<%-- 
    Document   : statistiques
    Created on : 15 avr. 2025, 10:56:11
    Author     : AMINE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.1/dist/chart.umd.min.js"></script>
        <title>Statistiques</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <%
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
            response.setHeader("Pragma", "no-cache");
            response.setDateHeader("Expires", 0);
            
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
                --danger: #ef4444;
                --dark: #1e293b;
                --gray: #64748b;
                --gray-lighter: #f8fafc;
                --shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
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
                min-height: 100vh;
            }

            /* ---------- Sidebar Styles ---------- */
            .sidebar {
                width: 280px;
                background: linear-gradient(to bottom, var(--primary-dark), var(--secondary));
                height: 100vh;
                position: fixed;
                color: white;
                transition: var(--transition);
                box-shadow: var(--shadow);
                z-index: 1000;
                display: flex;
                flex-direction: column;
            }

            .sidebar-header {
                padding: 1.5rem;
                border-bottom: 1px solid rgba(255, 255, 255, 0.1);
                text-align: center;
            }

            .sidebar-header h3 {
                color: white;
                font-size: 1.25rem;
                margin: 0;
                display: flex;
                align-items: center;
                gap: 0.5rem;
                justify-content: center;
            }

            .sidebar-menu {
                padding: 1rem 0;
                flex-grow: 1;
            }

            .sidebar-menu ul {
                list-style: none;
            }

            .sidebar-menu li a {
                display: flex;
                align-items: center;
                padding: 0.875rem 1.5rem;
                color: rgba(255, 255, 255, 0.9);
                text-decoration: none;
                transition: var(--transition);
                border-left: 3px solid transparent;
            }

            .sidebar-menu li a:hover,
            .sidebar-menu li a.active {
                background: rgba(255, 255, 255, 0.1);
                border-left-color: white;
                color: white;
            }

            .sidebar-menu li a i {
                width: 1.5rem;
                font-size: 1.1rem;
                margin-right: 0.75rem;
            }

            /* ---------- Chart Container ---------- */
            #chart-container {
                background-color: white;
                padding: 30px;
                border-radius: var(--radius-lg);
                box-shadow: var(--shadow);
                max-width: 800px;
                margin: 30px auto;
                height: 400px;
                position: relative;
            }

            canvas {
                width: 100% !important;
                height: 100% !important;
            }

            /* ---------- Mobile Styles ---------- */
            .menu-toggle {
                display: none;
                position: fixed;
                top: 1rem;
                right: 1rem;
                z-index: 1100;
                background: var(--primary);
                border: none;
                color: white;
                width: 3rem;
                height: 3rem;
                border-radius: 50%;
                cursor: pointer;
                box-shadow: var(--shadow);
            }

            @media (max-width: 768px) {
                .sidebar {
                    width: 0;
                    overflow: hidden;
                }

                .sidebar.active {
                    width: 280px;
                }

                .main-content {
                    margin-left: 0;
                    width: 100%;
                    padding: 1.5rem;
                }

                .menu-toggle {
                    display: flex;
                    align-items: center;
                    justify-content: center;
                }

                #chart-container {
                    height: 300px;
                    margin: 20px;
                    padding: 15px;
                }
            }
        </style>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    </head>

    <body>
        <!-- Mobile Menu Toggle -->
        <button class="menu-toggle" id="menuToggle">
            <i class="fas fa-bars"></i>
        </button>

        <!-- Sidebar -->
        <div class="sidebar" id="sidebar">
            <div class="sidebar-header">
                <h3><i class="fas fa-boxes"></i> Gestion Stock</h3>
            </div>
            <div class="sidebar-menu">
                <ul>
                    <li><a href="Route?page=produits"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
                    <li><a href="Route?page=categories"><i class="fas fa-tags"></i> Catégories</a></li>
                    <li><a href="Route?page=mouvementstock"><i class="fas fa-exchange-alt"></i> Mouvements</a></li>
                    <li><a href="Route?page=statistiques" class="active"><i class="fas fa-chart-bar"></i> Statistiques</a></li>
                    <li><a href="Route?page=profile"><i class="fas fa-user-cog"></i> Profil</a></li>
                    <li><a href="${pageContext.request.contextPath}/LogoutController"><i class="fas fa-sign-out-alt"></i> Déconnexion</a></li>
                </ul>
            </div>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <div id="chart-container">
                <canvas id="myChart"></canvas>
            </div>
        </div>

        <script>
            // Mobile Menu Toggle
            document.getElementById('menuToggle').addEventListener('click', () => {
                document.getElementById('sidebar').classList.toggle('active');
            });

            // Chart Initialization
            document.addEventListener('DOMContentLoaded', () => {
                fetch('http://localhost:8080/Gestion_stock/StatistiqueController')
                    .then(response => response.json())
                    .then(data => {
                        const ctx = document.getElementById('myChart').getContext('2d');
                        new Chart(ctx, {
                            type: 'bar',
                            data: {
                                labels: data.map(item => item.categorie),
                                datasets: [{
                                    label: 'Nombre de produits',
                                    data: data.map(item => item.nbProduits),
                                    backgroundColor: 'rgba(75, 192, 192, 0.2)',
                                    borderColor: 'rgb(75, 192, 192)',
                                    borderWidth: 1
                                }]
                            },
                            options: {
                                responsive: true,
                                maintainAspectRatio: false,
                                plugins: {
                                    title: {
                                        display: true,
                                        text: 'Répartition des produits par catégorie'
                                    },
                                    legend: {
                                        display: false
                                    }
                                },
                                scales: {
                                    y: {
                                        beginAtZero: true,
                                        ticks: {
                                            stepSize: 1,
                                            precision: 0
                                        }
                                    }
                                }
                            }
                        });
                    })
                    .catch(error => {
                        console.error('Erreur:', error);
                        document.getElementById('chart-container').innerHTML = 
                            '<p style="color: var(--danger); padding: 1rem;">Erreur de chargement des données</p>';
                    });
            });
        </script>
    </body>
</html>