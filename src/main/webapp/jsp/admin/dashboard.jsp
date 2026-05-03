<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Tableau de bord Admin &mdash; UnivSalles</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%@ include file="../_navbar.jsp" %>
<div class="container">
  <div class="page-header">
    <h1>&#128202; Administration</h1>
  </div>

  <div class="grid grid-3">
    <div class="stat">
      <div class="label">&#127970; Salles</div>
      <div class="value">${nbSalles}</div>
    </div>
    <div class="stat">
      <div class="label">&#128197; R&eacute;servations totales</div>
      <div class="value">${nbReservations}</div>
    </div>
    <div class="stat">
      <div class="label">&#128100; R&ocirc;le</div>
      <div class="value" style="font-size:1.4rem;letter-spacing:0;">ADMIN</div>
    </div>
  </div>

  <div class="card" style="margin-top:28px;">
    <h2>&#9889; Actions rapides</h2>
    <div class="quick-actions">
      <a class="btn btn-primary" href="${pageContext.request.contextPath}/admin/salles">&#127970; G&eacute;rer les salles</a>
      <a class="btn btn-success" href="${pageContext.request.contextPath}/admin/salles?action=new">&#10010; Nouvelle salle</a>
      <a class="btn btn-secondary" href="${pageContext.request.contextPath}/admin/reservations">&#128197; Voir les r&eacute;servations</a>
    </div>
  </div>
</div>
<footer>&copy; 2025 UnivSalles &mdash; Syst&egrave;me de r&eacute;servation universitaire</footer>
</body>
</html>
