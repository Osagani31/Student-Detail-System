<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>

<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="style.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Image Show</title>
    </head>
    <body>
        <div class="container">
        <%
            String idParam = request.getParameter("id");
            int imageid = -1;
            boolean validId = true;
            if (idParam == null) {
                validId = false;
        %>
            <div class="center"><strong>Error:</strong> No image ID provided.</div>
        <%
            } else {
                try {
                    imageid = Integer.parseInt(idParam);
                } catch (NumberFormatException nfe) {
                    validId = false;
        %>
            <div class="center"><strong>Error:</strong> Invalid image ID.</div>
        <%
                }
            }
            if (validId) {
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/fileupload", "root", "");
                Statement st = con.createStatement();
                String sql = "SELECT filename FROM image_table where id=" + imageid + "";
                ResultSet rs = st.executeQuery(sql);
                    boolean found = false;
                while (rs.next()) {
                        found = true;
                    String filename = rs.getString("filename");
        %>
        <table>
            <tr>
                <th>Id</th>
                <th>Image</th>
            </tr>
            <tr>
                <td><%=imageid%></td>
                <td><img src="<%=filename%>" width="200" height="200" alt="Student Image"/></td>
            </tr>
        </table>
        <%
                    }
                    if (!found) {
        %>
            <div class="center"><strong>Error:</strong> No image found for the given ID.</div>
        <%
                }
            } catch (Exception e) {
        %>
            <div class="center"><strong>Error:</strong> <%=e.getMessage()%></div>
        <%
                }
            }
        %>
        <div class="center"><a href="viewAll.jsp">View All</a></div>
        </div>
</body>
</html>