package com.univ.dao;

import com.univ.model.Notification;
import com.univ.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NotificationDAO {

    public void insert(Notification n) throws SQLException {
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(
                "INSERT INTO notification(utilisateur_id,message) VALUES (?,?)")) {
            ps.setLong(1, n.getUtilisateurId());
            ps.setString(2, n.getMessage());
            ps.executeUpdate();
        }
    }

    public List<Notification> findByUser(Long userId) throws SQLException {
        List<Notification> list = new ArrayList<>();
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(
                "SELECT * FROM notification WHERE utilisateur_id=? ORDER BY date_envoi DESC")) {
            ps.setLong(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Notification n = new Notification();
                    n.setId(rs.getLong("id"));
                    n.setUtilisateurId(rs.getLong("utilisateur_id"));
                    n.setMessage(rs.getString("message"));
                    n.setDateEnvoi(rs.getTimestamp("date_envoi").toLocalDateTime());
                    n.setLu(rs.getBoolean("lu"));
                    list.add(n);
                }
            }
        }
        return list;
    }

    public int countNonLues(Long userId) throws SQLException {
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(
                "SELECT COUNT(*) FROM notification WHERE utilisateur_id=? AND lu=false")) {
            ps.setLong(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        }
        return 0;
    }

    public void marquerCommeLu(Long id) throws SQLException {
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement("UPDATE notification SET lu=true WHERE id=?")) {
            ps.setLong(1, id);
            ps.executeUpdate();
        }
    }

    public void marquerToutesLues(Long userId) throws SQLException {
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement("UPDATE notification SET lu=true WHERE utilisateur_id=?")) {
            ps.setLong(1, userId);
            ps.executeUpdate();
        }
    }
}
