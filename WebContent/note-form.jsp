<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.exam.NoteDAO, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Formulaire Note</title>
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
        select, input[type="number"] {
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
        <h1><%= request.getParameter("id") != null ? "Modifier" : "Nouvelle" %> Note</h1>
    </div>
    
    <div class="container">
        <%
            String idParam = request.getParameter("id");
            String noteValue = "";
            String idCandidat = "";
            String idMatiere = "";
            String idCorrecteur = "";
            boolean isEdit = false;
            
            if (idParam != null && !idParam.isEmpty()) {
                isEdit = true;
                try {
                    String[] note = NoteDAO.findById(Integer.parseInt(idParam));
                    if (note != null) {
                        noteValue = note[1];
                        idCandidat = note[2];
                        idMatiere = note[3];
                        idCorrecteur = note[4];
                    }
                } catch (Exception e) {
                    out.println("<p class='error'>Erreur: " + e.getMessage() + "</p>");
                }
            }
        %>
        
        <form method="post" action="note-save.jsp">
            <% if (isEdit) { %>
            <input type="hidden" name="id" value="<%= idParam %>">
            <% } %>
            
            <div class="form-group">
                <label for="note">Note:</label>
                <input type="number" id="note" name="note" value="<%= noteValue %>" step="0.01" min="0" max="20" required>
            </div>
            
            <div class="form-group">
                <label for="idCandidat">Candidat:</label>
                <select id="idCandidat" name="idCandidat" required>
                    <option value="">-- Choisir --</option>
                    <%
                        try {
                            List<String[]> candidats = NoteDAO.getCandidats();
                            for (String[] c : candidats) {
                                String selected = c[0].equals(idCandidat) ? "selected" : "";
                    %>
                    <option value="<%= c[0] %>" <%= selected %>><%= c[1] %></option>
                    <%
                            }
                        } catch (Exception e) {}
                    %>
                </select>
            </div>
            
            <div class="form-group">
                <label for="idMatiere">Matière:</label>
                <select id="idMatiere" name="idMatiere" required>
                    <option value="">-- Choisir --</option>
                    <%
                        try {
                            List<String[]> matieres = NoteDAO.getMatieres();
                            for (String[] m : matieres) {
                                String selected = m[0].equals(idMatiere) ? "selected" : "";
                    %>
                    <option value="<%= m[0] %>" <%= selected %>><%= m[1] %></option>
                    <%
                            }
                        } catch (Exception e) {}
                    %>
                </select>
            </div>
            
            <div class="form-group">
                <label for="idCorrecteur">Correcteur:</label>
                <select id="idCorrecteur" name="idCorrecteur" required>
                    <option value="">-- Choisir --</option>
                    <%
                        try {
                            List<String[]> correcteurs = NoteDAO.getCorrecteurs();
                            for (String[] c : correcteurs) {
                                String selected = c[0].equals(idCorrecteur) ? "selected" : "";
                    %>
                    <option value="<%= c[0] %>" <%= selected %>><%= c[1] %></option>
                    <%
                            }
                        } catch (Exception e) {}
                    %>
                </select>
            </div>
            
            <button type="submit" class="btn btn-primary"><%= isEdit ? "Modifier" : "Ajouter" %></button>
            <a href="note-list.jsp" class="btn btn-retour">Annuler</a>
        </form>
    </div>
</body>
</html>
