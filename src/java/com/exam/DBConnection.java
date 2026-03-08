package com.exam;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    // Configuration de la base de données - À modifier selon votre config
    private static final String URL = "jdbc:postgresql://localhost:5432/correction_exam";
    private static final String USER = "postgres";
    private static final String PASSWORD = "postgres";
    
    static {
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            System.out.println("Driver PostgreSQL non trouvé: " + e.getMessage());
        }
    }
    
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
    
    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                System.out.println("Erreur fermeture connexion: " + e.getMessage());
            }
        }
    }
}
