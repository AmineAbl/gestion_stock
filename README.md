# 📦 Gestion de stock 

## 📘 1. Contexte :  
Ce projet est un système de gestion de stock qui permet de suivre les produits, leurs catégories et les mouvements d'entrée et de sortie.  
Il est conçu pour les commerçants ou entreprises souhaitant gérer efficacement leur inventaire via une interface web interactive et moderne.

## ❗ 2. Problématique :  
La gestion manuelle des stocks engendre des erreurs fréquentes, une absence de traçabilité et un manque de visibilité sur les quantités disponibles.  
Pour éviter ces problèmes, il est nécessaire d’automatiser et de centraliser la gestion des produits et de leurs mouvements avec une solution simple, intuitive et en temps réel.

## 🎯 3. Objectifs :
- Gérer les produits, les catégories, les utilisateurs et les mouvements de stock.  
- Afficher les produits par catégorie et les détails de chaque fiche produit.  
- Ajouter facilement des mouvements (entrée/sortie) avec mise à jour dynamique des quantités via AJAX.  
- Visualiser l’évolution du stock à l’aide de graphiques générés avec Chart.js.  
- Offrir une interface simple d’utilisation pour un suivi fluide et précis.

## 🧰 4. Technologies utilisées :

### 🖥️ Frontend :
- **HTML5** – Structure des pages.
- **CSS3** – Mise en forme et style.
- **JavaScript** – Logique côté client et interactions dynamiques.
- **AJAX** – Communication asynchrone avec le serveur pour la mise à jour instantanée des données (quantités, mouvements, etc.).
- **Chart.js** – Bibliothèque JavaScript pour l’affichage de graphiques statistiques (évolution du stock).

### ⚙️ Backend :
- **Java** – Langage principal pour la logique métier.
- **Hibernate (ORM)** – Pour la gestion de la persistance des données et les interactions avec la base de données de manière orientée objet.
- **JPA (Java Persistence API)** – Interface standard pour travailler avec Hibernate.
- **JDBC (optionnel)** – Utilisé en complément si nécessaire pour des requêtes spécifiques.

### 🗃️ Base de données :
- **MySQL** – Système de gestion de base de données relationnelle pour stocker les produits, catégories, utilisateurs et mouvements de stock.

## 🧩 5. Diagramme de classe :

<img width="277" alt="image" src="https://github.com/user-attachments/assets/5786e307-bc7f-40ff-84e8-96ced3de2315" />

## 🗺️ 6. Modèle conceptuel de la base généré :

<img width="551" alt="image" src="https://github.com/user-attachments/assets/eec75fbf-bfbe-475a-ad87-d174b1d2d173" />

## 🧪 7. Execution des tests dans la console :

<img width="251" alt="image" src="https://github.com/user-attachments/assets/3a65984a-0aa2-4533-9504-eeab800c5f95" />
<img width="241" alt="image" src="https://github.com/user-attachments/assets/7d424b46-6972-4d06-94b0-31bca7fc6283" />
<img width="281" alt="image" src="https://github.com/user-attachments/assets/230f80da-98e5-4505-b3a0-93eaac5557b6" />
<img width="242" alt="image" src="https://github.com/user-attachments/assets/92e96370-a4b9-4c42-a9ce-7ae8a412907f" />
