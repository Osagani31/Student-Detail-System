<%@ page contentType="text/html;charset=UTF-8" %>

<%
    if (session != null) {
        session.invalidate();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Logged Out</title>
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>
<body>
    <div class="login-container">
        <div style="text-align:center; margin-bottom:10px;">
            <i class="bi bi-box-arrow-right" style="font-size:3.2rem;color:#a259f7;"></i>
        </div>
        <h2 style="color:#c7a6ff; text-align:center;">You have been logged out.</h2>
        <a href="login.jsp" class="login-btn" style="text-align:center;display:block;max-width:200px;margin:24px auto 0 auto;">Login Again</a>
    </div>
</body>
</html> 