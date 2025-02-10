<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<%@ page import="com.kleencleaners.models.User" %>

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
    <title>Dashboard</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body {
            background-color: #f8f9fa;
        }
        .navbar {
            padding: 10px 15px;
        }
        .nav-link {
            font-size: 1rem;
            font-weight: 500;
        }
        .dashboard-card {
            max-width: 500px;
            margin: auto;
            padding: 20px;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand fw-bold" href="#">KleenCleaners</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link active" href="dashboard.jsp">Dashboard</a></li>
                    <li class="nav-item"><a class="nav-link" href="order.jsp">Orders</a></li>
                    <li class="nav-item"><a class="nav-link" href="receipts.jsp">Receipts</a></li>
                    <li class="nav-item"><a class="nav-link" href="order-history.jsp">Order History</a></li>
                    <li class="nav-item"><a class="nav-link" href="LaundryListServlet">Services</a></li>
                    <li class="nav-item"><a class="nav-link" href="feedback.jsp">Feedback</a></li>
                    <li class="nav-item"><a class="nav-link text-danger fw-bold" href="logout.jsp">Logout</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Dashboard Content -->
    <div class="container text-center mt-5">
        <div class="card shadow-lg p-3 bg-white rounded dashboard-card">
            <div class="card-body">
                <h3 class="fw-bold">Welcome, <%= user.getFname() %>!</h3>
                <p class="text-muted">Email: <%= user.getEmail() %></p>
                <p>Explore our services and place your orders with ease.</p>
                <a href="order.jsp" class="btn btn-primary w-100 mt-3">Place an Order</a>
            </div>
        </div>
    </div>
</body>
</html>
