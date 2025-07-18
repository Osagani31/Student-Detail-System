<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Live Student Search</title>
    <link rel="stylesheet" href="style.css">
    <script>
        function liveSearch() {
            var query = document.getElementById('searchInput').value;
            var xhr = new XMLHttpRequest();
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    document.getElementById('results').innerHTML = xhr.responseText;
                }
            };
            xhr.open('GET', 'SearchServlet?query=' + encodeURIComponent(query), true);
            xhr.send();
        }
    </script>
</head>
<body>
    <div class="container" style="max-width:600px;">
        <h2 style="text-align:center; color:#c7a6ff;">Live Student Search</h2>
        <input type="text" id="searchInput" onkeyup="liveSearch()" placeholder="Enter full name or degree name..." style="width:100%;padding:12px;margin-bottom:18px;border-radius:8px;border:1.5px solid #8250df;background-color:#2a1a3a;color:#e0e0ff;font-size:1rem;">
        <div id="results"></div>
    </div>
</body>
</html> 