<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Tableau de bord &mdash; UnivSalles</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%@ include file="../_navbar.jsp" %>
<div class="container">
  <div class="page-header">
    <h1>&#127968; Bienvenue, ${sessionScope.user.prenom}&nbsp;!</h1>
  </div>

  <div class="grid grid-3">
    <div class="stat">
      <div class="label">&#127970; Salles disponibles</div>
      <div class="value">${nbSalles}</div>
    </div>
    <div class="stat">
      <div class="label">&#128203; Mes r&eacute;servations</div>
      <div class="value">${nbMesReservations}</div>
    </div>
    <div class="stat">
      <div class="label">&#128100; R&ocirc;le</div>
      <div class="value" style="font-size:1.4rem;letter-spacing:0;">CLIENT</div>
    </div>
  </div>

  <div class="card" style="margin-top:28px;">
    <h2>&#9889; Actions rapides</h2>
    <div class="quick-actions">
      <a class="btn btn-primary" href="${pageContext.request.contextPath}/client/salles">&#127970; Consulter les salles</a>
      <a class="btn btn-success" href="${pageContext.request.contextPath}/client/reserver">&#10010; R&eacute;server une salle</a>
      <a class="btn btn-secondary" href="${pageContext.request.contextPath}/client/reservations">&#128203; Mes r&eacute;servations</a>
    </div>
  </div>
</div>
<footer>&copy; 2025 UnivSalles &mdash; Syst&egrave;me de r&eacute;servation universitaire</footer>
</body>
</html>
