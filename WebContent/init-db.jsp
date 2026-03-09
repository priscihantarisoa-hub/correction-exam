<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Initialisation Base de Données</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
        }
        .header {
            background-color: #2c3e50;
            color: white;
            padding: 20px;
            text-align: center;
        }
        .container {
            max-width: 600px;
            margin: 30px auto;
            padding: 20px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            text-align: center;
        }
        .info {
            color: #27ae60;
            font-size: 18px;
            margin: 20px 0;
        }
        .btn-retour {
            background-color: #3498db;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 4px;
            display: inline-block;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>Initialisation de la Base de Données</h1>
    </div>
    
    <div class="container">
        <p class="info">✓ Les tables ont déjà été créées!</p>
        
        <p>Si vous voulez réinitialiser les données:</p>
        <ol style="text-align: left;">
            <li>Ouvrir pgAdmin</li>
            <li>Aller dans votre base de données</li>
            <li>Exécuter le script reset.sql</li>
        </ol>
        
        <p><strong>Ou</strong> - Supprimer et recréer les tables:</p>
        <pre style="text-align: left; background: #f5f5f5; padding: 10px;">
DROP TABLE IF EXISTS note CASCADE;
DROP TABLE IF EXISTS candidat CASCADE;
-- Recréer les tables...
        </pre>
        
        <a href="index.jsp" class="btn-retour">Retour au menu</a>
    </div>
</body>
</html>
