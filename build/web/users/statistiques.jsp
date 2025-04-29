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
        <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.1/dist/chart.umd.min.js"></script>
        <title>Statistiques</title>
        <style>
            /* Styles généraux */
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
            
            /* Sidebar */
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
            
            /* Contenu principal */
            .main-content {
                margin-left: 250px;
                padding: 20px;
                width: calc(100% - 250px);
            }

            /* Style pour le container du graphique */
            #chart-container {
                background-color: white;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
                max-width: 800px;
                margin: 30px auto; /* Centrer le graphique */
            }

            canvas {
                width: 100% !important;
                height: auto !important;
            }

            /* Responsive */
            @media (max-width: 768px) {
                .sidebar {
                    width: 0;
                    overflow: hidden;
                }
                
                .main-content {
                    margin-left: 0;
                    width: 100%;
                }
                
                #chart-container {
                    margin: 20px;
                }
            }
        </style>
        <!-- Font Awesome -->
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
                    <li><a href="Route?page=mouvementstock"><i class="fas fa-book"></i> Mouvement de stock</a></li>
                    <li><a href="Route?page=statistiques"><i class="fas fa-chart-bar"></i> Statistiques</a></li>
                    <li><a href="Route?page=profile"><i class="fas fa-cog"></i> Profile</a></li>
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

        <!-- Script pour le graphique -->
        <script>
            document.addEventListener('DOMContentLoaded', () => {
                fetch('http://localhost:8080/Gestion_stock/StatistiqueController')
                    .then(response => {
                        if (!response.ok) {
                            throw new Error(`HTTP error! status: ${response.status}`);
                        }
                        return response.json();
                    })
                    .then(data => {
                        const labels = data.map(item => item.categorie);
                        const valeurs = data.map(item => item.nbProduits);

                        const ctx = document.getElementById('myChart').getContext('2d');

                        new Chart(ctx, {
                            type: 'bar',
                            data: {
                                labels: labels,
                                datasets: [{
                                    label: 'Nombre de produit',
                                    data: valeurs,
                                    backgroundColor: 'rgba(75, 192, 192, 0.2)',
                                    borderColor: 'rgb(75, 192, 192)',
                                    borderWidth: 1
                                }]
                            },
                            options: {
                                responsive: true,
                                plugins: {
                                    title: {
                                        display: true,
                                        text: 'Produits par catégorie'
                                    },
                                    legend: {
                                        display: false
                                    }
                                },
                                scales: {
                                    y: {
                                        beginAtZero: true,
                                        ticks: { stepSize: 1 }
                                    }
                                }
                            }
                        });
                    })
                    .catch(err => {
                        console.error('Erreur de chargement des données :', err);
                        const container = document.getElementById('chart-container');
                        container.innerHTML = '<p style="color:red;">Impossible de charger les données.</p>';
                    });
            });
        </script>
    </body>
</html>
