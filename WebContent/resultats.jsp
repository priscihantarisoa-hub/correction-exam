<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.exam.DBConnection, java.util.ArrayList, java.util.List" %>
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
            max-width: 1200px;
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
        .notes-list {
            font-size: 12px;
            color: #7f8c8d;
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
                    <th>Notes</th>
                    <th>Nb</th>
                    <th>Somme Diff</th>
                    <th>Type</th>
                    <th>Note Finale</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Connection conn = null;
                    try {
                        conn = DBConnection.getConnection();
                        
                        // Get all parametres for operator comparison
                        String sqlParam = "SELECT p.id, p.id_matiere, p.valeur, p.id_operateur, o.nom as op_nom, r.type " +
                                         "FROM parametre p " +
                                         "JOIN operateur o ON p.id_operateur = o.id " +
                                         "JOIN resolution r ON p.id_resolution = r.id";
                        Statement stmtParam = conn.createStatement();
                        ResultSet rsParam = stmtParam.executeQuery(sqlParam);
                        
                        // Store parametres in a list
                        List<String[]> parametres = new ArrayList<>();
                        while (rsParam.next()) {
                            String[] p = new String[6];
                            p[0] = String.valueOf(rsParam.getInt("id"));
                            p[1] = String.valueOf(rsParam.getInt("id_matiere"));
                            p[2] = String.valueOf(rsParam.getInt("valeur"));
                            p[3] = String.valueOf(rsParam.getInt("id_operateur"));
                            p[4] = rsParam.getString("op_nom");
                            p[5] = rsParam.getString("type");
                            parametres.add(p);
                        }
                        rsParam.close();
                        stmtParam.close();
                        
                        // Query to get all candidates and subjects
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
                            
                            // Get ALL notes for this candidat and matiere
                            String sqlNotes = "SELECT note, nom as correcteur FROM note n " +
                                             "JOIN correcteur c ON n.id_correcteur = c.id " +
                                             "WHERE id_candidat = " + idCandidat + " AND id_matiere = " + idMatiere +
                                             " ORDER BY n.id";
                            
                            Statement stmt2 = conn.createStatement();
                            ResultSet rsNotes = stmt2.executeQuery(sqlNotes);
                            
                            // Collect all notes
                            List<Double> notes = new ArrayList<>();
                            List<String> correcteurs = new ArrayList<>();
                            
                            while (rsNotes.next()) {
                                notes.add(rsNotes.getDouble("note"));
                                correcteurs.add(rsNotes.getString("correcteur"));
                            }
                            rsNotes.close();
                            stmt2.close();
                            
                            // Need at least 2 notes to calculate
                            if (notes.size() >= 2) {
                                // Calculate sum of differences between all pairs
                                double sumDiff = 0;
                                for (int i = 0; i < notes.size(); i++) {
                                    for (int j = i + 1; j < notes.size(); j++) {
                                        sumDiff += Math.abs(notes.get(i) - notes.get(j));
                                    }
                                }
                                
                                // Calculate average
                                double sum = 0;
                                for (double n : notes) {
                                    sum += n;
                                }
                                double moyenne = sum / notes.size();
                                
                                // Find parametre for this matiere
                                String type = "";
                                double noteFinale = 0;
                                
                                for (String[] p : parametres) {
                                    if (Integer.parseInt(p[1]) == idMatiere) {
                                        int valeur = Integer.parseInt(p[2]);
                                        int idOperateur = Integer.parseInt(p[3]);
                                        String opNom = p[4];
                                        type = p[5];
                                        
                                        // Apply operator
                                        boolean match = false;
                                        if (opNom.equals("sup")) {
                                            match = sumDiff > valeur;
                                        } else if (opNom.equals("inf")) {
                                            match = sumDiff < valeur;
                                        } else if (opNom.equals("supegal")) {
                                            match = sumDiff >= valeur;
                                        } else if (opNom.equals("infegal")) {
                                            match = sumDiff <= valeur;
                                        }
                                        
                                        if (match) {
                                            if (type.equals("grand")) {
                                                // Grand - moyenne sans max et min
                                                double maxNote = notes.get(0);
                                                double minNote = notes.get(0);
                                                for (double n : notes) {
                                                    if (n > maxNote) maxNote = n;
                                                    if (n < minNote) minNote = n;
                                                }
                                                
                                                if (notes.size() > 2) {
                                                    double sumMiddle = sum - maxNote - minNote;
                                                    noteFinale = sumMiddle / (notes.size() - 2);
                                                } else {
                                                    noteFinale = moyenne;
                                                }
                                            } else {
                                                // Petit ou moyen - moyenne simple
                                                noteFinale = moyenne;
                                            }
                                            break;
                                        }
                                    }
                                }
                                
                                // If no parametre matched, use default calculation
                                if (type.equals("")) {
                                    if (sumDiff <= 2) {
                                        noteFinale = moyenne;
                                        type = "petit";
                                    } else if (sumDiff <= 5) {
                                        noteFinale = moyenne;
                                        type = "moyen";
                                    } else {
                                        double maxNote = notes.get(0);
                                        double minNote = notes.get(0);
                                        for (double n : notes) {
                                            if (n > maxNote) maxNote = n;
                                            if (n < minNote) minNote = n;
                                        }
                                        if (notes.size() > 2) {
                                            double sumMiddle = sum - maxNote - minNote;
                                            noteFinale = sumMiddle / (notes.size() - 2);
                                        } else {
                                            noteFinale = moyenne;
                                        }
                                        type = "grand";
                                    }
                                }
                                
                                // Round to 2 decimal places
                                noteFinale = Math.round(noteFinale * 100.0) / 100.0;
                                
                                // Build notes display string
                                StringBuilder notesStr = new StringBuilder();
                                for (int i = 0; i < notes.size(); i++) {
                                    if (i > 0) notesStr.append(", ");
                                    notesStr.append(notes.get(i)).append(" (").append(correcteurs.get(i)).append(")");
                                }
                %>
                <tr>
                    <td><%= candidatNom %></td>
                    <td><%= matiereNom %></td>
                    <td class="notes-list"><%= notesStr.toString() %></td>
                    <td><%= notes.size() %></td>
                    <td><%= sumDiff %></td>
                    <td><%= type %></td>
                    <td class="note-finale"><%= noteFinale %></td>
                </tr>
                <%
                            } else if (notes.size() == 1) {
                %>
                <tr>
                    <td><%= candidatNom %></td>
                    <td><%= matiereNom %></td>
                    <td class="notes-list"><%= notes.get(0) %> (<%= correcteurs.get(0) %>)</td>
                    <td>1</td>
                    <td>-</td>
                    <td>-</td>
                    <td class="note-finale"><%= notes.get(0) %></td>
                </tr>
                <%
                            }
                        }
                        
                        rs.close();
                        stmt.close();
                        
                    } catch (Exception e) {
                        out.println("<tr><td colspan='7'>Erreur: " + e.getMessage() + "</td></tr>");
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
