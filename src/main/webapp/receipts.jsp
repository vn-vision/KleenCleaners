<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*, java.text.SimpleDateFormat, com.kleencleaners.DBConnection, com.kleencleaners.models.User" %>

<%
    HttpSession sessionObj = request.getSession(false);
    if (sessionObj == null || sessionObj.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    User user = (User) sessionObj.getAttribute("user");

    // Database connection and query execution
    String query = "SELECT id, total_price, order_date FROM orders WHERE user_id = ? ORDER BY order_date DESC";
    boolean hasRecords = false;
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Receipts</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <div class="container">
    	<div class="d-flex justify-content-between align-items-center my-3">
            <h2>Your Receipts</h2>
            <a href="dashboard.jsp" class="btn btn-secondary">← Back to Dashboard</a>
        </div>
        <div class="table-responsive">
            <table class="table table-striped mt-3">
                <thead class="table-dark">
                    <tr>
                        <th>Order ID</th>
                        <th>Date</th>
                        <th>Total Amount</th>
                        <th>Download</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try (Connection conn = DBConnection.getConnection();
                             PreparedStatement stmt = conn.prepareStatement(query)) {
                            
                            stmt.setInt(1, user.getId());
                            try (ResultSet rs = stmt.executeQuery()) {
                                SimpleDateFormat dateFormat = new SimpleDateFormat("dd MMM yyyy, HH:mm");

                                while (rs.next()) {
                                    hasRecords = true;
                    %>
                    <tr>
                        <td>#<%= rs.getInt("id") %></td>
                        <td><%= dateFormat.format(rs.getTimestamp("order_date")) %></td>
                        <td>KES <%= String.format("%.2f", rs.getDouble("total_price")) %></td>
                        <td>
                            <a href="DownloadReceiptServlet?orderId=<%= rs.getInt("id") %>" class="btn btn-primary btn-sm">
                                <i class="fas fa-file-pdf"></i> Download
                            </a>
                        </td>
                    </tr>
                    <%
                                }
                            }
                        } catch (SQLException e) {
                            out.println("<tr><td colspan='4' class='text-danger'>Error retrieving receipts. Please try again later.</td></tr>");
                            e.printStackTrace();
                        }
                    %>

                    <% if (!hasRecords) { %>
                    <tr>
                        <td colspan="4" class="text-center text-muted">No receipts available.</td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
