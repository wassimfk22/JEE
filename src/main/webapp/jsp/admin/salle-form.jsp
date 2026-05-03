<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>${empty salle ? 'Nouvelle salle' : 'Modifier salle'} &mdash; UnivSalles</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%@ include file="../_navbar.jsp" %>
<div class="container">
  <div class="card" style="max-width: 650px; margin: 40px auto; box-shadow: var(--shadow-md);">
    <h1 style="justify-content: center; margin-bottom: 30px;">
      ${empty salle ? '&#10010; Nouvelle salle' : '&#9998; Modifier la salle'}
    </h1>
    
    <form method="post" action="${pageContext.request.contextPath}/admin/salles?action=save">
      <c:if test="${not empty salle}">
        <input type="hidden" name="id" value="${salle.id}">
      </c:if>
      
      <div class="form-group">
        <label>&#127970; Nom de la salle</label>
        <input type="text" name="nom" value="${salle.nom}" placeholder="Ex: Amphi A, Salle 101..." required>
      </div>
      
      <div class="grid grid-2" style="gap: 15px;">
        <div class="form-group">
          <label>&#128101; Capacit&eacute; (personnes)</label>
          <input type="number" name="capacite" value="${salle.capacite}" min="1" required>
        </div>
        <div class="form-group">
          <label>&#128205; Localisation</label>
          <input type="text" name="localisation" value="${salle.localisation}" placeholder="Ex: B&acirc;timent B, 1er &eacute;tage">
        </div>
      </div>
      
      <div class="form-group">
        <label>&#128196; Description / Equipements</label>
        <textarea name="description" rows="4" placeholder="D&eacute;taillez les &eacute;quipements disponibles...">${salle.description}</textarea>
      </div>
      
      <div style="display: flex; gap: 12px; margin-top: 20px;">
        <button type="submit" class="btn btn-primary" style="flex: 1;">Enregistrer la salle</button>
        <a href="${pageContext.request.contextPath}/admin/salles" class="btn btn-secondary" style="flex: 1;">Annuler</a>
      </div>
    </form>
  </div>
</div>
<footer>&copy; 2025 UnivSalles &mdash; Syst&egrave;me de r&eacute;servation universitaire</footer>
</body>
</html>
