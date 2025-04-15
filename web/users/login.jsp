<%-- 
    Document   : login
    Created on : 13 avr. 2025, 22:27:14
    Author     : AMINE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Connexion</title>
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
            
            .login-container {
                background-color: white;
                border-radius: 10px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
                padding: 30px;
                width: 100%;
                max-width: 400px;
            }
            
            .login-header {
                text-align: center;
                margin-bottom: 30px;
            }
            
            .login-header h1 {
                font-size: 24px;
                font-weight: 600;
                color: #333;
                margin-bottom: 10px;
            }
            
            .login-header p {
                color: #666;
                font-size: 14px;
            }
            
            .login-header::after {
                content: '';
                display: block;
                width: 50px;
                height: 3px;
                background-color: #4a6fdc;
                margin: 15px auto 0;
            }
            
            form {
                width: 100%;
            }
            
            table {
                width: 100%;
            }
            
            td {
                padding: 8px 0;
            }
            
            label {
                display: block;
                margin-bottom: 6px;
                font-weight: 500;
                color: #555;
                font-size: 15px;
            }
            
            input[type="email"],
            input[type="password"] {
                width: 100%;
                padding: 12px 15px;
                border: 1px solid #ddd;
                border-radius: 6px;
                font-size: 16px;
                transition: border-color 0.3s, box-shadow 0.3s;
                margin-bottom: 15px;
            }
            
            input[type="email"]:focus,
            input[type="password"]:focus {
                border-color: #4a6fdc;
                box-shadow: 0 0 0 3px rgba(74, 111, 220, 0.2);
                outline: none;
            }
            
            input[type="submit"] {
                background-color: #4a6fdc;
                color: white;
                border: none;
                border-radius: 6px;
                padding: 14px 20px;
                font-size: 16px;
                font-weight: 500;
                cursor: pointer;
                transition: background-color 0.3s;
                width: 100%;
                margin-top: 10px;
            }
            
            input[type="submit"]:hover {
                background-color: #3a5fc8;
            }
            
            .register-link {
                text-align: center;
                margin-top: 20px;
                font-size: 14px;
                color: #666;
            }
            
            .register-link a {
                color: #4a6fdc;
                text-decoration: none;
                font-weight: 500;
            }
            
            .register-link a:hover {
                text-decoration: underline;
            }
            
            @media (max-width: 480px) {
                .login-container {
                    padding: 20px;
                }
            }
        </style>
    </head>
    <body>
        <div class="login-container">
            <div class="login-header">
                <h1>Connexion</h1>
                <p>Veuillez vous connecter pour accéder à votre compte</p>
            </div>
            
            <form method="POST" action="../LoginController">
                <table>
                    <tr>
                        <td>
                            <label for="email">Email :</label>
                            <input type="email" id="email" name="email" placeholder="Entrez votre email" required/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="mdp">Mot de passe :</label>
                            <input type="password" id="mdp" name="mdp" placeholder="Entrez votre mot de passe" required/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input type="submit" value="Se connecter"/>
                        </td>
                    </tr>
                </table>
            </form>
            
            <div class="register-link">
                Vous n'avez pas de compte ? <a href="user.jsp">S'inscrire</a>
            </div>
        </div>
    </body>
</html>