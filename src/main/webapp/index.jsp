<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="com.kleencleaners.models.User" %>
<%
    HttpSession sessionObj = request.getSession(false);
    User user = (sessionObj != null) ? (User) sessionObj.getAttribute("user") : null;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>KleenClean Laundry</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="index.jsp">KleenClean Laundry</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <% if (user == null) { %>
                        <li class="nav-item"><a class="nav-link" href="login.jsp">Login</a></li>
                    <% } else { %>
                        <li class="nav-item"><a class="nav-link" href="dashboard.jsp">Dashboard</a></li>
                        <li class="nav-item"><a class="nav-link" href="order.jsp">Orders</a></li>
                        <li class="nav-item"><a class="nav-link" href="receipts.jsp">Receipts</a></li>
                        <li class="nav-item"><a class="nav-link" href="order-history.jsp">Order-History</a></li>
                        <li class="nav-item"><a class="nav-link" href="LaundryListServlet">Services</a></li>
                        <li class="nav-item"><a class="nav-link" href="feedback.jsp">Feedback</a></li>
                        <li class="nav-item"><a class="nav-link text-danger" href="logout.jsp">Logout</a></li>
                    <% } %>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <div class="container text-center mt-5">
        <h1>Welcome to KleenClean Laundry</h1>
        <p class="lead">Reliable and professional laundry services at your convenience.</p>
        <% if (user == null) { %>
            <a href="login.jsp" class="btn btn-primary btn-lg">Get Started</a>
        <% } else { %>
            <a href="client-dashboard.jsp" class="btn btn-success btn-lg">Go to Dashboard</a>
        <% } %>
    </div>

    <!-- Bootstrap JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
