package com.univ.servlet.admin;

import com.univ.dao.NotificationDAO;
import com.univ.dao.ReservationDAO;
import com.univ.dao.SalleDAO;
import com.univ.model.Notification;
import com.univ.model.Reservation;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.time.LocalDate;

/**
 * GET /admin/reservations           -> liste + filtres (date, salleId)
 * GET /admin/reservations?action=delete&id=
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
            if ("delete".equals(action)) {
                Long id = Long.parseLong(req.getParameter("id"));
                Reservation r = dao.findById(id);
                if (r != null) {
                    dao.delete(id);
                    notifDAO.insert(new Notification(r.getUtilisateurId(),
                            "Votre réservation pour " + r.getSalleNom() + " du " + r.getDate()
                                    + " a été supprimée par l'administrateur."));
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
