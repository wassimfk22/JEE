<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0"><title>Gestion des salles &mdash; UnivSalles</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"></head>
<body>
<%@ include file="../_navbar.jsp" %>
<div class="container">
  <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:18px;">
    <h1 style="margin:0;">Gestion des salles</h1>
    <a class="btn btn-success" href="${pageContext.request.contextPath}/admin/salles?action=new">+ Nouvelle salle</a>
  </div>

  <table>
    <thead><tr><th>Nom</th><th>Capacité</th><th>Localisation</th><th>Description</th><th>Actions</th></tr></thead>
    <tbody>
      <c:forEach var="s" items="${salles}">
        <tr>
          <td><strong>${s.nom}</strong></td>
          <td>${s.capacite}</td>
          <td>${s.localisation}</td>
          <td>${s.description}</td>
          <td>
            <a class="btn btn-sm btn-primary" href="${pageContext.request.contextPath}/admin/salles?action=edit&id=${s.id}">Modifier</a>
            <a class="btn btn-sm btn-danger" href="${pageContext.request.contextPath}/admin/salles?action=delete&id=${s.id}"
               onclick="return confirm('Supprimer cette salle ?');">Supprimer</a>
          </td>
        </tr>
      </c:forEach>
      <c:if test="${empty salles}">
        <tr><td colspan="5" style="text-align:center;color:#6b7280;">Aucune salle.</td></tr>
      </c:if>
    </tbody>
  </table>
</div>
</body></html>
