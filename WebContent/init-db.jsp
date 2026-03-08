<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*" %>
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
        .success {
            color: #27ae60;
            font-size: 18px;
            margin: 20px 0;
        }
        .error {
            color: #e74c3c;
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
        <%
            Connection conn = null;
            try {
                // Read the reset.sql file
                String sqlFile = application.getRealPath("/") + "reset.sql";
                BufferedReader reader = new BufferedReader(new FileReader(sqlFile));
                StringBuilder sqlContent = new StringBuilder();
                String line;
                while ((line = reader.readLine()) != null) {
                    sqlContent.append(line).append("\n");
                }
                reader.close();
                
                // Connect and execute
                conn = com.exam.DBConnection.getConnection();
                Statement stmt = conn.createStatement();
                
                // Split and execute each statement
                String[] statements = sqlContent.toString().split(";");
                for (String s : statements) {
                    s = s.trim();
                    if (!s.isEmpty() && !s.startsWith("--")) {
                        try {
                            stmt.execute(s);
                        } catch (SQLException e) {
                            // Ignore errors for some statements
                        }
                    }
                }
                
                stmt.close();
                
                out.println("<p class='success'>✓ Base de données réinitialisée avec succès!</p>");
                out.println("<p>Toutes les données ont été remises à zéro.</p>");
                
            } catch (Exception e) {
                out.println("<p class='error'>✗ Erreur: " + e.getMessage() + "</p>");
                e.printStackTrace();
            } finally {
                if (conn != null) conn.close();
            }
        %>
        
        <a href="index.jsp" class="btn-retour">Retour au menu</a>
    </div>
</body>
</html>
