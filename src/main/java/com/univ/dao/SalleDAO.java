package com.univ.dao;

import com.univ.model.Salle;
import com.univ.util.DBConnection;

import java.sql.*;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

public class SalleDAO {

    public List<Salle> findAll() throws SQLException {
        List<Salle> list = new ArrayList<>();
        String sql = "SELECT * FROM salle ORDER BY nom";
        try (Connection c = DBConnection.getConnection();
             Statement st = c.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) list.add(map(rs));
        }
        return list;
    }

    public Salle findById(Long id) throws SQLException {
        String sql = "SELECT * FROM salle WHERE id = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setLong(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return map(rs);
            }
        }
        return null;
    }

    public void insert(Salle s) throws SQLException {
        String sql = "INSERT INTO salle(nom,capacite,localisation,description) VALUES (?,?,?,?)";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, s.getNom());
            ps.setInt(2, s.getCapacite());
            ps.setString(3, s.getLocalisation());
            ps.setString(4, s.getDescription());
            ps.executeUpdate();
        }
    }

    public void update(Salle s) throws SQLException {
        String sql = "UPDATE salle SET nom=?,capacite=?,localisation=?,description=? WHERE id=?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, s.getNom());
            ps.setInt(2, s.getCapacite());
            ps.setString(3, s.getLocalisation());
            ps.setString(4, s.getDescription());
            ps.setLong(5, s.getId());
            ps.executeUpdate();
        }
    }

    public void delete(Long id) throws SQLException {
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement("DELETE FROM salle WHERE id=?")) {
            ps.setLong(1, id);
            ps.executeUpdate();
        }
    }

    /** Salles disponibles sur un créneau donné (aucune réservation active qui chevauche). */
    public List<Salle> findDisponibles(LocalDate date, LocalTime debut, LocalTime fin) throws SQLException {
        String sql = "SELECT * FROM salle s WHERE NOT EXISTS (" +
                "  SELECT 1 FROM reservation r " +
                "  WHERE r.salle_id = s.id " +
                "    AND r.statut <> 'ANNULEE' " +
                "    AND r.date_reservation = ? " +
                "    AND r.heure_debut < ? AND r.heure_fin > ?" +
                ") ORDER BY s.nom";
        List<Salle> list = new ArrayList<>();
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setDate(1, Date.valueOf(date));
            ps.setTime(2, Time.valueOf(fin));
            ps.setTime(3, Time.valueOf(debut));
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(map(rs));
            }
        }
        return list;
    }

    private Salle map(ResultSet rs) throws SQLException {
        return new Salle(
                rs.getLong("id"),
                rs.getString("nom"),
                rs.getInt("capacite"),
                rs.getString("localisation"),
                rs.getString("description")
        );
    }
}
