<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*, com.kleencleaners.DBConnection, com.kleencleaners.models.User" %>

<%
    HttpSession sessionObj = request.getSession(false);
    if (sessionObj == null || sessionObj.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    User user = (User) sessionObj.getAttribute("user");
    Connection conn = DBConnection.getConnection();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Receipts</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container">
        <h2 class="mt-4">Your Receipts</h2>

        <table class="table table-striped mt-3">
            <thead>
                <tr>
                    <th>Order ID</th>
                    <th>Date</th>
                    <th>Total Amount</th>
                    <th>Download</th>
                </tr>
            </thead>
            <tbody>
                <%
                    String query = "SELECT id, total_price, order_date FROM orders WHERE user_id = ? ORDER BY order_date DESC";
                    PreparedStatement stmt = conn.prepareStatement(query);
                    stmt.setInt(1, user.getId());
                    ResultSet rs = stmt.executeQuery();

                    while (rs.next()) {
                %>
                <tr>
                    <td><%= rs.getInt("id") %></td>
                    <td><%= rs.getTimestamp("order_date") %></td>
                    <td>KES <%= rs.getDouble("total_price") %></td>
                    <td>
                        <a href="DownloadReceiptServlet?orderId=<%= rs.getInt("id") %>" class="btn btn-primary">Download PDF</a>
                    </td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>

        <a href="dashboard.jsp" class="btn btn-secondary mt-3">Back to Dashboard</a>
    </div>
</body>
</html>
