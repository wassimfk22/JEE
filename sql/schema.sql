-- Systeme de reservation des salles universitaires
-- PostgreSQL schema
SET client_encoding = 'UTF8';

DROP TABLE IF EXISTS notification CASCADE;
DROP TABLE IF EXISTS reservation CASCADE;
DROP TABLE IF EXISTS salle CASCADE;
DROP TABLE IF EXISTS utilisateur CASCADE;

CREATE TABLE utilisateur (
    id BIGSERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    mot_de_passe VARCHAR(255) NOT NULL,
    role VARCHAR(20) NOT NULL CHECK (role IN ('ADMIN','CLIENT'))
);

CREATE TABLE salle (
    id BIGSERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    capacite INT NOT NULL,
    localisation VARCHAR(150),
    description TEXT
);

CREATE TABLE reservation (
    id BIGSERIAL PRIMARY KEY,
    utilisateur_id BIGINT NOT NULL REFERENCES utilisateur(id) ON DELETE CASCADE,
    salle_id BIGINT NOT NULL REFERENCES salle(id) ON DELETE CASCADE,
    date_reservation DATE NOT NULL,
    heure_debut TIME NOT NULL,
    heure_fin TIME NOT NULL,
    statut VARCHAR(20) NOT NULL DEFAULT 'EN_ATTENTE'
        CHECK (statut IN ('EN_ATTENTE','CONFIRMEE','ANNULEE')),
    date_creation TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CHECK (heure_fin > heure_debut)
);

CREATE TABLE notification (
    id BIGSERIAL PRIMARY KEY,
    utilisateur_id BIGINT NOT NULL REFERENCES utilisateur(id) ON DELETE CASCADE,
    message TEXT NOT NULL,
    date_envoi TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    lu BOOLEAN NOT NULL DEFAULT FALSE
);

-- Données de test
INSERT INTO utilisateur (nom, prenom, email, mot_de_passe, role) VALUES
('Admin', 'Super', 'admin@univ.com', 'admin123', 'ADMIN'),
('Dupont', 'Jean', 'client@univ.com', 'client123', 'CLIENT'),
('Martin', 'Sophie', 'sophie@univ.com', 'sophie123', 'CLIENT');

INSERT INTO salle (nom, capacite, localisation, description) VALUES
('Amphi A', 200, 'Bâtiment Principal - RDC', 'Grand amphithéâtre équipé vidéoprojecteur'),
('Salle TP 101', 30, 'Bâtiment Info - 1er étage', 'Salle TP avec 30 postes'),
('Salle Réunion B', 15, 'Bâtiment Admin - 2ème étage', 'Salle de réunion conviviale'),
('Amphi C', 150, 'Bâtiment Sciences', 'Amphi avec tableau interactif'),
('Salle Conférence', 50, 'Bibliothèque', 'Salle pour conférences et séminaires');
