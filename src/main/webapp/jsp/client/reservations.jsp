<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0"><title>Mes r&eacute;servations &mdash; UnivSalles</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"></head>
<body>
<%@ include file="../_navbar.jsp" %>
<div class="container">
  <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:18px;">
    <h1 style="margin:0;">Mes réservations</h1>
    <a class="btn btn-success" href="${pageContext.request.contextPath}/client/reserver">+ Nouvelle réservation</a>
  </div>
  <table>
    <thead><tr><th>Date</th><th>Créneau</th><th>Salle</th><th>Statut</th><th>Action</th></tr></thead>
    <tbody>
      <c:forEach var="r" items="${reservations}">
        <tr>
          <td>${r.date}</td>
          <td>${r.heureDebut} - ${r.heureFin}</td>
          <td>${r.salleNom}</td>
          <td><span class="status status-${r.statut}">${r.statut}</span></td>
          <td>
            <c:if test="${r.statut != 'ANNULEE'}">
              <a class="btn btn-sm btn-danger"
                 href="${pageContext.request.contextPath}/client/reservations?action=annuler&id=${r.id}"
                 onclick="return confirm('Annuler cette réservation ?');">Annuler</a>
            </c:if>
          </td>
        </tr>
      </c:forEach>
      <c:if test="${empty reservations}">
        <tr><td colspan="5" style="text-align:center;color:#6b7280;">Aucune réservation.</td></tr>
      </c:if>
    </tbody>
  </table>
</div>
</body></html>
