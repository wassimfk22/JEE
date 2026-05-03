<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0"><title>Toutes les r&eacute;servations &mdash; UnivSalles</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"></head>
<body>
<%@ include file="../_navbar.jsp" %>
<div class="container">
  <h1>Toutes les réservations</h1>
  <div class="card">
    <form method="get" action="${pageContext.request.contextPath}/admin/reservations" class="filters">
      <div class="form-group"><label>Date</label>
        <input type="date" name="date" value="${filtreDate}"></div>
      <div class="form-group"><label>Salle</label>
        <select name="salleId">
          <option value="">Toutes</option>
          <c:forEach var="s" items="${salles}">
            <option value="${s.id}" ${filtreSalle == s.id ? 'selected' : ''}>${s.nom}</option>
          </c:forEach>
        </select></div>
      <div><button class="btn btn-primary">Filtrer</button>
        <a class="btn btn-secondary" href="${pageContext.request.contextPath}/admin/reservations">Réinitialiser</a></div>
    </form>
  </div>

  <table>
    <thead><tr><th>Date</th><th>Créneau</th><th>Salle</th><th>Utilisateur</th><th>Statut</th><th>Actions</th></tr></thead>
    <tbody>
      <c:forEach var="r" items="${reservations}">
        <tr>
          <td>${r.date}</td>
          <td>${r.heureDebut} - ${r.heureFin}</td>
          <td>${r.salleNom}</td>
          <td>${r.utilisateurNomComplet}</td>
          <td><span class="status status-${r.statut}">${r.statut}</span></td>
          <td>
            <a class="btn btn-sm btn-danger" href="${pageContext.request.contextPath}/admin/reservations?action=delete&id=${r.id}"
               onclick="return confirm('Supprimer définitivement cette réservation ?');">Supprimer</a>
          </td>
        </tr>
      </c:forEach>
      <c:if test="${empty reservations}">
        <tr><td colspan="6" style="text-align:center;color:#6b7280;">Aucune réservation.</td></tr>
      </c:if>
    </tbody>
  </table>
</div>
</body></html>
