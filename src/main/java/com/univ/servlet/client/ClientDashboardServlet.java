package com.univ.servlet.client;

import com.univ.dao.ReservationDAO;
import com.univ.dao.SalleDAO;
import com.univ.model.Utilisateur;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/client/dashboard")
public class ClientDashboardServlet extends HttpServlet {
    private final SalleDAO salleDAO = new SalleDAO();
    private final ReservationDAO resDAO = new ReservationDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            Utilisateur u = (Utilisateur) req.getSession().getAttribute("user");
            req.setAttribute("nbSalles", salleDAO.findAll().size());
            req.setAttribute("nbMesReservations", resDAO.findByUtilisateur(u.getId()).size());
            req.getRequestDispatcher("/jsp/client/dashboard.jsp").forward(req, resp);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
