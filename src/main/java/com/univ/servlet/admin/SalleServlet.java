package com.univ.servlet.admin;

import com.univ.dao.SalleDAO;
import com.univ.model.Salle;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

/**
 * CRUD salles : list / new (form) / edit (form) / save (POST) / delete
 * Routes :
 *  GET  /admin/salles?action=list (default)
 *  GET  /admin/salles?action=new
 *  GET  /admin/salles?action=edit&id=
 *  POST /admin/salles?action=save
 *  GET  /admin/salles?action=delete&id=
 */
@WebServlet("/admin/salles")
public class SalleServlet extends HttpServlet {
    private final SalleDAO dao = new SalleDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "list";
        try {
            switch (action) {
                case "new":
                    req.getRequestDispatcher("/jsp/admin/salle-form.jsp").forward(req, resp);
                    break;
                case "edit": {
                    Salle s = dao.findById(Long.parseLong(req.getParameter("id")));
                    req.setAttribute("salle", s);
                    req.getRequestDispatcher("/jsp/admin/salle-form.jsp").forward(req, resp);
                    break;
                }
                case "delete":
                    dao.delete(Long.parseLong(req.getParameter("id")));
                    resp.sendRedirect(req.getContextPath() + "/admin/salles");
                    break;
                default:
                    req.setAttribute("salles", dao.findAll());
                    req.getRequestDispatcher("/jsp/admin/salles.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            Salle s = new Salle();
            String idStr = req.getParameter("id");
            if (idStr != null && !idStr.isEmpty()) s.setId(Long.parseLong(idStr));
            s.setNom(req.getParameter("nom"));
            s.setCapacite(Integer.parseInt(req.getParameter("capacite")));
            s.setLocalisation(req.getParameter("localisation"));
            s.setDescription(req.getParameter("description"));
            if (s.getId() == null) dao.insert(s);
            else dao.update(s);
            resp.sendRedirect(req.getContextPath() + "/admin/salles");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
