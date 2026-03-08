package com.exam;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CandidatDAO {
    
    // CREATE - Ajouter un candidat
    public static int insert(String nom) throws SQLException {
        String sql = "INSERT INTO candidat (nom) VALUES (?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            pstmt.setString(1, nom);
            pstmt.executeUpdate();
            
            ResultSet rs = pstmt.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return -1;
    }
    
    // READ - Liste de tous les candidats
    public static List<String[]> findAll() throws SQLException {
        List<String[]> candidats = new ArrayList<>();
        String sql = "SELECT id, nom FROM candidat ORDER BY id";
        
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                String[] candidat = new String[2];
                candidat[0] = String.valueOf(rs.getInt("id"));
                candidat[1] = rs.getString("nom");
                candidats.add(candidat);
            }
        }
        return candidats;
    }
    
    // READ - Trouver un candidat par ID
    public static String[] findById(int id) throws SQLException {
        String sql = "SELECT id, nom FROM candidat WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                String[] candidat = new String[2];
                candidat[0] = String.valueOf(rs.getInt("id"));
                candidat[1] = rs.getString("nom");
                return candidat;
            }
        }
        return null;
    }
    
    // UPDATE - Modifier un candidat
    public static boolean update(int id, String nom) throws SQLException {
        String sql = "UPDATE candidat SET nom = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, nom);
            pstmt.setInt(2, id);
            return pstmt.executeUpdate() > 0;
        }
    }
    
    // DELETE - Supprimer un candidat
    public static boolean delete(int id) throws SQLException {
        String sql = "DELETE FROM candidat WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            return pstmt.executeUpdate() > 0;
        }
    }
}
