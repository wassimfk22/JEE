# Système de gestion et de réservation des salles universitaires

Projet **JEE classique** (Dynamic Web Project Eclipse) — Servlets + JSP + JDBC + PostgreSQL.

## Stack
- **Backend** : Java EE (Servlet API 4.0, JSP)
- **Front** : JSP + JSTL + CSS
- **BDD** : PostgreSQL
- **Serveur** : Apache Tomcat 9
- **JDK** : Java 11

## Importation dans Eclipse
1. Ouvrir Eclipse (Eclipse IDE for Enterprise Java Developers).
2. `File > Import > General > Existing Projects into Workspace`.
3. Sélectionner le dossier `SalleReservation`.
4. Cliquer sur `Finish`.
5. Clic droit projet → `Properties > Targeted Runtimes` → cocher **Apache Tomcat v9.0**.
6. Vérifier `Project Facets` : Java 11, Dynamic Web Module 4.0.

## Base de données PostgreSQL
1. Créer une base : `CREATE DATABASE salle_reservation;`
2. Exécuter le script `sql/schema.sql` (création des tables + données de test).
3. Modifier les identifiants dans `src/main/java/com/univ/util/DBConnection.java` si besoin :
   - URL : `jdbc:postgresql://localhost:5432/salle_reservation`
   - User : `postgres`
   - Password : `postgres`

## Driver JDBC
Le driver `postgresql-42.7.3.jar` doit être placé dans `src/main/webapp/WEB-INF/lib/`.
Téléchargement : https://jdbc.postgresql.org/download/postgresql-42.7.3.jar

## Lancement
1. Clic droit projet → `Run As > Run on Server` → choisir Tomcat 9.
2. Accéder à : `http://localhost:8080/SalleReservation/`

## Comptes de test
- **Admin** : `admin@univ.com` / `admin123`
- **Client** : `client@univ.com` / `client123`

## Fonctionnalités
### Admin
- Gérer les salles (CRUD)
- Voir / supprimer toutes les réservations
- Filtrer par date / salle
- Notifications

### Client (Enseignant)
- Consulter les salles disponibles
- Réserver une salle (date + heure début/fin)
- Annuler une réservation
- Voir ses réservations
- Notifications

## Règles de gestion implémentées
- Pas de double réservation sur le même créneau (vérification SQL).
- Réservation = Date + Heure début + Heure fin obligatoires.
- Authentification requise via filtre `AuthFilter`.
- Seul l'admin accède à `/admin/*`.

## Conception UML
Voir le dossier `docs/` pour les diagrammes (classes + cas d'utilisation).
