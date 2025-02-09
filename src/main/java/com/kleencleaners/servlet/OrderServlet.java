package com.kleencleaners.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kleencleaners.DBConnection;
import com.kleencleaners.models.User;

@SuppressWarnings("serial")
@WebServlet("/OrderServlet")
public class OrderServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = user.getId();
        String[] serviceIds = request.getParameterValues("service_id[]");
        String[] quantities = request.getParameterValues("quantity[]");

        if (serviceIds == null || quantities == null || serviceIds.length == 0 || quantities.length == 0) {
            response.sendRedirect("order.jsp?error=NoServiceSelected");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false); // Start transaction

            // Insert new order
            String orderQuery = "INSERT INTO orders (user_id, total_price, status) VALUES (?, 0, 'Pending')";
            PreparedStatement orderStmt = conn.prepareStatement(orderQuery, PreparedStatement.RETURN_GENERATED_KEYS);
            orderStmt.setInt(1, userId);
            orderStmt.executeUpdate();

            ResultSet rs = orderStmt.getGeneratedKeys();
            int orderId = -1;
            if (rs.next()) {
                orderId = rs.getInt(1);
            } else {
                throw new Exception("Order ID retrieval failed.");
            }

            double totalPrice = 0.0;
            String itemQuery = "INSERT INTO order_items (order_id, service_id, quantity, price) VALUES (?, ?, ?, ?)";
            PreparedStatement itemStmt = conn.prepareStatement(itemQuery);

            for (int i = 0; i < serviceIds.length; i++) {
                int serviceId = Integer.parseInt(serviceIds[i]);
                int quantity = Integer.parseInt(quantities[i]);

                // Get price of service
                String priceQuery = "SELECT price FROM laundry_list WHERE id = ?";
                PreparedStatement priceStmt = conn.prepareStatement(priceQuery);
                priceStmt.setInt(1, serviceId);
                ResultSet priceRs = priceStmt.executeQuery();
                double pricePerUnit = 0;
                if (priceRs.next()) {
                    pricePerUnit = priceRs.getDouble("price");
                }

                double totalItemPrice = pricePerUnit * quantity;
                totalPrice += totalItemPrice;

                // Insert into order_items
                itemStmt.setInt(1, orderId);
                itemStmt.setInt(2, serviceId);
                itemStmt.setInt(3, quantity);
                itemStmt.setDouble(4, pricePerUnit);
                itemStmt.addBatch();
            }

            itemStmt.executeBatch();

            // Update total price in orders table
            String updateOrder = "UPDATE orders SET total_price = ? WHERE id = ?";
            PreparedStatement updateStmt = conn.prepareStatement(updateOrder);
            updateStmt.setDouble(1, totalPrice);
            updateStmt.setInt(2, orderId);
            updateStmt.executeUpdate();

            conn.commit(); // Commit transaction
            response.sendRedirect("order-success.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("order.jsp?error=DatabaseError");
        }
    }
}
