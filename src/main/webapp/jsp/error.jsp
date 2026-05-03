<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="fr"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0"><title>Erreur &mdash; UnivSalles</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"></head>
<body>
<%@ include file="_navbar.jsp" %>
<div class="container">
  <div class="card">
    <h1>Une erreur est survenue</h1>
    <p>Désolé, une erreur s'est produite. Veuillez réessayer plus tard.</p>
    <a href="${pageContext.request.contextPath}/" class="btn btn-primary" style="margin-top:14px;">Retour à l'accueil</a>
  </div>
</div>
</body></html>
