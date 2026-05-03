package com.univ.servlet;

import com.univ.dao.UtilisateurDAO;
import com.univ.model.Role;
import com.univ.model.Utilisateur;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private final UtilisateurDAO dao = new UtilisateurDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/jsp/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String email = req.getParameter("email");
        String pwd = req.getParameter("motDePasse");
        try {
            Utilisateur u = dao.authentifier(email, pwd);
            if (u == null) {
                req.setAttribute("error", "Email ou mot de passe incorrect.");
                req.getRequestDispatcher("/jsp/login.jsp").forward(req, resp);
                return;
            }
            HttpSession session = req.getSession(true);
            session.setAttribute("user", u);
            if (u.getRole() == Role.ADMIN) {
                resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
            } else {
                resp.sendRedirect(req.getContextPath() + "/client/dashboard");
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
