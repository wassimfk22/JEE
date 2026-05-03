<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0"><title>Notifications &mdash; UnivSalles</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"></head>
<body>
<%@ include file="_navbar.jsp" %>
<div class="container">
  <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:18px;">
    <h1 style="margin:0;">🔔 Notifications</h1>
    <a class="btn btn-secondary" href="${pageContext.request.contextPath}/notifications?action=lireToutes">Tout marquer comme lu</a>
  </div>
  <c:forEach var="n" items="${notifications}">
    <div class="card" style="border-left:4px solid ${n.lu ? '#9ca3af' : '#2563eb'};">
      <div style="display:flex;justify-content:space-between;align-items:start;">
        <div>
          <p style="${n.lu ? 'color:#6b7280;' : 'font-weight:600;'}">${n.message}</p>
          <small style="color:#9ca3af;">${n.dateEnvoi}</small>
        </div>
        <c:if test="${!n.lu}">
          <a class="btn btn-sm btn-primary" href="${pageContext.request.contextPath}/notifications?action=lire&id=${n.id}">Marquer lu</a>
        </c:if>
      </div>
    </div>
  </c:forEach>
  <c:if test="${empty notifications}">
    <div class="card"><p style="color:#6b7280;text-align:center;">Aucune notification.</p></div>
  </c:if>
</div>
</body></html>
