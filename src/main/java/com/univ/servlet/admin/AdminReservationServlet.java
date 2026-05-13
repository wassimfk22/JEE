package com.univ.servlet.admin;

import com.univ.dao.NotificationDAO;
import com.univ.dao.ReservationDAO;
import com.univ.dao.SalleDAO;
import com.univ.model.Notification;
import com.univ.model.Reservation;
import com.univ.model.StatutReservation;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.time.LocalDate;

/**
 * GET /admin/reservations           -> liste + filtres (date, salleId)
 * GET /admin/reservations?action=delete&id=
 * GET /admin/reservations?action=confirm&id=
 * GET /admin/reservations?action=refuse&id=
 */
@WebServlet("/admin/reservations")
public class AdminReservationServlet extends HttpServlet {
    private final ReservationDAO dao = new ReservationDAO();
    private final SalleDAO salleDAO = new SalleDAO();
    private final NotificationDAO notifDAO = new NotificationDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            String action = req.getParameter("action");
            String idStr = req.getParameter("id");
            if (action != null && idStr != null) {
                Long id = Long.parseLong(idStr);
                Reservation r = dao.findById(id);
                if (r != null) {
                    if ("delete".equals(action)) {
                        dao.delete(id);
                        notifDAO.insert(new Notification(r.getUtilisateurId(),
                                "Votre réservation pour " + r.getSalleNom() + " du " + r.getDate()
                                        + " a été supprimée par l'administrateur."));
                    } else if ("confirm".equals(action)) {
                        dao.updateStatus(id, StatutReservation.CONFIRMEE);
                        notifDAO.insert(new Notification(r.getUtilisateurId(),
                                "Félicitations ! Votre réservation pour " + r.getSalleNom() + " le " + r.getDate()
                                        + " a été confirmée par l'administrateur."));
                    } else if ("refuse".equals(action)) {
                        dao.updateStatus(id, StatutReservation.ANNULEE);
                        notifDAO.insert(new Notification(r.getUtilisateurId(),
                                "Désolé, votre demande de réservation pour " + r.getSalleNom() + " le " + r.getDate()
                                        + " a été refusée par l'administrateur."));
                    }
                }
                resp.sendRedirect(req.getContextPath() + "/admin/reservations");
                return;
            }
            String dateStr = req.getParameter("date");
            String salleStr = req.getParameter("salleId");
            LocalDate date = (dateStr != null && !dateStr.isEmpty()) ? LocalDate.parse(dateStr) : null;
            Long salleId = (salleStr != null && !salleStr.isEmpty()) ? Long.parseLong(salleStr) : null;

            req.setAttribute("reservations", dao.findAllFiltered(date, salleId));
            req.setAttribute("salles", salleDAO.findAll());
            req.setAttribute("filtreDate", dateStr);
            req.setAttribute("filtreSalle", salleStr);
            req.getRequestDispatcher("/jsp/admin/reservations.jsp").forward(req, resp);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
