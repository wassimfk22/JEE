package com.univ.servlet;

import com.univ.dao.NotificationDAO;
import com.univ.model.Utilisateur;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

/**
 * Notifications accessibles aux 2 rôles connectés.
 * GET /notifications                              -> liste
 * GET /notifications?action=lire&id=              -> marquer lue (puis redirige)
 * GET /notifications?action=lireToutes            -> tout marquer lu
 */
@WebServlet("/notifications")
public class NotificationServlet extends HttpServlet {
    private final NotificationDAO dao = new NotificationDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        Utilisateur u = (Utilisateur) (req.getSession(false) != null
                ? req.getSession().getAttribute("user") : null);
        if (u == null) { resp.sendRedirect(req.getContextPath() + "/login"); return; }
        try {
            String action = req.getParameter("action");
            if ("lire".equals(action)) {
                dao.marquerCommeLu(Long.parseLong(req.getParameter("id")));
                resp.sendRedirect(req.getContextPath() + "/notifications");
                return;
            }
            if ("lireToutes".equals(action)) {
                dao.marquerToutesLues(u.getId());
                resp.sendRedirect(req.getContextPath() + "/notifications");
                return;
            }
            req.setAttribute("notifications", dao.findByUser(u.getId()));
            req.getRequestDispatcher("/jsp/notifications.jsp").forward(req, resp);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
