package com.univ.model;

import java.io.Serializable;

public class Salle implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long id;
    private String nom;
    private int capacite;
    private String localisation;
    private String description;

    public Salle() {}

    public Salle(Long id, String nom, int capacite, String localisation, String description) {
        this.id = id;
        this.nom = nom;
        this.capacite = capacite;
        this.localisation = localisation;
        this.description = description;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }
    public int getCapacite() { return capacite; }
    public void setCapacite(int capacite) { this.capacite = capacite; }
    public String getLocalisation() { return localisation; }
    public void setLocalisation(String localisation) { this.localisation = localisation; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
}
