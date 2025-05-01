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
        <title>Connexion | Gestion de Stock</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
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
                background: linear-gradient(135deg, var(--primary-dark), var(--secondary));
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
                padding: 20px;
                line-height: 1.5;
            }
            
            .login-container {
                background-color: white;
                border-radius: var(--radius-lg);
                box-shadow: var(--shadow-lg);
                padding: 2.5rem;
                width: 100%;
                max-width: 450px;
                transition: var(--transition);
                animation: fadeIn 0.5s ease-out;
            }
            
            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(-20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
            
            .login-header {
                text-align: center;
                margin-bottom: 2rem;
            }
            
            .login-logo {
                display: flex;
                align-items: center;
                justify-content: center;
                margin-bottom: 1.5rem;
            }
            
            .login-logo i {
                font-size: 2.5rem;
                color: var(--primary);
                margin-right: 0.75rem;
            }
            
            .login-logo-text {
                font-size: 1.5rem;
                font-weight: 700;
                color: var(--dark);
            }
            
            .login-header h1 {
                font-size: 1.75rem;
                font-weight: 700;
                color: var(--dark);
                margin-bottom: 0.75rem;
            }
            
            .login-header p {
                color: var(--gray);
                font-size: 1rem;
            }
            
            form {
                width: 100%;
            }
            
            .form-group {
                margin-bottom: 1.5rem;
            }
            
            label {
                display: block;
                margin-bottom: 0.5rem;
                font-weight: 500;
                color: var(--dark);
                font-size: 0.9375rem;
            }
            
            .input-group {
                position: relative;
            }
            
            .input-group i {
                position: absolute;
                left: 1rem;
                top: 50%;
                transform: translateY(-50%);
                color: var(--gray);
                font-size: 1.125rem;
            }
            
            input[type="email"],
            input[type="password"] {
                width: 100%;
                padding: 0.875rem 1rem 0.875rem 2.75rem;
                border: 1px solid var(--border);
                border-radius: var(--radius);
                font-size: 1rem;
                transition: var(--transition);
                background-color: var(--gray-lighter);
                color: var(--dark);
            }
            
            input[type="email"]:focus,
            input[type="password"]:focus {
                border-color: var(--primary);
                box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.2);
                outline: none;
                background-color: white;
            }
            
            input[type="email"]::placeholder,
            input[type="password"]::placeholder {
                color: var(--gray);
                opacity: 0.7;
            }
            
            .password-toggle {
                position: absolute;
                right: 1rem;
                top: 50%;
                transform: translateY(-50%);
                color: var(--gray);
                cursor: pointer;
                font-size: 1rem;
                transition: var(--transition);
            }
            
            .password-toggle:hover {
                color: var(--primary);
            }
            
            .remember-forgot {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 1.5rem;
                font-size: 0.875rem;
            }
            
            .remember-me {
                display: flex;
                align-items: center;
            }
            
            .remember-me input[type="checkbox"] {
                margin-right: 0.5rem;
                accent-color: var(--primary);
            }
            
            .forgot-password {
                color: var(--primary);
                text-decoration: none;
                font-weight: 500;
                transition: var(--transition);
            }
            
            .forgot-password:hover {
                color: var(--primary-dark);
                text-decoration: underline;
            }
            
            .btn {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                padding: 0.875rem 1.5rem;
                border-radius: var(--radius);
                font-weight: 500;
                font-size: 1rem;
                transition: var(--transition);
                text-decoration: none;
                border: none;
                cursor: pointer;
                width: 100%;
                box-shadow: var(--shadow-sm);
            }
            
            .btn-primary {
                background: linear-gradient(to right, var(--primary), var(--secondary));
                color: white;
            }
            
            .btn-primary:hover {
                background: linear-gradient(to right, var(--primary-dark), var(--primary));
                transform: translateY(-1px);
                box-shadow: var(--shadow);
            }
            
            .btn-primary:active {
                transform: translateY(0);
            }
            
            .btn i {
                margin-right: 0.5rem;
            }
            
            .divider {
                display: flex;
                align-items: center;
                margin: 1.5rem 0;
                color: var(--gray);
                font-size: 0.875rem;
            }
            
            .divider::before,
            .divider::after {
                content: '';
                flex: 1;
                height: 1px;
                background-color: var(--border);
            }
            
            .divider::before {
                margin-right: 1rem;
            }
            
            .divider::after {
                margin-left: 1rem;
            }
            
            .register-link {
                text-align: center;
                margin-top: 1.5rem;
                font-size: 0.9375rem;
                color: var(--gray);
            }
            
            .register-link a {
                color: var(--primary);
                text-decoration: none;
                font-weight: 500;
                transition: var(--transition);
            }
            
            .register-link a:hover {
                color: var(--primary-dark);
                text-decoration: underline;
            }
            
            @media (max-width: 480px) {
                .login-container {
                    padding: 1.5rem;
                }
                
                .login-header h1 {
                    font-size: 1.5rem;
                }
                
                .remember-forgot {
                    flex-direction: column;
                    align-items: flex-start;
                    gap: 0.75rem;
                }
            }
        </style>
    </head>
    <body>
        <div class="login-container">
            <div class="login-header">
                <div class="login-logo">
                    <i class="fas fa-boxes"></i>
                    <div class="login-logo-text">Gestion de Stock</div>
                </div>
                <h1>Connexion</h1>
                <p>Veuillez vous connecter pour accéder à votre compte</p>
            </div>
            
            <form method="POST" action="../LoginController">
                <div class="form-group">
                    <label for="email">Adresse email</label>
                    <div class="input-group">
                        <i class="fas fa-envelope"></i>
                        <input type="email" id="email" name="email" placeholder="Entrez votre email" required/>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="mdp">Mot de passe</label>
                    <div class="input-group">
                        <i class="fas fa-lock"></i>
                        <input type="password" id="mdp" name="mdp" placeholder="Entrez votre mot de passe" required/>
                        <span class="password-toggle" id="passwordToggle">
                            
                        </span>
                    </div>
                </div>
                
                <div class="remember-forgot">
                    <div class="remember-me">
                        
                        
                    </div>
                    
                </div>
                
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-sign-in-alt"></i> Se connecter
                </button>
            </form>
            
            <div class="divider">ou</div>
            
            <div class="register-link">
                Vous n'avez pas de compte? <a href="signup.jsp">S'inscrire maintenant</a>
            </div>
        </div>
        
        <script>
            document.addEventListener('DOMContentLoaded', function() {
                const passwordToggle = document.getElementById('passwordToggle');
                const passwordInput = document.getElementById('mdp');
                
                if (passwordToggle && passwordInput) {
                    passwordToggle.addEventListener('click', function() {
                        const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
                        passwordInput.setAttribute('type', type);
                        
                        // Toggle icon
                        const icon = passwordToggle.querySelector('i');
                        if (type === 'password') {
                            icon.classList.remove('fa-eye-slash');
                            icon.classList.add('fa-eye');
                        } else {
                            icon.classList.remove('fa-eye');
                            icon.classList.add('fa-eye-slash');
                        }
                    });
                }
            });
        </script>
    </body>
</html>