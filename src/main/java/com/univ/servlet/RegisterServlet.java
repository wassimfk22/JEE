package com.univ.servlet;

import com.univ.dao.UtilisateurDAO;
import com.univ.model.Role;
import com.univ.model.Utilisateur;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private final UtilisateurDAO dao = new UtilisateurDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/jsp/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            String email = req.getParameter("email");
            if (dao.findByEmail(email) != null) {
                req.setAttribute("error", "Cet email est déjà utilisé.");
                req.getRequestDispatcher("/jsp/register.jsp").forward(req, resp);
                return;
            }
            Utilisateur u = new Utilisateur();
            u.setNom(req.getParameter("nom"));
            u.setPrenom(req.getParameter("prenom"));
            u.setEmail(email);
            u.setMotDePasse(req.getParameter("motDePasse"));
            u.setRole(Role.CLIENT);
            dao.insert(u);
            resp.sendRedirect(req.getContextPath() + "/login?registered=1");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
