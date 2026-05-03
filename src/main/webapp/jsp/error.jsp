<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Une erreur est survenue &mdash; UnivSalles</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%@ include file="_navbar.jsp" %>
<div class="container" style="display: flex; align-items: center; justify-content: center; min-height: 70vh;">
  <div class="card" style="max-width: 500px; text-align: center; padding: 50px 30px; box-shadow: var(--shadow-md);">
    <div style="font-size: 5rem; margin-bottom: 20px;">&#128680;</div>
    <h1 style="justify-content: center;">Oups ! Une erreur est survenue</h1>
    <p style="color: var(--clr-muted); margin: 20px 0 30px; line-height: 1.6;">
      D&eacute;sol&eacute;, le syst&egrave;me a rencontr&eacute; un problème inattendu. 
      Veuillez r&eacute;essayer plus tard ou contacter l'administrateur si le problème persiste.
    </p>
    <div style="display: flex; gap: 12px; justify-content: center;">
      <a href="${pageContext.request.contextPath}/" class="btn btn-primary">Retour &agrave; l'accueil</a>
      <a href="javascript:history.back()" class="btn btn-secondary">Page pr&eacute;c&eacute;dente</a>
    </div>
  </div>
</div>
<footer>&copy; 2025 UnivSalles &mdash; Syst&egrave;me de r&eacute;servation universitaire</footer>
</body>
</html>
