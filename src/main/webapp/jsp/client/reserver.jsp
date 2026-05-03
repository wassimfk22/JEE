<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>R&eacute;server une salle &mdash; UnivSalles</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%@ include file="../_navbar.jsp" %>
<div class="container">
  <div class="card" style="max-width: 600px; margin: 40px auto; box-shadow: var(--shadow-md);">
    <h1 style="justify-content: center; margin-bottom: 25px;">&#128197; R&eacute;server une salle</h1>
    
    <c:if test="${not empty error}">
      <div class="alert alert-error">&#9888; ${error}</div>
    </c:if>
    
    <form method="post" action="${pageContext.request.contextPath}/client/reserver">
      <div class="form-group">
        <label>&#127970; Choisir une salle</label>
        <select name="salleId" required>
          <option value="">-- S&eacute;lectionnez une salle --</option>
          <c:forEach var="s" items="${salles}">
            <option value="${s.id}" ${salleId == s.id ? 'selected' : ''}>
              ${s.nom} (Capacit&eacute;: ${s.capacite})
            </option>
          </c:forEach>
        </select>
      </div>
      
      <div class="form-group">
        <label>&#128197; Date de r&eacute;servation</label>
        <input type="date" name="date" value="${date}" required>
      </div>
      
      <div class="grid grid-2" style="gap: 15px;">
        <div class="form-group">
          <label>&#128337; Heure de d&eacute;but</label>
          <input type="time" name="heureDebut" value="${heureDebut}" required>
        </div>
        <div class="form-group">
          <label>&#128337; Heure de fin</label>
          <input type="time" name="heureFin" value="${heureFin}" required>
        </div>
      </div>
      
      <div style="display: flex; gap: 12px; margin-top: 25px;">
        <button type="submit" class="btn btn-success" style="flex: 1; padding: 12px;">Confirmer la r&eacute;servation</button>
        <a class="btn btn-secondary" href="${pageContext.request.contextPath}/client/dashboard" style="flex: 1; padding: 12px;">Annuler</a>
      </div>
    </form>
  </div>
</div>
<footer>&copy; 2025 UnivSalles &mdash; Syst&egrave;me de r&eacute;servation universitaire</footer>
</body>
</html>
