<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Système de Correction d'Examens</title>
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
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
        }
        .menu {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
            margin-top: 30px;
        }
        .menu-item {
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            text-align: center;
            cursor: pointer;
            transition: transform 0.2s;
        }
        .menu-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        }
        .menu-item a {
            text-decoration: none;
            color: #2c3e50;
            font-size: 18px;
            font-weight: bold;
        }
        .menu-item p {
            color: #7f8c8d;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>Système de Correction d'Examens</h1>
    </div>
    
    <div class="container">
        <h2>Menu Principal</h2>
        
        <div class="menu">
            <div class="menu-item">
                <a href="candidat-list.jsp">Gestion des Candidats</a>
                <p>Ajouter, modifier ou supprimer des candidats</p>
            </div>
            
            <div class="menu-item">
                <a href="note-list.jsp">Gestion des Notes</a>
                <p>Ajouter, modifier ou supprimer des notes</p>
            </div>
            
            <div class="menu-item">
                <a href="resultats.jsp">Notes Finales</a>
                <p>Voir les résultats finals avec calcul</p>
            </div>
            
            <div class="menu-item">
                <a href="init-db.jsp">Réinitialiser la Base</a>
                <p>Recharger les données initiales</p>
            </div>
        </div>
    </div>
</body>
</html>
