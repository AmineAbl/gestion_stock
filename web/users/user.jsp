<%-- 
    Document   : user
    Created on : 12 avr. 2025, 18:31:41
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
        <title>Formulaire Utilisateur</title>
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
                justify-content: center;
                align-items: center;
                min-height: 100vh;
                padding: 20px;
            }
            
            fieldset {
                border: none;
                background-color: white;
                border-radius: 10px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
                padding: 30px;
                width: 100%;
                max-width: 500px;
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
            }
            
            td {
                padding: 12px 0;
                vertical-align: top;
            }
            
            td:first-child {
                width: 120px;
                font-weight: 500;
                color: #555;
                padding-top: 20px;
            }
            
            input[type="text"], input[type="password"] {
                width: 100%;
                padding: 12px 15px;
                border: 1px solid #ddd;
                border-radius: 6px;
                font-size: 16px;
                transition: border-color 0.3s, box-shadow 0.3s;
            }
            
            input[type="text"]:focus, input[type="password"]:focus {
                border-color: #4a6fdc;
                box-shadow: 0 0 0 3px rgba(74, 111, 220, 0.2);
                outline: none;
            }
            
            input[type="submit"] {
                background-color: #4a6fdc;
                color: white;
                border: none;
                border-radius: 6px;
                padding: 12px 25px;
                font-size: 16px;
                font-weight: 500;
                cursor: pointer;
                transition: background-color 0.3s;
                margin-top: 10px;
                width: 100%;
            }
            
            input[type="submit"]:hover {
                background-color: #3a5fc8;
            }
            
            .form-group {
                margin-bottom: 15px;
            }
            
            @media (max-width: 600px) {
                fieldset {
                    padding: 20px;
                }
                
                td:first-child {
                    display: block;
                    width: 100%;
                    padding-top: 0;
                    padding-bottom: 5px;
                }
                
                td {
                    display: block;
                    padding: 5px 0;
                }
            }
        </style>
    </head>
    <body>
        <fieldset>
            <legend>Formulaire d'utilisateur</legend>
            <form method="POST" action="../UserController">
                <input type="hidden" name="id" value="<%= request.getParameter("id") != null ? request.getParameter("id") : "" %>" />
                <table>
                    <tr class="form-group">
                        <td><label for="nom">Nom :</label></td>
                        <td><input type="text" id="nom" name="nom" value="<%= request.getParameter("nom") != null ? request.getParameter("nom") : "" %>" placeholder="Entrez votre nom" /></td>
                    </tr>
                    
                    <tr class="form-group">
                        <td><label for="prenom">Prénom :</label></td>
                        <td><input type="text" id="prenom" name="prenom" value="<%= request.getParameter("prenom") != null ? request.getParameter("prenom") : "" %>" placeholder="Entrez votre prénom" /></td>  
                    </tr>
                    
                    <tr class="form-group">
                        <td><label for="email">Email :</label></td>
                        <td><input type="text" id="email" name="email" value="<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>" placeholder="Entrez votre email" /></td>  
                    </tr>
                    
                    <tr class="form-group">
                        <td><label for="mdp">Mot de passe :</label></td>
                        <td><input type="password" id="mdp" name="mdp" value="<%= request.getParameter("mdp") != null ? request.getParameter("mdp") : "" %>" placeholder="Entrez votre mot de passe" /></td>  
                    </tr>
                    
                    <tr>
                        <td></td>
                        <td><input type="submit" value="Enregistrer" /></td>
                    </tr>
                </table>
            </form>
        </fieldset>
    </body>
</html>