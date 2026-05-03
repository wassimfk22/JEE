<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${empty salle ? 'Nouvelle salle' : 'Modifier salle'} &mdash; UnivSalles</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"></head>
<body>
<%@ include file="../_navbar.jsp" %>
<div class="container">
  <div class="card" style="max-width:600px;margin:0 auto;">
    <h1>${empty salle ? 'Nouvelle salle' : 'Modifier la salle'}</h1>
    <form method="post" action="${pageContext.request.contextPath}/admin/salles?action=save">
      <c:if test="${not empty salle}"><input type="hidden" name="id" value="${salle.id}"></c:if>
      <div class="form-group"><label>Nom</label>
        <input type="text" name="nom" value="${salle.nom}" required></div>
      <div class="form-group"><label>Capacité</label>
        <input type="number" name="capacite" value="${salle.capacite}" min="1" required></div>
      <div class="form-group"><label>Localisation</label>
        <input type="text" name="localisation" value="${salle.localisation}"></div>
      <div class="form-group"><label>Description</label>
        <textarea name="description" rows="3">${salle.description}</textarea></div>
      <button type="submit" class="btn btn-primary">Enregistrer</button>
      <a href="${pageContext.request.contextPath}/admin/salles" class="btn btn-secondary">Annuler</a>
    </form>
  </div>
</div>
</body></html>
