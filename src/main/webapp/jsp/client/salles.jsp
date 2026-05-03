<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Salles disponibles &mdash; UnivSalles</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%@ include file="../_navbar.jsp" %>
<div class="container">
  <div class="page-header">
    <h1>&#127970; Consulter les salles disponibles</h1>
  </div>

  <div class="card">
    <form method="get" action="${pageContext.request.contextPath}/client/salles" class="filters">
      <div class="form-group">
        <label>&#128197; Date</label>
        <input type="date" name="date" value="${date}" required>
      </div>
      <div class="form-group">
        <label>&#128337; Heure d&eacute;but</label>
        <input type="time" name="heureDebut" value="${heureDebut}" required>
      </div>
      <div class="form-group">
        <label>&#128337; Heure fin</label>
        <input type="time" name="heureFin" value="${heureFin}" required>
      </div>
      <div style="display: flex; gap: 10px;">
        <button class="btn btn-primary">&#128269; V&eacute;rifier</button>
        <a class="btn btn-secondary" href="${pageContext.request.contextPath}/client/salles">Voir toutes</a>
      </div>
    </form>
    
    <c:if test="${not empty error}">
      <div class="alert alert-error" style="margin-top:20px;">&#9888; ${error}</div>
    </c:if>
    <c:if test="${filtreActif}">
      <div class="alert alert-info" style="margin-top:20px;">
        &#10003; Salles disponibles le <strong>${date}</strong> de <strong>${heureDebut}</strong> &agrave; <strong>${heureFin}</strong>.
      </div>
    </c:if>
  </div>

  <div class="grid grid-2" style="margin-top: 30px;">
    <c:forEach var="s" items="${salles}">
      <div class="salle-card">
        <div style="display: flex; justify-content: space-between; align-items: flex-start;">
          <h3>${s.nom}</h3>
          <span class="badge" style="background: var(--clr-surface2); color: var(--clr-primary); animation: none; font-size: .8rem; padding: 5px 12px;">${s.capacite} pers.</span>
        </div>
        <div class="meta">&#128205; ${s.localisation}</div>
        <p style="margin-top:12px; color: var(--clr-muted); font-size: .9rem; line-height: 1.5;">${s.description}</p>
        <div class="actions">
          <a class="btn btn-success btn-sm" style="width: 100%;"
             href="${pageContext.request.contextPath}/client/reserver?salleId=${s.id}<c:if test='${filtreActif}'>&date=${date}&heureDebut=${heureDebut}&heureFin=${heureFin}</c:if>">
             &#128197; R&eacute;server cette salle
          </a>
        </div>
      </div>
    </c:forEach>
  </div>
  
  <c:if test="${empty salles}">
    <div class="card">
      <div class="empty-state">
        <div class="icon">&#128148;</div>
        <p>Aucune salle disponible pour ce cr&eacute;neau.</p>
      </div>
    </div>
  </c:if>
</div>
<footer>&copy; 2025 UnivSalles &mdash; Syst&egrave;me de r&eacute;servation universitaire</footer>
</body>
</html>
