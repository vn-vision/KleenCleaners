package com.kleencleaners.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kleencleaners.DBConnection;
import com.kleencleaners.models.Order;
import com.kleencleaners.models.User;

@SuppressWarnings("serial")
@WebServlet("/OrderHistoryServlet")
public class OrderHistoryServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        ArrayList<Order> orders = new ArrayList<>();

        try {
            Connection conn = DBConnection.getConnection();
            String query = "SELECT o.id, s.service_name, o.quantity, o.total_price, o.status, o.order_date " +
                           "FROM orders o " +
                           "JOIN laundry_list s ON o.service_id = s.id " +
                           "WHERE o.user_id = ? " +
                           "ORDER BY o.order_date DESC";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, user.getId());
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                orders.add(new Order(
                    rs.getInt("id"),
                    user.getId(),
                    rs.getInt("service_name"),
                    rs.getInt("quantity"),
                    rs.getDouble("total_price"),
                    rs.getString("status"),
                    rs.getTimestamp("order_date")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("orders", orders);
        request.getRequestDispatcher("order-history.jsp").forward(request, response);
    }
}
