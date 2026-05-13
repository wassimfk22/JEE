package com.univ.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * Utilitaire de connexion à la base de données PostgreSQL.
 */
public class DBConnection {

    private static final String URL = "jdbc:postgresql://localhost:5432/salle_reservation"
    		+ "?useUnicode=true&characterEncoding=UTF-8&socketTimeout=30";
    private static final String USER = "postgres";
    private static final String PASSWORD = "Support@2525";

    static {
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Driver PostgreSQL introuvable. Ajoutez postgresql-42.x.jar dans WEB-INF/lib", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
        try (Statement st = conn.createStatement()) {
            st.execute("SET client_encoding TO 'UTF8'");
        }
        return conn;
    }
}
