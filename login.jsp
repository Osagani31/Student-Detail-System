<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Login</title>
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>
<body>
    <div class="login-container">
        <div style="text-align:center; margin-bottom:10px;">
            <i class="bi bi-person-circle" style="font-size:3.2rem;color:#a259f7;"></i>
        </div>
        <h2 style="color:#c7a6ff; text-align:center; margin-bottom:10px;">Welcome to University Student Details System</h2>
        <h2>Admin Login</h2>
        <% if (request.getAttribute("error") != null) { %>
            <div class="error"><%= request.getAttribute("error") %></div>
        <% } %>
        <form action="LoginServlet" method="post">
            <label for="username">Username</label>
            <input type="text" id="username" name="username" required>
            <label for="password">Password</label>
            <input type="password" id="password" name="password" required>
            <button type="submit" class="login-btn">Login</button>
        </form>
    </div>
</body>
</html> 