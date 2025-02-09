<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*, java.util.*, com.kleencleaners.DBConnection, com.kleencleaners.models.User" %>

<%
    HttpSession sessionObj = request.getSession(false);
    if (sessionObj == null || sessionObj.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    User user = (User) sessionObj.getAttribute("user");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Order History</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container">
        <h2 class="mt-4">Your Order History</h2>

        <table class="table table-striped mt-3">
            <thead>
                <tr>
                    <th>#</th>
                    <th>Services</th>
                    <th>Total Price (KES)</th>
                    <th>Status</th>
                    <th>Order Date</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Connection conn = DBConnection.getConnection();
                    String query = "SELECT o.id, o.total_price, o.status, o.order_date, " +
                                   "GROUP_CONCAT(CONCAT(s.service_name, ' (', oi.quantity, 'x)') SEPARATOR ', ') AS services " +
                                   "FROM orders o " +
                                   "JOIN order_items oi ON o.id = oi.order_id " +
                                   "JOIN laundry_list s ON oi.service_id = s.id " +
                                   "WHERE o.user_id = ? " +
                                   "GROUP BY o.id " +
                                   "ORDER BY o.order_date DESC";

                    PreparedStatement stmt = conn.prepareStatement(query);
                    stmt.setInt(1, user.getId());
                    ResultSet rs = stmt.executeQuery();
                    int count = 1;

                    while (rs.next()) {
                %>
                    <tr>
                        <td><%= count++ %></td>
                        <td><%= rs.getString("services") %></td>
                        <td>KES <%= rs.getDouble("total_price") %></td>
                        <td><%= rs.getString("status") %></td>
                        <td><%= rs.getTimestamp("order_date") %></td>
                    </tr>
                <%
                    }
                %>
            </tbody>
        </table>

        <a href="dashboard.jsp" class="btn btn-primary mt-3">Back to Dashboard</a>
    </div>
</body>
</html>
