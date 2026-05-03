<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.univ.model.Utilisateur, com.univ.model.Role, com.univ.dao.NotificationDAO" %>
<%
  Utilisateur __user = (Utilisateur) session.getAttribute("user");
  int __nbNonLues = 0;
  if (__user != null) {
    try { __nbNonLues = new NotificationDAO().countNonLues(__user.getId()); } catch (Exception e) {}
  }
  String ctx = request.getContextPath();
%>
<nav class="navbar">
  <a class="brand" href="<%= ctx %>/">&#128218; UnivSalles</a>
  <div class="nav-links">
    <% if (__user != null) { %>
      <% if (__user.getRole() == Role.ADMIN) { %>
        <a href="<%= ctx %>/admin/dashboard">&#128202; Tableau de bord</a>
        <a href="<%= ctx %>/admin/salles">&#127970; Salles</a>
        <a href="<%= ctx %>/admin/reservations">&#128197; R&eacute;servations</a>
      <% } else { %>
        <a href="<%= ctx %>/client/dashboard">&#127968; Accueil</a>
        <a href="<%= ctx %>/client/salles">&#127970; Salles</a>
        <a href="<%= ctx %>/client/reserver">&#10010; R&eacute;server</a>
        <a href="<%= ctx %>/client/reservations">&#128203; Mes r&eacute;servations</a>
      <% } %>
      <a href="<%= ctx %>/notifications">
        &#128276;<% if (__nbNonLues > 0) { %><span class="badge"><%= __nbNonLues %></span><% } %>
      </a>
      <a href="<%= ctx %>/logout" style="color:#f87171;">&#x2717; D&eacute;connexion</a>
    <% } else { %>
      <a href="<%= ctx %>/login">Connexion</a>
      <a href="<%= ctx %>/register" class="btn btn-primary btn-sm" style="margin-left:8px;">S'inscrire</a>
    <% } %>
  </div>
</nav>

