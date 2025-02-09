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
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            Connection conn = DBConnection.getConnection();
            String query = "SELECT * FROM users WHERE email = ? AND password = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, email);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                // Create User object
                User user = new User(
                    rs.getInt("id"), 
                    rs.getString("fname"), 
                    rs.getString("lname"), 
                    rs.getString("email"), 
                    rs.getString("password")
                );

                // Store user in session
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                // Log the user info
                System.out.println("Logged in user: " + user.getEmail());
                // Redirect to the dashboard
                response.sendRedirect("dashboard.jsp");
            } else {
                // Redirect to login with error
                response.sendRedirect("login.jsp?error=true");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
