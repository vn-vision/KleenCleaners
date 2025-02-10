<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, java.text.SimpleDateFormat, javax.servlet.*, javax.servlet.http.*, com.kleencleaners.DBConnection, com.kleencleaners.models.User" %>
<%
    HttpSession sessionObj = request.getSession(false);
    if (sessionObj == null || sessionObj.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    User user = (User) sessionObj.getAttribute("user");
    Connection conn = DBConnection.getConnection();
    
    // Format dates for display
    SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy, HH:mm");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Feedback - KleenCleaners</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .card {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="container my-5">
        <!-- Feedback Form Card -->
        <div class="row">
            <div class="col-md-8 offset-md-2">
          		<!-- Back to Dashboard Button -->
                <div class="d-flex justify-content-between align-items-center mb-3">
                <h3 class="card-title text-center">Submit Your Feedback</h3>
                    <a href="dashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>
                </div>
                <div class="card shadow-sm">
                    <div class="card-body">
                        <% if (request.getParameter("success") != null) { %>
                            <div class="alert alert-success text-center">Thank you for your feedback!</div>
                        <% } %>
                        <form action="SubmitFeedbackServlet" method="post">
                            <div class="mb-3">
                                <label for="message" class="form-label">Your Feedback</label>
                                <textarea class="form-control" name="message" id="message" rows="4" required></textarea>
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
                            <button type="submit" class="btn btn-primary w-100">Submit Feedback</button>
                        </form>
                    </div>
                </div>

                <!-- Previous Feedback Card -->
                <div class="card shadow-sm">
                    <div class="card-body">
                        <h3 class="card-title text-center mb-4">Your Previous Feedback</h3>
                        <div class="table-responsive">
                            <table class="table table-striped table-bordered">
                                <thead class="table-dark">
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
                                        <td><%= sdf.format(rs.getTimestamp("created_at")) %></td>
                                    </tr>
                                    <%
                                        }
                                    %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
