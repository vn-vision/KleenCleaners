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
    <title>Feedback</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container">
        <h2 class="mt-4">Submit Your Feedback</h2>

        <% if (request.getParameter("success") != null) { %>
            <div class="alert alert-success">Thank you for your feedback!</div>
        <% } %>

        <form action="SubmitFeedbackServlet" method="post">
            <div class="mb-3">
                <label for="message" class="form-label">Your Feedback</label>
                <textarea class="form-control" name="message" id="message" required></textarea>
            </div>
            <div class="mb-3">
                <label for="rating" class="form-label">Rating (1 to 5)</label>
                <select class="form-select" name="rating" id="rating">
                    <option value="1">1 - Poor</option>
                    <option value="2">2 - Fair</option>
                    <option value="3">3 - Good</option>
                    <option value="4">4 - Very Good</option>
                    <option value="5">5 - Excellent</option>
                </select>
            </div>
            <button type="submit" class="btn btn-primary">Submit Feedback</button>
        </form>

        <h3 class="mt-5">Your Previous Feedback</h3>
        <table class="table table-striped mt-3">
            <thead>
                <tr>
                    <th>#</th>
                    <th>Feedback</th>
                    <th>Rating</th>
                    <th>Date</th>
                </tr>
            </thead>
            <tbody>
                <%
                    String fetchQuery = "SELECT message, rating, created_at FROM feedback WHERE user_id = ? ORDER BY created_at DESC";
                    PreparedStatement fetchStmt = conn.prepareStatement(fetchQuery);
                    fetchStmt.setInt(1, user.getId());
                    ResultSet rs = fetchStmt.executeQuery();
                    int count = 1;

                    while (rs.next()) {
                %>
                <tr>
                    <td><%= count++ %></td>
                    <td><%= rs.getString("message") %></td>
                    <td><%= rs.getInt("rating") %></td>
                    <td><%= rs.getTimestamp("created_at") %></td>
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
