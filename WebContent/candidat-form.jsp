<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.exam.CandidatDAO" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Formulaire Candidat</title>
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
            max-width: 500px;
            margin: 30px auto;
            padding: 20px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        input[type="text"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            margin-top: 10px;
        }
        .btn-primary {
            background-color: #3498db;
            color: white;
        }
        .btn-retour {
            background-color: #95a5a6;
            color: white;
        }
        .error {
            color: red;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1><%= request.getParameter("id") != null ? "Modifier" : "Nouveau" %> Candidat</h1>
    </div>
    
    <div class="container">
        <%
            String idParam = request.getParameter("id");
            String nom = "";
            boolean isEdit = false;
            
            if (idParam != null && !idParam.isEmpty()) {
                isEdit = true;
                try {
                    String[] candidat = CandidatDAO.findById(Integer.parseInt(idParam));
                    if (candidat != null) {
                        nom = candidat[1];
                    }
                } catch (Exception e) {
                    out.println("<p class='error'>Erreur: " + e.getMessage() + "</p>");
                }
            }
        %>
        
        <form method="post" action="candidat-save.jsp">
            <% if (isEdit) { %>
            <input type="hidden" name="id" value="<%= idParam %>">
            <% } %>
            
            <div class="form-group">
                <label for="nom">Nom du Candidat:</label>
                <input type="text" id="nom" name="nom" value="<%= nom %>" required>
            </div>
            
            <button type="submit" class="btn btn-primary"><%= isEdit ? "Modifier" : "Ajouter" %></button>
            <a href="candidat-list.jsp" class="btn btn-retour">Annuler</a>
        </form>
    </div>
</body>
</html>
