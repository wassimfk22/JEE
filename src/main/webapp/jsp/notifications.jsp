<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Notifications &mdash; UnivSalles</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%@ include file="_navbar.jsp" %>
<div class="container">
  <div class="page-header">
    <h1>&#128276; Mes Notifications</h1>
    <a class="btn btn-secondary btn-sm" href="${pageContext.request.contextPath}/notifications?action=lireToutes">Tout marquer comme lu</a>
  </div>

  <div style="display: flex; flex-direction: column; gap: 12px;">
    <c:forEach var="n" items="${notifications}">
      <div class="card ${n.lu ? 'notif-read' : 'notif-unread'}" style="margin-bottom: 0;">
        <div style="display: flex; justify-content: space-between; align-items: flex-start; gap: 15px;">
          <div style="flex: 1;">
            <p style="font-size: .95rem; color: var(--clr-text); ${!n.lu ? 'font-weight: 600;' : ''}">${n.message}</p>
            <div style="margin-top: 8px; font-size: .8rem; color: var(--clr-muted); display: flex; align-items: center; gap: 5px;">
              &#128337; ${n.dateEnvoi}
            </div>
          </div>
          <c:if test="${!n.lu}">
            <a class="btn btn-sm btn-primary" href="${pageContext.request.contextPath}/notifications?action=lire&id=${n.id}">Lire</a>
          </c:if>
        </div>
      </div>
    </c:forEach>
  </div>
  
  <c:if test="${empty notifications}">
    <div class="card">
      <div class="empty-state">
        <div class="icon">&#128221;</div>
        <p>Aucune notification pour le moment.</p>
      </div>
    </div>
  </c:if>
</div>
<footer>&copy; 2025 UnivSalles &mdash; Syst&egrave;me de r&eacute;servation universitaire</footer>
</body>
</html>
