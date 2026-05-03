package com.univ.servlet.client;

import com.univ.dao.NotificationDAO;
import com.univ.dao.ReservationDAO;
import com.univ.model.Notification;
import com.univ.model.Reservation;
import com.univ.model.Utilisateur;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

/**
 * GET /client/reservations                          -> mes réservations
 * GET /client/reservations?action=annuler&id=       -> annuler
 */
@WebServlet("/client/reservations")
public class MesReservationsServlet extends HttpServlet {
    private final ReservationDAO dao = new ReservationDAO();
    private final NotificationDAO notifDAO = new NotificationDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            Utilisateur u = (Utilisateur) req.getSession().getAttribute("user");
            String action = req.getParameter("action");
            if ("annuler".equals(action)) {
                Long id = Long.parseLong(req.getParameter("id"));
                Reservation r = dao.findById(id);
                if (r != null && r.getUtilisateurId().equals(u.getId())) {
                    dao.annuler(id);
                    notifDAO.insert(new Notification(u.getId(),
                            "Vous avez annulé votre réservation pour " + r.getSalleNom() + " du " + r.getDate() + "."));
                }
                resp.sendRedirect(req.getContextPath() + "/client/reservations");
                return;
            }
            req.setAttribute("reservations", dao.findByUtilisateur(u.getId()));
            req.getRequestDispatcher("/jsp/client/reservations.jsp").forward(req, resp);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
