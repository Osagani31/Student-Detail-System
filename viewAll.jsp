<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Live Student Search</title>
        <link rel="stylesheet" href="style.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
        <table style="width:100%" border="2" class="data-table">
            <tr>
                <th style="text-align:center;">Id</th>
                <th style="text-align:left;">Full Name</th>
                <th style="text-align:left;">Degree Name</th>
                <th style="text-align:center;">Image</th>
                <th style="text-align:left;">Path</th>
            </tr>
        <%
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/fileupload", "root", "");
                Statement st = con.createStatement();
                String sql = "SELECT * FROM image_table";
                ResultSet rs = st.executeQuery(sql);
                while (rs.next()) {
                    int id = rs.getInt("id");
                    String firstname = rs.getString("FullName");
                    String degreename = rs.getString("degreeName");
                    String filename = rs.getString("filename");
                    String path = rs.getString("path");
        %>
            <tr>
                <td style="text-align:center;"><%=id%></td>
                <td style="text-align:left;"><%=firstname%></td>
                <td style="text-align:left;"><%=degreename%></td>
                <td style="text-align:center;"><img src="<%=request.getContextPath() + "/" + filename%>" width="150" height="120"/></td>
                <td style="text-align:left;"><%=path%></td>
            </tr>
        <%
                }
            } catch (Exception e) {
        %>
            <tr><td colspan="5"><%=e%></td></tr>
        <%
            }
        %>
        </table>
    </body>
</html>