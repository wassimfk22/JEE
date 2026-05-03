<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0"><title>Salles disponibles &mdash; UnivSalles</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"></head>
<body>
<%@ include file="../_navbar.jsp" %>
<div class="container">
  <h1>Consulter les salles disponibles</h1>
  <div class="card">
    <form method="get" action="${pageContext.request.contextPath}/client/salles" class="filters">
      <div class="form-group"><label>Date</label>
        <input type="date" name="date" value="${date}" required></div>
      <div class="form-group"><label>Heure début</label>
        <input type="time" name="heureDebut" value="${heureDebut}" required></div>
      <div class="form-group"><label>Heure fin</label>
        <input type="time" name="heureFin" value="${heureFin}" required></div>
      <div><button class="btn btn-primary">Vérifier disponibilité</button>
        <a class="btn btn-secondary" href="${pageContext.request.contextPath}/client/salles">Voir toutes</a></div>
    </form>
    <c:if test="${not empty error}"><div class="alert alert-error" style="margin-top:14px;">${error}</div></c:if>
    <c:if test="${filtreActif}">
      <div class="alert alert-info" style="margin-top:14px;">
        Salles disponibles le ${date} de ${heureDebut} à ${heureFin}.
      </div>
    </c:if>
  </div>

  <div class="grid grid-2">
    <c:forEach var="s" items="${salles}">
      <div class="salle-card">
        <h3>${s.nom}</h3>
        <div class="meta">📍 ${s.localisation}</div>
        <div class="meta">👥 Capacité : ${s.capacite}</div>
        <p style="margin-top:8px;color:#374151;">${s.description}</p>
        <div class="actions">
          <a class="btn btn-success btn-sm"
             href="${pageContext.request.contextPath}/client/reserver?salleId=${s.id}<c:if test='${filtreActif}'>&date=${date}&heureDebut=${heureDebut}&heureFin=${heureFin}</c:if>">
             Réserver
          </a>
        </div>
      </div>
    </c:forEach>
    <c:if test="${empty salles}">
      <p style="color:#6b7280;">Aucune salle disponible.</p>
    </c:if>
  </div>
</div>
</body></html>
