<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0"><title>R&eacute;server une salle &mdash; UnivSalles</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"></head>
<body>
<%@ include file="../_navbar.jsp" %>
<div class="container">
  <div class="card" style="max-width:600px;margin:0 auto;">
    <h1>Réserver une salle</h1>
    <c:if test="${not empty error}"><div class="alert alert-error">${error}</div></c:if>
    <form method="post" action="${pageContext.request.contextPath}/client/reserver">
      <div class="form-group"><label>Salle</label>
        <select name="salleId" required>
          <option value="">-- Choisir une salle --</option>
          <c:forEach var="s" items="${salles}">
            <option value="${s.id}" ${salleId == s.id ? 'selected' : ''}>${s.nom} (cap. ${s.capacite})</option>
          </c:forEach>
        </select></div>
      <div class="form-group"><label>Date</label>
        <input type="date" name="date" value="${date}" required></div>
      <div class="form-group"><label>Heure début</label>
        <input type="time" name="heureDebut" value="${heureDebut}" required></div>
      <div class="form-group"><label>Heure fin</label>
        <input type="time" name="heureFin" value="${heureFin}" required></div>
      <button type="submit" class="btn btn-success">Confirmer la réservation</button>
      <a class="btn btn-secondary" href="${pageContext.request.contextPath}/client/dashboard">Annuler</a>
    </form>
  </div>
</div>
</body></html>
