<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
   <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>Register - KleenCleaners</title>
   <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
   <style>
       body {
           background-color: #f8f9fa;
       }
       .register-container {
           max-width: 500px;
           margin: 100px auto;
           padding: 20px;
           background: white;
           border-radius: 8px;
           box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
       }
   </style>
</head>
<body>
   <div class="container">
       <div class="register-container">
           <h3 class="text-center mb-4">Register - KleenCleaners</h3>
           
           <%-- Display error/success messages if present --%>
           <% if(request.getParameter("error") != null){ %>
               <div class="alert alert-danger text-center">Registration failed. Please try again.</div>
           <% } %>
           <% if(request.getParameter("success") != null){ %>
               <div class="alert alert-success text-center">Registration successful! Please log in.</div>
           <% } %>
           
           <form action="RegisterServlet" method="post">
               <div class="mb-3">
                   <label for="fname" class="form-label">First Name:</label>
                   <input type="text" class="form-control" id="fname" name="fname" required>
               </div>
               <div class="mb-3">
                   <label for="lname" class="form-label">Last Name:</label>
                   <input type="text" class="form-control" id="lname" name="lname" required>
               </div>
               <div class="mb-3">
                   <label for="email" class="form-label">Email:</label>
                   <input type="email" class="form-control" id="email" name="email" required>
               </div>
               <div class="mb-3">
                   <label for="password" class="form-label">Password:</label>
                   <input type="password" class="form-control" id="password" name="password" required>
               </div>
               <div class="mb-3">
                   <label for="confirm_password" class="form-label">Confirm Password:</label>
                   <input type="password" class="form-control" id="confirm_password" name="confirm_password" required>
               </div>
               <button type="submit" class="btn btn-primary w-100">Register</button>
           </form>
           <p class="text-center mt-3">Already have an account? <a href="login.jsp">Login here</a></p>
       </div>
   </div>
   
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
   <script>
       // Client-side validation: Ensure password and confirm password match
       const form = document.querySelector('form');
       form.addEventListener('submit', function(e){
           const password = document.getElementById('password').value;
           const confirmPassword = document.getElementById('confirm_password').value;
           if(password !== confirmPassword) {
               e.preventDefault();
               alert("Passwords do not match!");
           }
       });
   </script>
</body>
</html>
