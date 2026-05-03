package com.univ.servlet.admin;

import com.univ.dao.ReservationDAO;
import com.univ.dao.SalleDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    private final SalleDAO salleDAO = new SalleDAO();
    private final ReservationDAO resDAO = new ReservationDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            req.setAttribute("nbSalles", salleDAO.findAll().size());
            req.setAttribute("nbReservations", resDAO.findAllFiltered(null, null).size());
            req.getRequestDispatcher("/jsp/admin/dashboard.jsp").forward(req, resp);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
