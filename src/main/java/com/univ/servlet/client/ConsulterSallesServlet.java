package com.univ.servlet.client;

import com.univ.dao.SalleDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;

/**
 * GET /client/salles                       -> toutes les salles
 * GET /client/salles?date=&debut=&fin=     -> salles disponibles au créneau
 */
@WebServlet("/client/salles")
public class ConsulterSallesServlet extends HttpServlet {
    private final SalleDAO dao = new SalleDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            String d = req.getParameter("date");
            String hd = req.getParameter("heureDebut");
            String hf = req.getParameter("heureFin");
            if (d != null && !d.isEmpty() && hd != null && !hd.isEmpty() && hf != null && !hf.isEmpty()) {
                LocalDate date = LocalDate.parse(d);
                LocalTime debut = LocalTime.parse(hd);
                LocalTime fin = LocalTime.parse(hf);
                if (!fin.isAfter(debut)) {
                    req.setAttribute("error", "L'heure de fin doit être après l'heure de début.");
                    req.setAttribute("salles", dao.findAll());
                } else {
                    req.setAttribute("salles", dao.findDisponibles(date, debut, fin));
                    req.setAttribute("date", d);
                    req.setAttribute("heureDebut", hd);
                    req.setAttribute("heureFin", hf);
                    req.setAttribute("filtreActif", true);
                }
            } else {
                req.setAttribute("salles", dao.findAll());
            }
            req.getRequestDispatcher("/jsp/client/salles.jsp").forward(req, resp);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
