package com.exam;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NoteDAO {
    
    // CREATE - Ajouter une note
    public static int insert(double note, int idCandidat, int idMatiere, int idCorrecteur) throws SQLException {
        String sql = "INSERT INTO note (note, id_candidat, id_matiere, id_correcteur) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            pstmt.setDouble(1, note);
            pstmt.setInt(2, idCandidat);
            pstmt.setInt(3, idMatiere);
            pstmt.setInt(4, idCorrecteur);
            pstmt.executeUpdate();
            
            ResultSet rs = pstmt.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return -1;
    }
    
    // READ - Liste de toutes les notes avec les noms
    public static List<String[]> findAll() throws SQLException {
        List<String[]> notes = new ArrayList<>();
        String sql = "SELECT n.id, n.note, c.nom as candidat, m.nom as matiere, co.nom as correcteur " +
                     "FROM note n " +
                     "JOIN candidat c ON n.id_candidat = c.id " +
                     "JOIN matiere m ON n.id_matiere = m.id " +
                     "JOIN correcteur co ON n.id_correcteur = co.id " +
                     "ORDER BY n.id";
        
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                String[] note = new String[5];
                note[0] = String.valueOf(rs.getInt("id"));
                note[1] = rs.getString("note");
                note[2] = rs.getString("candidat");
                note[3] = rs.getString("matiere");
                note[4] = rs.getString("correcteur");
                notes.add(note);
            }
        }
        return notes;
    }
    
    // READ - Notes par candidat
    public static List<String[]> findByCandidat(int idCandidat) throws SQLException {
        List<String[]> notes = new ArrayList<>();
        String sql = "SELECT n.id, n.note, c.nom as candidat, m.nom as matiere, co.nom as correcteur " +
                     "FROM note n " +
                     "JOIN candidat c ON n.id_candidat = c.id " +
                     "JOIN matiere m ON n.id_matiere = m.id " +
                     "JOIN correcteur co ON n.id_correcteur = co.id " +
                     "WHERE n.id_candidat = ? " +
                     "ORDER BY m.nom";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idCandidat);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                String[] note = new String[5];
                note[0] = String.valueOf(rs.getInt("id"));
                note[1] = rs.getString("note");
                note[2] = rs.getString("candidat");
                note[3] = rs.getString("matiere");
                note[4] = rs.getString("correcteur");
                notes.add(note);
            }
        }
        return notes;
    }
    
    // READ - Trouver une note par ID
    public static String[] findById(int id) throws SQLException {
        String sql = "SELECT n.id, n.note, n.id_candidat, n.id_matiere, n.id_correcteur " +
                     "FROM note n WHERE n.id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                String[] note = new String[5];
                note[0] = String.valueOf(rs.getInt("id"));
                note[1] = rs.getString("note");
                note[2] = String.valueOf(rs.getInt("id_candidat"));
                note[3] = String.valueOf(rs.getInt("id_matiere"));
                note[4] = String.valueOf(rs.getInt("id_correcteur"));
                return note;
            }
        }
        return null;
    }
    
    // UPDATE - Modifier une note
    public static boolean update(int id, double note, int idCandidat, int idMatiere, int idCorrecteur) throws SQLException {
        String sql = "UPDATE note SET note = ?, id_candidat = ?, id_matiere = ?, id_correcteur = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setDouble(1, note);
            pstmt.setInt(2, idCandidat);
            pstmt.setInt(3, idMatiere);
            pstmt.setInt(4, idCorrecteur);
            pstmt.setInt(5, id);
            return pstmt.executeUpdate() > 0;
        }
    }
    
    // DELETE - Supprimer une note
    public static boolean delete(int id) throws SQLException {
        String sql = "DELETE FROM note WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            return pstmt.executeUpdate() > 0;
        }
    }
    
    // READ - Liste des candidats pour les combobox
    public static List<String[]> getCandidats() throws SQLException {
        List<String[]> candidats = new ArrayList<>();
        String sql = "SELECT id, nom FROM candidat ORDER BY nom";
        
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                String[] c = new String[2];
                c[0] = String.valueOf(rs.getInt("id"));
                c[1] = rs.getString("nom");
                candidats.add(c);
            }
        }
        return candidats;
    }
    
    // READ - Liste des matières pour les combobox
    public static List<String[]> getMatieres() throws SQLException {
        List<String[]> matieres = new ArrayList<>();
        String sql = "SELECT id, nom FROM matiere ORDER BY nom";
        
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                String[] m = new String[2];
                m[0] = String.valueOf(rs.getInt("id"));
                m[1] = rs.getString("nom");
                matieres.add(m);
            }
        }
        return matieres;
    }
    
    // READ - Liste des correcteurs pour les combobox
    public static List<String[]> getCorrecteurs() throws SQLException {
        List<String[]> correcteurs = new ArrayList<>();
        String sql = "SELECT id, nom FROM correcteur ORDER BY nom";
        
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                String[] c = new String[2];
                c[0] = String.valueOf(rs.getInt("id"));
                c[1] = rs.getString("nom");
                correcteurs.add(c);
            }
        }
        return correcteurs;
    }
}
