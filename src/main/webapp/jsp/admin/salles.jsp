<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Gestion des salles &mdash; UnivSalles</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%@ include file="../_navbar.jsp" %>
<div class="container">
  <div class="page-header">
    <h1>&#127970; Gestion des salles</h1>
    <a class="btn btn-success" href="${pageContext.request.contextPath}/admin/salles?action=new">&#10010; Nouvelle salle</a>
  </div>

  <div class="card" style="padding: 0; overflow: hidden;">
    <table>
      <thead>
        <tr>
          <th>Nom</th>
          <th>Capacit&eacute;</th>
          <th>Localisation</th>
          <th>Description</th>
          <th style="text-align: right;">Actions</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="s" items="${salles}">
          <tr>
            <td><strong>${s.nom}</strong></td>
            <td><span class="badge" style="background: var(--clr-surface2); color: var(--clr-muted); animation: none; padding: 4px 10px;">${s.capacite} pers.</span></td>
            <td><span style="color: var(--clr-muted);">&#128205;</span> ${s.localisation}</td>
            <td style="max-width: 300px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; color: var(--clr-muted);">${s.description}</td>
            <td style="text-align: right;">
              <div style="display: flex; gap: 8px; justify-content: flex-end;">
                <a class="btn btn-sm btn-primary" 
				   href="${pageContext.request.contextPath}/admin/salles?action=edit&id=${s.id}">Modifier</a>
				<a class="btn btn-sm btn-danger" 
				   href="${pageContext.request.contextPath}/admin/salles?action=delete&id=${s.id}"
				   onclick="return confirm('Supprimer cette salle ?');">Supprimer</a>
              </div>
            </td>
          </tr>
        </c:forEach>
        <c:if test="${empty salles}">
          <tr>
            <td colspan="5">
              <div class="empty-state">
                <div class="icon">&#128683;</div>
                <p>Aucune salle enregistr&eacute;e.</p>
              </div>
            </td>
          </tr>
        </c:if>
      </tbody>
    </table>
  </div>
</div>
<footer>&copy; 2025 UnivSalles &mdash; Syst&egrave;me de r&eacute;servation universitaire</footer>
</body>
</html>
