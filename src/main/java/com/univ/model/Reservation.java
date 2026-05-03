package com.univ.model;

import java.io.Serializable;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

public class Reservation implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long id;
    private Long utilisateurId;
    private Long salleId;
    private LocalDate date;
    private LocalTime heureDebut;
    private LocalTime heureFin;
    private StatutReservation statut;
    private LocalDateTime dateCreation;

    // Champs joints (lecture seule, remplis par DAO)
    private String salleNom;
    private String utilisateurNomComplet;

    public Reservation() {}

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Long getUtilisateurId() { return utilisateurId; }
    public void setUtilisateurId(Long utilisateurId) { this.utilisateurId = utilisateurId; }
    public Long getSalleId() { return salleId; }
    public void setSalleId(Long salleId) { this.salleId = salleId; }
    public LocalDate getDate() { return date; }
    public void setDate(LocalDate date) { this.date = date; }
    public LocalTime getHeureDebut() { return heureDebut; }
    public void setHeureDebut(LocalTime heureDebut) { this.heureDebut = heureDebut; }
    public LocalTime getHeureFin() { return heureFin; }
    public void setHeureFin(LocalTime heureFin) { this.heureFin = heureFin; }
    public StatutReservation getStatut() { return statut; }
    public void setStatut(StatutReservation statut) { this.statut = statut; }
    public LocalDateTime getDateCreation() { return dateCreation; }
    public void setDateCreation(LocalDateTime dateCreation) { this.dateCreation = dateCreation; }
    public String getSalleNom() { return salleNom; }
    public void setSalleNom(String salleNom) { this.salleNom = salleNom; }
    public String getUtilisateurNomComplet() { return utilisateurNomComplet; }
    public void setUtilisateurNomComplet(String n) { this.utilisateurNomComplet = n; }
}
