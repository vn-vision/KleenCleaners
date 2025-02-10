<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.kleencleaners.models.LaundryService" %>
<%
    List<LaundryService> laundryServices = (List<LaundryService>) request.getAttribute("laundryServices");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Laundry Services & Prices</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        .table-container {
            overflow-x: auto;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h2 class="text-center">Laundry Services & Prices</h2>
            <a href="dashboard.jsp" class="btn btn-secondary">← Back to Dashboard</a>
        </div>
        
        <input type="text" id="search" class="form-control mb-3" placeholder="Search services...">
        
        <div class="table-container">
            <table class="table table-striped table-hover">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Service Name</th>
                        <th>Price (KES)</th>
                    </tr>
                </thead>
                <tbody id="serviceTable">
                    <% for (LaundryService service : laundryServices) { %>
                        <tr>
                            <td><%= service.getId() %></td>
                            <td><%= service.getServiceName() %></td>
                            <td>KES <%= service.getPrice() %></td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <script>
        document.getElementById("search").addEventListener("input", function () {
            let filter = this.value.toLowerCase();
            let rows = document.querySelectorAll("#serviceTable tr");

            rows.forEach(row => {
                let serviceName = row.cells[1].textContent.toLowerCase();
                row.style.display = serviceName.includes(filter) ? "" : "none";
            });
        });
    </script>
</body>
</html>
