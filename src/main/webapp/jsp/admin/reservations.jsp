<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Toutes les r&eacute;servations &mdash; UnivSalles</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%@ include file="../_navbar.jsp" %>
<div class="container">
  <div class="page-header">
    <h1>&#128197; Toutes les r&eacute;servations</h1>
  </div>

  <div class="card">
    <form method="get" action="${pageContext.request.contextPath}/admin/reservations" class="filters">
      <div class="form-group">
        <label>&#128197; Date</label>
        <input type="date" name="date" value="${filtreDate}">
      </div>
      <div class="form-group">
        <label>&#127970; Salle</label>
        <select name="salleId">
          <option value="">Toutes les salles</option>
          <c:forEach var="s" items="${salles}">
            <option value="${s.id}" ${filtreSalle == s.id ? 'selected' : ''}>${s.nom}</option>
          </c:forEach>
        </select>
      </div>
      <div style="display: flex; gap: 10px;">
        <button class="btn btn-primary">&#128269; Filtrer</button>
        <a class="btn btn-secondary" href="${pageContext.request.contextPath}/admin/reservations">R&eacute;initialiser</a>
      </div>
    </form>
  </div>

  <div class="card" style="padding: 0; overflow: hidden; margin-top: 24px;">
    <table>
      <thead>
        <tr>
          <th>Date</th>
          <th>Cr&eacute;neau</th>
          <th>Salle</th>
          <th>Utilisateur</th>
          <th>Statut</th>
          <th style="text-align: right;">Actions</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="r" items="${reservations}">
          <tr>
            <td><strong>${r.date}</strong></td>
            <td><span style="color: var(--clr-muted);">&#128337;</span> ${r.heureDebut} &ndash; ${r.heureFin}</td>
            <td>${r.salleNom}</td>
            <td><span style="color: var(--clr-muted);">&#128100;</span> ${r.utilisateurNomComplet}</td>
            <td><span class="status status-${r.statut}">${r.statut}</span></td>
            <td style="text-align: right;">
              <div style="display: flex; gap: 6px; justify-content: flex-end;">
                <c:if test="${r.statut == 'EN_ATTENTE'}">
                  <a class="btn btn-sm btn-success" 
                     href="${pageContext.request.contextPath}/admin/reservations?action=confirm&id=${r.id}"
                     onclick="event.preventDefault(); customConfirm('Confirmer cette réservation ?', () => window.location.href=this.href);">Confirmer</a>
                  <a class="btn btn-sm btn-warning" 
                     href="${pageContext.request.contextPath}/admin/reservations?action=refuse&id=${r.id}"
                     onclick="event.preventDefault(); customConfirm('Refuser cette réservation ?', () => window.location.href=this.href);">Refuser</a>
                </c:if>
                <a class="btn btn-sm btn-danger" href="${pageContext.request.contextPath}/admin/reservations?action=delete&id=${r.id}"
                   onclick="event.preventDefault(); customConfirm('Voulez-vous vraiment supprimer définitivement cette réservation ?', () => window.location.href=this.href);">Supprimer</a>
              </div>
            </td>
          </tr>
        </c:forEach>
        <c:if test="${empty reservations}">
          <tr>
            <td colspan="6">
              <div class="empty-state">
                <div class="icon">&#128198;</div>
                <p>Aucune r&eacute;servation trouv&eacute;e.</p>
              </div>
            </td>
          </tr>
        </c:if>
      </tbody>
    </table>
  </div>
</div>
<footer>&copy; 2025 UnivSalles &mdash; Syst&egrave;me de r&eacute;servation universitaire</footer>
</body>
</html>
