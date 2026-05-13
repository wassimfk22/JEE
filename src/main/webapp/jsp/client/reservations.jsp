<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Mes r&eacute;servations &mdash; UnivSalles</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%@ include file="../_navbar.jsp" %>
<div class="container">
  <div class="page-header">
    <h1>&#128203; Mes r&eacute;servations</h1>
    <a class="btn btn-success" href="${pageContext.request.contextPath}/client/reserver">&#10010; Nouvelle r&eacute;servation</a>
  </div>

  <div class="card" style="padding: 0; overflow: hidden;">
    <table>
      <thead>
        <tr>
          <th>Date</th>
          <th>Cr&eacute;neau</th>
          <th>Salle</th>
          <th>Statut</th>
          <th style="text-align: right;">Action</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="r" items="${reservations}">
          <tr>
            <td><strong>${r.date}</strong></td>
            <td><span style="color: var(--clr-muted);">&#128337;</span> ${r.heureDebut} &ndash; ${r.heureFin}</td>
            <td><span style="color: var(--clr-muted);">&#127970;</span> ${r.salleNom}</td>
            <td><span class="status status-${r.statut}">${r.statut}</span></td>
            <td style="text-align: right;">
              <c:if test="${r.statut != 'ANNULEE'}">
                <a class="btn btn-sm btn-danger"
                   href="${pageContext.request.contextPath}/client/reservations?action=annuler&id=${r.id}"
                   onclick="event.preventDefault(); customConfirm('Voulez-vous vraiment annuler cette réservation ?', () => window.location.href=this.href);">Annuler</a>
              </c:if>
              <c:if test="${r.statut == 'ANNULEE'}">
                <span style="color: var(--clr-faint); font-size: .85rem; font-style: italic;">Aucune action</span>
              </c:if>
            </td>
          </tr>
        </c:forEach>
        <c:if test="${empty reservations}">
          <tr>
            <td colspan="5">
              <div class="empty-state">
                <div class="icon">&#128197;</div>
                <p>Vous n'avez aucune r&eacute;servation pour le moment.</p>
                <a href="${pageContext.request.contextPath}/client/reserver" class="btn btn-primary" style="margin-top: 15px;">Faire ma premi&egrave;re r&eacute;servation</a>
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
