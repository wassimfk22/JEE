<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Connexion &mdash; UnivSalles</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="auth-wrapper">
  <div class="auth-card">
    <h1>&#128218; UnivSalles</h1>
    <p class="sub">Syst&egrave;me de r&eacute;servation des salles universitaires</p>

    <% if (request.getAttribute("error") != null) { %>
      <div class="alert alert-error">&#9888; <%= request.getAttribute("error") %></div>
    <% } %>
    <% if ("auth".equals(request.getParameter("error"))) { %>
      <div class="alert alert-info">&#128274; Veuillez vous connecter pour acc&eacute;der &agrave; cette page.</div>
    <% } %>
    <% if ("1".equals(request.getParameter("registered"))) { %>
      <div class="alert alert-success">&#10003; Inscription r&eacute;ussie. Connectez-vous.</div>
    <% } %>

    <form method="post" action="${pageContext.request.contextPath}/login">
      <div class="form-group">
        <label>&#128231; Email</label>
        <input type="email" name="email" placeholder="votre@email.com" required autofocus>
      </div>
      <div class="form-group">
        <label>&#128272; Mot de passe</label>
        <input type="password" name="motDePasse" placeholder="••••••••" required>
      </div>
      <button type="submit" class="btn btn-primary" style="width:100%;padding:13px;font-size:1rem;margin-top:6px;">
        Se connecter &#8594;
      </button>
    </form>

    <hr class="auth-divider">

    <p style="text-align:center;font-size:.88rem;color:var(--clr-muted);">
      Pas encore de compte ?
      <a href="${pageContext.request.contextPath}/register" style="font-weight:600;">S'inscrire</a>
    </p>
    <p style="text-align:center;margin-top:14px;font-size:.78rem;color:var(--clr-faint);">
      Test : admin@univ.com / admin123 &mdash; client@univ.com / client123
    </p>
  </div>
</div>
</body>
</html>
