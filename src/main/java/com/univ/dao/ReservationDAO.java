package com.univ.dao;

import com.univ.model.Reservation;
import com.univ.model.StatutReservation;
import com.univ.util.DBConnection;

import java.sql.*;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

public class ReservationDAO {

    private static final String SELECT_BASE =
            "SELECT r.*, s.nom AS salle_nom, u.nom AS u_nom, u.prenom AS u_prenom " +
            "FROM reservation r " +
            "JOIN salle s ON s.id = r.salle_id " +
            "JOIN utilisateur u ON u.id = r.utilisateur_id ";

    /** Vrai s'il existe déjà une réservation non annulée chevauchant ce créneau pour la salle. */
    public boolean existeConflit(Long salleId, LocalDate date, LocalTime debut, LocalTime fin, Long ignoreReservationId) throws SQLException {
        String sql = "SELECT 1 FROM reservation WHERE salle_id=? AND statut<>'ANNULEE' " +
                "AND date_reservation=? AND heure_debut < ? AND heure_fin > ? " +
                (ignoreReservationId != null ? " AND id <> ?" : "");
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setLong(1, salleId);
            ps.setDate(2, Date.valueOf(date));
            ps.setTime(3, Time.valueOf(fin));
            ps.setTime(4, Time.valueOf(debut));
            if (ignoreReservationId != null) ps.setLong(5, ignoreReservationId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    public void insert(Reservation r) throws SQLException {
        String sql = "INSERT INTO reservation(utilisateur_id,salle_id,date_reservation,heure_debut,heure_fin,statut) " +
                "VALUES (?,?,?,?,?,?)";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setLong(1, r.getUtilisateurId());
            ps.setLong(2, r.getSalleId());
            ps.setDate(3, Date.valueOf(r.getDate()));
            ps.setTime(4, Time.valueOf(r.getHeureDebut()));
            ps.setTime(5, Time.valueOf(r.getHeureFin()));
            ps.setString(6, r.getStatut().name());
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) r.setId(rs.getLong(1));
            }
        }
    }

    public void updateStatus(Long id, StatutReservation statut) throws SQLException {
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement("UPDATE reservation SET statut=? WHERE id=?")) {
            ps.setString(1, statut.name());
            ps.setLong(2, id);
            ps.executeUpdate();
        }
    }

    public void annuler(Long id) throws SQLException {
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement("UPDATE reservation SET statut='ANNULEE' WHERE id=?")) {
            ps.setLong(1, id);
            ps.executeUpdate();
        }
    }

    public void delete(Long id) throws SQLException {
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement("DELETE FROM reservation WHERE id=?")) {
            ps.setLong(1, id);
            ps.executeUpdate();
        }
    }

    public Reservation findById(Long id) throws SQLException {
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(SELECT_BASE + "WHERE r.id=?")) {
            ps.setLong(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return map(rs);
            }
        }
        return null;
    }

    public List<Reservation> findByUtilisateur(Long userId) throws SQLException {
        List<Reservation> list = new ArrayList<>();
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(SELECT_BASE + "WHERE r.utilisateur_id=? ORDER BY r.date_reservation DESC, r.heure_debut DESC")) {
            ps.setLong(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(map(rs));
            }
        }
        return list;
    }

    public List<Reservation> findAllFiltered(LocalDate date, Long salleId) throws SQLException {
        StringBuilder sb = new StringBuilder(SELECT_BASE).append("WHERE 1=1 ");
        List<Object> params = new ArrayList<>();
        if (date != null) { sb.append("AND r.date_reservation=? "); params.add(Date.valueOf(date)); }
        if (salleId != null) { sb.append("AND r.salle_id=? "); params.add(salleId); }
        sb.append("ORDER BY r.date_reservation DESC, r.heure_debut DESC");
        List<Reservation> list = new ArrayList<>();
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sb.toString())) {
            for (int i = 0; i < params.size(); i++) ps.setObject(i + 1, params.get(i));
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(map(rs));
            }
        }
        return list;
    }

    private Reservation map(ResultSet rs) throws SQLException {
        Reservation r = new Reservation();
        r.setId(rs.getLong("id"));
        r.setUtilisateurId(rs.getLong("utilisateur_id"));
        r.setSalleId(rs.getLong("salle_id"));
        r.setDate(rs.getDate("date_reservation").toLocalDate());
        r.setHeureDebut(rs.getTime("heure_debut").toLocalTime());
        r.setHeureFin(rs.getTime("heure_fin").toLocalTime());
        r.setStatut(StatutReservation.valueOf(rs.getString("statut")));
        Timestamp ts = rs.getTimestamp("date_creation");
        if (ts != null) r.setDateCreation(ts.toLocalDateTime());
        r.setSalleNom(rs.getString("salle_nom"));
        r.setUtilisateurNomComplet(rs.getString("u_prenom") + " " + rs.getString("u_nom"));
        return r;
    }
}
