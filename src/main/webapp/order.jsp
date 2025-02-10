<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*, com.kleencleaners.DBConnection" %>

<%
    HttpSession sessionObj = request.getSession(false);
    if (sessionObj == null || sessionObj.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Place Order</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h2 class="fw-bold">Place Laundry Order</h2>
            <a href="dashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>
        </div>
        
        <div class="card shadow p-4">
            <form action="OrderServlet" method="post">
                <div class="mb-3">
                    <label for="service" class="form-label">Select Laundry Services:</label>
                    <select name="service_id[]" id="service" class="form-select" multiple required>
                        <%
                            Connection conn = null;
                            PreparedStatement stmt = null;
                            ResultSet rs = null;
                            try {
                                conn = DBConnection.getConnection();
                                String query = "SELECT * FROM laundry_list";
                                stmt = conn.prepareStatement(query);
                                rs = stmt.executeQuery();
                                while (rs.next()) {
                        %>
                        <option value="<%= rs.getInt("id") %>">
                            <%= rs.getString("service_name") %> - KES <%= rs.getDouble("price") %>
                        </option>
                        <%
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                            } finally {
                                if (rs != null) rs.close();
                                if (stmt != null) stmt.close();
                                if (conn != null) conn.close();
                            }
                        %>
                    </select>
                </div>

                <div id="quantityFields" class="mb-3">
                    <label class="form-label">Enter Quantity for Each Selected Service:</label>
                </div>

                <button type="submit" class="btn btn-primary w-100">Submit Order</button>
            </form>
        </div>
    </div>

    <script>
        document.getElementById("service").addEventListener("change", function () {
            let selectedOptions = Array.from(this.selectedOptions);
            let quantityFieldsDiv = document.getElementById("quantityFields");
            quantityFieldsDiv.innerHTML = '<label class="form-label">Enter Quantity for Each Selected Service:</label>';

            selectedOptions.forEach(option => {
                let input = document.createElement("input");
                input.type = "number";
                input.name = "quantity[]";
                input.className = "form-control mb-2";
                input.placeholder = "Quantity for " + option.text;
                input.required = true;
                quantityFieldsDiv.appendChild(input);
            });
        });
    </script>
</body>
</html>
