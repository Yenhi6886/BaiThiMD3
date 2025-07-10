package org.example.thuchanh.controller;

import org.example.thuchanh.dao.PaymentDAO;
import org.example.thuchanh.dao.RoomDAO;
import org.example.thuchanh.model.Room;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/rooms")
public class RoomServlet extends HttpServlet {
    private RoomDAO roomDAO = new RoomDAO();
    private PaymentDAO paymentDAO = new PaymentDAO();

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        try {
            if ("createForm".equals(action)) {
                req.setAttribute("methods", paymentDAO.findAll());
                req.getRequestDispatcher("form.jsp").forward(req, resp);
            } else {
                String keyword = req.getParameter("search");
                req.setAttribute("rooms", roomDAO.findAll(keyword));
                req.setAttribute("keyword", keyword);
                req.getRequestDispatcher("list.jsp").forward(req, resp);
            }
        } catch (Exception e) { throw new ServletException(e); }
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            if (req.getParameterValues("deleteIds") != null) {
                String[] ids = req.getParameterValues("deleteIds");
                List<Integer> idList = Arrays.stream(ids).map(Integer::parseInt).collect(Collectors.toList());
                roomDAO.deleteByIds(idList);
            } else {
                Room room = new Room(0,
                    req.getParameter("tenantName"),
                    req.getParameter("phone"),
                    req.getParameter("startDate"),
                    Integer.parseInt(req.getParameter("paymentMethodId")),
                    req.getParameter("note")
                );
                roomDAO.insert(room);
            }
            resp.sendRedirect("/rooms");
        } catch (Exception e) { throw new ServletException(e); }
    }
}
