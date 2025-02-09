package com.kleencleaners.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kleencleaners.DBConnection;
import com.kleencleaners.models.User;

@SuppressWarnings("serial")
@WebServlet("/SubmitFeedbackServlet")
public class SubmitFeedbackServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String message = request.getParameter("message");
        int rating = Integer.parseInt(request.getParameter("rating"));

        try {
            Connection conn = DBConnection.getConnection();
            String query = "INSERT INTO feedback (user_id, message, rating) VALUES (?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, user.getId());
            stmt.setString(2, message);
            stmt.setInt(3, rating);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("feedback.jsp?success=true");
    }
}
