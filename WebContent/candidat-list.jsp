<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.exam.CandidatDAO, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Liste des Candidats</title>
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
            margin: 30px auto;
            padding: 20px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #34495e;
            color: white;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
        .btn {
            padding: 8px 16px;
            margin: 5px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
        }
        .btn-primary {
            background-color: #3498db;
            color: white;
        }
        .btn-danger {
            background-color: #e74c3c;
            color: white;
        }
        .btn-edit {
            background-color: #f39c12;
            color: white;
        }
        .btn-retour {
            background-color: #95a5a6;
            color: white;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>Gestion des Candidats</h1>
    </div>
    
    <div class="container">
        <a href="index.jsp" class="btn btn-retour">← Retour au menu</a>
        <a href="candidat-form.jsp" class="btn btn-primary">+ Nouveau Candidat</a>
        
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nom</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    try {
                        List<String[]> candidats = CandidatDAO.findAll();
                        for (String[] candidat : candidats) {
                %>
                <tr>
                    <td><%= candidat[0] %></td>
                    <td><%= candidat[1] %></td>
                    <td>
                        <a href="candidat-form.jsp?id=<%= candidat[0] %>" class="btn btn-edit">Modifier</a>
                        <a href="candidat-delete.jsp?id=<%= candidat[0] %>" class="btn btn-danger" onclick="return confirm('Êtes-vous sûr?')">Supprimer</a>
                    </td>
                </tr>
                <%
                        }
                    } catch (Exception e) {
                        out.println("<tr><td colspan='3'>Erreur: " + e.getMessage() + "</td></tr>");
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>
