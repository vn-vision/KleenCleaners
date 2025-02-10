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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order History</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        .table-container {
            overflow-x: auto;
        }
        .status {
            font-weight: bold;
            padding: 5px 10px;
            border-radius: 5px;
            display: inline-block;
        }
        .status-pending { background-color: #ffc107; color: #000; }
        .status-completed { background-color: #28a745; color: #fff; }
        .status-cancelled { background-color: #dc3545; color: #fff; }
    </style>
</head>
<body>
    <div class="container mt-5">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h2>Your Order History</h2>
            <a href="dashboard.jsp" class="btn btn-secondary">← Back to Dashboard</a>
        </div>

        <input type="text" id="search" class="form-control mb-3" placeholder="Search orders...">

        <div class="table-container">
            <table class="table table-striped table-hover">
                <thead class="table-dark">
                    <tr>
                        <th>#</th>
                        <th>Services</th>
                        <th>Total Price (KES)</th>
                        <th>Status</th>
                        <th>Order Date</th>
                    </tr>
                </thead>
                <tbody id="orderTable">
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
                            String status = rs.getString("status");
                            String statusClass = "";
                            if ("Pending".equalsIgnoreCase(status)) statusClass = "status-pending";
                            else if ("Completed".equalsIgnoreCase(status)) statusClass = "status-completed";
                            else if ("Cancelled".equalsIgnoreCase(status)) statusClass = "status-cancelled";
                    %>
                        <tr>
                            <td><%= count++ %></td>
                            <td><%= rs.getString("services") %></td>
                            <td>KES <%= rs.getDouble("total_price") %></td>
                            <td><span class="status <%= statusClass %>"><%= status %></span></td>
                            <td><%= new java.text.SimpleDateFormat("dd MMM yyyy, HH:mm").format(rs.getTimestamp("order_date")) %></td>
                        </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>

    <script>
        document.getElementById("search").addEventListener("input", function () {
            let filter = this.value.toLowerCase();
            let rows = document.querySelectorAll("#orderTable tr");

            rows.forEach(row => {
                let text = row.innerText.toLowerCase();
                row.style.display = text.includes(filter) ? "" : "none";
            });
        });
    </script>
</body>
</html>
