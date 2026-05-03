<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Inscription &mdash; UnivSalles</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="auth-wrapper">
  <div class="auth-card">
    <h1>&#128100; Cr&eacute;er un compte</h1>
    <p class="sub">Inscription enseignant / client</p>

    <% if (request.getAttribute("error") != null) { %>
      <div class="alert alert-error">&#9888; <%= request.getAttribute("error") %></div>
    <% } %>

    <form method="post" action="${pageContext.request.contextPath}/register">
      <div class="form-group">
        <label>&#128100; Nom</label>
        <input type="text" name="nom" placeholder="Votre nom" required>
      </div>
      <div class="form-group">
        <label>&#128100; Pr&eacute;nom</label>
        <input type="text" name="prenom" placeholder="Votre pr&eacute;nom" required>
      </div>
      <div class="form-group">
        <label>&#128231; Email</label>
        <input type="email" name="email" placeholder="votre@email.com" required>
      </div>
      <div class="form-group">
        <label>&#128272; Mot de passe</label>
        <input type="password" name="motDePasse" placeholder="••••••••" required minlength="4">
      </div>
      <button type="submit" class="btn btn-success" style="width:100%;padding:13px;font-size:1rem;margin-top:6px;">
        Cr&eacute;er mon compte &#8594;
      </button>
    </form>

    <hr class="auth-divider">

    <p style="text-align:center;font-size:.88rem;color:var(--clr-muted);">
      D&eacute;j&agrave; inscrit ?
      <a href="${pageContext.request.contextPath}/login" style="font-weight:600;">Se connecter</a>
    </p>
  </div>
</div>
</body>
</html>
