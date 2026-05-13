package com.univ.servlet.client;

import com.univ.dao.NotificationDAO;
import com.univ.dao.ReservationDAO;
import com.univ.dao.SalleDAO;
import com.univ.model.Notification;
import com.univ.model.Reservation;
import com.univ.model.StatutReservation;
import com.univ.model.Utilisateur;
import com.univ.dao.UtilisateurDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;

/**
 * GET  /client/reserver?salleId=         -> formulaire
 * GET  /client/reserver                  -> formulaire (choix salle)
 * POST /client/reserver                  -> créer
 */
@WebServlet("/client/reserver")
public class ReserverServlet extends HttpServlet {
    private final SalleDAO salleDAO = new SalleDAO();
    private final ReservationDAO resDAO = new ReservationDAO();
    private final NotificationDAO notifDAO = new NotificationDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            req.setAttribute("salles", salleDAO.findAll());
            String salleId = req.getParameter("salleId");
            if (salleId != null) req.setAttribute("salleId", salleId);
            req.setAttribute("date", req.getParameter("date"));
            req.setAttribute("heureDebut", req.getParameter("heureDebut"));
            req.setAttribute("heureFin", req.getParameter("heureFin"));
            req.getRequestDispatcher("/jsp/client/reserver.jsp").forward(req, resp);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            Utilisateur u = (Utilisateur) req.getSession().getAttribute("user");
            Long salleId = Long.parseLong(req.getParameter("salleId"));
            LocalDate date = LocalDate.parse(req.getParameter("date"));
            LocalTime debut = LocalTime.parse(req.getParameter("heureDebut"));
            LocalTime fin = LocalTime.parse(req.getParameter("heureFin"));

            String error = null;
            if (!fin.isAfter(debut)) error = "L'heure de fin doit être après l'heure de début.";
            else if (date.isBefore(LocalDate.now())) error = "La date ne peut pas être dans le passé.";
            else if (resDAO.existeConflit(salleId, date, debut, fin, null))
                error = "Cette salle est déjà réservée sur ce créneau.";

            if (error != null) {
                req.setAttribute("error", error);
                req.setAttribute("salles", salleDAO.findAll());
                req.setAttribute("salleId", req.getParameter("salleId"));
                req.setAttribute("date", req.getParameter("date"));
                req.setAttribute("heureDebut", req.getParameter("heureDebut"));
                req.setAttribute("heureFin", req.getParameter("heureFin"));
                req.getRequestDispatcher("/jsp/client/reserver.jsp").forward(req, resp);
                return;
            }
            Reservation r = new Reservation();
            r.setUtilisateurId(u.getId());
            r.setSalleId(salleId);
            r.setDate(date);
            r.setHeureDebut(debut);
            r.setHeureFin(fin);
            r.setStatut(StatutReservation.EN_ATTENTE);
            resDAO.insert(r);

            // Notif client
            notifDAO.insert(new Notification(u.getId(),
                    "Votre demande de réservation pour le " + date + " (" + debut + "-" + fin + ") est en attente de validation."));

            // Notif admins (en sécurité pour ne pas bloquer la réservation)
            try {
                String msgAdmin = "Nouvelle demande de réservation de " + u.getNomComplet() + " pour le " + date;
                UtilisateurDAO uDAO = new UtilisateurDAO();
                for (Long adminId : uDAO.findAllAdminIds()) {
                    notifDAO.insert(new Notification(adminId, msgAdmin));
                }
            } catch (Exception e) {
                e.printStackTrace(); // Log l'erreur mais continue
            }

            resp.sendRedirect(req.getContextPath() + "/client/reservations");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
