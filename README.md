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

<img width="380" alt="image" src="https://github.com/user-attachments/assets/4a245f99-2d15-413f-84a2-6e777fbc0d66" />


## 🗺️ 6. Modèle conceptuel de la base généré :

<img width="551" alt="image" src="https://github.com/user-attachments/assets/eec75fbf-bfbe-475a-ad87-d174b1d2d173" />

## 🧪 7. Execution des tests dans la console :
### Création des tables dans la base de données :
<img width="293" alt="image" src="https://github.com/user-attachments/assets/6ca2a195-98d6-487e-95a3-d6519c93af4b" />

### Insertion des données dans les tables :
<img width="310" alt="image" src="https://github.com/user-attachments/assets/a2471ebd-7cba-429c-b96d-1ad132b07c80" />

<img width="264" alt="image" src="https://github.com/user-attachments/assets/932969e5-6ca9-4c17-b169-c2cb33d67ca2" />

<img width="200" alt="image" src="https://github.com/user-attachments/assets/5ca22152-088d-42c5-b078-ec100c068e66" />

<img width="264" alt="image" src="https://github.com/user-attachments/assets/b2b7a2ee-abab-44fe-a4fa-60fb21790aad" />

<img width="193" alt="image" src="https://github.com/user-attachments/assets/0200112c-5334-4776-8025-8de59a8dfb81" />

<img width="278" alt="image" src="https://github.com/user-attachments/assets/eb515e86-f2cd-485e-a805-f2fa68c1e7a8" />

<img width="275" alt="image" src="https://github.com/user-attachments/assets/3f6ebe15-b9e5-4303-af3c-3af998cecc1a" />

<img width="270" alt="image" src="https://github.com/user-attachments/assets/57891d16-0cce-44ae-9365-0cb164e5a0ff" />

<img width="239" alt="image" src="https://github.com/user-attachments/assets/fae01c49-08e7-4b87-9714-90a67d46d18b" />


### Modification :
<img width="278" alt="image" src="https://github.com/user-attachments/assets/4bc82564-f8fa-4d48-a838-33738168503f" />

<img width="293" alt="image" src="https://github.com/user-attachments/assets/a2e9640d-6f3a-4592-9ab6-a2d4ecd459c6" />

<img width="260" alt="image" src="https://github.com/user-attachments/assets/6c8658aa-b70c-459a-bee6-3041e46b4f1a" />

<img width="309" alt="image" src="https://github.com/user-attachments/assets/c56a2196-8468-4d2d-a2cc-2fbdcaae95a8" />

<img width="284" alt="image" src="https://github.com/user-attachments/assets/8936397e-d0b7-4008-a0fa-fde9f687ce4e" />


### Suppression :
<img width="280" alt="image" src="https://github.com/user-attachments/assets/f4090e5e-762d-4bf4-b506-70eff8977ab0" />

<img width="326" alt="image" src="https://github.com/user-attachments/assets/c14c0a7b-6fa0-454e-aeb8-4ed8469bcfb7" />

<img width="242" alt="image" src="https://github.com/user-attachments/assets/3b3b4033-e9e6-4999-bdb9-297f3d39096a" />

##  8. Architecture du projet :

<img width="960" alt="Architecture" src="https://github.com/user-attachments/assets/8acae443-f971-46f7-a160-f76325aba1d1" />


##  9. Des prises d'écrans du site :
<img width="943" alt="1" src="https://github.com/user-attachments/assets/c58d435d-ebe7-481f-aa76-c62775667e61" />

<img width="950" alt="2" src="https://github.com/user-attachments/assets/6bf7683e-be2b-4488-b93a-dde7ee4b68b9" />

<img width="935" alt="3" src="https://github.com/user-attachments/assets/1a48a644-bcf4-483a-a19f-e27b2bc19615" />

<img width="938" alt="4" src="https://github.com/user-attachments/assets/265f4a61-ee74-464d-8a4b-68dbcff30a70" />

##  10. La vidéo :

https://github.com/user-attachments/assets/47336d24-3605-4075-b8a9-e848113173aa







