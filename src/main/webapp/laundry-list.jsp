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
</head>
<body>
    <div class="container mt-5">
        <h2 class="text-center">Laundry Services & Prices</h2>
        <table class="table table-bordered mt-3">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Service Name</th>
                    <th>Price (KES)</th>
                </tr>
            </thead>
            <tbody>
                <% for (LaundryService service : laundryServices) { %>
                    <tr>
                        <td><%= service.getId() %></td>
                        <td><%= service.getServiceName() %></td>
                        <td><%= service.getPrice() %></td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</body>
</html>
