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
        
       <div id="chart-container">
    <canvas id="myChart"></canvas>
  </div>

  <script>
    // Dès que le DOM est prêt...
    document.addEventListener('DOMContentLoaded', () => {
      // 1. Appel au service REST
      fetch('http://localhost:8981/web/StatistiqueController')
        .then(response => {
          if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
          }
          return response.json();
        })
        .then(data => {
          // 2. Extraction des labels et des valeurs
          const labels = data.map(item => item.code);
          const valeurs = data.map(item => item.nbEtudiants);

          // 3. Initialisation du canvas
          const ctx = document.getElementById('myChart').getContext('2d');

          // 4. Création du graphique
          new Chart(ctx, {
            type: 'bar',  // ou 'line' si vous préférez une courbe
            data: {
              labels: labels,
              datasets: [{
                label: 'Nombre de produit ',
                data: valeurs,
                backgroundColor: 'rgba(75, 192, 192, 0.2)',
                borderColor:   'rgb(75, 192, 192)',
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