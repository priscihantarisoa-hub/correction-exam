<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.exam.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Notes Finales</title>
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
            max-width: 1000px;
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
            text-align: center;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #34495e;
            color: white;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
        .note-finale {
            font-weight: bold;
            color: #27ae60;
            font-size: 18px;
        }
        .btn-retour {
            background-color: #95a5a6;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 4px;
            display: inline-block;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>Notes Finales</h1>
    </div>
    
    <div class="container">
        <a href="index.jsp" class="btn-retour">← Retour au menu</a>
        
        <table>
            <thead>
                <tr>
                    <th>Candidat</th>
                    <th>Matière</th>
                    <th>P1</th>
                    <th>P2</th>
                    <th>Diff</th>
                    <th>Note Finale</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Connection conn = null;
                    try {
                        conn = DBConnection.getConnection();
                        
                        // Query to get all notes grouped by candidat and matiere
                        String sql = "SELECT c.nom as candidat, m.nom as matiere, m.id as id_matiere, c.id as id_candidat " +
                                     "FROM candidat c " +
                                     "JOIN matiere m ON 1=1 " +
                                     "ORDER BY c.nom, m.nom";
                        
                        Statement stmt = conn.createStatement();
                        ResultSet rs = stmt.executeQuery(sql);
                        
                        while (rs.next()) {
                            String candidatNom = rs.getString("candidat");
                            String matiereNom = rs.getString("matiere");
                            int idMatiere = rs.getInt("id_matiere");
                            int idCandidat = rs.getInt("id_candidat");
                            
                            // Get notes for this candidat and matiere
                            String sqlNotes = "SELECT note FROM note WHERE id_candidat = " + idCandidat + " AND id_matiere = " + idMatiere;
                            Statement stmt2 = conn.createStatement();
                            ResultSet rsNotes = stmt2.executeQuery(sqlNotes);
                            
                            double note1 = -1, note2 = -1;
                            int count = 0;
                            while (rsNotes.next()) {
                                if (count == 0) note1 = rsNotes.getDouble("note");
                                else note2 = rsNotes.getDouble("note");
                                count++;
                            }
                            rsNotes.close();
                            stmt2.close();
                            
                            if (note1 >= 0 && note2 >= 0) {
                                double diff = Math.abs(note1 - note2);
                                double noteFinale = 0;
                                String type = "";
                                
                                // Logique de calcul selon la différence
                                if (diff <= 2) {
                                    // Petit - moyenne simple
                                    noteFinale = (note1 + note2) / 2;
                                    type = "petit";
                                } else if (diff <= 5) {
                                    // Moyen
                                    noteFinale = (note1 + note2) / 2;
                                    type = "moyen";
                                } else {
                                    // Grand - moyenne avec pondération
                                    noteFinale = (note1 + note2) / 2;
                                    type = "grand";
                                }
                                
                                // Arrondir à 2 décimales
                                noteFinale = Math.round(noteFinale * 100.0) / 100.0;
                %>
                <tr>
                    <td><%= candidatNom %></td>
                    <td><%= matiereNom %></td>
                    <td><%= note1 %></td>
                    <td><%= note2 %></td>
                    <td><%= diff %> (<%= type %>)</td>
                    <td class="note-finale"><%= noteFinale %></td>
                </tr>
                <%
                            }
                        }
                        rs.close();
                        stmt.close();
                        
                    } catch (Exception e) {
                        out.println("<tr><td colspan='6'>Erreur: " + e.getMessage() + "</td></tr>");
                        e.printStackTrace();
                    } finally {
                        if (conn != null) conn.close();
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>
